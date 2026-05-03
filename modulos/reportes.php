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

// ✅ Empleados para reporte individual
$empleados = $pdo->query("
  SELECT e.id, CONCAT(e.nombres,' ',e.apellidos) AS nombre, e.cedula, c.nombre AS cargo
  FROM empleados e
  JOIN cargos c ON c.id = e.cargo_id
  ORDER BY e.apellidos, e.nombres
")->fetchAll(PDO::FETCH_ASSOC);

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
  .filters-grid-individual{
    display:grid;
    grid-template-columns: 1.5fr 1fr 1fr 0.8fr auto;
    gap:10px;
    align-items:end;
    margin:12px 0 8px;
  }
  .input,.select{padding:10px 12px;border:1px solid #d6dee8;border-radius:12px;background:#fff;width:100%}
  .btn{padding:10px 14px;border-radius:12px;border:none;cursor:pointer;font-weight:900}
  .btnP{background:#0b6fe6;color:#fff}
  .note{color:#6b7280;font-size:13px;margin-top:8px;line-height:1.35}
  .section-divider{border-top:2px solid #e5e7eb;margin:24px 0;padding-top:20px}
  .section-title{font-size:16px;font-weight:900;margin:0 0 4px 0}
  .section-sub{color:#6b7280;font-size:13px;margin:0 0 10px 0}
  .hidden{display:none}
</style>

<div class="card">
  <div class="h1">Módulo de Reportes (PDF)</div>
  <div class="sub">Exporta reportes de asistencia en formato PDF.</div>

  <!-- ===== REPORTE GENERAL ===== -->
  <div class="section-title">Reporte General</div>
  <div class="section-sub">Genera reportes diarios, semanales, quincenales, mensuales y trimestrales con estadísticas de todos los empleados.</div>

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
      - Si colocas <em>Desde</em> y <em>Hasta</em>, se usa ese rango (ideal para "Personalizado").<br>
      - Si no, el sistema calcula el rango según el <em>Periodo</em> y la <em>Fecha base</em>.<br>
      - El estado diario sigue la prioridad: <strong>Reposo</strong> &gt; <strong>Permiso</strong> &gt; <strong>Retardo</strong> &gt; <strong>A tiempo</strong> &gt; <strong>Ausente</strong>.
    </div>
  </form>

  <!-- ===== REPORTE INDIVIDUAL ===== -->
  <div class="section-divider">
    <div class="section-title">Reporte Individual por Empleado</div>
    <div class="section-sub">Genera un reporte PDF con toda la asistencia de un empleado específico.</div>

    <form method="GET" action="<?php echo e(BASE_URL); ?>/procesos/reporte_pdf.php" target="_blank">
      <input type="hidden" name="periodo" value="INDIVIDUAL">

      <div class="filters-grid-individual">
        <div>
          <label style="font-weight:900;font-size:12px;color:#6b7280;">Empleado</label>
          <select class="select" name="empleado_id" required>
            <option value="">Seleccionar empleado...</option>
            <?php foreach($empleados as $emp): ?>
              <option value="<?php echo (int)$emp["id"]; ?>">
                <?php echo eopt($emp["nombre"]); ?> — <?php echo eopt(formatCedula($emp["cedula"])); ?> (<?php echo eopt($emp["cargo"]); ?>)
              </option>
            <?php endforeach; ?>
          </select>
        </div>

        <div>
          <label style="font-weight:900;font-size:12px;color:#6b7280;">Desde</label>
          <input class="input" type="date" name="desde" value="<?php echo e(date('Y-m-01')); ?>">
        </div>

        <div>
          <label style="font-weight:900;font-size:12px;color:#6b7280;">Hasta</label>
          <input class="input" type="date" name="hasta" value="<?php echo e($hoy); ?>">
        </div>

        <div>
          <label style="font-weight:900;font-size:12px;color:#6b7280;">&nbsp;</label>
          <div></div>
        </div>

        <div style="display:flex;gap:10px;align-items:end;">
          <button class="btn btnP" type="submit">Generar PDF Individual</button>
        </div>
      </div>
    </form>
  </div>

</div>

<?php require_once __DIR__ . "/../includes/footer.php"; ?>
