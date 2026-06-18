<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Acceso inválido"));
  exit;
}

verifyCsrfOrRedirect(BASE_URL . "/modulos/personal.php?err=" . urlencode("Solicitud inválida. Intenta nuevamente."));
requirePermiso("ver_personal", BASE_URL . "/modulos/personal.php");

$nombres   = trim($_POST["nombres"] ?? "");
$apellidos = trim($_POST["apellidos"] ?? "");
$cedula    = trim($_POST["cedula"] ?? "");
$cargo_id  = (int)($_POST["cargo_id"] ?? 0);
$turno_id  = (int)($_POST["turno_id"] ?? 0);
if ($turno_id > 0) {
  $stmtTurnoScope = $pdo->prepare("SELECT nombre FROM turnos WHERE id = ? LIMIT 1");
  $stmtTurnoScope->execute([$turno_id]);
  $turnoNombreScope = (string)$stmtTurnoScope->fetchColumn();

  if (!puedeVerTurno($turnoNombreScope)) {
    header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("No tienes permiso para registrar personal en ese turno."));
    exit;
  }
}

if ($nombres === "" || $apellidos === "" || $cedula === "" || $cargo_id <= 0 || $turno_id <= 0) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Completa todos los campos (incluye turno)."));
  exit;
}

// Validar cargo existe
$stmt = $pdo->prepare("SELECT id FROM cargos WHERE id=? LIMIT 1");
$stmt->execute([$cargo_id]);
if (!$stmt->fetch()) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Cargo inválido"));
  exit;
}

// Validar turno existe
$stmt = $pdo->prepare("SELECT id FROM turnos WHERE id=? LIMIT 1");
$stmt->execute([$turno_id]);
if (!$stmt->fetch()) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Turno inválido"));
  exit;
}

// Evitar duplicado por cédula
$stmt = $pdo->prepare("SELECT id FROM empleados WHERE cedula=? LIMIT 1");
$stmt->execute([$cedula]);
if ($stmt->fetch()) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Ya existe un empleado con esa cédula"));
  exit;
}

$fotoArchivo = null;

if (isset($_FILES["foto"]) && is_array($_FILES["foto"]) && (int)($_FILES["foto"]["error"] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE) {
    $fotoError = (int)($_FILES["foto"]["error"] ?? UPLOAD_ERR_NO_FILE);

    if ($fotoError !== UPLOAD_ERR_OK) {
        header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("No se pudo cargar la foto"));
        exit;
    }

    $fotoTmp = (string)($_FILES["foto"]["tmp_name"] ?? "");
    $fotoSize = (int)($_FILES["foto"]["size"] ?? 0);

    if ($fotoTmp === "" || !is_uploaded_file($fotoTmp)) {
        header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Foto invalida"));
        exit;
    }

    if ($fotoSize <= 0 || $fotoSize > 2 * 1024 * 1024) {
        header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("La foto no debe superar 2 MB"));
        exit;
    }

    $fotoInfo = @getimagesize($fotoTmp);
    if ($fotoInfo === false) {
        header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("El archivo debe ser una imagen valida"));
        exit;
    }

    $mime = (string)($fotoInfo["mime"] ?? "");
    $mimePermitidos = [
        "image/jpeg" => "jpg",
        "image/png" => "png",
        "image/webp" => "webp",
    ];

    if (!isset($mimePermitidos[$mime])) {
        header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Formato de foto no permitido"));
        exit;
    }

    $uploadDir = __DIR__ . "/../uploads/empleados";
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }

    $cedulaLimpia = preg_replace("/\D+/", "", $cedula);
    $nombreArchivo = "empleado_" . $cedulaLimpia . "_" . bin2hex(random_bytes(8)) . "." . $mimePermitidos[$mime];
    $destino = $uploadDir . "/" . $nombreArchivo;

    if (!move_uploaded_file($fotoTmp, $destino)) {
        header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("No se pudo guardar la foto"));
        exit;
    }

    $fotoArchivo = "uploads/empleados/" . $nombreArchivo;
}
// MB5C: registro seguro de personal con transaccion y limpieza de foto si falla la DB.
try {
  $pdo->beginTransaction();

  $ins = $pdo->prepare("
    INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado, foto_archivo)
      VALUES (?, ?, ?, NULL, ?, 'TURNO', ?, 'ACTIVO', ?)
  ");
  $ins->execute([$cedula, $nombres, $apellidos, $cargo_id, $turno_id, $fotoArchivo]);

  $nuevoEmpleadoId = (int)$pdo->lastInsertId();

  $pdo->commit();

  header("Location: " . BASE_URL . "/modulos/personal.php?msg=" . urlencode("Personal registrado exitosamente") . "&ok_personal=1&empleado_id=" . $nuevoEmpleadoId);
  exit;

} catch (Throwable $e) {
  if ($pdo->inTransaction()) {
    $pdo->rollBack();
  }

  if ($fotoArchivo !== null && $fotoArchivo !== "") {
    $rutaFoto = __DIR__ . "/../" . ltrim((string)$fotoArchivo, "/");
    if (is_file($rutaFoto)) {
      @unlink($rutaFoto);
    }
  }

  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("No se pudo registrar el personal."));
  exit;
}
