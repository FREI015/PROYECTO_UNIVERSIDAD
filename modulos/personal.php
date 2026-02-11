<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");

// Cargos
$cargos = $pdo->query("SELECT id, nombre FROM cargos ORDER BY nombre")->fetchAll(PDO::FETCH_ASSOC);

// ✅ Turnos (incluye Turnos Nocturnos)
$turnos = $pdo->query("SELECT id, nombre FROM turnos ORDER BY id")->fetchAll(PDO::FETCH_ASSOC);

// Personal (incluye turno)
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
")->fetchAll(PDO::FETCH_ASSOC);

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
      <form method="POST" action="../procesos/personal_guardar.php">
        <div class="grid4">

          <div class="field">
            <label>Nombres</label>
            <input class="input" name="nombres" required placeholder="Ej: María">
          </div>

          <div class="field">
            <label>Apellidos</label>
            <input class="input" name="apellidos" required placeholder="Ej: García">
          </div>

          <div class="field">
            <label>Cédula</label>
            <input class="input" name="cedula" required placeholder="Ej: 12345678" inputmode="numeric">
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
    <p class="table-sub">Este listado es el que aparece en Asistencias (según filtros y estado).</p>

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
  </div>

</div>

<?php require_once __DIR__ . "/../includes/footer.php"; ?>
