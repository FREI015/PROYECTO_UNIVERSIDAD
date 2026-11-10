<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/funciones.php';
requireLogin(); requirePermiso('ver_personal', BASE_URL . '/index.php');
require_once __DIR__ . '/../includes/conexion.php';
$id = filter_var($_GET['empleado_id'] ?? null, FILTER_VALIDATE_INT, ['options'=>['min_range'=>1]]);
if (!$id) { http_response_code(404); exit('Empleado no encontrado.'); }
$st = $pdo->prepare('SELECT e.nombres, e.apellidos, t.nombre AS turno FROM empleados e LEFT JOIN turnos t ON t.id=e.turno_id WHERE e.id = ?');
$st->execute([$id]); $emp=$st->fetch(PDO::FETCH_ASSOC);
if (!$emp || !puedeVerTurno($emp['turno'] ?? '')) { http_response_code(404); exit('Empleado no encontrado.'); }
$st = $pdo->prepare('SELECT h.estado_anterior, h.estado_nuevo, h.condicion_baja, h.creado_en, u.usuario FROM empleados_historial_estado h LEFT JOIN usuarios u ON u.id=h.actor_id WHERE h.empleado_id=? ORDER BY h.id DESC LIMIT 100');
$st->execute([$id]); $eventos=$st->fetchAll(PDO::FETCH_ASSOC);
$pageTitle='Historial de personal'; $active='personal'; require_once __DIR__ . '/../includes/header.php';
?>
<style>
.history-back{
  margin:18px 0 0;
}

.history-back-btn{
  display:inline-flex;
  align-items:center;
  gap:8px;
  min-height:42px;
  padding:10px 14px;
  border:1px solid #d6dee8;
  border-radius:12px;
  background:#eef2f7;
  color:#111827;
  font-size:13px;
  font-weight:900;
  text-decoration:none;
  box-shadow:0 2px 10px rgba(15,23,42,.06);
  transition:background .15s ease,border-color .15s ease,transform .08s ease;
}

.history-back-btn:hover{
  background:#e2e8f0;
  border-color:#c8d4e0;
}

.history-back-btn:active{
  transform:translateY(1px);
}

.history-back-btn svg{
  width:16px;
  height:16px;
  display:block;
  fill:none;
  stroke:currentColor;
  stroke-width:2;
  stroke-linecap:round;
  stroke-linejoin:round;
}
</style>
<div class="panel"><h1>Historial laboral</h1><p><?= e($emp['nombres'].' '.$emp['apellidos']) ?></p>
<p>Solo se incluyen movimientos registrados a partir de la instalación de la migración H-18.</p>
<table style="width:100%;border-collapse:collapse"><thead><tr><th>Fecha</th><th>Estado anterior</th><th>Nuevo estado</th><th>Condición</th><th>Registrado por</th></tr></thead><tbody>
<?php foreach ($eventos as $ev): ?><tr><td><?= e($ev['creado_en']) ?></td><td><?= e($ev['estado_anterior']) ?></td>
<td><?= e($ev['estado_nuevo']) ?></td><td><?= e($ev['condicion_baja'] ?: '-') ?></td><td><?= e($ev['usuario'] ?: '-') ?></td></tr><?php endforeach; ?>
</tbody></table><p class="history-back"><a class="history-back-btn" href="<?= e(BASE_URL) ?>/modulos/personal.php"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M19 12H5"></path><path d="M12 19l-7-7 7-7"></path></svg> Volver a Personal</a></p></div>
<?php require_once __DIR__ . '/../includes/footer.php'; ?>
