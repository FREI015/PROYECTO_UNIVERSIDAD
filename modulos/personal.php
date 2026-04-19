<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");
$pagina = max(1, (int)($_GET["pagina"] ?? 1));
$porPagina = 10;
$offset = ($pagina - 1) * $porPagina;

// Cargos
$cargos = $pdo->query("SELECT id, nombre FROM cargos ORDER BY nombre")->fetchAll(PDO::FETCH_ASSOC);

// ✅ Turnos (incluye Turnos Nocturnos)
$turnos = $pdo->query("SELECT id, nombre FROM turnos ORDER BY id")->fetchAll(PDO::FETCH_ASSOC);

// Personal (incluye turno) con paginacion
$stmtTotal = $pdo->query("SELECT COUNT(*) AS total FROM empleados");
$totalPersonal = (int)($stmtTotal->fetch(PDO::FETCH_ASSOC)["total"] ?? 0);
$totalPaginas = ceil($totalPersonal / $porPagina);

$personal = $pdo->query("
  SELECT e.id, e.cedula,
         CONCAT(
           UCASE(LEFT(TRIM(e.nombres),1)), SUBSTRING(TRIM(e.nombres),2), ' ',
           UCASE(LEFT(TRIM(e.apellidos),1)), SUBSTRING(TRIM(e.apellidos),2)
         ) AS nombre,
         c.nombre AS cargo,
         t.nombre AS turno,
         e.estado
  FROM empleados e
  JOIN cargos c ON c.id = e.cargo_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  ORDER BY e.apellidos, e.nombres
  LIMIT $porPagina OFFSET $offset
")->fetchAll(PDO::FETCH_ASSOC);

$mostrandoInicio = $offset + 1;
$mostrandoFin = min($offset + $porPagina, $totalPersonal);

$pageTitle = "Personal del Plantel";
$active = "personal";
require_once __DIR__ . "/../includes/header.php";
?>

<style>
  /* ===== PERSONAL: MISMO LOOK & FEEL QUE PERMISOS ===== */
  .pers-wrap{ max-width: 980px; margin: 0 auto; }
  .pers-card{ padding: 18px; }

  .pers-title{ font-size: 22px; font-weight: 850; margin: 0 0 6px 0; }
  .pers-sub{ margin: 0 0 14px 0; color:#6c757d; font-size: 13px; font-weight: 600; line-height: 1.35; }

  .pers-form{
    background:#fff; border:1px solid #e9edf4; border-radius:14px; padding:14px;
    max-width: 860px; margin: 0 auto;
  }

  .grid4{
    display:grid;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    gap:12px;
    align-items:end;
  }

  .field label{
    display:block; font-size:12px; font-weight:650; margin:0 0 6px; color:#111827;
  }

  .input,.select{
    width:100%; padding:10px 12px; border:1px solid #d6dee8; border-radius:12px;
    outline:none; background:#fff; font-weight:600; color:#111827;
  }

  .input:focus,.select:focus{
    border-color: rgba(11,110,253,.45);
    box-shadow: 0 0 0 4px rgba(11,110,253,.10);
  }

  .span4{ grid-column: 1 / -1; }
  .span2{ grid-column: span 2; }

  .actions-row{
    display:flex; justify-content:flex-end; gap:10px; margin-top:12px;
  }

  .btn-primary{
    background:#0b6efd; color:#fff; border:none; padding:10px 14px; border-radius:12px;
    cursor:pointer; font-weight:750; box-shadow: 0 2px 10px rgba(15,23,42,.06);
  }
  .btn-primary:hover{filter:brightness(.98)}

  .btn-light{
    background:#eef2f7; color:#111827; border:1px solid #d6dee8; padding:10px 14px;
    border-radius:12px; cursor:pointer; font-weight:700; text-decoration:none;
    display:inline-flex; align-items:center; justify-content:center;
  }

  .table-card{ margin-top:14px; padding:18px; }
  .table-title{ font-size:18px; font-weight:850; margin:0 0 4px 0; }
  .table-sub{ margin:0 0 10px 0; color:#6c757d; font-size:13px; font-weight:600; }

  table th{ font-weight:700 !important; font-size:12px; }

  .actions-personal{ display:flex; gap:8px; flex-wrap:wrap; }
  .btn-action{
    border:1px solid #d6dee8; background:#fff; padding:8px 10px; border-radius:10px;
    cursor:pointer; font-weight:700; font-size:12px;
  }
  .btn-activar{ background:#dcfce7; border-color:#bbf7d0; color:#166534; }
  .btn-suspender{ background:#fef3c7; border-color:#fde68a; color:#92400e; }
  .btn-retirar{ background:#fee2e2; border-color:#fecaca; color:#991b1b; }

  .pagination{display:flex;justify-content:space-between;align-items:center;margin-top:14px;padding-top:14px;border-top:1px solid #e5e7eb}
  .pagination-info{color:#6b7280;font-size:13px;font-weight:900}
  .pagination-pages{display:flex;gap:6px}
  .pagination-pages a,.pagination-pages span{padding:8px 14px;border-radius:10px;text-decoration:none;font-weight:900;font-size:13px;display:inline-flex;align-items:center}
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
  }
</style>

<div class="pers-wrap">

  <div class="card pers-card">
    <div class="pers-title">Personal del Plantel</div>
    <p class="pers-sub">Registra al personal que aparecerá en Asistencias para marcar entrada/salida.</p>

    <?php if ($msg): ?><div class="alert ok"><?php echo e($msg); ?></div><?php endif; ?>
    <?php if ($err): ?><div class="alert bad"><?php echo e($err); ?></div><?php endif; ?>

    <div class="pers-form">
      <form method="POST" action="../procesos/personal_guardar.php" id="formPersonal">
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

          <!-- ✅ NUEVO: TURNO -->
          <div class="field span2">
            <label>Turno</label>
            <select class="select" name="turno_id" required>
              <option value="">Seleccione…</option>
              <?php foreach ($turnos as $t): ?>
                <option value="<?php echo (int)$t["id"]; ?>"><?php echo e($t["nombre"]); ?></option>
              <?php endforeach; ?>
            </select>
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
  </div>

  <div class="card table-card">
    <div class="table-title">Listado de Personal</div>
    <p class="table-sub">Listado de personal registrado.</p>

    <table>
      <thead>
        <tr>
          <th>Nombre</th>
          <th>Cédula</th>
          <th>Cargo</th>
          <th>Turno</th> <!-- ✅ NUEVO -->
          <th>Estado</th>
          <th>Acción</th>
        </tr>
      </thead>
      <tbody>
        <?php if (!$personal): ?>
          <tr><td colspan="6">No hay personal registrado.</td></tr>
        <?php endif; ?>

        <?php foreach ($personal as $p): ?>
          <tr>
            <td><?php echo e($p["nombre"]); ?></td>
            <td><?php echo e($p["cedula"]); ?></td>
            <td><?php echo e($p["cargo"]); ?></td>
            <td><?php echo e($p["turno"] ?: "—"); ?></td> <!-- Turno del empleado -->
            <td>
              <span class="pill <?php echo ($p["estado"] === "ACTIVO") ? "status-present" : "status-rest"; ?>">
                <?php echo e($p["estado"]); ?>
              </span>
            </td>
            <td>
              <form method="POST" action="../procesos/personal_estado.php" class="actions-personal">
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
            return BASE_URL . "/modulos/personal.php?pagina=" . $pag;
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
  // ✅ Validaciones para Personal
  (function(){
    const nombresInput = document.getElementById('inputNombres');
    const apellidosInput = document.getElementById('inputApellidos');
    const cedulaInput = document.getElementById('inputCedula');
    const regexNoLetras = /[^a-zA-ZáéíóúÁÉÍÓÚÜüÑñ\s]/g;
    const regexNoNumeros = /[^0-9]/g;

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
  })();
</script>

<?php require_once __DIR__ . "/../includes/footer.php"; ?>
