<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

$pageTitle = "Reportes";
$active = "reportes";
require_once __DIR__ . "/../includes/header.php";

$hoy = date("Y-m-d");
$turnos = $pdo->query("SELECT id, nombre FROM turnos ORDER BY id")->fetchAll(PDO::FETCH_ASSOC);

function eopt($v){ return htmlspecialchars((string)$v, ENT_QUOTES, "UTF-8"); }
?>

<style>
  .filters-grid{
    display:grid;
    grid-template-columns: 1.1fr 1fr 1fr 1fr 0.8fr auto;
    gap:10px;
    align-items:end;
    margin:12px 0 8px;
  }
  .input,.select{padding:10px 12px;border:1px solid #d6dee8;border-radius:12px;background:#fff;width:100%}
  .btn{padding:10px 14px;border-radius:12px;border:none;cursor:pointer;font-weight:900}
  .btnP{background:#0b6fe6;color:#fff}
  .note{color:#6b7280;font-size:13px;margin-top:8px;line-height:1.35}
</style>

<div class="card">
  <div class="h1">Módulo de Reportes (PDF)</div>
  <div class="sub">Exporta reportes diarios, semanales, quincenales, mensuales y trimestrales con estadísticas de asistencia.</div>

  <form method="GET" action="<?php echo e(BASE_URL); ?>/procesos/reporte_pdf.php" target="_blank">
    <div class="filters-grid">
      <div>
        <label style="font-weight:900;font-size:12px;color:#6b7280;">Periodo</label>
        <select class="select" name="periodo" required>
          <option value="DIARIO">Diario</option>
          <option value="SEMANAL">Semanal</option>
          <option value="QUINCENAL">Quincenal</option>
          <option value="MENSUAL">Mensual</option>
          <option value="TRIMESTRAL">Trimestral</option>
          <option value="PERSONALIZADO">Personalizado (desde/hasta)</option>
        </select>
      </div>

      <div>
        <label style="font-weight:900;font-size:12px;color:#6b7280;">Fecha base</label>
        <input class="input" type="date" name="fecha_base" value="<?php echo e($hoy); ?>">
      </div>

      <div>
        <label style="font-weight:900;font-size:12px;color:#6b7280;">Desde (opcional)</label>
        <input class="input" type="date" name="desde">
      </div>

      <div>
        <label style="font-weight:900;font-size:12px;color:#6b7280;">Hasta (opcional)</label>
        <input class="input" type="date" name="hasta">
      </div>

      <div>
        <label style="font-weight:900;font-size:12px;color:#6b7280;">Turno</label>
        <select class="select" name="turno_id">
          <option value="">Todos</option>
          <?php foreach($turnos as $t): ?>
            <option value="<?php echo (int)$t["id"]; ?>"><?php echo eopt($t["nombre"]); ?></option>
          <?php endforeach; ?>
        </select>
      </div>

      <div style="display:flex;gap:10px;align-items:end;">
        <button class="btn btnP" type="submit">Generar PDF</button>
      </div>
    </div>

    <div class="note">
      <strong>Cómo se toma el rango:</strong><br>
      - Si colocas <em>Desde</em> y <em>Hasta</em>, se usa ese rango (ideal para “Personalizado”).<br>
      - Si no, el sistema calcula el rango según el <em>Periodo</em> y la <em>Fecha base</em>.<br>
      - El estado diario sigue la prioridad: <strong>Reposo</strong> &gt; <strong>Permiso</strong> &gt; <strong>Retardo</strong> &gt; <strong>A tiempo</strong> &gt; <strong>Ausente</strong>.
    </div>
  </form>
</div>

<?php require_once __DIR__ . "/../includes/footer.php"; ?>