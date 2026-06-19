<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

$returnQuery = trim((string)($_POST["return_query"] ?? ""));

function asistenciaReturnUrl(string $key, string $message, array $extra = []): string {
  global $returnQuery;

  $params = [];

  if ($returnQuery !== "") {
    parse_str($returnQuery, $params);

    if (!is_array($params)) {
      $params = [];
    }
  }

  foreach (["msg", "err", "ok_asistencia", "empleado_id", "ok_estado", "hora", "min_tarde", "salida_estado", "min_salida_tardia"] as $k) {
    unset($params[$k]);
  }

  $params[$key] = $message;

  foreach ($extra as $k => $v) {
    if ($v !== null && $v !== "") {
      $params[$k] = $v;
    }
  }

  $query = http_build_query($params);

  return BASE_URL . "/modulos/asistencias.php" . ($query !== "" ? "?" . $query : "");
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  header("Location: " . asistenciaReturnUrl("err", "Acceso inválido"));
  exit;
}

verifyCsrfOrRedirect(asistenciaReturnUrl("err", "Solicitud inválida. Intenta nuevamente."));
requirePermiso("marcar_asistencia", BASE_URL . "/modulos/asistencias.php");

$empleado_id = (int)($_POST["empleado_id"] ?? 0);
if ($empleado_id <= 0) {
  header("Location: " . asistenciaReturnUrl("err", "Empleado inválido"));
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
  header("Location: " . asistenciaReturnUrl("err", "Empleado no existe"));
  exit;
}

if (strtoupper(trim((string)$emp["estado"])) !== "ACTIVO") {
  header("Location: " . asistenciaReturnUrl("err", "Empleado no está ACTIVO"));
  exit;
}

if (!puedeVerTurno($emp["turno_nombre"] ?? "")) {
  header("Location: " . asistenciaReturnUrl("err", "No tienes permiso para marcar asistencia de este turno"));
  exit;
}

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

$stmt = $pdo->prepare("
  SELECT id, estado, hora_entrada, hora_salida
  FROM asistencias
  WHERE empleado_id = ? AND fecha = ?
  LIMIT 1
");
$stmt->execute([$empleado_id, $fecha_asistencia]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$row || empty($row["hora_entrada"])) {
  header("Location: " . asistenciaReturnUrl("err", "No tiene entrada registrada para esa fecha"));
  exit;
}

if (!empty($row["hora_salida"])) {
  header("Location: " . asistenciaReturnUrl("err", "Ya tiene salida registrada para esa fecha"));
  exit;
}

$entrada_time = (string)$row["hora_entrada"];
$inicio = new DateTimeImmutable($fecha_asistencia . " " . $entrada_time, $tz);

if ($horaFin !== null) {
  $hi = (string)$horaInicio;
  $hf = (string)$horaFin;

  if ($hi > $hf && $entrada_time < $hf) {
    $inicio = $inicio->modify("+1 day");
  }
}

$diffSec = $now->getTimestamp() - $inicio->getTimestamp();

if ($diffSec < 0) {
  header("Location: " . asistenciaReturnUrl("err", "La hora de salida no puede ser anterior a la entrada"));
  exit;
}

$horas_trab = round($diffSec / 3600, 2);

$salidaEstado = "NORMAL";
$minutosSalidaTardia = 0;
$observacionSistema = null;

if ($horaFin !== null) {
  $hi = (string)$horaInicio;
  $hf = (string)$horaFin;

  $finTurno = new DateTimeImmutable($fecha_asistencia . " " . $hf, $tz);

  if ($hi > $hf) {
    $finTurno = $finTurno->modify("+1 day");
  }

  $diffFinSec = $now->getTimestamp() - $finTurno->getTimestamp();

  if ($diffFinSec > 0) {
    $minutosSalidaTardia = (int)ceil($diffFinSec / 60);
  }

  $toleranciaSalidaTardia = 0;
  if (defined("SALIDA_TARDIA_TOLERANCIA_MINUTOS")) {
    $toleranciaSalidaTardia = max(0, (int)constant("SALIDA_TARDIA_TOLERANCIA_MINUTOS"));
  }

  if ($minutosSalidaTardia > $toleranciaSalidaTardia) {
    $salidaEstado = "SALIDA_TARDIA";
    $observacionSistema = "Salida tardía: {$minutosSalidaTardia} min después del fin del turno ({$hf}).";
  }
} else {
  $salidaEstado = "SIN_HORARIO";
  $observacionSistema = "No se pudo comparar la salida porque el turno no tiene hora_fin.";
}

$upd = $pdo->prepare("
  UPDATE asistencias
  SET hora_salida = ?,
      horas_trabajadas = ?,
      salida_estado = ?,
      minutos_salida_tardia = ?,
      observacion_sistema = ?
  WHERE id = ?
");
$upd->execute([
  $hora_now,
  $horas_trab,
  $salidaEstado,
  $minutosSalidaTardia,
  $observacionSistema,
  (int)$row["id"]
]);

$mensaje = "Salida registrada con éxito";
if ($salidaEstado === "SALIDA_TARDIA") {
  $mensaje = "Salida registrada como tardía ({$minutosSalidaTardia} min)";
} elseif ($salidaEstado === "SIN_HORARIO") {
  $mensaje = "Salida registrada sin comparación de horario";
}

header("Location: " . asistenciaReturnUrl("msg", $mensaje, [
  "ok_asistencia" => "salida",
  "empleado_id" => $empleado_id,
  "ok_estado" => (string)$row["estado"],
  "salida_estado" => $salidaEstado,
  "min_salida_tardia" => (string)$minutosSalidaTardia,
  "hora" => $hora_now
]));
exit;