<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/conexion.php";

requireLogin();

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");

// Empleados para el select
$empleados = $pdo->query("
  SELECT e.id, CONCAT(e.nombres,' ',e.apellidos) AS nombre, e.cedula, c.nombre AS cargo
  FROM empleados e
  JOIN cargos c ON c.id = e.cargo_id
  ORDER BY e.apellidos, e.nombres
")->fetchAll(PDO::FETCH_ASSOC);

// Lista permisos
$permisos = $pdo->query("
  SELECT
    p.id, p.tipo, p.fecha_inicio, p.fecha_fin, p.motivo, p.observaciones, p.estado, p.creado_en,
    CONCAT(e.nombres,' ',e.apellidos) AS empleado,
    e.cedula,
    c.nombre AS cargo,
    u.usuario AS creado_por_usuario
  FROM permisos p
  JOIN empleados e ON e.id = p.empleado_id
  JOIN cargos c ON c.id = e.cargo_id
  LEFT JOIN usuarios u ON u.id = p.creado_por
  ORDER BY p.id DESC
  LIMIT 50
")->fetchAll(PDO::FETCH_ASSOC);

$pageTitle = "Permisos";
$active = "permisos";
require_once __DIR__ . "/../includes/header.php";
?>

<style>
  /* ===== Permisos: más limpio, menos negrita y más angosto ===== */
  .perm-wrap{
    max-width: 980px;
    margin: 0 auto;
  }

  /* Card principal */
  .perm-card{
    padding: 18px;
  }

  .perm-title{
    font-size: 22px;
    font-weight: 850; /* solo títulos fuertes */
    margin: 0 0 6px 0;
  }
  .perm-sub{
    margin: 0 0 14px 0;
    color:#6c757d;
    font-size: 13px;
    font-weight: 600; /* menos negrita */
    line-height: 1.35;
  }

  /* Form “más angosto” centrado */
  .perm-form{
    background:#fff;
    border:1px solid #e9edf4;
    border-radius:14px;
    padding:14px;
    max-width: 860px;       /* ✅ angosto */
    margin: 0 auto;         /* ✅ centrado */
  }

  .grid{
    display:grid;
    grid-template-columns: 2.2fr 1.3fr 1fr 1fr;
    gap:12px;
    align-items:end;
  }

  .field label{
    display:block;
    font-size:12px;
    font-weight: 650; /* ✅ menos negrita */
    margin:0 0 6px;
    color:#111827;
  }

  .input,.select,textarea{
    width:100%;
    padding:10px 12px;
    border:1px solid #d6dee8;
    border-radius:12px;
    outline:none;
    background:#fff;
    font-weight: 600; /* ✅ menos negrita */
    color:#111827;
  }

  textarea{
    min-height: 48px;
    resize: vertical;
  }

  .input:focus,.select:focus,textarea:focus{
    border-color: rgba(11,110,253,.45);
    box-shadow: 0 0 0 4px rgba(11,110,253,.10);
  }

  /* Observaciones a lo ancho */
  .spanAll{ grid-column: 1 / -1; }

  .actions-row{
    display:flex;
    justify-content:flex-end;
    gap:10px;
    margin-top:12px;
  }

  .btn-primary{
    background:#0b6efd;
    color:#fff;
    border:none;
    padding:10px 14px;
    border-radius:12px;
    cursor:pointer;
    font-weight: 750; /* menos negrita */
    box-shadow: 0 2px 10px rgba(15,23,42,.06);
  }
  .btn-primary:hover{filter:brightness(.98)}
  .btn-light{
    background:#eef2f7;
    color:#111827;
    border:1px solid #d6dee8;
    padding:10px 14px;
    border-radius:12px;
    cursor:pointer;
    font-weight: 700; /* menos negrita */
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
  }

  /* Card tabla */
  .table-card{
    margin-top:14px;
    padding: 18px;
  }
  .table-title{
    font-size: 18px;
    font-weight: 850;
    margin: 0 0 4px 0;
  }
  .table-sub{
    margin: 0 0 10px 0;
    color:#6c757d;
    font-size: 13px;
    font-weight: 600;
  }

  /* Ajuste de tabla (menos negrita en encabezado) */
  table th{
    font-weight: 700 !important;
    font-size: 12px;
  }

  @media (max-width: 980px){
    .perm-form{max-width: 100%;}
    .grid{ grid-template-columns: 1fr 1fr; }
    .span2{ grid-column: span 2; }
    .spanAll{ grid-column: span 2; }
  }
  @media (max-width: 640px){
    .grid{ grid-template-columns: 1fr; }
    .span2,.spanAll{ grid-column: span 1; }
    .actions-row{ justify-content:stretch; }
    .actions-row .btn-primary,
    .actions-row .btn-light{ width:100%; }
  }
</style>

<div class="perm-wrap">

  <div class="card perm-card">
    <div class="perm-title">Permisos</div>
    <p class="perm-sub">
      Registra permisos por rango de fecha. Se reflejan automáticamente en Asistencias mientras estén activos.
    </p>

    <?php if ($msg): ?><div class="alert ok"><?php echo e($msg); ?></div><?php endif; ?>
    <?php if ($err): ?><div class="alert bad"><?php echo e($err); ?></div><?php endif; ?>

    <div class="perm-form">
      <form method="POST" action="../procesos/permiso_guardar.php" id="formPermiso">
        <div class="grid">
          <!-- Empleado -->
          <div class="field span2">
            <label>Empleado</label>
            <select class="select" name="empleado_id" required>
              <option value="">Selecciona un empleado...</option>
              <?php foreach($empleados as $e): ?>
                <option value="<?php echo (int)$e["id"]; ?>">
                  <?php echo e($e["nombre"]); ?> — <?php echo e($e["cedula"]); ?> (<?php echo e($e["cargo"]); ?>)
                </option>
              <?php endforeach; ?>
            </select>
          </div>

          <!-- Tipo -->
          <div class="field">
            <label>Tipo</label>
            <input class="input" name="tipo" placeholder="INSTITUCIONAL / PERSONAL / MÉDICO" required>
          </div>

          <!-- Desde -->
          <div class="field">
            <label>Desde</label>
            <input class="input" type="date" name="fecha_inicio" id="fecha_inicio" required>
          </div>

          <!-- Hasta -->
          <div class="field">
            <label>Hasta</label>
            <input class="input" type="date" name="fecha_fin" id="fecha_fin" required>
          </div>

          <!-- Motivo -->
          <div class="field span2">
            <label>Motivo</label>
            <input class="input" name="motivo" placeholder="Opcional">
          </div>

          <!-- Observaciones -->
          <div class="field spanAll">
            <label>Observaciones</label>
            <textarea name="observaciones" placeholder="Opcional"></textarea>
          </div>
        </div>

        <div class="actions-row">
          <button class="btn-primary" type="submit">Guardar Permiso</button>
          <a class="btn-light" href="permisos.php">Limpiar</a>
        </div>
      </form>
    </div>
  </div>

  <div class="card table-card">
    <div class="table-title">Permisos Registrados</div>
    <p class="table-sub">Últimos 50 registros.</p>

    <table>
      <thead>
        <tr>
          <th>Empleado</th>
          <th>Cédula</th>
          <th>Cargo</th>
          <th>Tipo</th>
          <th>Desde</th>
          <th>Hasta</th>
          <th>Estado</th>
          <th>Registrado por</th>
        </tr>
      </thead>
      <tbody>
        <?php if(!$permisos): ?>
          <tr><td colspan="8">No hay permisos registrados.</td></tr>
        <?php else: ?>
          <?php foreach($permisos as $p): ?>
            <tr>
              <td><?php echo e($p["empleado"]); ?></td>
              <td><?php echo e($p["cedula"]); ?></td>
              <td><?php echo e($p["cargo"]); ?></td>
              <td><?php echo e($p["tipo"]); ?></td>
              <td><?php echo e($p["fecha_inicio"]); ?></td>
              <td><?php echo e($p["fecha_fin"]); ?></td>
              <td><?php echo e($p["estado"]); ?></td>
              <td><?php echo e($p["creado_por_usuario"] ?: "—"); ?></td>
            </tr>
          <?php endforeach; ?>
        <?php endif; ?>
      </tbody>
    </table>
  </div>

</div>

<script>
  // ✅ Coherencia de fechas (desde <= hasta)
  (function(){
    const desde = document.getElementById('fecha_inicio');
    const hasta = document.getElementById('fecha_fin');

    function sync() {
      if (desde.value) hasta.min = desde.value;
      else hasta.removeAttribute('min');

      if (hasta.value) desde.max = hasta.value;
      else desde.removeAttribute('max');
    }

    desde.addEventListener('change', sync);
    hasta.addEventListener('change', sync);
    sync();
  })();
</script>

<?php require_once __DIR__ . "/../includes/footer.php"; ?>
