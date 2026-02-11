<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");

// empleados para el select
$empleados = $pdo->query("
  SELECT e.id, CONCAT(e.nombres,' ',e.apellidos) AS nombre, e.cedula, c.nombre AS cargo
  FROM empleados e
  JOIN cargos c ON c.id = e.cargo_id
  ORDER BY e.apellidos, e.nombres
")->fetchAll(PDO::FETCH_ASSOC);

// lista reposos
$reposos = $pdo->query("
  SELECT
    r.id, r.tipo, r.fecha_inicio, r.fecha_fin, r.motivo, r.observaciones, r.estado, r.creado_en,
    CONCAT(e.nombres,' ',e.apellidos) AS empleado,
    e.cedula,
    c.nombre AS cargo,
    u.usuario AS creado_por_usuario
  FROM reposos r
  JOIN empleados e ON e.id = r.empleado_id
  JOIN cargos c ON c.id = e.cargo_id
  LEFT JOIN usuarios u ON u.id = r.creado_por
  ORDER BY r.id DESC
  LIMIT 50
")->fetchAll(PDO::FETCH_ASSOC);

$pageTitle = "Reposos";
$active = "reposos";
require_once __DIR__ . "/../includes/header.php";
?>

<style>
  /* ====== Reposos (replica visual de Permisos) ====== */

  /* Mantén el card igual que tus módulos, pero el FORM más angosto y centrado */
  .repo-wrap { max-width: 980px; margin: 0 auto; }
  .form-narrow { max-width: 900px; margin: 10px auto 0; }

  /* Caja del formulario (borde suave + padding como en la imagen) */
  .form-box{
    background:#fff;
    border:1px solid #e9edf4;
    border-radius:14px;
    padding:14px;
  }

  /* Grid igual al layout bonito */
  .form-grid{
    display:grid;
    grid-template-columns: 2fr 1.4fr 1fr 1fr;
    gap:12px;
    align-items:end;
  }

  /* spans */
  .span2{ grid-column: span 2; }
  .spanAll{ grid-column: 1 / -1; }

  /* labels: NO demasiado negrita */
  .field label{
    display:block;
    font-size:12px;
    font-weight:700; /* menos pesado */
    margin:0 0 6px;
    color:#111827;
  }

  /* inputs */
  .input, .select, textarea{
    width:100%;
    padding:10px 12px;
    border:1px solid #d6dee8;
    border-radius:12px;
    outline:none;
    background:#fff;
    font-weight:600;
  }
  textarea{ min-height:44px; resize:vertical; }

  .input:focus, .select:focus, textarea:focus{
    border-color: rgba(11,110,253,.45);
    box-shadow: 0 0 0 4px rgba(11,110,253,.10);
  }

  /* fila de botones alineada a la derecha */
  .actions-row{
    display:flex;
    justify-content:flex-end;
    gap:10px;
    margin-top:12px;
  }

  /* Responsive */
  @media (max-width: 980px){
    .form-grid{ grid-template-columns: 1fr 1fr; }
    .span2{ grid-column: span 2; }
    .spanAll{ grid-column: span 2; }
  }
  @media (max-width: 640px){
    .form-grid{ grid-template-columns: 1fr; }
    .span2, .spanAll{ grid-column: span 1; }
    .actions-row{ justify-content:stretch; }
    .actions-row .btn{ width:100%; }
  }
</style>

<div class="repo-wrap">

  <div class="card">
    <div class="h1">Reposos</div>
    <p class="sub">Registro de reposos médicos o justificados.</p>

    <?php if ($msg): ?><div class="alert ok"><?php echo e($msg); ?></div><?php endif; ?>
    <?php if ($err): ?><div class="alert bad"><?php echo e($err); ?></div><?php endif; ?>

    <div class="form-narrow">
      <div class="form-box">
        <form method="POST" action="../procesos/reposo_guardar.php" id="formReposo">
          <div class="form-grid">

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

            <div class="field">
              <label>Tipo</label>
              <input class="input" name="tipo" placeholder="Ej: MÉDICO, ACCIDENTE, POST-OP" required>
            </div>

            <div class="field">
              <label>Desde</label>
              <input class="input" type="date" name="fecha_inicio" id="fecha_inicio" required>
            </div>

            <div class="field">
              <label>Hasta</label>
              <input class="input" type="date" name="fecha_fin" id="fecha_fin" required>
            </div>

            <div class="field span2">
              <label>Motivo</label>
              <input class="input" name="motivo" placeholder="Opcional">
            </div>

            <!-- espacio para mantener simetría -->
            <div class="span2"></div>

            <div class="field spanAll">
              <label>Observaciones</label>
              <textarea name="observaciones" placeholder="Opcional"></textarea>
            </div>

            <div class="spanAll">
              <div class="actions-row">
                <button class="btn btn-primary" type="submit">Guardar Reposo</button>
                <a class="btn btn-light" href="reposos.php" style="text-decoration:none;display:inline-flex;align-items:center;">
                  Limpiar
                </a>
              </div>
            </div>

          </div>
        </form>
      </div>
    </div>
  </div>

  <div class="card" style="margin-top:14px;">
    <div class="h1">Reposos Registrados</div>
    <p class="sub">Últimos 50 registros.</p>

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
        <?php if(!$reposos): ?>
          <tr><td colspan="8">No hay reposos registrados.</td></tr>
        <?php endif; ?>

        <?php foreach($reposos as $r): ?>
          <tr>
            <td><?php echo e($r["empleado"]); ?></td>
            <td><?php echo e($r["cedula"]); ?></td>
            <td><?php echo e($r["cargo"]); ?></td>
            <td><?php echo e($r["tipo"]); ?></td>
            <td><?php echo e($r["fecha_inicio"]); ?></td>
            <td><?php echo e($r["fecha_fin"]); ?></td>
            <td><?php echo e($r["estado"]); ?></td>
            <td><?php echo e($r["creado_por_usuario"] ?: "—"); ?></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>

</div>

<script>
  // ✅ Coherencia: Hasta no puede ser menor que Desde
  (function(){
    const desde = document.getElementById('fecha_inicio');
    const hasta = document.getElementById('fecha_fin');

    function syncMin(){
      if (!desde || !hasta) return;
      if (desde.value) {
        hasta.min = desde.value;
        if (hasta.value && hasta.value < desde.value) {
          hasta.value = desde.value;
        }
      } else {
        hasta.min = "";
      }
    }

    if (desde) desde.addEventListener('change', syncMin);
    if (hasta) hasta.addEventListener('change', syncMin);
    syncMin();
  })();
</script>

<?php require_once __DIR__ . "/../includes/footer.php"; ?>
