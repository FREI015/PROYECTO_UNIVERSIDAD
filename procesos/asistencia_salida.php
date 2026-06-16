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

$tz  = new DateTimeZone("America/Caracas");
$now = new DateTimeImmutable("now", $tz);

$hoy_real = $now->format("Y-m-d");
$hora_now = $now->format("H:i:s");

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

if (strtoupper(trim((string)$emp["estado"])) !== "ACTIVO") {
  header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Empleado no está ACTIVO"));
  exit;
}

if (!puedeVerTurno($emp["turno_nombre"] ?? "")) {
    header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("No tienes permiso para marcar asistencia de este turno"));
    exit;
}
$horaInicio = $emp["hora_inicio"] ?: "07:00:00";
$horaFin    = $emp["hora_fin"] ?: null;

$fecha_asistencia = $hoy_real;
if ($horaFin !== null) {
  $hi = (string)$horaInicio;
  $hf = (string)$horaFin;

  if ($hi > $hf) {
    if ($hora_now < $hf) {
      $fecha_asistencia = $now->modify("-1 day")->format("Y-m-d");
    }
  }
}

$stmt = $pdo->prepare("
  SELECT id, estado, hora_entrada, hora_salida
  FROM asistencias
  WHERE empleado_id=? AND fecha=?
  LIMIT 1
");
$stmt->execute([$empleado_id, $fecha_asistencia]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$row || empty($row["hora_entrada"])) {
  header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("No tiene entrada registrada para esa fecha"));
  exit;
}

if (!empty($row["hora_salida"])) {
  header("Location: " . BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Ya tiene salida registrada para esa fecha"));
  exit;
}

$entrada_time = (string)$row["hora_entrada"];
$inicio = new DateTimeImmutable($fecha_asistencia . " " . $entrada_time, $tz);

if ($horaFin !== null) {
  $hi = (string)$horaInicio;
  $hf = (string)$horaFin;

  if ($hi > $hf) {
    if ($entrada_time < $hf) {
      $inicio = $inicio->modify("+1 day");
    }
  }
}

$diffSec = $now->getTimestamp() - $inicio->getTimestamp();
if ($diffSec < 0) $diffSec = 0;

$horas_trab = round($diffSec / 3600, 2);

$upd = $pdo->prepare("
  UPDATE asistencias
  SET hora_salida=?, horas_trabajadas=?
  WHERE id=?
");
$upd->execute([$hora_now, $horas_trab, (int)$row["id"]]);

header("Location: " . BASE_URL . "/modulos/asistencias.php?msg=" . urlencode("Salida registrada con éxito") . "&ok_asistencia=salida&empleado_id=" . $empleado_id . "&estado=" . urlencode((string)$row["estado"]) . "&hora=" . urlencode($hora_now));
exit;

