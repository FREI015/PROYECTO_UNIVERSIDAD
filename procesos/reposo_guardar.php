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
requirePermiso("ver_reposos", BASE_URL . "/modulos/reposos.php");

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

$creado_por = (int)($_SESSION["user"]["id"] ?? $_SESSION["usuario_id"] ?? 0);
$creado_por = $creado_por > 0 ? $creado_por : null;

$ins = $pdo->prepare("
  INSERT INTO reposos (empleado_id, tipo, fecha_inicio, fecha_fin, motivo, observaciones, estado, creado_por, creado_en)
  VALUES (?, ?, ?, ?, ?, ?, 'ACTIVO', ?, NOW())
");
$ins->execute([$empleado_id, $tipo, $fecha_inicio, $fecha_fin, $motivo, $observaciones, $creado_por]);

header("Location: " . BASE_URL . "/modulos/reposos.php?msg=" . urlencode("Reposo guardado"));
exit;

