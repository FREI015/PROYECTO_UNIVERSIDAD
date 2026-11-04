<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/auditoria.php";

requireLogin();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Acceso inválido"));
  exit;
}

verifyCsrfOrRedirect(BASE_URL . "/modulos/personal.php?err=" . urlencode("Solicitud inválida. Intenta nuevamente."));
requirePermiso("cambiar_estado_personal", BASE_URL . "/modulos/personal.php");

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
  $stmt = $pdo->prepare("SELECT id, estado FROM empleados WHERE id=? LIMIT 1 FOR UPDATE");
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

  $estadoAnterior = strtoupper(trim((string)$emp['estado']));
  if ($estadoAnterior === $nuevo) {
    $pdo->rollBack();
    header("Location: " . BASE_URL . "/modulos/personal.php?msg=" . urlencode("El empleado ya tiene ese estado."));
    exit;
  }

  if ($accion === "retirar") {
    $upd = $pdo->prepare("UPDATE empleados SET estado=?, condicion_baja=?, fecha_baja=CURDATE() WHERE id=?");
    $upd->execute([$nuevo, $condicion !== "" ? $condicion : null, $id]);

    // Conservar historicos cumplidos, cerrar periodos en curso y anular solo futuros.
    foreach (['permisos', 'reposos'] as $tabla) {
      $pdo->prepare("UPDATE {$tabla} SET estado='CERRADO'
        WHERE empleado_id=? AND estado='ACTIVO' AND fecha_fin < CURDATE()")
          ->execute([$id]);
      $pdo->prepare("UPDATE {$tabla}
        SET fecha_fin=DATE_SUB(CURDATE(), INTERVAL 1 DAY), estado='CERRADO'
        WHERE empleado_id=? AND estado='ACTIVO'
          AND fecha_inicio < CURDATE() AND fecha_fin >= CURDATE()")
          ->execute([$id]);
      $pdo->prepare("UPDATE {$tabla} SET estado='ANULADO'
        WHERE empleado_id=? AND estado='ACTIVO' AND fecha_inicio >= CURDATE()")
          ->execute([$id]);
    }
  } else {
    $upd = $pdo->prepare("UPDATE empleados SET estado=?, condicion_baja=NULL, fecha_baja=NULL WHERE id=?");
    $upd->execute([$nuevo, $id]);
  }

  // El registro de historial y la auditoria se confirman junto al cambio de estado.
  $actorId = (int)($_SESSION['user']['id'] ?? $_SESSION['usuario_id'] ?? 0);
  $logEstado = $pdo->prepare('INSERT INTO empleados_historial_estado (empleado_id, estado_anterior, estado_nuevo, condicion_baja, actor_id) VALUES (?, ?, ?, ?, ?)');
  $logEstado->execute([$id, $estadoAnterior, $nuevo, $accion === 'retirar' && $condicion !== '' ? $condicion : null, $actorId > 0 ? $actorId : null]);
  registrarAuditoria($pdo, 'CAMBIAR_ESTADO', 'empleados', $id, [
    'anterior' => $estadoAnterior, 'nuevo' => $nuevo
  ]);
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

