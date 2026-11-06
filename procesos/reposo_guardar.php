<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/conexion.php";

requireLogin();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Acceso inválido"));
  exit;
}

verifyCsrfOrRedirect(BASE_URL . "/modulos/reposos.php?err=" . urlencode("Solicitud inválida. Intenta nuevamente."));
requirePermiso("crear_reposos", BASE_URL . "/modulos/reposos.php");

$empleado_id = (int)($_POST["empleado_id"] ?? 0);
if ($empleado_id > 0) {
  $stmtEmpScope = $pdo->prepare("
    SELECT t.nombre
    FROM empleados e
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE e.id = ?
    LIMIT 1
  ");
  $stmtEmpScope->execute([$empleado_id]);
  $turnoNombreScope = (string)$stmtEmpScope->fetchColumn();

  if (!puedeVerTurno($turnoNombreScope)) {
    header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("No tienes permiso para registrar este movimiento para ese turno."));
    exit;
  }
}
$tipo = trim((string)($_POST["tipo"] ?? ""));
$fecha_inicio = trim((string)($_POST["fecha_inicio"] ?? ""));
$fecha_fin = trim((string)($_POST["fecha_fin"] ?? ""));
$motivo = trim((string)($_POST["motivo"] ?? ""));
$observaciones = trim((string)($_POST["observaciones"] ?? ""));

if ($empleado_id <= 0 || $tipo === "" || $fecha_inicio === "" || $fecha_fin === "") {
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Completa los campos requeridos"));
  exit;
}

if ($fecha_fin < $fecha_inicio) {
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Rango de fechas inválido"));
  exit;
}

// Bloquea en el servidor fechas anteriores a hoy (nuevos registros).
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $fecha_inicio) || !preg_match('/^\d{4}-\d{2}-\d{2}$/', $fecha_fin)) {
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Formato de fecha inválido"));
  exit;
}

$hoy = date("Y-m-d");

if ($fecha_inicio < $hoy) {
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("La fecha de inicio no puede ser anterior a hoy"));
  exit;
}

if ($fecha_fin < $hoy) {
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("La fecha final no puede ser anterior a hoy"));
  exit;
}

// Valida que el empleado esté activo.
$st = $pdo->prepare("SELECT estado FROM empleados WHERE id=? LIMIT 1");
$st->execute([$empleado_id]);
$emp = $st->fetch(PDO::FETCH_ASSOC);

if (!$emp) {
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Empleado no existe"));
  exit;
}

if (strtoupper($emp["estado"]) !== "ACTIVO") {
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("No puedes registrar reposos a un empleado NO ACTIVO"));
  exit;
}

$justificativoTmp = null;
$justificativoExt = null;
$justificativoGuardado = null;
$archivoSubido = $_FILES["justificativo"] ?? null;
if ($archivoSubido !== null) {
  if (!is_array($archivoSubido)) {
    header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Archivo invalido."));
    exit;
  }
  $errorArchivo = (int)($archivoSubido["error"] ?? UPLOAD_ERR_NO_FILE);
  if ($errorArchivo !== UPLOAD_ERR_NO_FILE) {
    $tmp = (string)($archivoSubido["tmp_name"] ?? "");
    $size = (int)($archivoSubido["size"] ?? 0);
    if ($errorArchivo !== UPLOAD_ERR_OK || $size <= 0 || $size > 5 * 1024 * 1024 || !is_uploaded_file($tmp)) {
      header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Justificativo invalido o supera 5 MB."));
      exit;
    }
    $mime = (new finfo(FILEINFO_MIME_TYPE))->file($tmp);
    $permitidos = ["application/pdf" => "pdf", "image/jpeg" => "jpg", "image/png" => "png"];
    if (!isset($permitidos[$mime])) {
      header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Solo se permiten PDF, JPG o PNG."));
      exit;
    }
    $justificativoTmp = $tmp;
    $justificativoExt = $permitidos[$mime];
  }
}
$creado_por = (int)($_SESSION["user"]["id"] ?? $_SESSION["usuario_id"] ?? 0);
$creado_por = $creado_por > 0 ? $creado_por : null;

try {
  $pdo->beginTransaction();

  // Serializar la creacion de reposos del mismo empleado.
  $lock = $pdo->prepare("SELECT estado FROM empleados WHERE id = ? FOR UPDATE");
  $lock->execute([$empleado_id]);
  $estadoActual = strtoupper(trim((string)$lock->fetchColumn()));

  if ($estadoActual !== "ACTIVO") {
    $pdo->rollBack();
    header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("El empleado no esta activo."));
    exit;
  }

  // No se puede registrar reposo que invalide una entrada ya efectuada.
  $asistenciaExistente = $pdo->prepare("SELECT id FROM asistencias
    WHERE empleado_id = ? AND fecha BETWEEN ? AND ?
      AND hora_entrada IS NOT NULL LIMIT 1");
  $asistenciaExistente->execute([$empleado_id, $fecha_inicio, $fecha_fin]);
  if ($asistenciaExistente->fetchColumn() !== false) {
    $pdo->rollBack();
    header('Location: ' . BASE_URL . '/modulos/reposos.php?err=' . urlencode('Existe una asistencia registrada en ese periodo. Requiere revision administrativa.'));
    exit;
  }

  // Dos rangos se solapan cuando inicio1 <= fin2 y fin1 >= inicio2.
  $conflicto = $pdo->prepare("
    SELECT id
    FROM reposos
    WHERE empleado_id = ?
      AND estado = 'ACTIVO'
      AND fecha_inicio <= ?
      AND fecha_fin >= ?
    LIMIT 1
  ");

  $conflicto->execute([$empleado_id, $fecha_fin, $fecha_inicio]);

  if ($conflicto->fetchColumn() !== false) {
    $pdo->rollBack();
    header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Ya existe un reposo activo que coincide con esas fechas."));
    exit;
  }

  // Un reposo no puede coincidir con un permiso activo del empleado.
  $conflictoPermiso = $pdo->prepare("
    SELECT id FROM permisos
    WHERE empleado_id = ? AND estado = 'ACTIVO'
      AND fecha_inicio <= ? AND fecha_fin >= ?
    LIMIT 1
  ");
  $conflictoPermiso->execute([$empleado_id, $fecha_fin, $fecha_inicio]);
  if ($conflictoPermiso->fetchColumn() !== false) {
    $pdo->rollBack();
    header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("Las fechas coinciden con un permiso activo."));
    exit;
  }

  $justificativoRuta = null;
  if ($justificativoTmp !== null) {
    $justificativoRuta = "uploads/justificativos/" . bin2hex(random_bytes(16)) . "." . $justificativoExt;
    $destinoJustificativo = __DIR__ . "/../" . $justificativoRuta;
    if (!is_dir(dirname($destinoJustificativo)) || !move_uploaded_file($justificativoTmp, $destinoJustificativo)) {
      throw new RuntimeException("No fue posible guardar el justificativo.");
    }
    $justificativoGuardado = $destinoJustificativo;
  }
  $ins = $pdo->prepare("
    INSERT INTO reposos (empleado_id, tipo, fecha_inicio, fecha_fin, motivo, observaciones, justificativo_archivo, estado, creado_por, creado_en)
    VALUES (?, ?, ?, ?, ?, ?, ?, 'ACTIVO', ?, NOW())
  ");

  $ins->execute([$empleado_id, $tipo, $fecha_inicio, $fecha_fin, $motivo, $observaciones, $justificativoRuta, $creado_por]);

  require_once __DIR__ . '/../includes/auditoria.php';
  registrarAuditoria($pdo, 'CREAR_REPOSO', 'reposos', (int)$pdo->lastInsertId(), ['empleado_id' => $empleado_id]);
  $pdo->commit();

} catch (Throwable $e) {
  if ($pdo->inTransaction()) {
    $pdo->rollBack();
  }

  if ($justificativoGuardado !== null && is_file($justificativoGuardado)) {
    @unlink($justificativoGuardado);
  }
  error_log("Error al guardar reposo: " . $e->getMessage());
  header("Location: " . BASE_URL . "/modulos/reposos.php?err=" . urlencode("No se pudo guardar el reposo."));
  exit;
}

header("Location: " . BASE_URL . "/modulos/reposos.php?msg=" . urlencode("Reposo guardado"));
exit;

