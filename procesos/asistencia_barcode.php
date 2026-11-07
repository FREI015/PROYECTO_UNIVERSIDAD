<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";

$ipKiosco = (string)($_SERVER["REMOTE_ADDR"] ?? "");
if (!in_array($ipKiosco, ["127.0.0.1", "::1"], true)) {
  http_response_code(403);
  exit("El kiosco solo puede utilizarse desde esta computadora.");
}
require_once __DIR__ . "/../includes/conexion.php";

$redirect_url = BASE_URL . "/login_empleado.php";

function barcode_esAjax(): bool {
  $header = strtoupper(
    trim((string)($_SERVER["HTTP_X_REQUESTED_WITH"] ?? ""))
  );

  if ($header === "XMLHTTPREQUEST") {
    return true;
  }

  $accept = strtolower(
    (string)($_SERVER["HTTP_ACCEPT"] ?? "")
  );

  return strpos($accept, "application/json") !== false;
}

function barcode_requestId(): string {
  $id = trim((string)($_POST["request_id"] ?? ""));

  if (
    $id === "" ||
    strlen($id) > 80 ||
    !preg_match('/^[A-Za-z0-9._:-]+$/', $id)
  ) {
    return "";
  }

  return $id;
}

/**
 * Normaliza el codigo recibido:
 * - conserva ceros iniciales (siempre trabaja como texto);
 * - quita BOM, espacios y comillas externas del CSV;
 * - unifica a mayusculas, igual que empleados.codigo_barra.
 */
function barcode_normalizarCodigo(string $raw): array {
  $codigo = preg_replace('/^\xEF\xBB\xBF/', '', $raw);
  $codigo = trim((string)$codigo);

  while (strlen($codigo) >= 2) {
    $primero = $codigo[0];
    $ultimo = $codigo[strlen($codigo) - 1];

    if (
      ($primero === '"' && $ultimo === '"') ||
      ($primero === "'" && $ultimo === "'")
    ) {
      $codigo = trim(substr($codigo, 1, -1));
      continue;
    }

    break;
  }

  $codigo = str_replace(["\r", "\n", "\t"], "", $codigo);
  $codigo = strtoupper($codigo);

  if ($codigo === "") {
    return [
      "codigo" => "",
      "error" => "El código de barras está vacío.",
    ];
  }

  if (strlen($codigo) > 50) {
    return [
      "codigo" => "",
      "error" => "El código de barras no debe superar 50 caracteres.",
    ];
  }

  if (
    preg_match('/[\x00-\x1F\x7F]/', $codigo) ||
    preg_match('/[\s"\']/', $codigo)
  ) {
    return [
      "codigo" => "",
      "error" => "El código de barras contiene caracteres no válidos.",
    ];
  }

  return [
    "codigo" => $codigo,
    "error" => null,
  ];
}

function barcode_payload(array $params): array {
  $tipo = (string)($params["barcode_type"] ?? "error");

  if (
    !in_array($tipo, ["success", "error", "warning", "info", "csrf"], true)
  ) {
    $tipo = "error";
  }

  return [
    "ok" => $tipo === "success",
    "type" => $tipo,
    "message" => (string)($params["barcode_msg"] ?? ""),
    "accion" => isset($params["ok_asistencia"])
      ? (string)$params["ok_asistencia"]
      : null,
    "empleado" => isset($params["empleado_nombre"])
      ? (string)$params["empleado_nombre"]
      : null,
    "empleado_id" => isset($params["empleado_id"])
      ? (int)$params["empleado_id"]
      : null,
    "hora" => isset($params["hora"])
      ? (string)$params["hora"]
      : null,
    "estado" => isset($params["estado"])
      ? (string)$params["estado"]
      : null,
    "minutos_tarde" => isset($params["min_tarde"])
      ? (int)$params["min_tarde"]
      : 0,
    "salida_estado" => isset($params["salida_estado"])
      ? (string)$params["salida_estado"]
      : null,
    "minutos_salida_tardia" => isset($params["min_salida_tardia"])
      ? (int)$params["min_salida_tardia"]
      : 0,
    "duplicate" => !empty($params["duplicate"]),
    "request_id" => barcode_requestId(),
  ];
}

function barcode_respuestaGuardada(string $requestId): ?array {
  if ($requestId === "") {
    return null;
  }

  $store = $_SESSION["kiosk_barcode_respuestas"] ?? null;

  if (!is_array($store) || !isset($store[$requestId])) {
    return null;
  }

  $respuesta = $store[$requestId];

  return is_array($respuesta) ? $respuesta : null;
}

function barcode_guardarRespuesta(
  string $requestId,
  array $payload
): void {
  if ($requestId === "" || ($payload["type"] ?? "") === "csrf") {
    return;
  }

  $store = $_SESSION["kiosk_barcode_respuestas"] ?? [];

  if (!is_array($store)) {
    $store = [];
  }

  $store[$requestId] = $payload;

  if (count($store) > 50) {
    $store = array_slice($store, -50, null, true);
  }

  $_SESSION["kiosk_barcode_respuestas"] = $store;
}

function barcode_redirect($url, $params = []) {
  global $redirect_url, $pdo;

  if ($pdo instanceof PDO && $pdo->inTransaction()) {
    if (($params["barcode_type"] ?? "") === "success") {
      try {
        $pdo->commit();
      } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
          $pdo->rollBack();
        }
        error_log("Error al confirmar asistencia: " . $e->getMessage());
        $params = [
          "barcode_msg" => "No se pudo confirmar la asistencia.",
          "barcode_type" => "error"
        ];
      }
    } else {
      $pdo->rollBack();
    }
  }

  $payload = barcode_payload($params);
  barcode_guardarRespuesta(barcode_requestId(), $payload);

  if (barcode_esAjax()) {
    header("Content-Type: application/json; charset=utf-8");
    echo json_encode($payload, JSON_UNESCAPED_UNICODE);
    exit;
  }

  if (($params["barcode_type"] ?? "") === "success" && isset($params["empleado_id"])) {
    $_SESSION["kiosk_ok_empleado_id"] = (int)$params["empleado_id"];
    unset($params["empleado_id"]);
  }

  unset($params["empleado_nombre"]);

  $base = $redirect_url;
  $sep = strpos($base, "?") === false ? "?" : "&";
  foreach ($params as $k => $v) {
    $base .= $sep . urlencode($k) . "=" . urlencode((string)$v);
    $sep = "&";
  }
  header("Location: " . $base);
  exit;
}

function barcode_err($msg, $tipo = "error") {
  barcode_redirect("", ["barcode_msg" => $msg, "barcode_type" => $tipo]);
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  barcode_err("Acceso inválido");
}

$csrf_redirect_url = $redirect_url
  . (strpos($redirect_url, "?") === false ? "?" : "&")
  . "barcode_msg=" . urlencode("Solicitud invalida. Intenta nuevamente.")
  . "&barcode_type=error";

if (barcode_esAjax()) {
  $csrfToken = $_POST["csrf_token"] ?? "";
  $csrfSesion = $_SESSION["csrf_token"] ?? "";

  if (
    !is_string($csrfToken) ||
    !is_string($csrfSesion) ||
    $csrfToken === "" ||
    $csrfSesion === "" ||
    !hash_equals($csrfSesion, $csrfToken)
  ) {
    barcode_err("Solicitud invalida. Intenta nuevamente.", "csrf");
  }
} else {
  verifyCsrfOrRedirect($csrf_redirect_url);
}

$requestId = barcode_requestId();

if ($requestId !== "") {
  $respuestaGuardada = barcode_respuestaGuardada($requestId);

  if ($respuestaGuardada !== null) {
    if (barcode_esAjax()) {
      header("Content-Type: application/json; charset=utf-8");
      echo json_encode($respuestaGuardada, JSON_UNESCAPED_UNICODE);
      exit;
    }

    $paramsGuardados = [
      "barcode_msg" => (string)($respuestaGuardada["message"] ?? ""),
      "barcode_type" => (string)($respuestaGuardada["type"] ?? "error"),
    ];

    foreach ([
      "accion" => "ok_asistencia",
      "empleado_id" => "empleado_id",
      "hora" => "hora",
      "estado" => "estado",
      "minutos_tarde" => "min_tarde",
      "salida_estado" => "salida_estado",
      "minutos_salida_tardia" => "min_salida_tardia",
    ] as $campoPayload => $campoRedirect) {
      if (isset($respuestaGuardada[$campoPayload])) {
        $paramsGuardados[$campoRedirect] = $respuestaGuardada[$campoPayload];
      }
    }

    barcode_redirect("", $paramsGuardados);
  }
}

$ahoraRate = time();
$ventanaRate = $ahoraRate - 60;
$historialIntentos = $_SESSION["kiosk_barcode_rate"] ?? [];

if (!is_array($historialIntentos)) {
  $historialIntentos = [];
}

$intentosRecientes = [];
foreach ($historialIntentos as $tsIntento) {
  $tsIntento = (int)$tsIntento;
  if ($tsIntento >= $ventanaRate) {
    $intentosRecientes[] = $tsIntento;
  }
}

$limiteBarcodeMinuto = defined("BARCODE_RATE_LIMIT_POR_MINUTO")
  ? max(1, (int)constant("BARCODE_RATE_LIMIT_POR_MINUTO"))
  : 120;

if (count($intentosRecientes) >= $limiteBarcodeMinuto) {
  barcode_err("Demasiados intentos. Espera un minuto.");
}

$intentosRecientes[] = $ahoraRate;
$_SESSION["kiosk_barcode_rate"] = $intentosRecientes;

$codigoNormalizado = barcode_normalizarCodigo(
  (string)($_POST["codigo_barra"] ?? "")
);

if ($codigoNormalizado["error"] !== null) {
  barcode_err((string)$codigoNormalizado["error"]);
}

$codigo_barra = (string)$codigoNormalizado["codigo"];

$segundosDuplicado = defined("BARCODE_DUPLICADO_SEGUNDOS")
  ? max(1, (int)constant("BARCODE_DUPLICADO_SEGUNDOS"))
  : 5;

$ultimoBarcode = $_SESSION["kiosk_barcode_ultimo"] ?? null;

if (
  is_array($ultimoBarcode) &&
  (string)($ultimoBarcode["codigo"] ?? "") === $codigo_barra &&
  (time() - (int)($ultimoBarcode["ts"] ?? 0)) < $segundosDuplicado
) {
  barcode_redirect("", [
    "barcode_msg" => "Lectura repetida ignorada. Espera unos segundos antes de volver a escanear.",
    "barcode_type" => "warning",
    "duplicate" => true,
  ]);
}

$empleado = empleadoPorCodigoBarra($pdo, $codigo_barra);
if (!$empleado) {
  barcode_err("No se encontró un empleado con ese código de barras");
}

$empleado_id = (int)$empleado["id"];

$nombreEmpleado = trim(
  (string)$empleado["nombres"] . " " . (string)$empleado["apellidos"]
);

$pdo->beginTransaction();
$stmt = $pdo->prepare("SELECT e.estado, e.turno_id, t.nombre AS turno_nombre, t.hora_inicio, t.hora_fin
  FROM empleados e
  LEFT JOIN turnos t ON t.id = e.turno_id
  WHERE e.id = ? LIMIT 1 FOR UPDATE");
$stmt->execute([$empleado_id]);
$emp = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$emp) {
  barcode_err("Empleado no existe");
}

if (strtoupper(trim((string)$emp["estado"])) !== "ACTIVO") {
  barcode_err("El empleado no está ACTIVO");
}


$tipoTurno = tipoTurnoVentanas(
  (string)($emp["turno_nombre"] ?? ""),
  (int)($emp["turno_id"] ?? 0)
);

$tieneVentanaTurno = $tipoTurno !== null;
if (!$tieneVentanaTurno) {
  barcode_err('Empleado sin turno valido asignado.');
}

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

// Conserva observacion_sistema y la proteccion de concurrencia.
$stmt = $pdo->prepare("SELECT a.id, a.hora_entrada, a.hora_salida, a.estado, a.observacion_sistema,
  a.turno_id_marcaje, a.hora_inicio_marcaje, a.hora_fin_marcaje,
  tm.nombre AS turno_marcaje_nombre
  FROM asistencias a LEFT JOIN turnos tm ON tm.id = a.turno_id_marcaje
  WHERE a.empleado_id=? AND a.fecha=? LIMIT 1");
$stmt->execute([$empleado_id, $fecha_asistencia]);
$asistencia = $stmt->fetch(PDO::FETCH_ASSOC);

$uid = (int)($_SESSION["user"]["id"] ?? ($_SESSION["usuario_id"] ?? 0));
$registrado_por = $uid > 0 ? $uid : null;

if (!$asistencia || empty($asistencia["hora_entrada"])) {
  // Solo la entrada se bloquea por reposos/permisos; la salida de una
  // entrada ya registrada debe poder cerrarse sin quedar atrapada.
  $stmt = $pdo->prepare("SELECT id FROM reposos WHERE empleado_id = ? AND estado = 'ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin LIMIT 1");
  $stmt->execute([$empleado_id, $hoy_real]);
  if ($stmt->fetchColumn() !== false) barcode_err('No puedes marcar: reposo activo');
  $stmt = $pdo->prepare("SELECT id FROM permisos WHERE empleado_id = ? AND estado = 'ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin LIMIT 1");
  $stmt->execute([$empleado_id, $hoy_real]);
  if ($stmt->fetchColumn() !== false) barcode_err('No puedes marcar: permiso activo');

  if ($tieneVentanaTurno) {
    $ventanaEntrada = validarVentanaEntradaTurno(
      $fecha_asistencia,
      $now,
      $tz,
      (string)$tipoTurno,
      (string)$horaInicio,
      $horaFin !== null ? (string)$horaFin : null
    );

    if (!$ventanaEntrada["ok"]) {
      barcode_err((string)$ventanaEntrada["error"]);
    }
  }

  $tolMin = defined("RETARDO_TOLERANCIA_MINUTOS") ? (int)RETARDO_TOLERANCIA_MINUTOS : 0;
  $inicioTurno = new DateTimeImmutable($fecha_asistencia . " " . $horaInicio, $tz);
  $limite = $inicioTurno->modify("+" . $tolMin . " minutes");

  $margenAntesMin = defined("ASISTENCIA_MARGEN_ANTES_MINUTOS") ? max(0, (int)ASISTENCIA_MARGEN_ANTES_MINUTOS) : 0;
  $inicioPermitido = $inicioTurno->modify("-" . $margenAntesMin . " minutes");

  if (!$tieneVentanaTurno && $now->getTimestamp() < $inicioPermitido->getTimestamp()) {
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
    $upd = $pdo->prepare("UPDATE asistencias SET hora_entrada=?, estado=?, minutos_tarde=?, registrado_por=?, turno_id_marcaje=?, hora_inicio_marcaje=?, hora_fin_marcaje=? WHERE id=?");
    $upd->execute([$hora_now, $estado, $min_tarde, $registrado_por, (int)$emp['turno_id'], $horaInicio, $horaFin, (int)$asistencia["id"]]);
  } else {
    $ins = $pdo->prepare("INSERT INTO asistencias (empleado_id, fecha, estado, hora_entrada, minutos_tarde, registrado_por, turno_id_marcaje, hora_inicio_marcaje, hora_fin_marcaje) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $ins->execute([$empleado_id, $fecha_asistencia, $estado, $hora_now, $min_tarde, $registrado_por, (int)$emp['turno_id'], $horaInicio, $horaFin]);
  }

  $msg = "Entrada registrada: " . $empleado["nombres"] . " " . $empleado["apellidos"];

  if ($tieneVentanaTurno) {
    $msg = $estado === "RETARDO"
      ? "Asistencia registrada correctamente. Entrada con retardo."
      : "Asistencia registrada correctamente. Entrada puntual.";
  }

  $_SESSION["kiosk_barcode_ultimo"] = [
    "codigo" => $codigo_barra,
    "ts" => time(),
  ];

  barcode_redirect("", [
    "barcode_msg" => $msg,
    "barcode_type" => "success",
    "ok_asistencia" => "entrada",
    "empleado_id" => $empleado_id,
    "empleado_nombre" => $nombreEmpleado,
    "estado" => $estado,
    "hora" => $hora_now,
    "min_tarde" => $min_tarde
  ]);

} elseif (empty($asistencia["hora_salida"])) {
  if (!empty($asistencia['turno_id_marcaje']) && !empty($asistencia['hora_inicio_marcaje']) && !empty($asistencia['hora_fin_marcaje'])) {
    $horaInicio = (string)$asistencia['hora_inicio_marcaje'];
    $horaFin = (string)$asistencia['hora_fin_marcaje'];
    $tipoTurno = tipoTurnoVentanas((string)($asistencia['turno_marcaje_nombre'] ?? ''), (int)$asistencia['turno_id_marcaje']);
    $tieneVentanaTurno = $tipoTurno !== null;
  }
  if ($tieneVentanaTurno) {
    $ventanaSalida = validarVentanaSalidaTurno(
      $fecha_asistencia,
      $now,
      $tz,
      (string)$tipoTurno,
      (string)$horaInicio,
      $horaFin !== null ? (string)$horaFin : null
    );

    if (!$ventanaSalida["ok"]) {
      barcode_err((string)$ventanaSalida["error"]);
    }
  }

  $salidaCalculada = calcularSalidaAsistencia(
  $fecha_asistencia,
  (string)$asistencia["hora_entrada"],
  (string)$horaInicio,
  $horaFin !== null ? (string)$horaFin : null,
  $now,
  $tz
);

if (!$salidaCalculada["ok"]) {
  barcode_err((string)$salidaCalculada["error"]);
}

$hora_now = (string)$salidaCalculada["hora_salida"];
$horas_trab = (float)$salidaCalculada["horas_trabajadas"];
$salidaEstado = (string)$salidaCalculada["salida_estado"];
$minutosSalidaTardia =
  (int)$salidaCalculada["minutos_salida_tardia"];
$observacionSistema =
  $salidaCalculada["observacion_sistema"];

if ($tieneVentanaTurno) {
  $observacionPrevia = trim((string)($asistencia["observacion_sistema"] ?? ""));
  if ($observacionPrevia !== '') {
    $observacionSistema = trim((string)$observacionSistema) === ''
      ? $observacionPrevia
      : $observacionPrevia . ' | ' . $observacionSistema;
  }
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
  (int)$asistencia["id"]
]);

$msg = "Salida registrada: " . $empleado["nombres"] . " " . $empleado["apellidos"];

if ($tieneVentanaTurno) {
  $msg = "Salida registrada correctamente.";
}

  $_SESSION["kiosk_barcode_ultimo"] = [
    "codigo" => $codigo_barra,
    "ts" => time(),
  ];

  barcode_redirect("", [
    "barcode_msg" => $msg,
    "barcode_type" => "success",
    "ok_asistencia" => "salida",
    "empleado_id" => $empleado_id,
    "empleado_nombre" => $nombreEmpleado,
    "estado" => $asistencia["estado"],
    "hora" => $hora_now,
    "salida_estado" => $salidaEstado,
    "min_salida_tardia" => $minutosSalidaTardia
  ]);

} else {
  $mensajeDuplicado = $tieneVentanaTurno
    ? "Ya existe un registro de entrada y salida para esta jornada."
    : "Ya registró entrada y salida hoy";

  barcode_err($mensajeDuplicado);
}
