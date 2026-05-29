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

  // Actualizar empleado (con condición si la columna existe)
  // Para evitar error si NO existe la columna, hacemos update simple y luego intentamos el extra.
  $upd = $pdo->prepare("UPDATE empleados SET estado=? WHERE id=?");
  $upd->execute([$nuevo, $id]);

  if ($accion === "retirar") {
    // Si existen las columnas, las llenamos (si no existen, lo ignoramos)
    try {
      $upd2 = $pdo->prepare("UPDATE empleados SET condicion_baja=?, fecha_baja=CURDATE() WHERE id=?");
      $upd2->execute([$condicion !== "" ? $condicion : null, $id]);
    } catch (Throwable $e) {
      // Si tu tabla no tiene esas columnas, no rompemos el sistema.
    }

    // Anula permisos y reposos activos al retirar el empleado.
    $pdo->prepare("UPDATE permisos SET estado='ANULADO' WHERE empleado_id=? AND estado='ACTIVO'")
        ->execute([$id]);

    $pdo->prepare("UPDATE reposos SET estado='ANULADO' WHERE empleado_id=? AND estado='ACTIVO'")
        ->execute([$id]);
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

