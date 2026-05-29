<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requirePermiso("ver_reposos", BASE_URL . "/index.php");
function reposoEmpleadoPermitido(PDO $pdo, int $empleadoId): bool {
  if (tieneAlcanceGlobalTurnos()) {
    return true;
  }

  if ($empleadoId <= 0) {
    return false;
  }

  static $cache = [];

  if (array_key_exists($empleadoId, $cache)) {
    return $cache[$empleadoId];
  }

  $stmtScope = $pdo->prepare("
    SELECT t.nombre
    FROM empleados e
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE e.id = ?
    LIMIT 1
  ");
  $stmtScope->execute([$empleadoId]);
  $turnoNombre = (string)$stmtScope->fetchColumn();

  $cache[$empleadoId] = puedeVerTurno($turnoNombre);
  return $cache[$empleadoId];
}

function filtrarRepososPorTurno(PDO $pdo, array $filas, string $idKey): array {
  if (tieneAlcanceGlobalTurnos()) {
    return $filas;
  }

  $filtradas = [];

  foreach ($filas as $fila) {
    $empleadoId = (int)($fila[$idKey] ?? 0);

    if (reposoEmpleadoPermitido($pdo, $empleadoId)) {
      $filtradas[] = $fila;
    }
  }

  return $filtradas;
}

requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");
$pagina = max(1, (int)($_GET["pagina"] ?? 1));
$porPagina = 10;
$offset = ($pagina - 1) * $porPagina;
$turnoWhereSql = "";
$turnoParams = [];

if (!tieneAlcanceGlobalTurnos()) {
  $turnoWhereSql = filtroTurnosPermitidosSql("t", $turnoParams);

  if (trim($turnoWhereSql) === "") {
    $turnoWhereSql = " AND 1 = 0 ";
  }
}

$whereSql = trim($turnoWhereSql) !== "" ? (" WHERE 1 = 1 " . $turnoWhereSql) : "";

// empleados para el select
$sqlEmpleados = "
  SELECT e.id, CONCAT(e.nombres,' ',e.apellidos) AS nombre, e.cedula, c.nombre AS cargo
  FROM empleados e
  JOIN cargos c ON c.id = e.cargo_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  $whereSql
  ORDER BY e.apellidos, e.nombres
";
$stmtEmpleados = $pdo->prepare($sqlEmpleados);
$stmtEmpleados->execute($turnoParams);
$empleados = $stmtEmpleados->fetchAll(PDO::FETCH_ASSOC);

// lista reposos con paginacion
$sqlTotal = "
  SELECT COUNT(*) AS total
  FROM reposos r
  JOIN empleados e ON e.id = r.empleado_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  $whereSql
";
$stmtTotal = $pdo->prepare($sqlTotal);
$stmtTotal->execute($turnoParams);
$totalReposos = (int)($stmtTotal->fetch(PDO::FETCH_ASSOC)["total"] ?? 0);
$totalPaginas = (int)ceil($totalReposos / $porPagina);

$sqlReposos = "
  SELECT
    r.id, r.empleado_id, r.tipo, r.fecha_inicio, r.fecha_fin, r.motivo, r.observaciones, r.estado, r.creado_en,
    CONCAT(e.nombres,' ',e.apellidos) AS empleado,
    e.cedula,
    c.nombre AS cargo,
    u.usuario AS creado_por_usuario
  FROM reposos r
  JOIN empleados e ON e.id = r.empleado_id
  JOIN cargos c ON c.id = e.cargo_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  LEFT JOIN usuarios u ON u.id = r.creado_por
  $whereSql
  ORDER BY r.id DESC
  LIMIT $porPagina OFFSET $offset
";
$stmtReposos = $pdo->prepare($sqlReposos);
$stmtReposos->execute($turnoParams);
$reposos = $stmtReposos->fetchAll(PDO::FETCH_ASSOC);

// Defensa secundaria: conserva filtro PHP por si cambia el SQL.
if (isset($reposos) && is_array($reposos)) {
  $reposos = filtrarRepososPorTurno($pdo, $reposos, "empleado_id");
}

$mostrandoInicio = $totalReposos > 0 ? $offset + 1 : 0;
$mostrandoFin = min($offset + $porPagina, $totalReposos);

$pageTitle = "Reposos";
$active = "reposos";
require_once __DIR__ . "/../includes/header.php";
?>

<style>

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

  .pagination{display:flex;justify-content:space-between;align-items:center;margin-top:14px;padding-top:14px;border-top:1px solid #e5e7eb}
  .pagination-info{color:#6b7280;font-size:13px;font-weight:900}
  .pagination-pages{display:flex;gap:6px}
  .pagination-pages a,.pagination-pages span{padding:8px 14px;border-radius:10px;text-decoration:none;font-weight:900;font-size:13px;display:inline-flex;align-items:center}
  .pagination-pages a{background:#f1f5f9;color:#111}
  .pagination-pages a:hover{background:#e2e8f0}
  .pagination-pages .current{background:#0b6fe6;color:#fff}
  .pagination-pages .disabled{opacity:.4;pointer-events:none}

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
        <form class="reposos-form-modern" method="POST" action="../procesos/reposo_guardar.php" id="formReposo">
    <?php echo csrfInput(); ?>
          <div class="form-grid">

            <div class="field span2">
              <label>Empleado</label>
              <select class="select" name="empleado_id" required>
                <option value="">Selecciona un empleado...</option>
                <?php foreach($empleados as $e): ?>
                  <option value="<?php echo (int)$e["id"]; ?>">
                    <?php echo e($e["nombre"]); ?> — <?php echo e(formatCedula($e["cedula"])); ?> (<?php echo e($e["cargo"]); ?>)
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
    <p class="sub">Listado de reposos registrados.</p>

    <table class="reposos-table-modern">
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
            <td><?php echo e(formatCedula($r["cedula"])); ?></td>
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

    <?php if ($totalPaginas > 0): ?>
    <div class="pagination">
      <div class="pagination-info">
        Mostrando <?php echo $mostrandoInicio; ?>-<?php echo $mostrandoFin; ?> de <?php echo $totalReposos; ?> reposos
      </div>
      <div class="pagination-pages">
        <?php
          function buildUrl($pag) {
            return BASE_URL . "/modulos/reposos.php?pagina=" . $pag;
          }
        ?>
        <a href="<?php echo buildUrl($pagina - 1); ?>" class="<?php echo $pagina <= 1 ? 'disabled' : ''; ?>">‹ Anterior</a>
        <?php for ($i = 1; $i <= $totalPaginas; $i++): ?>
          <a href="<?php echo buildUrl($i); ?>" class="<?php echo $i === $pagina ? 'current' : ''; ?>"><?php echo $i; ?></a>
        <?php endfor; ?>
        <a href="<?php echo buildUrl($pagina + 1); ?>" class="<?php echo $pagina >= $totalPaginas ? 'disabled' : ''; ?>">Siguiente ›</a>
      </div>
    </div>
    <?php endif; ?>
  </div>

</div>

<script>
  // Valida que la fecha final no sea menor que la inicial.
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

  // Limita tipo y motivo a caracteres alfabéticos.
  (function(){
    const tipoInput = document.querySelector('input[name="tipo"]');
    const motivoInput = document.querySelector('input[name="motivo"]');
    const regexNoLetras = /[^a-zA-ZáéíóúÁÉÍÓÚÜüÑñ\s]/g;

    function validarSoloLetras(input) {
      input.addEventListener('input', function() {
        this.value = this.value.replace(regexNoLetras, '');
      });
    }

    if (tipoInput) validarSoloLetras(tipoInput);
    if (motivoInput) validarSoloLetras(motivoInput);
  })();
</script>

<script>
(function(){
  function formatDate(value){
    if (!value || value.indexOf("-") === -1) return "";
    var parts = value.split("-");
    if (parts.length !== 3) return value;
    return parts[2] + "/" + parts[1] + "/" + parts[0];
  }

  function openNativePicker(input){
    try {
      input.focus({ preventScroll:true });
    } catch(e) {
      input.focus();
    }

    try {
      if (typeof input.showPicker === "function") {
        input.showPicker();
      } else {
        input.click();
      }
    } catch(e) {
      try { input.click(); } catch(ignore) {}
    }
  }

  function bindRepososDates(){
    var inputs = Array.prototype.slice.call(document.querySelectorAll("form.reposos-form-modern input[type='date']"));

    inputs.forEach(function(input){
      if (input.dataset.repososDateVisual === "1") return;

      input.dataset.repososDateVisual = "1";
      input.classList.add("reposos-native-date");

      var currentParent = input.parentNode;
      if (!currentParent) return;

      var control = document.createElement("div");
      control.className = "reposos-date-control";
      control.setAttribute("role", "button");
      control.setAttribute("tabindex", "0");

      var value = document.createElement("span");
      value.className = "reposos-date-value";

      var icon = document.createElement("span");
      icon.className = "reposos-date-icon";
      icon.setAttribute("aria-hidden", "true");
      icon.textContent = String.fromCharCode(9638);

      currentParent.insertBefore(control, input);
      control.appendChild(input);
      control.appendChild(value);
      control.appendChild(icon);

      function sync(){
        var text = formatDate(input.value);
        value.textContent = text || "";
        if (text) {
          value.classList.remove("is-empty");
        } else {
          value.classList.add("is-empty");
        }
      }

      control.addEventListener("click", function(){
        openNativePicker(input);
      });

      control.addEventListener("keydown", function(event){
        var key = event.key || "";
        if (key === "Enter" || key === " ") {
          event.preventDefault();
          openNativePicker(input);
        }
      });

      input.addEventListener("change", sync);
      input.addEventListener("input", sync);

      sync();
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", bindRepososDates);
  } else {
    bindRepososDates();
  }
})();
</script>
<?php require_once __DIR__ . "/../includes/footer.php"; ?>


