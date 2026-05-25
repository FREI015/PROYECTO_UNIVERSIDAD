<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Acceso inválido"));
  exit;
}

verifyCsrfOrRedirect(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Solicitud inválida. Intenta nuevamente."));
requirePermiso("marcar_asistencia", BASE_URL . "/modulos/asistencias.php");

$empleado_id = (int)($_POST["empleado_id"] ?? 0);
if ($empleado_id <= 0) {
  header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Empleado inválido"));
  exit;
}

/**
 * Hora y fecha calculadas con zona horaria de Caracas.
 */
$tz = new DateTimeZone("America/Caracas");
$now = new DateTimeImmutable("now", $tz);
$hoy_real = $now->format("Y-m-d");
$hora_now = $now->format("H:i:s");

// Usuario que registra
$uid = (int)($_SESSION["user"]["id"] ?? ($_SESSION["usuario_id"] ?? 0));
$registrado_por = $uid > 0 ? $uid : null;

// 1) Validar empleado y turno (para retardo)
$stmt = $pdo->prepare("
  SELECT e.estado, e.turno_id, t.nombre AS turno_nombre, t.hora_inicio, t.hora_fin
  FROM empleados e
  LEFT JOIN turnos t ON t.id = e.turno_id
  WHERE e.id = ?
  LIMIT 1
");
$stmt->execute([$empleado_id]);
$emp = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$emp) {
  header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Empleado no existe"));
  exit;
}

$estadoEmp = strtoupper(trim((string)$emp["estado"]));
if ($estadoEmp !== "ACTIVO") {
  header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Empleado no está ACTIVO"));
  exit;
}

if (!puedeVerTurno($emp["turno_nombre"] ?? "")) {
    header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("No tienes permiso para marcar asistencia de este turno"));
    exit;
}
// Modo emergencia: omite restricciones de reposo y permiso.
$modoEmergencia = !empty($_SESSION['modo_emergencia']);

// 2) Bloquear si tiene reposo/permiso activo HOY (fecha real) — sauf modo emergencia
if (!$modoEmergencia) {
  $stmt = $pdo->prepare("SELECT id FROM reposos WHERE empleado_id=? AND estado='ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin LIMIT 1");
  $stmt->execute([$empleado_id, $hoy_real]);
  if ($stmt->fetch()) {
    header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("No puedes marcar: reposo activo"));
    exit;
  }

  $stmt = $pdo->prepare("SELECT id FROM permisos WHERE empleado_id=? AND estado='ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin LIMIT 1");
  $stmt->execute([$empleado_id, $hoy_real]);
  if ($stmt->fetch()) {
    header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("No puedes marcar: permiso activo"));
    exit;
  }
}

// 3) Calcular retardo según turno + tolerancia (SEGURA)
$horaInicio = $emp["hora_inicio"] ?: "07:00:00";
$horaFin    = $emp["hora_fin"] ?: null;

/**
 * Define la fecha de asistencia para turnos que cruzan medianoche.
 * Ej: NOCTURNO 18:00 -> 06:00
 * Si son las 02:00, esa asistencia pertenece al día anterior (fecha de inicio del turno).
 */
$fecha_asistencia = $hoy_real;
if ($horaFin !== null) {
  $hi = (string)$horaInicio; // "HH:MM:SS"
  $hf = (string)$horaFin;

  // Cruza medianoche si inicio > fin (ej 18:00 > 06:00)
  if ($hi > $hf) {
    // Si estamos "después de medianoche" pero antes de la hora_fin, pertenece al día anterior
    if ($hora_now < $hf) {
      $fecha_asistencia = $now->modify("-1 day")->format("Y-m-d");
    }
  }
}

/**
 * Usa tolerancia configurada cuando esté disponible.
 * (Este es el FIX de tu error)
 */
$tolMin = 0;
if (defined("RETARDO_TOLERANCIA_MINUTOS")) {
  $tolMin = (int) constant("RETARDO_TOLERANCIA_MINUTOS");
}

// Límite = hora_inicio + tolerancia (en fecha de inicio del turno)
$inicioTurno = new DateTimeImmutable($fecha_asistencia . " " . $horaInicio, $tz);
$limite = $inicioTurno->modify("+" . $tolMin . " minutes");

$margenAntesMin = 0;
if (defined("ASISTENCIA_MARGEN_ANTES_MINUTOS")) {
    $margenAntesMin = max(0, (int) constant("ASISTENCIA_MARGEN_ANTES_MINUTOS"));
}

$inicioPermitido = $inicioTurno->modify("-" . $margenAntesMin . " minutes");

if ($now->getTimestamp() < $inicioPermitido->getTimestamp()) {
    header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Aun no esta dentro del margen permitido para marcar entrada"));
    exit;
}

// Estado por defecto
$min_tarde = 0;
$estado = "ASISTIO";

if ($now->getTimestamp() > $limite->getTimestamp()) {
  $segundosTarde = $now->getTimestamp() - $limite->getTimestamp();
  $min_tarde = max(1, (int) ceil($segundosTarde / 60));
  $estado = "RETARDO";
}

// 4) Insertar/actualizar asistencia del día (usa fecha_asistencia)
$stmt = $pdo->prepare("SELECT id, hora_entrada FROM asistencias WHERE empleado_id=? AND fecha=? LIMIT 1");
$stmt->execute([$empleado_id, $fecha_asistencia]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);

if ($row && !empty($row["hora_entrada"])) {
  header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Ya tiene entrada registrada para esa fecha"));
  exit;
}

if ($row) {
  $upd = $pdo->prepare("UPDATE asistencias SET hora_entrada=?, estado=?, minutos_tarde=?, registrado_por=? WHERE id=?");
  $upd->execute([$hora_now, $estado, $min_tarde, $registrado_por, (int)$row["id"]]);
} else {
  $ins = $pdo->prepare("
    INSERT INTO asistencias (empleado_id, fecha, estado, hora_entrada, minutos_tarde, registrado_por)
    VALUES (?, ?, ?, ?, ?, ?)
  ");
  $ins->execute([$empleado_id, $fecha_asistencia, $estado, $hora_now, $min_tarde, $registrado_por]);
}

header("Location: " . BASE_URL . "/modulos/asistencias.php?msg=" . urlencode("Asistencia guardada con exito") . "&ok_asistencia=entrada&empleado_id=" . $empleado_id . "&estado=" . urlencode($estado) . "&hora=" . urlencode($hora_now) . "&min_tarde=" . $min_tarde);
exit;
