<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/conexion.php";

$redirect_to = trim($_POST["redirect_to"] ?? "");
$redirect_default = BASE_URL . "/modulos/asistencias.php";
$redirect_url = $redirect_to !== "" ? $redirect_to : $redirect_default;

function barcode_redirect($url, $params = []) {
  global $redirect_url;
  $base = $redirect_url;
  $sep = strpos($base, "?") === false ? "?" : "&";
  foreach ($params as $k => $v) {
    $base .= $sep . urlencode($k) . "=" . urlencode((string)$v);
    $sep = "&";
  }
  header("Location: " . $base);
  exit;
}

function barcode_err($msg) {
  barcode_redirect("", ["barcode_msg" => $msg, "barcode_type" => "error"]);
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  barcode_err("Acceso inválido");
}

$es_kiosko = ($redirect_to !== "");
if ($redirect_to === "") {
  requireLogin();
  verifyCsrfOrRedirect($redirect_default . "?err=" . urlencode("Solicitud inválida. Intenta nuevamente."));
  requirePermiso("marcar_asistencia", $redirect_default);
}

$codigo_barra = trim($_POST["codigo_barra"] ?? "");
if ($codigo_barra === "") {
  barcode_err("Código de barras vacío");
}

$empleado = empleadoPorCodigoBarra($pdo, $codigo_barra);
if (!$empleado) {
  barcode_err("No se encontró un empleado con ese código de barras");
}

$empleado_id = (int)$empleado["id"];

$stmt = $pdo->prepare("SELECT e.estado, e.turno_id, t.nombre AS turno_nombre, t.hora_inicio, t.hora_fin
  FROM empleados e
  LEFT JOIN turnos t ON t.id = e.turno_id
  WHERE e.id = ? LIMIT 1");
$stmt->execute([$empleado_id]);
$emp = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$emp) {
  barcode_err("Empleado no existe");
}

if (strtoupper(trim((string)$emp["estado"])) !== "ACTIVO") {
  barcode_err("El empleado no está ACTIVO");
}

if (!$es_kiosko && !puedeVerTurno($emp["turno_nombre"] ?? "")) {
  barcode_err("No tienes permiso para marcar asistencia de este turno");
}

$modoEmergencia = !empty($_SESSION['modo_emergencia']);

$tz = new DateTimeZone("America/Caracas");
$now = new DateTimeImmutable("now", $tz);
$hoy_real = $now->format("Y-m-d");
$hora_now = $now->format("H:i:s");

$horaInicio = $emp["hora_inicio"] ?: "07:00:00";
$horaFin    = $emp["hora_fin"] ?: null;

$fecha_asistencia = $hoy_real;
if ($horaFin !== null) {
  $hi = (string)$horaInicio;
  $hf = (string)$horaFin;
  if ($hi > $hf && $hora_now < $hf) {
    $fecha_asistencia = $now->modify("-1 day")->format("Y-m-d");
  }
}

if (!$modoEmergencia) {
  $stmt = $pdo->prepare("SELECT id FROM reposos WHERE empleado_id=? AND estado='ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin LIMIT 1");
  $stmt->execute([$empleado_id, $hoy_real]);
  if ($stmt->fetch()) {
    barcode_err("No puedes marcar: reposo activo");
  }

  $stmt = $pdo->prepare("SELECT id FROM permisos WHERE empleado_id=? AND estado='ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin LIMIT 1");
  $stmt->execute([$empleado_id, $hoy_real]);
  if ($stmt->fetch()) {
    barcode_err("No puedes marcar: permiso activo");
  }
}

$stmt = $pdo->prepare("SELECT id, hora_entrada, hora_salida, estado FROM asistencias WHERE empleado_id=? AND fecha=? LIMIT 1");
$stmt->execute([$empleado_id, $fecha_asistencia]);
$asistencia = $stmt->fetch(PDO::FETCH_ASSOC);

$uid = (int)($_SESSION["user"]["id"] ?? ($_SESSION["usuario_id"] ?? 0));
$registrado_por = $uid > 0 ? $uid : null;

if (!$asistencia || empty($asistencia["hora_entrada"])) {
  $tolMin = defined("RETARDO_TOLERANCIA_MINUTOS") ? (int)RETARDO_TOLERANCIA_MINUTOS : 0;
  $inicioTurno = new DateTimeImmutable($fecha_asistencia . " " . $horaInicio, $tz);
  $limite = $inicioTurno->modify("+" . $tolMin . " minutes");

  $margenAntesMin = defined("ASISTENCIA_MARGEN_ANTES_MINUTOS") ? max(0, (int)ASISTENCIA_MARGEN_ANTES_MINUTOS) : 0;
  $inicioPermitido = $inicioTurno->modify("-" . $margenAntesMin . " minutes");

  if ($now->getTimestamp() < $inicioPermitido->getTimestamp()) {
    barcode_err("Fuera del margen permitido");
  }

  $min_tarde = 0;
  $estado = "ASISTIO";
  if ($now->getTimestamp() > $limite->getTimestamp()) {
    $segundosTarde = $now->getTimestamp() - $limite->getTimestamp();
    $min_tarde = max(1, (int)ceil($segundosTarde / 60));
    $estado = "RETARDO";
  }

  if ($asistencia) {
    $upd = $pdo->prepare("UPDATE asistencias SET hora_entrada=?, estado=?, minutos_tarde=?, registrado_por=? WHERE id=?");
    $upd->execute([$hora_now, $estado, $min_tarde, $registrado_por, (int)$asistencia["id"]]);
  } else {
    $ins = $pdo->prepare("INSERT INTO asistencias (empleado_id, fecha, estado, hora_entrada, minutos_tarde, registrado_por) VALUES (?, ?, ?, ?, ?, ?)");
    $ins->execute([$empleado_id, $fecha_asistencia, $estado, $hora_now, $min_tarde, $registrado_por]);
  }

  $msg = "Entrada registrada: " . $empleado["nombres"] . " " . $empleado["apellidos"];
  barcode_redirect("", [
    "barcode_msg" => $msg,
    "barcode_type" => "success",
    "ok_asistencia" => "entrada",
    "empleado_id" => $empleado_id,
    "estado" => $estado,
    "hora" => $hora_now,
    "min_tarde" => $min_tarde
  ]);

} elseif (empty($asistencia["hora_salida"])) {
  $entrada_time = (string)$asistencia["hora_entrada"];
  $inicio = new DateTimeImmutable($fecha_asistencia . " " . $entrada_time, $tz);

  if ($horaFin !== null) {
    $hi = (string)$horaInicio;
    $hf = (string)$horaFin;
    if ($hi > $hf && $entrada_time < $hf) {
      $inicio = $inicio->modify("+1 day");
    }
  }

  $diffSec = $now->getTimestamp() - $inicio->getTimestamp();
  if ($diffSec < 0) $diffSec = 0;
  $horas_trab = round($diffSec / 3600, 2);

  $upd = $pdo->prepare("UPDATE asistencias SET hora_salida=?, horas_trabajadas=? WHERE id=?");
  $upd->execute([$hora_now, $horas_trab, (int)$asistencia["id"]]);

  $msg = "Salida registrada: " . $empleado["nombres"] . " " . $empleado["apellidos"];
  barcode_redirect("", [
    "barcode_msg" => $msg,
    "barcode_type" => "success",
    "ok_asistencia" => "salida",
    "empleado_id" => $empleado_id,
    "estado" => $asistencia["estado"],
    "hora" => $hora_now
  ]);

} else {
  barcode_err("Ya registró entrada y salida hoy");
}
