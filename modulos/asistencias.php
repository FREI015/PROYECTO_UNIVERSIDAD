<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

date_default_timezone_set("America/Caracas");

$pageTitle = "Gestión de Asistencias";
$active = "asistencias";
require_once __DIR__ . "/../includes/header.php";

$hoy = date("Y-m-d");

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");

$q = trim($_GET["q"] ?? "");
$estadoFiltro = trim($_GET["estado"] ?? "");
$turnoFiltro  = trim($_GET["turno"] ?? "");
$desde = trim($_GET["desde"] ?? "");
$hasta = trim($_GET["hasta"] ?? "");

$turnos = $pdo->query("SELECT id, nombre FROM turnos ORDER BY id")->fetchAll(PDO::FETCH_ASSOC);

function statusClass($status) {
  switch ($status) {
    case "En Servicio":      return "status-present";
    case "Retardo":          return "status-late";
    case "Reposo":           return "status-rest";
    case "Permiso":          return "status-justified";
    case "Ausente":          return "status-unjustified";
    case "Desincorporado":   return "status-disabled";
    case "Suspendido":       return "status-disabled";
    default:                 return "status-unjustified";
  }
}

function titleCaseEs($s) {
  $s = trim((string)$s);
  if ($s === "") return "";
  $s = mb_strtolower($s, "UTF-8");
  return mb_convert_case($s, MB_CASE_TITLE, "UTF-8");
}

function estadoEmpleadoLabel($estadoEmpRaw) {
  $estado = strtoupper(trim((string)$estadoEmpRaw));
  if ($estado === "ACTIVO") return "ACTIVO";
  if ($estado === "SUSPENDIDO") return "Suspendido";
  return "Desincorporado";
}

function empleadoNoActivo($estadoEmpRaw) {
  return strtoupper(trim((string)$estadoEmpRaw)) !== "ACTIVO";
}

$turnoWhereParte = "";
$turnoParamsParte = [];
if ($turnoFiltro !== "") {
  $turnoWhereParte = " AND e.turno_id = ? ";
  $turnoParamsParte[] = (int)$turnoFiltro;
}

$stmt = $pdo->prepare("
  SELECT
    COUNT(*) AS total_activos,
    SUM(CASE WHEN r.reposo_id IS NOT NULL THEN 1 ELSE 0 END) AS reposos_hoy,
    SUM(CASE WHEN r.reposo_id IS NULL AND p.permiso_id IS NOT NULL THEN 1 ELSE 0 END) AS permisos_hoy,
    SUM(CASE WHEN r.reposo_id IS NULL AND p.permiso_id IS NULL AND a.es_retardo = 1 THEN 1 ELSE 0 END) AS retardos_hoy,
    SUM(CASE WHEN r.reposo_id IS NULL AND p.permiso_id IS NULL AND a.es_retardo = 0 AND a.es_asistio = 1 THEN 1 ELSE 0 END) AS asistencias_hoy,
    SUM(CASE WHEN r.reposo_id IS NULL AND p.permiso_id IS NULL AND a.es_retardo = 0 AND a.es_asistio = 0 THEN 1 ELSE 0 END) AS ausentes_hoy
  FROM empleados e
  LEFT JOIN (
    SELECT empleado_id, MIN(id) AS reposo_id
    FROM reposos
    WHERE estado='ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin
    GROUP BY empleado_id
  ) r ON r.empleado_id = e.id
  LEFT JOIN (
    SELECT empleado_id, MIN(id) AS permiso_id
    FROM permisos
    WHERE estado='ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin
    GROUP BY empleado_id
  ) p ON p.empleado_id = e.id
  LEFT JOIN (
    SELECT
      empleado_id,
      MAX(CASE WHEN estado='RETARDO' THEN 1 ELSE 0 END) AS es_retardo,
      MAX(CASE WHEN estado='ASISTIO'  THEN 1 ELSE 0 END) AS es_asistio
    FROM asistencias
    WHERE fecha = ?
    GROUP BY empleado_id
  ) a ON a.empleado_id = e.id
  WHERE e.estado='ACTIVO'
  $turnoWhereParte
");
$stmt->execute(array_merge([$hoy, $hoy, $hoy], $turnoParamsParte));
$parte = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];

$totalNominaActiva = (int)($parte["total_activos"] ?? 0);
$asistenciasHoy    = (int)($parte["asistencias_hoy"] ?? 0);
$retardosHoy       = (int)($parte["retardos_hoy"] ?? 0);
$permisosHoy       = (int)($parte["permisos_hoy"] ?? 0);
$repososHoy        = (int)($parte["reposos_hoy"] ?? 0);
$ausentesHoy       = (int)($parte["ausentes_hoy"] ?? 0);

$where = [];
$params = [];

if ($q !== "") {
  $where[] = "(CONCAT(e.nombres,' ',e.apellidos) LIKE ? OR e.cedula LIKE ? OR c.nombre LIKE ?)";
  $like = "%$q%";
  $params[] = $like; $params[] = $like; $params[] = $like;
}

if ($turnoFiltro !== "") {
  $where[] = "e.turno_id = ?";
  $params[] = (int)$turnoFiltro;
}

$sql = "
SELECT
  e.id,
  CONCAT(e.nombres,' ',e.apellidos) AS nombre,
  e.cedula,
  c.nombre AS cargo,
  e.estado AS estado_empleado,
  t.nombre AS turno_nombre,
  a.es_retardo,
  a.es_asistio,
  a.hora_entrada,
  a.hora_salida,
  a.horas_trabajadas,
  p.permiso_id AS permiso_hoy,
  r.reposo_id  AS reposo_hoy,
  ua.ultima_fecha AS ultima_asistencia
FROM empleados e
JOIN cargos c ON c.id = e.cargo_id
LEFT JOIN turnos t ON t.id = e.turno_id
LEFT JOIN (
  SELECT
    empleado_id,
    MAX(CASE WHEN estado='RETARDO' THEN 1 ELSE 0 END) AS es_retardo,
    MAX(CASE WHEN estado='ASISTIO'  THEN 1 ELSE 0 END) AS es_asistio,
    MIN(hora_entrada) AS hora_entrada,
    MAX(hora_salida)  AS hora_salida,
    MAX(horas_trabajadas) AS horas_trabajadas
  FROM asistencias
  WHERE fecha = ?
  GROUP BY empleado_id
) a ON a.empleado_id = e.id
LEFT JOIN (
  SELECT empleado_id, MIN(id) AS permiso_id
  FROM permisos
  WHERE estado='ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin
  GROUP BY empleado_id
) p ON p.empleado_id = e.id
LEFT JOIN (
  SELECT empleado_id, MIN(id) AS reposo_id
  FROM reposos
  WHERE estado='ACTIVO' AND ? BETWEEN fecha_inicio AND fecha_fin
  GROUP BY empleado_id
) r ON r.empleado_id = e.id
LEFT JOIN (
  SELECT empleado_id, MAX(fecha) AS ultima_fecha
  FROM asistencias
  GROUP BY empleado_id
) ua ON ua.empleado_id = e.id
";

$paramsBase = [$hoy, $hoy, $hoy];
$paramsFinal = array_merge($paramsBase, $params);

if (!empty($where)) $sql .= " WHERE " . implode(" AND ", $where);
$sql .= " ORDER BY e.apellidos, e.nombres";

$stmt = $pdo->prepare($sql);
$stmt->execute($paramsFinal);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$empleados = [];
foreach ($rows as $row) {
  $estadoEmpRaw = $row["estado_empleado"] ?? "";
  $noActivo = empleadoNoActivo($estadoEmpRaw);

  if ($noActivo) {
    $status = estadoEmpleadoLabel($estadoEmpRaw);
  } else {
    if (!empty($row["reposo_hoy"])) {
      $status = "Reposo";
    } elseif (!empty($row["permiso_hoy"])) {
      $status = "Permiso";
    } elseif ((int)($row["es_retardo"] ?? 0) === 1) {
      $status = "Retardo";
    } elseif ((int)($row["es_asistio"] ?? 0) === 1) {
      $status = "En Servicio";
    } else {
      $status = "Ausente";
    }
  }

  if ($estadoFiltro !== "") {
    $map = [
      "EN_SERVICIO"     => "En Servicio",
      "RETARDO"         => "Retardo",
      "REPOSO"          => "Reposo",
      "PERMISO"         => "Permiso",
      "AUSENTE"         => "Ausente",
      "DESINCORPORADO"  => "Desincorporado",
      "SUSPENDIDO"      => "Suspendido",
    ];
    $want = $map[$estadoFiltro] ?? "";
    if ($want !== "" && $status !== $want) continue;
  }

  if ($desde !== "" || $hasta !== "") {
    $u = $row["ultima_asistencia"] ?: null;
    if ($u === null) continue;
    if ($desde !== "" && $u < $desde) continue;
    if ($hasta !== "" && $u > $hasta) continue;
  }

  $row["_status"] = $status;
  $empleados[] = $row;
}
?>

<style>
  .grid6{display:grid;grid-template-columns:repeat(6,minmax(170px,1fr));gap:14px;margin-bottom:14px}
  .cardx{background:#fff;border-radius:14px;padding:16px;box-shadow:0 2px 10px rgba(15,23,42,.06)}
  .cardx h4{margin:0;color:#6b7280;font-size:13px}
  .cardx .n{font-size:28px;font-weight:900;margin-top:6px}
  .b1{border-top:4px solid #111827}
  .b2{border-top:4px solid #22c55e}
  .b3{border-top:4px solid #f59e0b}
  .b4{border-top:4px solid #3b82f6}
  .b5{border-top:4px solid #ec4899}
  .b6{border-top:4px solid #ef4444}

  .panel{background:#fff;border-radius:14px;padding:16px;box-shadow:0 2px 10px rgba(15,23,42,.06)}
  .panel h2{margin:0 0 6px 0}
  .subx{color:#6b7280;margin:0 0 12px 0;font-size:13px}

  .alert{padding:10px 12px;border-radius:12px;margin-bottom:12px;font-weight:800}
  .ok{background:#dcfce7;color:#166534}
  .bad{background:#fee2e2;color:#991b1b}

  .filters-grid{
    display:grid;
    grid-template-columns: 1.4fr 1fr 1fr 0.8fr 0.8fr auto auto;
    gap:10px;
    align-items:end;
    margin:12px 0 14px;
  }
  .input,.select{padding:10px 12px;border:1px solid #d6dee8;border-radius:12px;background:#fff;width:100%}
  .btn{padding:10px 14px;border-radius:12px;border:none;cursor:pointer;font-weight:900}
  .btnP{background:#0b6fe6;color:#fff}
  .btnL{background:#eef2f7;color:#111;text-decoration:none;display:inline-flex;align-items:center;justify-content:center}

  table{width:100%;border-collapse:collapse;margin-top:6px}
  th,td{padding:12px;border-bottom:1px solid #e5e7eb;text-align:left;font-size:13px}
  th{background:#f8fafc;font-weight:900}
  .pill{display:inline-block;padding:6px 10px;border-radius:999px;font-size:12px;font-weight:900}
  .status-present{background:#dcfce7;color:#166534}
  .status-late{background:#fef3c7;color:#92400e}
  .status-rest{background:#ffe4e6;color:#9f1239}
  .status-justified{background:#dbeafe;color:#1d4ed8}
  .status-unjustified{background:#e5e7eb;color:#111827}
  .status-disabled{background:#f1f5f9;color:#0f172a}

  .actions{display:flex;gap:8px;flex-wrap:wrap}
  .mini{padding:8px 10px;border-radius:12px;border:none;cursor:pointer;font-weight:900}
  .in{background:#22c55e;color:#fff}
  .out{background:#ef4444;color:#fff}
  .muted{opacity:.75;font-size:12px;margin-top:6px}

  @media (max-width: 1300px){ .grid6{grid-template-columns:repeat(3,1fr)} }
  @media (max-width: 980px){ .grid6{grid-template-columns:repeat(2,1fr)} }
  @media (max-width: 1050px){
    .filters-grid{grid-template-columns: 1fr 1fr;}
    .btnP,.btnL{width:100%}
  }
</style>

<div class="grid6">
  <div class="cardx b1"><h4>Total Personal Disponible (ACTIVO)</h4><div class="n"><?php echo (int)$totalNominaActiva; ?></div></div>
  <div class="cardx b2"><h4>Asistencias Hoy</h4><div class="n"><?php echo (int)$asistenciasHoy; ?></div></div>
  <div class="cardx b3"><h4>Retardos Hoy</h4><div class="n"><?php echo (int)$retardosHoy; ?></div></div>
  <div class="cardx b4"><h4>Permisos Hoy</h4><div class="n"><?php echo (int)$permisosHoy; ?></div></div>
  <div class="cardx b5"><h4>Reposos Hoy</h4><div class="n"><?php echo (int)$repososHoy; ?></div></div>
  <div class="cardx b6"><h4>Ausentes Hoy</h4><div class="n"><?php echo (int)$ausentesHoy; ?></div></div>
</div>

<div class="panel">
  <h2>Gestión de Asistencias</h2>
  <p class="subx">Busca por nombre, cargo o cédula y marca entrada/salida del día.</p>

  <?php if ($msg): ?><div class="alert ok"><?php echo e($msg); ?></div><?php endif; ?>
  <?php if ($err): ?><div class="alert bad"><?php echo e($err); ?></div><?php endif; ?>

  <form class="filters-grid" method="GET">
    <input class="input" name="q" value="<?php echo e($q); ?>" placeholder="Buscar por nombre, cargo o cédula...">

    <select class="select" name="estado">
      <option value="" <?php echo $estadoFiltro===""?"selected":""; ?>>Todos</option>
      <option value="EN_SERVICIO" <?php echo $estadoFiltro==="EN_SERVICIO"?"selected":""; ?>>En Servicio</option>
      <option value="RETARDO" <?php echo $estadoFiltro==="RETARDO"?"selected":""; ?>>Retardo</option>
      <option value="PERMISO" <?php echo $estadoFiltro==="PERMISO"?"selected":""; ?>>Permiso</option>
      <option value="REPOSO" <?php echo $estadoFiltro==="REPOSO"?"selected":""; ?>>Reposo</option>
      <option value="AUSENTE" <?php echo $estadoFiltro==="AUSENTE"?"selected":""; ?>>Ausente</option>
      <option value="DESINCORPORADO" <?php echo $estadoFiltro==="DESINCORPORADO"?"selected":""; ?>>Desincorporado</option>
      <option value="SUSPENDIDO" <?php echo $estadoFiltro==="SUSPENDIDO"?"selected":""; ?>>Suspendido</option>
    </select>

    <select class="select" name="turno">
      <option value="" <?php echo $turnoFiltro==="" ? "selected" : ""; ?>>Todos los turnos</option>
      <?php foreach ($turnos as $t): ?>
        <option value="<?php echo (int)$t["id"]; ?>" <?php echo ((string)$turnoFiltro === (string)$t["id"]) ? "selected" : ""; ?>>
          <?php echo e($t["nombre"]); ?>
        </option>
      <?php endforeach; ?>
    </select>

    <input class="input" type="date" name="desde" value="<?php echo e($desde); ?>" title="Desde (última asistencia)">
    <input class="input" type="date" name="hasta" value="<?php echo e($hasta); ?>" title="Hasta (última asistencia)">

    <button class="btn btnP" type="submit">Filtrar</button>
    <a class="btn btnL" href="asistencias.php">Limpiar</a>
  </form>

  <table>
    <thead>
      <tr>
        <th>Nombre</th>
        <th>Cédula</th>
        <th>Cargo</th>
        <th>Turno</th>
        <th>Estado Hoy</th>
        <th>Entrada / Salida</th>
        <th>Acciones</th>
        <th>Última Asistencia</th>
      </tr>
    </thead>
    <tbody>
      <?php if (count($empleados) === 0): ?>
        <tr><td colspan="8">No hay resultados con esos filtros.</td></tr>
      <?php endif; ?>

      <?php foreach ($empleados as $e): ?>
        <?php
          $label  = $e["_status"];
          $class  = statusClass($label);
          $ultima = $e["ultima_asistencia"] ?: "—";
          $entrada= $e["hora_entrada"] ?: "—";
          $salida = $e["hora_salida"] ?: "—";
          $horas  = ($e["horas_trabajadas"] !== null) ? $e["horas_trabajadas"] : "—";

          $tieneReposo  = !empty($e["reposo_hoy"]);
          $tienePermiso = !empty($e["permiso_hoy"]);
          $noActivo     = empleadoNoActivo($e["estado_empleado"] ?? "");

          $bloquear = ($tieneReposo || $tienePermiso || $noActivo);

          $motivos = [];
          if ($noActivo) $motivos[] = strtolower(estadoEmpleadoLabel($e["estado_empleado"] ?? ""));
          if ($tieneReposo) $motivos[] = "reposo activo";
          if ($tienePermiso) $motivos[] = "permiso activo";

          $bloqueoTxt = "";
          if (!empty($motivos)) $bloqueoTxt = "Bloqueado (" . implode(" y ", $motivos) . ")";

          $nombre = titleCaseEs($e["nombre"]);
          $turnoNombre = $e["turno_nombre"] ?: "—";
        ?>
        <tr>
          <td><?php echo e($nombre); ?></td>
          <td><?php echo e($e["cedula"]); ?></td>
          <td><?php echo e($e["cargo"]); ?></td>
          <td><?php echo e($turnoNombre); ?></td>
          <td><span class="pill <?php echo e($class); ?>"><?php echo e($label); ?></span></td>
          <td>
            <div><b>Entrada:</b> <?php echo e($entrada); ?></div>
            <div><b>Salida:</b> <?php echo e($salida); ?> <span class="muted">(Horas: <?php echo e($horas); ?>)</span></div>
          </td>
          <td>
            <div class="actions">
              <form method="POST" action="../procesos/asistencia_entrada.php">
                <input type="hidden" name="empleado_id" value="<?php echo (int)$e["id"]; ?>">
                <button class="mini in" type="submit" <?php echo $bloquear ? "disabled" : ""; ?>>Entrada</button>
              </form>

              <form method="POST" action="../procesos/asistencia_salida.php">
                <input type="hidden" name="empleado_id" value="<?php echo (int)$e["id"]; ?>">
                <button class="mini out" type="submit" <?php echo $bloquear ? "disabled" : ""; ?>>Salida</button>
              </form>
            </div>
            <?php if ($bloquear && $bloqueoTxt): ?><div class="muted"><?php echo e($bloqueoTxt); ?></div><?php endif; ?>
          </td>
          <td><?php echo e($ultima); ?></td>
        </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>

<?php require_once __DIR__ . "/../includes/footer.php"; ?>
