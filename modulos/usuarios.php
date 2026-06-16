<?php
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";

requireLogin();
if (!usuarioPuedeAccederModuloUsuarios()) {
  go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("No tienes permiso para administrar usuarios."));
}

$pageTitle = "Usuarios";
$active = "usuarios";

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");
$q = trim($_GET["q"] ?? "");
$rolFiltro = normalizarRolUsuario((string)($_GET["rol"] ?? ""));
$estadoFiltro = normalizarEstadoUsuario((string)($_GET["estado"] ?? ""));
$pagina = max(1, (int)($_GET["pagina"] ?? 1));
$porPagina = 10;
$offset = ($pagina - 1) * $porPagina;

$rolesDisponibles = rolesUsuarioDisponibles();
$estadosDisponibles = estadosUsuarioDisponibles();
$usuarioActualInfo = usuarioActual();
$usuarioActualId = (int)($usuarioActualInfo["id"] ?? ($_SESSION["usuario_id"] ?? 0));

$where = [];
$params = [];

if ($q !== "") {
  $where[] = "usuario LIKE ?";
  $params[] = "%" . $q . "%";
}

if ($rolFiltro !== "" && rolUsuarioValido($rolFiltro)) {
  $where[] = "rol = ?";
  $params[] = $rolFiltro;
}

if ($estadoFiltro !== "" && estadoUsuarioValido($estadoFiltro)) {
  $where[] = "estado = ?";
  $params[] = $estadoFiltro;
}

$whereSql = $where ? ("WHERE " . implode(" AND ", $where)) : "";

$stmtTotal = $pdo->prepare("SELECT COUNT(*) FROM usuarios $whereSql");
$stmtTotal->execute($params);
$totalUsuarios = (int)$stmtTotal->fetchColumn();
$totalPaginas = max(1, (int)ceil($totalUsuarios / $porPagina));

$sql = "
  SELECT id, usuario, rol, estado, creado_en
  FROM usuarios
  $whereSql
  ORDER BY
    CASE rol
      WHEN 'SUPER' THEN 1
      WHEN 'DIRECTORA' THEN 2
      WHEN 'DIURNO' THEN 3
      WHEN 'TARDE' THEN 4
      ELSE 5
    END,
    usuario ASC
  LIMIT $porPagina OFFSET $offset
";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);

$conteos = $pdo->query("
  SELECT rol, estado, COUNT(*) AS total
  FROM usuarios
  GROUP BY rol, estado
  ORDER BY rol, estado
")->fetchAll(PDO::FETCH_ASSOC);

$resumenRoles = [];
foreach ($conteos as $c) {
  $rol = (string)$c["rol"];
  $estado = (string)$c["estado"];

  if (!isset($resumenRoles[$rol])) {
    $resumenRoles[$rol] = ["ACTIVO" => 0, "INACTIVO" => 0, "TOTAL" => 0];
  }

  $resumenRoles[$rol][$estado] = (int)$c["total"];
  $resumenRoles[$rol]["TOTAL"] += (int)$c["total"];
}

function usuarioEstadoClass(string $estado): string {
  return strtoupper($estado) === "ACTIVO" ? "status-active" : "status-inactive";
}

function usuariosUrl(array $extra = []): string {
  $params = array_merge($_GET, $extra);
  foreach ($params as $k => $v) {
    if ($v === "" || $v === null) {
      unset($params[$k]);
    }
  }

  return BASE_URL . "/modulos/usuarios.php" . ($params ? ("?" . http_build_query($params)) : "");
}

require_once __DIR__ . "/../includes/header.php";
?>

<style>
  .usuarios-wrap{ max-width:1180px; margin:0 auto; }
  .usuarios-card{ padding:18px; }
  .usuarios-title{ font-size:22px; font-weight:850; margin:0 0 6px 0; }
  .usuarios-sub{ margin:0 0 14px 0; color:#6c757d; font-size:13px; font-weight:600; line-height:1.35; }

  .metrics-grid{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:12px;
    margin:12px 0 14px;
  }
  .metric-card{
    border:1px solid #e9edf4;
    background:#fff;
    border-radius:14px;
    padding:14px;
  }
  .metric-card .label{
    color:#64748b;
    font-weight:800;
    font-size:12px;
    margin-bottom:6px;
  }
  .metric-card .value{
    color:#111827;
    font-weight:900;
    font-size:24px;
  }

  .create-user-card{
    background:#fff;
    border:1px solid #e9edf4;
    border-radius:14px;
    padding:14px;
    margin-bottom:14px;
  }
  .create-user-title{
    font-size:17px;
    font-weight:900;
    margin:0 0 4px;
    color:#111827;
  }
  .create-user-sub{
    margin:0 0 12px;
    color:#64748b;
    font-size:13px;
    font-weight:650;
  }
  .create-user-grid{
    display:grid;
    grid-template-columns:1.2fr 1fr 1fr 1fr 1fr auto;
    gap:10px;
    align-items:end;
  }

  .filters{
    background:#fff;
    border:1px solid #e9edf4;
    border-radius:14px;
    padding:14px;
    display:grid;
    grid-template-columns:2fr 1fr 1fr auto;
    gap:10px;
    align-items:end;
    margin-bottom:14px;
  }
  .field label{
    display:block;
    font-size:12px;
    font-weight:750;
    margin-bottom:6px;
    color:#111827;
  }
  .input,.select{
    width:100%;
    padding:10px 12px;
    border:1px solid #d6dee8;
    border-radius:12px;
    outline:none;
    background:#fff;
    font-weight:650;
    color:#111827;
  }

  .btn-primary{
    background:#0b6efd;
    color:#fff;
    border:none;
    padding:10px 14px;
    border-radius:12px;
    cursor:pointer;
    font-weight:800;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
  }
  .btn-light{
    background:#eef2f7;
    color:#111827;
    border:1px solid #d6dee8;
    padding:10px 14px;
    border-radius:12px;
    cursor:pointer;
    font-weight:750;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
  }

  .table-card{ padding:18px; }
  .table-title{ font-size:18px; font-weight:850; margin:0 0 4px 0; }
  .table-sub{ margin:0 0 10px 0; color:#6c757d; font-size:13px; font-weight:600; }
  table th{ font-weight:800 !important; font-size:12px; }

  .user-cell{
    display:flex;
    align-items:center;
    gap:10px;
  }
  .user-avatar{
    width:38px;
    height:38px;
    border-radius:50%;
    background:#eef2ff;
    border:1px solid #dbe4ef;
    color:#1e3a8a;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:900;
    flex:0 0 auto;
  }
  .user-name{font-weight:900;color:#111827}
  .user-id{font-size:12px;color:#64748b;font-weight:700}

  .status-active{background:#dcfce7;color:#166534}
  .status-inactive{background:#fee2e2;color:#991b1b}
  .role-chip{
    display:inline-flex;
    padding:6px 10px;
    border-radius:999px;
    background:#eef2f7;
    color:#111827;
    font-weight:800;
    font-size:12px;
  }
  .scope-note{
    font-size:12px;
    color:#64748b;
    font-weight:650;
  }
      .password-users{
    margin-top:8px;
  }
  .password-users form{
    display:grid;
    grid-template-columns:1fr 1fr auto;
    gap:6px;
    align-items:center;
    margin:0;
  }
  .input-mini{
    padding:8px 9px;
    font-size:12px;
    border-radius:10px;
  }
  .btn-password{
    background:#eef2ff;
    border-color:#c7d2fe;
    color:#1e3a8a;
  }
.actions-users{
    display:flex;
    gap:8px;
    flex-wrap:wrap;
  }
  .actions-users form{ margin:0; }
  .btn-action{
    border:1px solid #d6dee8;
    background:#fff;
    padding:8px 10px;
    border-radius:10px;
    cursor:pointer;
    font-weight:800;
    font-size:12px;
  }
  .btn-activate{ background:#dcfce7; border-color:#bbf7d0; color:#166534; }
  .btn-deactivate{ background:#fee2e2; border-color:#fecaca; color:#991b1b; }
.locked-note{
    font-size:12px;
    color:#991b1b;
    font-weight:800;
  }

  .pagination{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-top:14px;
    padding-top:14px;
    border-top:1px solid #e5e7eb;
  }
  .pagination-info{color:#6b7280;font-size:13px;font-weight:900}
  .pagination-pages{display:flex;gap:6px}
  .pagination-pages a,.pagination-pages span{
    padding:8px 14px;
    border-radius:10px;
    text-decoration:none;
    font-weight:900;
    font-size:13px;
    display:inline-flex;
    align-items:center;
  }
  .pagination-pages a{background:#f1f5f9;color:#111}
  .pagination-pages a:hover{background:#e2e8f0}
  .pagination-pages .current{background:#0b6fe6;color:#fff}
  .pagination-pages .disabled{opacity:.4;pointer-events:none}

  @media (max-width:980px){
    .metrics-grid{grid-template-columns:1fr 1fr}
    .create-user-grid{grid-template-columns:1fr 1fr}
    .filters{grid-template-columns:1fr 1fr}
  }

  @media (max-width:640px){
    .metrics-grid{grid-template-columns:1fr}
    .create-user-grid{grid-template-columns:1fr}
    .filters{grid-template-columns:1fr}
  }
</style>

<div class="usuarios-wrap">
  <div class="card usuarios-card">
    <div class="usuarios-title">Administracion de usuarios</div>
    <p class="usuarios-sub">
      Consulta usuarios, roles y estados del sistema. Esta etapa es solo lectura; crear, activar, inactivar y cambiar claves se implementa en las siguientes etapas.
    </p>

    <?php if ($msg): ?><div class="alert ok"><?php echo e($msg); ?></div><?php endif; ?>
    <?php if ($err): ?><div class="alert bad"><?php echo e($err); ?></div><?php endif; ?>

    <div class="metrics-grid">
      <?php foreach ($rolesDisponibles as $rolKey => $rolLabel): ?>
        <?php $r = $resumenRoles[$rolKey] ?? ["ACTIVO" => 0, "INACTIVO" => 0, "TOTAL" => 0]; ?>
        <div class="metric-card">
          <div class="label"><?php echo e($rolLabel); ?></div>
          <div class="value"><?php echo (int)$r["TOTAL"]; ?></div>
          <div class="scope-note">
            Activos: <?php echo (int)$r["ACTIVO"]; ?> · Inactivos: <?php echo (int)$r["INACTIVO"]; ?>
          </div>
        </div>
      <?php endforeach; ?>
    </div>

    <div class="create-user-card">
      <div class="create-user-title">Crear usuario</div>
      <p class="create-user-sub">
        Crea usuarios con clave segura. La clave no se muestra ni queda expuesta en pantalla.
      </p>

      <form method="POST" action="../procesos/usuario_guardar.php" id="formCrearUsuario">
        <?php echo csrfInput(); ?>

        <div class="create-user-grid">
          <div class="field">
            <label>Usuario</label>
            <input class="input" type="text" name="usuario" required minlength="3" maxlength="50" autocomplete="off" placeholder="usuario">
          </div>

          <div class="field">
            <label>Clave</label>
            <input class="input" type="password" name="clave" required minlength="6" autocomplete="new-password" placeholder="Minimo 6 caracteres">
          </div>

          <div class="field">
            <label>Confirmar clave</label>
            <input class="input" type="password" name="clave_confirmar" required minlength="6" autocomplete="new-password">
          </div>

          <div class="field">
            <label>Rol</label>
            <select class="select" name="rol" required>
              <?php foreach ($rolesDisponibles as $rolKey => $rolLabel): ?>
                <?php if (puedeGestionarRolUsuario($rolKey)): ?>
                  <option value="<?php echo e($rolKey); ?>"><?php echo e($rolLabel); ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
            </select>
          </div>

          <div class="field">
            <label>Estado</label>
            <select class="select" name="estado" required>
              <?php foreach ($estadosDisponibles as $estadoKey => $estadoLabel): ?>
                <option value="<?php echo e($estadoKey); ?>" <?php echo $estadoKey === "ACTIVO" ? "selected" : ""; ?>>
                  <?php echo e($estadoLabel); ?>
                </option>
              <?php endforeach; ?>
            </select>
          </div>

          <button class="btn-primary" type="submit">Crear</button>
        </div>
      </form>
    </div>

    <form class="filters" method="GET" action="usuarios.php">
      <div class="field">
        <label>Buscar usuario</label>
        <input class="input" type="text" name="q" value="<?php echo e($q); ?>" placeholder="Usuario">
      </div>

      <div class="field">
        <label>Rol</label>
        <select class="select" name="rol">
          <option value="">Todos</option>
          <?php foreach ($rolesDisponibles as $rolKey => $rolLabel): ?>
            <option value="<?php echo e($rolKey); ?>" <?php echo $rolFiltro === $rolKey ? "selected" : ""; ?>>
              <?php echo e($rolLabel); ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="field">
        <label>Estado</label>
        <select class="select" name="estado">
          <option value="">Todos</option>
          <?php foreach ($estadosDisponibles as $estadoKey => $estadoLabel): ?>
            <option value="<?php echo e($estadoKey); ?>" <?php echo $estadoFiltro === $estadoKey ? "selected" : ""; ?>>
              <?php echo e($estadoLabel); ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <div style="display:flex;gap:8px">
        <button class="btn-primary" type="submit">Filtrar</button>
        <a class="btn-light" href="usuarios.php">Limpiar</a>
      </div>
    </form>
  </div>

  <div class="card table-card">
<div class="users-roles-scope" role="region" aria-label="Alcance de roles">
  <div class="users-roles-scope-header">
    <div>
      <div class="users-roles-scope-title">Alcance de roles</div>
      <p class="users-roles-scope-sub">Guía rápida para seleccionar el rol correcto al crear usuarios. Este bloque es informativo y no cambia permisos internos.</p>
    </div>
  </div>

  <div class="users-roles-scope-grid">
    <div class="users-role-card">
      <div class="users-role-name">Super administrador</div>
      <p>Acceso general al sistema. Recomendado solo para la cuenta principal de administracion.</p>
      <span>Alcance: todos los turnos</span>
    </div>

    <div class="users-role-card">
      <div class="users-role-name">Directora</div>
      <p>Supervisión general de asistencia, personal, reportes, permisos y reposos.</p>
      <span>Alcance: todos los turnos</span>
    </div>

    <div class="users-role-card">
      <div class="users-role-name">Diurno / Matutino</div>
      <p>Usuario operativo limitado al turno de la mañana o jornada matutina.</p>
      <span>Alcance: MATUTINO</span>
    </div>

    <div class="users-role-card">
      <div class="users-role-name">Tarde / Vespertino</div>
      <p>Usuario operativo limitado al turno de la tarde o jornada vespertina.</p>
      <span>Alcance: VESPERTINO</span>
    </div>
  </div>
</div>
<div class="table-title">Usuarios registrados</div>
    <p class="table-sub">
      Solo se muestran datos seguros. Las claves no se imprimen ni se exponen.
    </p>

    <table>
      <thead>
        <tr>
          <th>Usuario</th>
          <th>Rol</th>
          <th>Estado</th>
          <th>Alcance</th>
          <th>Creado</th>
          <th>Gestion</th>
        </tr>
      </thead>
      <tbody>
        <?php if (!$usuarios): ?>
          <tr><td colspan="6">No hay usuarios para mostrar.</td></tr>
        <?php endif; ?>

        <?php foreach ($usuarios as $u): ?>
          <?php
            $usuarioNombre = (string)$u["usuario"];
            $rol = strtoupper((string)$u["rol"]);
            $estado = strtoupper((string)$u["estado"]);
            $inicial = strtoupper(substr($usuarioNombre, 0, 1));
            $puedeGestionar = puedeGestionarUsuarioActual($u);
            $turnos = turnosPermitidosPorRol($rol);
            $alcance = tieneAlcanceGlobalTurnos($rol)
              ? "Todos los turnos"
              : ($turnos ? implode(", ", $turnos) : "Sin alcance definido");
          ?>
          <tr>
            <td>
              <div class="user-cell">
                <div class="user-avatar"><?php echo e($inicial); ?></div>
                <div>
                  <div class="user-name"><?php echo e($usuarioNombre); ?></div>
                  <div class="user-id">ID <?php echo (int)$u["id"]; ?></div>
                </div>
              </div>
            </td>
            <td><span class="role-chip"><?php echo e($rol); ?></span></td>
            <td><span class="status <?php echo e(usuarioEstadoClass($estado)); ?>"><?php echo e($estado); ?></span></td>
            <td><span class="scope-note"><?php echo e($alcance); ?></span></td>
            <td><?php echo e((string)$u["creado_en"]); ?></td>
            <td>
              <?php
                $esUsuarioActual = ((int)$u["id"] === $usuarioActualId);
                $puedeCambiarEstado = $puedeGestionar && !$esUsuarioActual;
                $estadoDestino = $estado === "ACTIVO" ? "INACTIVO" : "ACTIVO";
                $textoAccion = $estadoDestino === "ACTIVO" ? "Activar" : "Inactivar";
                $claseAccion = $estadoDestino === "ACTIVO" ? "btn-activate" : "btn-deactivate";
              ?>

              <?php if ($puedeCambiarEstado): ?>
                <div class="actions-users">
                  <form method="POST" action="../procesos/usuario_estado.php" onsubmit="return confirm('Confirmar cambio de estado del usuario <?php echo e($usuarioNombre); ?>');">
                    <?php echo csrfInput(); ?>
                    <input type="hidden" name="id" value="<?php echo (int)$u["id"]; ?>">
                    <input type="hidden" name="estado" value="<?php echo e($estadoDestino); ?>">
                    <button class="btn-action <?php echo e($claseAccion); ?>" type="submit"><?php echo e($textoAccion); ?></button>
                  </form>
                </div>
              <?php elseif ($esUsuarioActual): ?>
                <span class="locked-note">Cuenta actual</span>
              <?php else: ?>
                <span class="locked-note">Protegido</span>
              <?php endif; ?>

              <?php if ($puedeGestionar): ?>
                <div class="password-users">
                  <form method="POST" action="../procesos/usuario_clave.php" onsubmit="return confirm('Confirmar cambio de clave del usuario <?php echo e($usuarioNombre); ?>');">
                    <?php echo csrfInput(); ?>
                    <input type="hidden" name="id" value="<?php echo (int)$u["id"]; ?>">
                    <input class="input input-mini" type="password" name="clave" minlength="6" required autocomplete="new-password" placeholder="Nueva clave">
                    <input class="input input-mini" type="password" name="clave_confirmar" minlength="6" required autocomplete="new-password" placeholder="Confirmar">
                    <button class="btn-action btn-password" type="submit">Cambiar clave</button>
                  </form>
                </div>
              <?php endif; ?>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>

    <div class="pagination">
      <div class="pagination-info">
        Mostrando <?php echo count($usuarios); ?> de <?php echo (int)$totalUsuarios; ?> usuarios
      </div>
      <div class="pagination-pages">
        <?php if ($pagina > 1): ?>
          <a href="<?php echo e(usuariosUrl(["pagina" => $pagina - 1])); ?>">Anterior</a>
        <?php else: ?>
          <span class="disabled">Anterior</span>
        <?php endif; ?>

        <span class="current"><?php echo (int)$pagina; ?> / <?php echo (int)$totalPaginas; ?></span>

        <?php if ($pagina < $totalPaginas): ?>
          <a href="<?php echo e(usuariosUrl(["pagina" => $pagina + 1])); ?>">Siguiente</a>
        <?php else: ?>
          <span class="disabled">Siguiente</span>
        <?php endif; ?>
      </div>
    </div>
  </div>
</div>

<script>
(function(){
  function textOf(node){
    return (node && node.textContent ? node.textContent : "").toLowerCase();
  }

  function markUsersModule(){
    var forms = Array.prototype.slice.call(document.querySelectorAll("form"));

    forms.forEach(function(form){
      var text = textOf(form);
      var hasUserSearch = !!form.querySelector("input[name*='usuario'], input[name*='buscar'], input[name*='q'], input[type='search']");
      var hasRole = !!form.querySelector("select[name*='rol']");
      var hasEstado = !!form.querySelector("select[name*='estado']");
      var hasPassword = !!form.querySelector("input[type='password'], input[name*='clave'], input[name*='password']");

      if (hasUserSearch || hasRole || hasEstado || text.indexOf("buscar usuario") !== -1) {
        form.classList.add("users-filter-form-modern");
      }

      if (hasPassword || text.indexOf("crear usuario") !== -1 || text.indexOf("clave segura") !== -1) {
        form.classList.add("users-create-form-modern");
      }

      if (hasUserSearch || hasRole || hasEstado || hasPassword) {
        form.classList.add("users-form-modern");
      }
    });

    Array.prototype.slice.call(document.querySelectorAll("table")).forEach(function(table){
      var text = textOf(table);
      if (text.indexOf("usuario") !== -1 && text.indexOf("rol") !== -1 && text.indexOf("estado") !== -1) {
        table.classList.add("users-table-modern");
      }
    });

    Array.prototype.slice.call(document.querySelectorAll(".card, .stat, .metric, .kpi, .role-card, .summary-card, [class*='card'], [class*='stat'], [class*='metric']")).forEach(function(card){
      var text = textOf(card);
      if (text.indexOf("activos") !== -1 && text.indexOf("inactivos") !== -1) {
        card.classList.add("users-summary-card-modern");
      }
    });

    Array.prototype.slice.call(document.querySelectorAll("td")).forEach(function(td){
      var text = textOf(td);
      if (
        text.indexOf("nueva clave") !== -1 ||
        text.indexOf("confirmar") !== -1 ||
        text.indexOf("cambiar clave") !== -1 ||
        text.indexOf("inactivar") !== -1 ||
        text.indexOf("activar") !== -1
      ) {
        td.classList.add("users-management-cell-modern");
      }
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", markUsersModule);
  } else {
    markUsersModule();
  }
})();
</script>
<script>
(function(){
  function textOf(node){
    return (node && node.textContent ? node.textContent : "").toLowerCase();
  }

  function addRoleHelp(){
    var forms = Array.prototype.slice.call(document.querySelectorAll("form"));

    forms.forEach(function(form){
      var text = textOf(form);
      var isCreateForm = text.indexOf("crear usuario") !== -1 || text.indexOf("clave segura") !== -1;
      var roleSelect = form.querySelector("select[name*='rol'], select[name*='role']");

      if (!isCreateForm || !roleSelect) return;

      var parent = roleSelect.parentElement || form;
      if (parent.querySelector(".users-role-help")) return;

      var help = document.createElement("div");
      help.className = "users-role-help";
      help.innerHTML = "<strong>Rol:</strong> define el alcance operativo del usuario. Super administrador y Directora trabajan con todos los turnos; Diurno/Matutino y Tarde/Vespertino limitan el alcance al turno correspondiente.";

      parent.appendChild(help);
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", addRoleHelp);
  } else {
    addRoleHelp();
  }
})();
</script>
<?php require_once __DIR__ . "/../includes/footer.php"; ?>



