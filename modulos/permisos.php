<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";

// 24A1_GUARD_MODULO_SENSIBLE
if (empty($_SESSION["user"]) && empty($_SESSION["usuario_id"]) && empty($_SESSION["usuario"])) {
  go(BASE_URL . "/login.php?next=" . urlencode(BASE_URL . "/modulos/permisos.php"));
}

requirePermiso("ver_permisos", BASE_URL . "/modulos/asistencias.php");
// permisos24A3_TURNO_HELPERS
function permisos24A3_empleadoPermitido(PDO $pdo, int $empleadoId): bool {
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

function permisos24A3_filtrarPorTurno(PDO $pdo, array $filas, string $idKey): array {
  if (tieneAlcanceGlobalTurnos()) {
    return $filas;
  }

  $filtradas = [];

  foreach ($filas as $fila) {
    $empleadoId = (int)($fila[$idKey] ?? 0);

    if (permisos24A3_empleadoPermitido($pdo, $empleadoId)) {
      $filtradas[] = $fila;
    }
  }

  return $filtradas;
}


require_once __DIR__ . "/../includes/conexion.php";

requireLogin();

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");
$pagina = max(1, (int)($_GET["pagina"] ?? 1));
$porPagina = 10;
$offset = ($pagina - 1) * $porPagina;

// 24B1_PERMISOS_SQL_REAL
$turnoWhereSql = "";
$turnoParams = [];

if (!tieneAlcanceGlobalTurnos()) {
  $turnoWhereSql = filtroTurnosPermitidosSql("t", $turnoParams);

  if (trim($turnoWhereSql) === "") {
    $turnoWhereSql = " AND 1 = 0 ";
  }
}

$whereSql = trim($turnoWhereSql) !== "" ? (" WHERE 1 = 1 " . $turnoWhereSql) : "";

// Empleados para el select
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

// Lista permisos con paginacion
$sqlTotal = "
  SELECT COUNT(*) AS total
  FROM permisos p
  JOIN empleados e ON e.id = p.empleado_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  $whereSql
";
$stmtTotal = $pdo->prepare($sqlTotal);
$stmtTotal->execute($turnoParams);
$totalPermisos = (int)($stmtTotal->fetch(PDO::FETCH_ASSOC)["total"] ?? 0);
$totalPaginas = (int)ceil($totalPermisos / $porPagina);

$sqlPermisos = "
  SELECT
    p.id, p.empleado_id, p.tipo, p.fecha_inicio, p.fecha_fin, p.motivo, p.observaciones, p.estado, p.creado_en,
    CONCAT(e.nombres,' ',e.apellidos) AS empleado,
    e.cedula,
    c.nombre AS cargo,
    u.usuario AS creado_por_usuario
  FROM permisos p
  JOIN empleados e ON e.id = p.empleado_id
  JOIN cargos c ON c.id = e.cargo_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  LEFT JOIN usuarios u ON u.id = p.creado_por
  $whereSql
  ORDER BY p.id DESC
  LIMIT $porPagina OFFSET $offset
";
$stmtPermisos = $pdo->prepare($sqlPermisos);
$stmtPermisos->execute($turnoParams);
$permisos = $stmtPermisos->fetchAll(PDO::FETCH_ASSOC);

// Defensa secundaria: conserva filtro PHP por si cambia el SQL.
if (isset($permisos) && is_array($permisos)) {
  $permisos = permisos24A3_filtrarPorTurno($pdo, $permisos, "empleado_id");
}

$mostrandoInicio = $totalPermisos > 0 ? $offset + 1 : 0;
$mostrandoFin = min($offset + $porPagina, $totalPermisos);

$pageTitle = "Permisos";
$active = "permisos";
require_once __DIR__ . "/../includes/header.php";
?>

<style>

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
    font-weight: 600;
    line-height: 1.35;
  }
  .perm-form{
    background:#fff;
    border:1px solid #e9edf4;
    border-radius:14px;
    padding:14px;
    max-width: 860px;
    margin: 0 auto;
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
    font-weight: 650;
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
    font-weight: 600;
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
    font-weight: 750;
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
    font-weight: 700;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
  }

  .pagination{display:flex;justify-content:space-between;align-items:center;margin-top:14px;padding-top:14px;border-top:1px solid #e5e7eb}
  .pagination-info{color:#6b7280;font-size:13px;font-weight:900}
  .pagination-pages{display:flex;gap:6px}
  .pagination-pages a,.pagination-pages span{padding:8px 14px;border-radius:10px;text-decoration:none;font-weight:900;font-size:13px;display:inline-flex;align-items:center}
  .pagination-pages a{background:#f1f5f9;color:#111}
  .pagination-pages a:hover{background:#e2e8f0}
  .pagination-pages .current{background:#0b6fe6;color:#fff}
  .pagination-pages .disabled{opacity:.4;pointer-events:none}

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
      <form class="permissions-form-modern" method="POST" action="../procesos/permiso_guardar.php" id="formPermiso">
    <?php echo csrfInput(); ?>
        <div class="grid">
          <!-- Empleado -->
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

    <table class="permissions-table-modern">
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
              <td><?php echo e(formatCedula($p["cedula"])); ?></td>
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

    <?php if ($totalPaginas > 0): ?>
    <div class="pagination">
      <div class="pagination-info">
        Mostrando <?php echo $mostrandoInicio; ?>-<?php echo $mostrandoFin; ?> de <?php echo $totalPermisos; ?> permisos
      </div>
      <div class="pagination-pages">
        <?php
          function buildUrl($pag) {
            return BASE_URL . "/modulos/permisos.php?pagina=" . $pag;
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
/* 25A2K5_PERMISOS_DATE_VISUAL */
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
      }
    } catch(e) {}
  }

  function bindPermissionDates(){
    var inputs = Array.prototype.slice.call(document.querySelectorAll("#formPermiso input[type='date']"));

    inputs.forEach(function(input){
      if (input.dataset.permissionDateVisual === "1") return;

      input.dataset.permissionDateVisual = "1";
      input.classList.add("permission-native-date");

      var currentParent = input.parentNode;
      if (!currentParent) return;

      var control = document.createElement("div");
      control.className = "permission-date-control";
      control.setAttribute("role", "button");
      control.setAttribute("tabindex", "0");

      var value = document.createElement("span");
      value.className = "permission-date-value";

      var icon = document.createElement("span");
      icon.className = "permission-date-icon";
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
    document.addEventListener("DOMContentLoaded", bindPermissionDates);
  } else {
    bindPermissionDates();
  }
})();
</script>
<?php require_once __DIR__ . "/../includes/footer.php"; ?>
