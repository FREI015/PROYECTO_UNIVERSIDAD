<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
requirePermiso("ver_personal", BASE_URL . "/index.php");
require_once __DIR__ . "/../includes/conexion.php";

$turnosPermitidos = turnosPermitidosPorRol();
$tieneAlcanceGlobal = tieneAlcanceGlobalTurnos();
$puedeCrearPersonal = puede("crear_personal");
$puedeEditarPersonal = puede("editar_personal");
$puedeCambiarEstadoPersonal = puede("cambiar_estado_personal");
$turnoIdsPermitidos = [];

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");
$okPersonal = trim($_GET["ok_personal"] ?? "");
$okEmpleadoId = (int)($_GET["empleado_id"] ?? 0);
$okEmpleado = null;

if ($okPersonal !== "" && $okEmpleadoId > 0) {
  $stmtOk = $pdo->prepare("
    SELECT
      e.id,
      CONCAT(e.nombres, ' ', e.apellidos) AS nombre,
      e.cedula,
      e.estado,
      e.foto_archivo,
      e.codigo_barra,
      c.nombre AS cargo,
      t.nombre AS turno
    FROM empleados e
    LEFT JOIN cargos c ON c.id = e.cargo_id
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE e.id = ?
    LIMIT 1
  ");
  $stmtOk->execute([$okEmpleadoId]);
  $okEmpleado = $stmtOk->fetch(PDO::FETCH_ASSOC) ?: null;
}
$pagina = max(1, (int)($_GET["pagina"] ?? 1));
$orden = trim($_GET["orden"] ?? "");
$filtroEstado = trim($_GET["filtro"] ?? "");
$porPagina = 10;
$offset = ($pagina - 1) * $porPagina;

// Cargos
$cargos = $pdo->query("SELECT id, nombre FROM cargos ORDER BY nombre")->fetchAll(PDO::FETCH_ASSOC);

// Turnos disponibles.
if ($tieneAlcanceGlobal) {
  $turnos = $pdo->query("SELECT id, nombre FROM turnos ORDER BY id")->fetchAll(PDO::FETCH_ASSOC);
} else {
  if ($turnosPermitidos === []) {
    $turnos = [];
  } else {
    $placeholdersTurnos = implode(",", array_fill(0, count($turnosPermitidos), "?"));
    $stmtTurnos = $pdo->prepare("SELECT id, nombre FROM turnos WHERE UPPER(nombre) IN ($placeholdersTurnos) ORDER BY id");
    $stmtTurnos->execute($turnosPermitidos);
    $turnos = $stmtTurnos->fetchAll(PDO::FETCH_ASSOC);
  }

  $turnoIdsPermitidos = array_map("intval", array_column($turnos, "id"));
}

// Filtro por estado.
$whereEstado = "";
$paramsTotal = [];
if ($filtroEstado === "ACTIVO") {
  $whereEstado = " WHERE estado = 'ACTIVO'";
} elseif ($filtroEstado === "SUSPENDIDO") {
  $whereEstado = " WHERE estado = 'SUSPENDIDO'";
} elseif ($filtroEstado === "RETIRADO") {
  $whereEstado = " WHERE estado = 'RETIRADO'";
}

// Personal con paginacion y ordenamiento
if (!isset($params) || !is_array($params)) {
  $params = [];
}

if (!isset($paramsTotal) || !is_array($paramsTotal)) {
  $paramsTotal = [];
}

if (!$tieneAlcanceGlobal) {
  if ($turnoIdsPermitidos === []) {
    if (trim($whereEstado) === "") {
      $whereEstado = " WHERE 1 = 0 ";
    } else {
      $whereEstado .= " AND 1 = 0 ";
    }
  } else {
    $scopeSqlPersonal = " turno_id IN (" . implode(",", array_fill(0, count($turnoIdsPermitidos), "?")) . ") ";

    if (trim($whereEstado) === "") {
      $whereEstado = " WHERE " . $scopeSqlPersonal;
    } else {
      $whereEstado .= " AND " . $scopeSqlPersonal;
    }

    foreach ($turnoIdsPermitidos as $turnoIdPermitido) {
      $params[] = $turnoIdPermitido;
      $paramsTotal[] = $turnoIdPermitido;
    }
  }
}
$stmtTotal = $pdo->prepare("SELECT COUNT(*) AS total FROM empleados" . $whereEstado);
$stmtTotal->execute($paramsTotal);
$totalPersonal = (int)($stmtTotal->fetch(PDO::FETCH_ASSOC)["total"] ?? 0);
$totalPaginas = ceil($totalPersonal / $porPagina);

// Ordenamiento de la lista.
$orderClause = "ORDER BY e.apellidos, e.nombres";
if ($orden === "jerarquia") {
  $orderClause = "ORDER BY c.nombre ASC, e.apellidos ASC, e.nombres ASC";
} elseif ($orden === "alfabetico") {
  $orderClause = "ORDER BY e.nombres ASC, e.apellidos ASC";
}

$personal = $pdo->prepare("
  SELECT e.id, e.cedula, e.estado, e.codigo_barra, e.nombres, e.apellidos, e.cargo_id, e.turno_id, e.foto_archivo,
         CONCAT(
           UCASE(LEFT(TRIM(e.nombres),1)), SUBSTRING(TRIM(e.nombres),2), ' ',
           UCASE(LEFT(TRIM(e.apellidos),1)), SUBSTRING(TRIM(e.apellidos),2)
         ) AS nombre,
         c.nombre AS cargo,
         t.nombre AS turno
  FROM empleados e
  JOIN cargos c ON c.id = e.cargo_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  $whereEstado
  $orderClause
  LIMIT $porPagina OFFSET $offset
");
$personal->execute($paramsTotal);
$personal = $personal->fetchAll(PDO::FETCH_ASSOC);

$mostrandoInicio = $offset + 1;
$mostrandoFin = min($offset + $porPagina, $totalPersonal);

$pageTitle = "Personal del Plantel";
$active = "personal";
require_once __DIR__ . "/../includes/header.php";
?>

<style>
  .pers-wrap{ max-width: 1180px; margin: 0 auto; }
  .pers-card{ padding:18px; }
  .pers-title{ font-size: 22px; font-weight: 850; margin: 0 0 6px 0; }
  .pers-sub{ margin: 0 0 14px 0; color:#6c757d; font-size: 13px; font-weight: 600; line-height: 1.35; }

  .personal-success-card{
    display:flex;
    align-items:center;
    gap:14px;
    padding:14px 16px;
    border:1px solid #bfe7d1;
    background:#ecfdf3;
    border-radius:18px;
    margin:12px 0 16px;
  }
  .personal-success-card .success-title{
    font-weight:900;
    color:#166534;
    margin-bottom:4px;
  }
  .personal-success-card .success-meta{
    color:#334155;
    font-size:13px;
    line-height:1.45;
  }
  .personal-photo{
    width:54px;
    height:54px;
    border-radius:50%;
    object-fit:cover;
    border:1px solid #dbe4ef;
    background:#f3f6fb;
    flex:0 0 auto;
  }
  .personal-photo-empty{
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:900;
    color:#334155;
    font-size:18px;
  }

  .pers-form{
    background:#fff;
    border:1px solid #e9edf4;
    border-radius:14px;
    padding:14px;
    max-width: 860px;
    margin: 0 auto;
  }

  .grid4{
    display:grid;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    gap:12px;
    align-items:end;
  }

  .field label{
    display:block;
    font-size:12px;
    font-weight:650;
    margin:0 0 6px;
    color:#111827;
  }

  .input,.select{
    width:100%;
    padding:10px 12px;
    border:1px solid #d6dee8;
    border-radius:12px;
    outline:none;
    background:#fff;
    font-weight:600;
    color:#111827;
  }

  .input:focus,.select:focus{
    border-color: rgba(11,110,253,.45);
    box-shadow: 0 0 0 4px rgba(11,110,253,.10);
  }

  .span4{ grid-column: 1 / -1; }
  .span2{ grid-column: span 2; }

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
    font-weight:750;
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
    font-weight:700;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
  }

  .table-card{ margin-top:14px; padding:18px; }
  .table-title{ font-size:18px; font-weight:850; margin:0 0 4px 0; }
  .table-sub{ margin:0 0 10px 0; color:#6c757d; font-size:13px; font-weight:600; }

  table th{ font-weight:700 !important; font-size:12px; }

  .personal-table-modern{
    width:100%;
    table-layout:auto;
  }

  .personal-table-modern thead th{
    text-align:left;
    white-space:normal;
    line-height:1.25;
  }

  .personal-table-modern th,
  .personal-table-modern td{
    padding:13px 12px;
  }

  .personal-table-modern tbody td{
    vertical-align:middle;
    word-break:break-word;
    overflow-wrap:break-word;
  }

  .personal-table-modern tbody td:last-child{
    white-space:nowrap;
  }

  .actions-personal{ display:inline-flex; gap:6px; flex-wrap:nowrap; margin:0; vertical-align:middle; }
  .personal-table-modern .btn-editar{
    vertical-align:middle;
    margin-left:2px;
  }
  .btn-action{
    border:1px solid #d6dee8;
    background:#fff;
    padding:8px 10px;
    border-radius:10px;
    cursor:pointer;
    font-weight:700;
    font-size:12px;
  }
  .btn-activar{ background:#dcfce7; border-color:#bbf7d0; color:#166534; }
  .btn-suspender{ background:#fef3c7; border-color:#fde68a; color:#92400e; }
  .btn-retirar{ background:#fee2e2; border-color:#fecaca; color:#991b1b; }
  .btn-editar{ background:#e0f2fe; border-color:#bae6fd; color:#075985; }

  .modal-overlay{position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,.5);display:none;align-items:center;justify-content:center;z-index:9999}
  .modal-overlay.show{display:flex}
  .modal-box{background:#fff;border-radius:16px;padding:24px;max-width:760px;width:94%;box-shadow:0 10px 40px rgba(0,0,0,.2);max-height:92vh;overflow-y:auto}
  .modal-box h3{margin:0 0 4px;font-size:19px}
  .modal-sub{color:#6b7280;font-size:13px;margin:0 0 16px}
  .modal-actions{display:flex;gap:10px;justify-content:flex-end;margin-top:18px}
  .modal-actions .btn-primary{background:#800020;color:#fff;border:0;padding:10px 18px;border-radius:11px;font-weight:800;cursor:pointer}
  .modal-actions .btn-light{background:#f1f5f9;border:1px solid #d6dee8;color:#334155;padding:10px 18px;border-radius:11px;font-weight:700;cursor:pointer;text-decoration:none}
  .edit-preview{width:64px;height:64px;border-radius:14px;object-fit:cover;border:1px solid #d6dee8;margin-bottom:8px}

  .status-suspended{background:#fef3c7;color:#92400e}
  .status-retired{background:#fee2e2;color:#991b1b}

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

  @media (max-width: 980px){
    .pers-form{ max-width: 100%; }
    .grid4{ grid-template-columns: 1fr 1fr; }
    .span2{ grid-column: span 2; }
    .span4{ grid-column: span 2; }
  }

  @media (max-width: 640px){
    .grid4{ grid-template-columns: 1fr; }
    .span2,.span4{ grid-column: span 1; }
    .actions-row{ justify-content:stretch; }
    .actions-row .btn-primary,
    .actions-row .btn-light{ width:100%; }

    .personal-table-modern tbody td:last-child{
      white-space:normal;
    }

    .actions-personal{
      flex-wrap:wrap;
    }
  }
</style>

<div class="pers-wrap">

  <div class="card pers-card">
    <div class="pers-title">Personal del Plantel</div>
    <p class="pers-sub">Registra al personal que aparecerá en Asistencias para marcar entrada/salida.</p>

    <?php if ($msg): ?><div class="alert ok"><?php echo e($msg); ?></div><?php endif; ?>

<?php if ($okPersonal !== ""): ?>
  <?php
    $okNombreRaw = $okEmpleado ? trim((string)($okEmpleado["nombre"] ?? "")) : "Empleado registrado";
    $okNombre = ucwords(strtolower($okNombreRaw));
    $okFotoArchivo = $okEmpleado ? trim((string)($okEmpleado["foto_archivo"] ?? "")) : "";
    $okFotoUrl = $okFotoArchivo !== "" ? BASE_URL . "/" . ltrim($okFotoArchivo, "/") : "";
    $okInicial = strtoupper(substr(trim((string)$okNombre), 0, 1));

    if ($okInicial === "") {
      $okInicial = "-";
    }

    $okCedula = $okEmpleado["cedula"] ?? "";
    $okCargo = $okEmpleado["cargo"] ?? "-";
    $okTurno = $okEmpleado["turno"] ?? "-";
    $okEstadoEmpleado = trim((string)($okEmpleado["estado"] ?? "ACTIVO"));
    $okCodigoBarra = $okEmpleado["codigo_barra"] ?? "";
  ?>

  <div class="personal-success-card" id="personalSuccessCard">
    <?php if ($okFotoUrl !== ""): ?>
      <img class="personal-photo" src="<?php echo e($okFotoUrl); ?>" alt="Foto de <?php echo e($okNombre); ?>">
    <?php else: ?>
      <div class="personal-photo personal-photo-empty"><?php echo e($okInicial); ?></div>
    <?php endif; ?>

    <div>
      <div class="success-title">Personal registrado exitosamente</div>
      <div class="success-meta">
        <strong><?php echo e($okNombre); ?></strong><br>
        <?php if ($okEmpleado): ?>
          Cedula: <?php echo e(formatCedula($okCedula)); ?> |
          Cargo: <?php echo e($okCargo); ?> |
          Turno: <?php echo e($okTurno); ?><br>
          C&oacute;digo de Barras: <strong><?php echo e($okCodigoBarra ?: "—"); ?></strong> |
          Estado del empleado: <?php echo e($okEstadoEmpleado); ?>
        <?php else: ?>
          Registro guardado. No se pudo cargar el resumen completo del empleado.
        <?php endif; ?>
      </div>
    </div>
  </div>
<?php endif; ?>
    <?php if ($err): ?><div class="alert bad"><?php echo e($err); ?></div><?php endif; ?>

    <?php if ($puedeCrearPersonal): ?>
<div class="pers-form">
      <form class="personal-form-modern" method="POST" action="../procesos/personal_guardar.php" id="formPersonal" enctype="multipart/form-data">
    <?php echo csrfInput(); ?>
        <div class="grid4">

          <div class="field">
            <label>Nombres</label>
            <input class="input" name="nombres" id="inputNombres" required placeholder="Ej: María">
          </div>

          <div class="field">
            <label>Apellidos</label>
            <input class="input" name="apellidos" id="inputApellidos" required placeholder="Ej: García">
          </div>

          <div class="field">
            <label>Cédula</label>
            <input class="input" name="cedula" id="inputCedula" required placeholder="Ej: 12345678" inputmode="numeric">
          </div>

          <div class="field">
            <label>Cargo</label>
            <select class="select" name="cargo_id" required>
              <option value="">Seleccione…</option>
              <?php foreach ($cargos as $c): ?>
                <option value="<?php echo (int)$c["id"]; ?>"><?php echo e($c["nombre"]); ?></option>
              <?php endforeach; ?>
            </select>
          </div>

          <div class="field span2">
            <label>Turno</label>
            <select class="select" name="turno_id" required>
              <option value="">Seleccione…</option>
              <?php foreach ($turnos as $t): ?>
                <option value="<?php echo (int)$t["id"]; ?>"><?php echo e($t["nombre"]); ?></option>
              <?php endforeach; ?>
            </select>

        <label>Foto del personal</label>
        <input class="input" type="file" name="foto" id="inputFoto" accept="image/jpeg,image/png,image/webp">
        <small style="display:block;color:#6b7280;margin-top:-6px;margin-bottom:12px">Formatos permitidos: JPG, PNG o WEBP. Máximo 2 MB.</small>
          </div>

          <div class="field span4">
            <label>Código de Barras</label>
            <input class="input" name="codigo_barra" id="inputCodigoBarra" required maxlength="50" inputmode="text" placeholder="Ej: ASIS-4F8E...">
            <small style="display:block;color:#6b7280;margin-top:-6px;margin-bottom:12px">Código del carné. Hasta 50 caracteres, sin espacios.</small>
          </div>

          <div class="span4">
            <div class="actions-row">
              <button class="btn-primary" type="submit">Registrar Personal</button>
              <a href="personal.php" class="btn-light">Limpiar</a>
            </div>
          </div>

        </div>
      </form>
    </div>
<?php endif; ?>
  </div>

    <div class="card table-card">
      <div class="table-title">Listado de Personal</div>
      <p class="table-sub">
        <?php if ($filtroEstado === "ACTIVO"): ?>
          Personal activo registrado.
        <?php elseif ($filtroEstado === "SUSPENDIDO"): ?>
          Personal suspendido registrado.
        <?php elseif ($filtroEstado === "RETIRADO"): ?>
          Personal retirado registrado.
        <?php else: ?>
          Listado de personal registrado.
        <?php endif; ?>
      </p>

    <div style="display:flex;gap:8px;margin-bottom:12px;flex-wrap:wrap">
      <a href="<?php echo BASE_URL; ?>/modulos/personal.php?pagina=1<?php echo $orden === 'jerarquia' ? '' : '&orden=jerarquia'; ?><?php echo $filtroEstado !== '' ? '&filtro=' . $filtroEstado : ''; ?>" 
         class="btn <?php echo $orden === 'jerarquia' ? 'btn-primary' : 'btn-light'; ?>" 
         style="font-size:12px;padding:8px 12px">
        Orden por Cargo
      </a>
      <a href="<?php echo BASE_URL; ?>/modulos/personal.php?pagina=1<?php echo $orden === 'alfabetico' ? '' : '&orden=alfabetico'; ?><?php echo $filtroEstado !== '' ? '&filtro=' . $filtroEstado : ''; ?>" 
         class="btn <?php echo $orden === 'alfabetico' ? 'btn-primary' : 'btn-light'; ?>" 
         style="font-size:12px;padding:8px 12px">
        Orden Alfabético
      </a>
      <div style="border-left:1px solid #d6dee8;margin:0 4px"></div>
      <a href="<?php echo BASE_URL; ?>/modulos/personal.php?pagina=1&filtro=ACTIVO<?php echo $orden !== '' ? '&orden=' . $orden : ''; ?>" 
         class="btn <?php echo $filtroEstado === 'ACTIVO' ? 'btn-primary' : 'btn-light'; ?>" 
         style="font-size:12px;padding:8px 12px">
        Activos
      </a>
      <a href="<?php echo BASE_URL; ?>/modulos/personal.php?pagina=1&filtro=SUSPENDIDO<?php echo $orden !== '' ? '&orden=' . $orden : ''; ?>" 
         class="btn <?php echo $filtroEstado === 'SUSPENDIDO' ? 'btn-primary' : 'btn-light'; ?>" 
         style="font-size:12px;padding:8px 12px">
        Suspendidos
      </a>
      <a href="<?php echo BASE_URL; ?>/modulos/personal.php?pagina=1&filtro=RETIRADO<?php echo $orden !== '' ? '&orden=' . $orden : ''; ?>" 
         class="btn <?php echo $filtroEstado === 'RETIRADO' ? 'btn-primary' : 'btn-light'; ?>" 
         style="font-size:12px;padding:8px 12px">
        Retirados
      </a>
      <a href="<?php echo BASE_URL; ?>/modulos/personal.php?pagina=1" 
         class="btn btn-light" 
         style="font-size:12px;padding:8px 12px">
        Mostrar Todos
      </a>
    </div>

    <table class="personal-table-modern">
      <thead>
        <tr>
          <th>Nombre</th>
          <th>C&eacute;dula</th>
          <th>C&oacute;digo de Barras</th>
          <th>Cargo</th>
          <th>Turno</th>
          <th>Estado</th>
          <th>Acción</th>
        </tr>
      </thead>
      <tbody>
        <?php if (!$personal): ?>
          <tr><td colspan="7">No hay personal registrado.</td></tr>
        <?php endif; ?>

        <?php foreach ($personal as $p): ?>
          <?php $codigoBarra = $p["codigo_barra"] ?? ""; ?>
          <tr>
            <td><?php echo e($p["nombre"]); ?></td>
            <td><?php echo e(formatCedula($p["cedula"])); ?></td>
            <td><code style="font-size:13px;font-weight:700;letter-spacing:1px"><?php echo e(enmascararCodigoBarra($codigoBarra)); ?></code></td>
            <td><?php echo e($p["cargo"]); ?></td>
            <td><?php echo e($p["turno"] ?: "—"); ?></td>
            <td>
              <?php
                $pillClass = "status-present";
                if ($p["estado"] === "SUSPENDIDO") $pillClass = "status-suspended";
                elseif ($p["estado"] === "RETIRADO") $pillClass = "status-retired";
              ?>
              <span class="pill <?php echo $pillClass; ?>">
                <?php echo e($p["estado"]); ?>
              </span>
            </td>
            <td>
              <?php if ($puedeCambiarEstadoPersonal): ?>
                <form method="POST" action="../procesos/personal_estado.php" class="actions-personal">
    <?php echo csrfInput(); ?>
                <input type="hidden" name="id" value="<?php echo (int)$p["id"]; ?>">

                <?php if ($p["estado"] === "ACTIVO"): ?>
                  <button type="submit" name="accion" value="suspender" class="btn-action btn-suspender">Suspender</button>
                  <button type="submit" name="accion" value="retirar" class="btn-action btn-retirar">Retirar</button>

                <?php elseif ($p["estado"] === "SUSPENDIDO"): ?>
                  <button type="submit" name="accion" value="activar" class="btn-action btn-activar">Activar</button>
                  <button type="submit" name="accion" value="retirar" class="btn-action btn-retirar">Retirar</button>

                <?php else: /* RETIRADO */ ?>
                  <button type="submit" name="accion" value="activar" class="btn-action btn-activar">Reingresar</button>
                <?php endif; ?>
              </form>
              <?php else: ?>
                <span class="scope-note">Solo lectura</span>
              <?php endif; ?>
              <?php if ($puedeEditarPersonal): ?>
                <button type="button" class="btn-action btn-editar"
                  data-id="<?php echo (int)$p["id"]; ?>"
                  data-nombres="<?php echo e($p["nombres"] ?? ""); ?>"
                  data-apellidos="<?php echo e($p["apellidos"] ?? ""); ?>"
                  data-cedula="<?php echo e($p["cedula"] ?? ""); ?>"
                  data-cargo-id="<?php echo (int)($p["cargo_id"] ?? 0); ?>"
                  data-turno-id="<?php echo (int)($p["turno_id"] ?? 0); ?>"
                  data-codigo="<?php echo e($p["codigo_barra"] ?? ""); ?>"
                  data-foto="<?php echo e($p["foto_archivo"] ?? ""); ?>">Editar</button>
              <?php endif; ?>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>

    <?php if ($totalPaginas > 0): ?>
    <div class="pagination">
      <div class="pagination-info">
        Mostrando <?php echo $mostrandoInicio; ?>-<?php echo $mostrandoFin; ?> de <?php echo $totalPersonal; ?> personal
      </div>
      <div class="pagination-pages">
        <?php
          function buildUrl($pag) {
            global $orden, $filtroEstado;
            $params = ["pagina" => $pag];
            if ($orden !== "") $params["orden"] = $orden;
            if ($filtroEstado !== "") $params["filtro"] = $filtroEstado;
            return BASE_URL . "/modulos/personal.php?" . http_build_query($params);
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

<div class="modal-overlay" id="modalEditarPersonal">
  <div class="modal-box">
    <h3>Editar Personal</h3>
    <p class="modal-sub">Actualiza los datos del empleado. El código de barras es obligatorio.</p>
    <form method="POST" action="../procesos/personal_actualizar.php" id="formEditarPersonal" enctype="multipart/form-data">
      <?php echo csrfInput(); ?>
      <input type="hidden" name="id" id="editId">
      <div class="grid4">

        <div class="field">
          <label>Nombres</label>
          <input class="input" name="nombres" id="editNombres" required>
        </div>

        <div class="field">
          <label>Apellidos</label>
          <input class="input" name="apellidos" id="editApellidos" required>
        </div>

        <div class="field">
          <label>Cédula</label>
          <input class="input" name="cedula" id="editCedula" required inputmode="numeric">
        </div>

        <div class="field">
          <label>Cargo</label>
          <select class="select" name="cargo_id" id="editCargoId" required>
            <option value="">Seleccione…</option>
            <?php foreach ($cargos as $c): ?>
              <option value="<?php echo (int)$c["id"]; ?>"><?php echo e($c["nombre"]); ?></option>
            <?php endforeach; ?>
          </select>
        </div>

        <div class="field">
          <label>Turno</label>
          <select class="select" name="turno_id" id="editTurnoId" required>
            <option value="">Seleccione…</option>
            <?php foreach ($turnos as $t): ?>
              <option value="<?php echo (int)$t["id"]; ?>"><?php echo e($t["nombre"]); ?></option>
            <?php endforeach; ?>
          </select>
        </div>

        <div class="field span2">
          <label>Código de Barras</label>
          <input class="input" name="codigo_barra" id="editCodigoBarra" required maxlength="50" inputmode="text">
          <small style="display:block;color:#6b7280;margin-top:-6px;margin-bottom:12px">Hasta 50 caracteres, sin espacios.</small>
        </div>

        <div class="field span2">
          <img class="edit-preview" id="editFotoPreview" alt="Foto actual" style="display:none">
          <label>Foto (opcional)</label>
          <input class="input" type="file" name="foto" id="editFoto" accept="image/jpeg,image/png,image/webp">
        </div>

      </div>
      <div class="modal-actions">
        <button type="button" class="btn-light" id="btnCerrarModalEditar">Cancelar</button>
        <button type="submit" class="btn-primary">Guardar Cambios</button>
      </div>
    </form>
  </div>
</div>

<script>
  // Validaciones del formulario de personal.
  (function(){
    const nombresInput = document.getElementById('inputNombres');
    const apellidosInput = document.getElementById('inputApellidos');
    const cedulaInput = document.getElementById('inputCedula');
    const codigoBarraInput = document.getElementById('inputCodigoBarra');
    const editNombres = document.getElementById('editNombres');
    const editApellidos = document.getElementById('editApellidos');
    const editCedula = document.getElementById('editCedula');
    const editCodigoBarra = document.getElementById('editCodigoBarra');
    const regexNoLetras = /[^a-zA-ZáéíóúÁÉÍÓÚÜüÑñ\s]/g;
    const regexNoNumeros = /[^0-9]/g;
    const regexCodigoLimpio = /[\s"']/g;

    // Nombres: solo letras
    if (nombresInput) {
      nombresInput.addEventListener('input', function() {
        this.value = this.value.replace(regexNoLetras, '');
      });
    }

    // Apellidos: solo letras
    if (apellidosInput) {
      apellidosInput.addEventListener('input', function() {
        this.value = this.value.replace(regexNoLetras, '');
      });
    }

    // Cédula: solo números
    if (cedulaInput) {
      cedulaInput.addEventListener('input', function() {
        this.value = this.value.replace(regexNoNumeros, '');
      });
    }

    // Código de barras: quitar espacios y comillas, mayúsculas
    if (codigoBarraInput) {
      codigoBarraInput.addEventListener('input', function() {
        this.value = this.value.replace(regexCodigoLimpio, '').toUpperCase();
      });
    }

    // Limpieza equivalente para el modal de edición.
    if (editNombres) {
      editNombres.addEventListener('input', function() {
        this.value = this.value.replace(regexNoLetras, '');
      });
    }

    if (editApellidos) {
      editApellidos.addEventListener('input', function() {
        this.value = this.value.replace(regexNoLetras, '');
      });
    }

    if (editCedula) {
      editCedula.addEventListener('input', function() {
        this.value = this.value.replace(regexNoNumeros, '');
      });
    }

    if (editCodigoBarra) {
      editCodigoBarra.addEventListener('input', function() {
        this.value = this.value.replace(regexCodigoLimpio, '').toUpperCase();
      });
    }
  })();
</script>

<script>
(function(){
  function markPersonal(){
    var forms = Array.prototype.slice.call(document.querySelectorAll("form"));

    forms.forEach(function(form){
      var hasFile = !!form.querySelector("input[type='file']");
      var hasPersonalFields =
        !!form.querySelector("input[name*='nombre'], input[name*='apellido'], input[name*='cedula'], select[name*='cargo'], select[name*='turno']");
      var hasFilters =
        !!form.querySelector("input[type='search'], input[name*='buscar'], input[name*='q'], select[name*='estado'], select[name*='cargo'], select[name*='turno']");

      if (hasFile || hasPersonalFields) {
        form.classList.add("personal-form-modern");
      }

      if (!hasFile && hasFilters) {
        form.classList.add("personal-filters-modern");
      }
    });

    var fileInputs = Array.prototype.slice.call(document.querySelectorAll("form.personal-form-modern input[type='file']"));

    fileInputs.forEach(function(input){
      input.classList.add("personal-file-input");

      var node = input.parentElement;
      if (node) {
        node.classList.add("personal-photo-field");
      }

      var walker = node;
      var guard = 0;

      while (walker && guard < 4) {
        if (walker.textContent && walker.textContent.toLowerCase().indexOf("formatos permitidos") !== -1) {
          walker.classList.add("personal-photo-block");
          break;
        }

        walker = walker.parentElement;
        guard++;
      }
    });

    var tables = Array.prototype.slice.call(document.querySelectorAll("table"));

    tables.forEach(function(table){
      var text = (table.textContent || "").toLowerCase();
      if (text.indexOf("cedula") !== -1 || text.indexOf("cédula") !== -1 || text.indexOf("cargo") !== -1 || text.indexOf("turno") !== -1) {
        table.classList.add("personal-table-modern");
      }
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", markPersonal);
  } else {
    markPersonal();
  }
})();
</script>

<script>
(function(){
  var modal = document.getElementById('modalEditarPersonal');
  var cerrar = document.getElementById('btnCerrarModalEditar');

  function cerrarModal(){
    if (modal) modal.classList.remove('show');
  }

  function abrirModal(datos){
    if (!modal) return;

    var id = document.getElementById('editId');
    var nombres = document.getElementById('editNombres');
    var apellidos = document.getElementById('editApellidos');
    var cedula = document.getElementById('editCedula');
    var cargoId = document.getElementById('editCargoId');
    var turnoId = document.getElementById('editTurnoId');
    var codigo = document.getElementById('editCodigoBarra');
    var foto = document.getElementById('editFoto');
    var preview = document.getElementById('editFotoPreview');

    if (id) id.value = datos.id || '';
    if (nombres) nombres.value = datos.nombres || '';
    if (apellidos) apellidos.value = datos.apellidos || '';
    if (cedula) cedula.value = datos.cedula || '';
    if (codigo) codigo.value = datos.codigo || '';

    if (cargoId) cargoId.value = datos.cargoId || '';
    if (turnoId) turnoId.value = datos.turnoId || '';

    if (foto) foto.value = '';
    if (preview) {
      if (datos.foto) {
        preview.src = '<?php echo BASE_URL; ?>/' + datos.foto;
        preview.style.display = 'block';
      } else {
        preview.src = '';
        preview.style.display = 'none';
      }
    }

    modal.classList.add('show');
  }

  var botones = Array.prototype.slice.call(document.querySelectorAll('.btn-editar'));
  botones.forEach(function(boton){
    boton.addEventListener('click', function(){
      abrirModal({
        id: boton.getAttribute('data-id'),
        nombres: boton.getAttribute('data-nombres'),
        apellidos: boton.getAttribute('data-apellidos'),
        cedula: boton.getAttribute('data-cedula'),
        cargoId: boton.getAttribute('data-cargo-id'),
        turnoId: boton.getAttribute('data-turno-id'),
        codigo: boton.getAttribute('data-codigo'),
        foto: boton.getAttribute('data-foto')
      });
    });
  });

  if (cerrar) cerrar.addEventListener('click', cerrarModal);
  if (modal) modal.addEventListener('click', function(e){
    if (e.target === modal) cerrarModal();
  });
})();
</script>
<?php require_once __DIR__ . "/../includes/footer.php"; ?>


