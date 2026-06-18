<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/conexion.php";

requireLogin();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Acceso inválido"));
  exit;
}

verifyCsrfOrRedirect(BASE_URL . "/modulos/personal.php?err=" . urlencode("Solicitud inválida. Intenta nuevamente."));
requirePermiso("ver_personal", BASE_URL . "/modulos/personal.php");

$id = (int)($_POST["id"] ?? 0);
$empleadoScopeId = isset($empleado_id) ? (int)$empleado_id : (int)$id;
if ($empleadoScopeId > 0) {
  $stmtEmpScope = $pdo->prepare("
    SELECT t.nombre
    FROM empleados e
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE e.id = ?
    LIMIT 1
  ");
  $stmtEmpScope->execute([$empleadoScopeId]);
  $turnoNombreScope = (string)$stmtEmpScope->fetchColumn();

  if (!puedeVerTurno($turnoNombreScope)) {
    header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("No tienes permiso para modificar personal de ese turno."));
    exit;
  }
}
$accion = trim((string)($_POST["accion"] ?? ""));

// (Opcional) condición de baja si existe en tu BD
$condicion = trim((string)($_POST["condicion_baja"] ?? ""));

if ($id <= 0) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Empleado inválido"));
  exit;
}

$acciones_validas = ["activar", "suspender", "retirar"];
if (!in_array($accion, $acciones_validas, true)) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Acción inválida"));
  exit;
}

try {
  $pdo->beginTransaction();

  // Buscar empleado
  $stmt = $pdo->prepare("SELECT id, estado FROM empleados WHERE id=? LIMIT 1");
  $stmt->execute([$id]);
  $emp = $stmt->fetch(PDO::FETCH_ASSOC);

  if (!$emp) {
    $pdo->rollBack();
    header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Empleado no existe"));
    exit;
  }

  $nuevo = "ACTIVO";
  if ($accion === "suspender") $nuevo = "SUSPENDIDO";
  if ($accion === "retirar")   $nuevo = "RETIRADO";

  // MB5C: actualizar estado limpio usando columnas reales de baja.
  if ($accion === "retirar") {
    $upd = $pdo->prepare("UPDATE empleados SET estado=?, condicion_baja=?, fecha_baja=CURDATE() WHERE id=?");
    $upd->execute([$nuevo, $condicion !== "" ? $condicion : null, $id]);

    // Anula permisos y reposos activos al retirar el empleado.
    $pdo->prepare("UPDATE permisos SET estado='ANULADO' WHERE empleado_id=? AND estado='ACTIVO'")
        ->execute([$id]);

    $pdo->prepare("UPDATE reposos SET estado='ANULADO' WHERE empleado_id=? AND estado='ACTIVO'")
        ->execute([$id]);
  } else {
    $upd = $pdo->prepare("UPDATE empleados SET estado=?, condicion_baja=NULL, fecha_baja=NULL WHERE id=?");
    $upd->execute([$nuevo, $id]);
  }

  $pdo->commit();

  $msg = "Estado actualizado a $nuevo";
  header("Location: " . BASE_URL . "/modulos/personal.php?msg=" . urlencode($msg));
  exit;

} catch (Throwable $e) {
  if ($pdo->inTransaction()) $pdo->rollBack();
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("No se pudo actualizar el estado del empleado."));
  exit;
}
?>

