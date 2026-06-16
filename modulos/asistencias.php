<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
requirePermiso("ver_asistencias", BASE_URL . "/login.php");
require_once __DIR__ . "/../includes/conexion.php";

date_default_timezone_set("America/Caracas");

$pageTitle = "Gestión de Asistencias";
$active = "asistencias";
require_once __DIR__ . "/../includes/header.php";

$hoy = date("Y-m-d");

$msg = trim($_GET["msg"] ?? "");
$err = trim($_GET["err"] ?? "");
$okAsistencia = trim($_GET["ok_asistencia"] ?? "");
$okEmpleadoId = (int)($_GET["empleado_id"] ?? 0);
$okEstado = trim($_GET["estado"] ?? "");
$okHora = trim($_GET["hora"] ?? "");
$okMinTarde = (int)($_GET["min_tarde"] ?? 0);
$okEmpleado = null;

if ($okAsistencia !== "" && $okEmpleadoId > 0) {
  $stmtOk = $pdo->prepare("
    SELECT
      e.id,
      CONCAT(e.nombres, ' ', e.apellidos) AS nombre,
      e.cedula,
      e.foto_archivo,
      c.nombre AS cargo,
      t.nombre AS turno
    FROM empleados e
    JOIN cargos c ON c.id = e.cargo_id
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE e.id = ?
    LIMIT 1
  ");
  $stmtOk->execute([$okEmpleadoId]);
  $okEmpleado = $stmtOk->fetch(PDO::FETCH_ASSOC) ?: null;
}
$modoEmergencia = !empty($_SESSION['modo_emergencia']);

$q = trim($_GET["q"] ?? "");
$estadoFiltro = trim($_GET["estado"] ?? "");
$turnoFiltro  = trim($_GET["turno"] ?? "");
$turnosPermitidos = turnosPermitidosPorRol();
$tieneAlcanceGlobal = tieneAlcanceGlobalTurnos();
$turnoIdsPermitidos = [];

$desde = trim($_GET["desde"] ?? "");
$hasta = trim($_GET["hasta"] ?? "");
$orden = trim($_GET["orden"] ?? "");
$pagina = max(1, (int)($_GET["pagina"] ?? 1));
$porPagina = 10;
$offset = ($pagina - 1) * $porPagina;

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
if (!$tieneAlcanceGlobal) {
  if ($turnoIdsPermitidos === []) {
    $turnoWhereParte .= " AND 1 = 0 ";
  } else {
    $turnoWhereParte .= " AND e.turno_id IN (" . implode(",", array_fill(0, count($turnoIdsPermitidos), "?")) . ") ";
    foreach ($turnoIdsPermitidos as $turnoIdPermitido) {
      $turnoParamsParte[] = $turnoIdPermitido;
    }
  }
}

if ($turnoFiltro !== "") {
  $turnoWhereParte .= " AND e.turno_id = ? ";
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

if (!$tieneAlcanceGlobal) {
  if ($turnoIdsPermitidos === []) {
    $where[] = "1 = 0";
  } else {
    $where[] = "e.turno_id IN (" . implode(",", array_fill(0, count($turnoIdsPermitidos), "?")) . ")";
    foreach ($turnoIdsPermitidos as $turnoIdPermitido) {
      $params[] = $turnoIdPermitido;
    }
  }
}

if ($turnoFiltro !== "") {
  $where[] = "e.turno_id = ?";
  $params[] = (int)$turnoFiltro;
}

// Filtro de estado según prioridad operativa.
if ($estadoFiltro === "REPOSO") {
  $where[] = "e.estado = 'ACTIVO' AND r.reposo_id IS NOT NULL";
} elseif ($estadoFiltro === "PERMISO") {
  $where[] = "e.estado = 'ACTIVO' AND p.permiso_id IS NOT NULL AND r.reposo_id IS NULL";
} elseif ($estadoFiltro === "RETARDO") {
  $where[] = "e.estado = 'ACTIVO' AND a.es_retardo = 1 AND r.reposo_id IS NULL AND p.permiso_id IS NULL";
} elseif ($estadoFiltro === "EN_SERVICIO") {
  $where[] = "e.estado = 'ACTIVO' AND a.es_asistio = 1 AND a.es_retardo = 0 AND r.reposo_id IS NULL AND p.permiso_id IS NULL";
} elseif ($estadoFiltro === "AUSENTE") {
  $where[] = "e.estado = 'ACTIVO' AND (a.es_asistio IS NULL OR a.es_asistio = 0) AND (a.es_retardo IS NULL OR a.es_retardo = 0) AND r.reposo_id IS NULL AND p.permiso_id IS NULL";
} elseif ($estadoFiltro === "DESINCORPORADO") {
  $where[] = "e.estado = 'RETIRADO'";
} elseif ($estadoFiltro === "SUSPENDIDO") {
  $where[] = "e.estado = 'SUSPENDIDO'";
}

$sqlBase = "
SELECT
  e.id,
  CONCAT(e.nombres,' ',e.apellidos) AS nombre,
  e.cedula,
    e.foto_archivo,
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

$sqlCount = "SELECT COUNT(*) AS total FROM ($sqlBase";
if (!empty($where)) $sqlCount .= " WHERE " . implode(" AND ", $where);
$sqlCount .= ") AS tmp";
$stmtCount = $pdo->prepare($sqlCount);
$stmtCount->execute($paramsFinal);
$totalEmpleados = (int)($stmtCount->fetch(PDO::FETCH_ASSOC)["total"] ?? 0);

$sql = $sqlBase;
if (!empty($where)) $sql .= " WHERE " . implode(" AND ", $where);

// Ordenamiento de la lista.
$orderClause = "ORDER BY e.apellidos, e.nombres";
if ($orden === "jerarquia") {
  $orderClause = "ORDER BY e.jerarquia ASC, e.apellidos, e.nombres";
} elseif ($orden === "alfabetico") {
  $orderClause = "ORDER BY e.nombres ASC, e.apellidos ASC";
}
$sql .= " $orderClause LIMIT $porPagina OFFSET $offset";

$stmt = $pdo->prepare($sql);
$stmt->execute($paramsFinal);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$totalPaginas = ceil($totalEmpleados / $porPagina);
$paginaActual = min($pagina, $totalPaginas);
$mostrandoInicio = $offset + 1;
$mostrandoFin = min($offset + $porPagina, $totalEmpleados);

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
  
        .success-person-card{
      display:flex;
      align-items:center;
      gap:14px;
      padding:14px 16px;
      border:1px solid #bfe7d1;
      background:#ecfdf3;
      border-radius:18px;
      margin:12px 0 16px;
    }
    .success-person-card .success-title{
      font-weight:900;
      color:#166534;
      margin-bottom:4px;
    }
    .success-person-card .success-meta{
      color:#334155;
      font-size:13px;
      line-height:1.45;
    }
.emp-cell{
      display:flex;
      align-items:center;
      gap:10px;
      min-width:180px;
    }
    .emp-photo{
      width:42px;
      height:42px;
      border-radius:50%;
      object-fit:cover;
      border:1px solid #dbe4ef;
      background:#f3f6fb;
      flex:0 0 auto;
    }
    .emp-photo-empty{
      display:flex;
      align-items:center;
      justify-content:center;
      font-weight:800;
      color:#334155;
      font-size:15px;
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

  .btn-emergency{background:#dc2626;color:#fff;border:none;padding:10px 14px;border-radius:12px;cursor:pointer;font-weight:900;font-size:13px}
  .btn-emergency:hover{filter:brightness(1.1)}
  .btn-emergency.active{background:#f59e0b;color:#111}
  .emergency-bar{background:#fef3c7;border:2px solid #f59e0b;border-radius:12px;padding:10px 14px;margin-bottom:14px;display:flex;align-items:center;justify-content:space-between;font-weight:900;color:#92400e}
  .emergency-bar .btn{margin-left:10px}
  .modal-overlay{position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,.5);display:none;align-items:center;justify-content:center;z-index:9999}
  .modal-overlay.show{display:flex}
  .modal-box{background:#fff;border-radius:16px;padding:24px;max-width:400px;width:90%;box-shadow:0 10px 40px rgba(0,0,0,.2)}
  .modal-box h3{margin:0 0 12px;font-size:18px}
  .modal-box .field{margin-bottom:12px}
  .modal-box .field label{display:block;font-size:12px;font-weight:700;margin-bottom:4px}
  .modal-box .field input{width:100%;padding:10px 12px;border:1px solid #d6dee8;border-radius:10px}
  .modal-actions{display:flex;gap:10px;justify-content:flex-end;margin-top:16px}

  .pagination{display:flex;justify-content:space-between;align-items:center;margin-top:14px;padding-top:14px;border-top:1px solid #e5e7eb}
  .pagination-info{color:#6b7280;font-size:13px;font-weight:900}
  .pagination-pages{display:flex;gap:6px}
  .pagination-pages a,.pagination-pages span{padding:8px 14px;border-radius:10px;text-decoration:none;font-weight:900;font-size:13px;display:inline-flex;align-items:center}
  .pagination-pages a{background:#f1f5f9;color:#111}
  .pagination-pages a:hover{background:#e2e8f0}
  .pagination-pages .current{background:#0b6fe6;color:#fff}
  .pagination-pages .disabled{opacity:.4;pointer-events:none}

  @media (max-width: 1300px){ .grid6{grid-template-columns:repeat(3,1fr)} }
  @media (max-width: 980px){ .grid6{grid-template-columns:repeat(2,1fr)} }
  @media (max-width: 1050px){
    .filters-grid{grid-template-columns: 1fr 1fr;}
    .btnP,.btnL{width:100%}
  }
.attendance-hero{
  display:grid;
  grid-template-columns:1fr auto;
  gap:18px;
  align-items:center;
  background:#ffffff;
  border:1px solid var(--border);
  border-radius:24px;
  padding:22px;
  margin:0 0 18px;
  box-shadow:0 8px 20px rgba(38,53,72,.045);
}

.attendance-kicker{
  display:inline-flex;
  width:max-content;
  min-height:28px;
  align-items:center;
  padding:5px 11px;
  border-radius:999px;
  background:var(--primary-soft);
  border:1px solid #dbeaf8;
  color:var(--primary-strong);
  font-size:12px;
  font-weight:900;
  letter-spacing:.04em;
  text-transform:uppercase;
  margin-bottom:10px;
}

.attendance-hero h1{
  margin:0;
  color:var(--text);
  font-size:30px;
  line-height:1.08;
  font-weight:950;
}

.attendance-hero p{
  max-width:760px;
  margin:8px 0 0;
  color:var(--text-soft);
  font-size:14px;
  line-height:1.45;
}

.attendance-hero-meta{
  min-width:160px;
  background:var(--surface-soft);
  border:1px solid var(--border);
  border-radius:18px;
  padding:14px 16px;
  text-align:right;
}

.attendance-hero-meta span{
  display:block;
  color:var(--text-muted);
  font-size:11px;
  font-weight:850;
  margin-bottom:5px;
  text-transform:uppercase;
  letter-spacing:.03em;
}

.attendance-hero-meta strong{
  display:block;
  color:var(--text);
  font-size:20px;
  line-height:1;
  font-weight:950;
}

.attendance-hero-meta small{
  display:block;
  margin-top:8px;
  color:var(--primary-strong);
  font-size:12px;
  font-weight:850;
}

.cardx{
  background:#ffffff !important;
  border:1px solid var(--border) !important;
  border-radius:22px !important;
  box-shadow:0 8px 20px rgba(38,53,72,.045) !important;
  padding:18px !important;
}

.cardx h4{
  color:var(--text-muted) !important;
  font-size:11px !important;
  font-weight:900 !important;
  letter-spacing:.04em !important;
  text-transform:uppercase !important;
  margin:0 0 9px !important;
}

.cardx .n{
  color:var(--text) !important;
  font-size:28px !important;
  font-weight:950 !important;
  line-height:1 !important;
}

.success-person-card{
  display:flex;
  align-items:center;
  gap:14px;
  background:#ffffff !important;
  border:1px solid #d8eadf !important;
  border-radius:22px !important;
  box-shadow:0 8px 20px rgba(76,125,92,.07) !important;
  padding:16px !important;
  margin:0 0 18px !important;
}

.success-person-card .success-title{
  color:var(--success-strong) !important;
  font-size:17px !important;
  font-weight:950 !important;
}

.success-person-card .success-meta{
  color:var(--text-soft) !important;
  font-size:13px !important;
  line-height:1.45 !important;
  margin-top:3px !important;
}

.emp-photo,
.emp-photo-empty{
  width:52px !important;
  height:52px !important;
  min-width:52px !important;
  border-radius:17px !important;
  object-fit:cover !important;
  border:1px solid var(--border) !important;
  background:var(--surface-soft) !important;
}

.emp-photo-empty{
  display:inline-flex !important;
  align-items:center !important;
  justify-content:center !important;
  color:var(--primary-strong) !important;
  font-weight:950 !important;
  font-size:18px !important;
}

.filters{
  background:#ffffff !important;
  border:1px solid var(--border) !important;
  border-radius:22px !important;
  padding:16px !important;
  box-shadow:0 8px 20px rgba(38,53,72,.04) !important;
  margin-bottom:18px !important;
}

.input,
.select,
.filters input,
.filters select{
  min-height:42px;
  border-radius:14px !important;
  border:1px solid var(--border-strong) !important;
  background:#ffffff !important;
  color:var(--text) !important;
  font-weight:700 !important;
}

.btn,
.btnP,
.btnL{
  min-height:42px;
  border-radius:14px !important;
  border:1px solid var(--border) !important;
  font-weight:900 !important;
  text-decoration:none !important;
}

.btnP{
  background:var(--primary-soft) !important;
  color:var(--primary-strong) !important;
  border-color:#dbeaf8 !important;
}

.btnL{
  background:#ffffff !important;
  color:var(--text-soft) !important;
}

.btnL:hover,
.btnP:hover{
  background:var(--surface-soft) !important;
  color:var(--primary-strong) !important;
}

table{
  width:100%;
  border-collapse:separate !important;
  border-spacing:0 10px !important;
}

thead th{
  background:transparent !important;
  color:var(--text-muted) !important;
  font-size:11px !important;
  font-weight:900 !important;
  letter-spacing:.04em !important;
  text-transform:uppercase !important;
  padding:0 12px 4px !important;
  border:0 !important;
}

tbody tr{
  background:#ffffff !important;
  box-shadow:0 6px 16px rgba(38,53,72,.04) !important;
}

tbody td{
  background:#ffffff !important;
  border-top:1px solid var(--border) !important;
  border-bottom:1px solid var(--border) !important;
  padding:13px 12px !important;
  vertical-align:middle !important;
}

tbody td:first-child{
  border-left:1px solid var(--border) !important;
  border-radius:18px 0 0 18px !important;
}

tbody td:last-child{
  border-right:1px solid var(--border) !important;
  border-radius:0 18px 18px 0 !important;
}

.pill,
[class*="status-"]{
  display:inline-flex !important;
  align-items:center !important;
  min-height:28px !important;
  padding:5px 10px !important;
  border-radius:999px !important;
  font-size:12px !important;
  font-weight:900 !important;
  border:1px solid var(--border) !important;
  background:var(--surface-soft) !important;
  color:var(--text-soft) !important;
}

.status-late{
  background:var(--warning-soft) !important;
  border-color:#efe2c3 !important;
  color:var(--warning-strong) !important;
}

.status-ok,
.status-present{
  background:var(--success-soft) !important;
  border-color:#d8eadf !important;
  color:var(--success-strong) !important;
}

.mini{
  min-height:36px !important;
  padding:8px 13px !important;
  border-radius:13px !important;
  border:1px solid var(--border) !important;
  font-size:12px !important;
  font-weight:950 !important;
  cursor:pointer !important;
}

.mini.in{
  background:var(--success-soft) !important;
  border-color:#d8eadf !important;
  color:var(--success-strong) !important;
}

.mini.out{
  background:var(--primary-soft) !important;
  border-color:#dbeaf8 !important;
  color:var(--primary-strong) !important;
}

.mini:disabled{
  opacity:.45 !important;
  cursor:not-allowed !important;
}

.pagination{
  display:flex;
  justify-content:center;
  align-items:center;
  gap:7px;
  margin-top:18px;
}

.pagination a{
  min-height:38px;
  min-width:38px;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  padding:8px 12px;
  border:1px solid var(--border);
  border-radius:13px;
  background:#ffffff;
  color:var(--text-soft);
  font-size:13px;
  font-weight:900;
  text-decoration:none;
}

.pagination a:hover,
.pagination a.current{
  background:var(--primary-soft);
  color:var(--primary-strong);
  border-color:#dbeaf8;
}

.pagination a.disabled{
  opacity:.45;
  pointer-events:none;
}

@media (max-width:900px){
  .attendance-hero{
    grid-template-columns:1fr;
  }

  .attendance-hero-meta{
    text-align:left;
    min-width:0;
  }

  table{
    border-spacing:0 8px !important;
  }
}

@media (max-width:680px){
  .attendance-hero{
    padding:18px;
  }

  .attendance-hero h1{
    font-size:25px;
  }

  .success-person-card{
    align-items:flex-start;
  }

  tbody td{
    padding:11px 10px !important;
  }
}
</style>
<div class="panel attendance-panel">
<?php if ($msg): ?><div class="alert ok"><?php echo e($msg); ?></div><?php endif; ?>

<?php if ($okEmpleado): ?>
  <?php
    $okNombre = titleCaseEs($okEmpleado["nombre"] ?? "");
    $okFotoArchivo = trim((string)($okEmpleado["foto_archivo"] ?? ""));
    $okFotoUrl = $okFotoArchivo !== "" ? BASE_URL . "/" . ltrim($okFotoArchivo, "/") : "";
    $okInicial = strtoupper(substr(trim((string)$okNombre), 0, 1));

    if ($okInicial === "") {
      $okInicial = "—";
    }

    $okEstadoTexto = "Registrado a tiempo";

    if (strtoupper($okEstado) === "RETARDO") {
      $okEstadoTexto = "Registrado con retardo";
    }

    if ($okAsistencia === "salida") {
      $okEstadoTexto = "Salida registrada";
    }
  ?>

  <div class="success-person-card">
    <?php if ($okFotoUrl !== ""): ?>
      <img class="emp-photo" src="<?php echo e($okFotoUrl); ?>" alt="Foto de <?php echo e($okNombre); ?>">
    <?php else: ?>
      <div class="emp-photo emp-photo-empty"><?php echo e($okInicial); ?></div>
    <?php endif; ?>

    <div>
      <div class="success-title">Asistencia guardada con éxito</div>
      <div class="success-meta">
        <strong><?php echo e($okNombre); ?></strong><br>
        Cedula: <?php echo e(formatCedula($okEmpleado["cedula"] ?? "")); ?> |
        Cargo: <?php echo e($okEmpleado["cargo"] ?? "—"); ?> |
        Turno: <?php echo e($okEmpleado["turno"] ?? "—"); ?><br>
        Estado: <?php echo e($okEstadoTexto); ?>
        <?php if ($okHora !== ""): ?> | Hora: <?php echo e($okHora); ?><?php endif; ?>
        <?php if (strtoupper($okEstado) === "RETARDO"): ?> | Retardo: <?php echo (int)$okMinTarde; ?> min<?php endif; ?>
      </div>
    </div>
  </div>
<?php endif; ?>
  <?php if ($err): ?><div class="alert bad"><?php echo e($err); ?></div><?php endif; ?>

  <?php if ($modoEmergencia): ?>
  <div class="emergency-bar">
    <span>⚠️ MODO EMERGENCIA ACTIVO — Puedes registrar asistencia sin restricciones</span>
    <form method="POST" action="../procesos/modo_emergencia.php" style="display:inline">
    <?php echo csrfInput(); ?>
      <input type="hidden" name="accion" value="desactivar">
      <button class="btn btnL" type="submit">Desactivar</button>
    </form>
  </div>
  <?php else: ?>
  <div style="margin-bottom:14px;text-align:right">
    <button class="btn-emergency" id="btnModoEmergencia">Modo Emergencia</button>
  </div>
  <?php endif; ?>

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

  <div style="display:flex;gap:8px;margin:12px 0;flex-wrap:wrap">
    <a href="?pagina=1<?php echo $orden === 'jerarquia' ? '' : '&orden=jerarquia'; ?>"
       class="btn <?php echo $orden === 'jerarquia' ? 'btnP' : 'btnL'; ?>"
       style="font-size:12px;padding:8px 12px">
      Orden por Jerarquía
    </a>
    <a href="?pagina=1<?php echo $orden === 'alfabetico' ? '' : '&orden=alfabetico'; ?>"
       class="btn <?php echo $orden === 'alfabetico' ? 'btnP' : 'btnL'; ?>"
       style="font-size:12px;padding:8px 12px">
      Orden Alfabético
    </a>
    <a href="?pagina=1"
       class="btn btnL"
       style="font-size:12px;padding:8px 12px">
      Limpiar
    </a>
  </div>

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
$fotoArchivo = trim((string)($e["foto_archivo"] ?? ""));
$fotoUrl = $fotoArchivo !== "" ? BASE_URL . "/" . ltrim($fotoArchivo, "/") : "";
$inicialFoto = strtoupper(substr(trim((string)$nombre), 0, 1));
if ($inicialFoto === "") {
  $inicialFoto = "—";
}
        ?>
        <tr>
          <td>
  <div class="emp-cell">
    <?php if ($fotoUrl !== ""): ?>
      <img class="emp-photo" src="<?php echo e($fotoUrl); ?>" alt="Foto de <?php echo e($nombre); ?>">
    <?php else: ?>
      <div class="emp-photo emp-photo-empty"><?php echo e($inicialFoto); ?></div>
    <?php endif; ?>
    <div><?php echo e($nombre); ?></div>
  </div>
</td>
          <td><?php echo e(formatCedula($e["cedula"])); ?></td>
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
    <?php echo csrfInput(); ?>
                <input type="hidden" name="empleado_id" value="<?php echo (int)$e["id"]; ?>">
                <button class="mini in" type="submit" <?php echo $bloquear ? "disabled" : ""; ?>>Entrada</button>
              </form>

              <form method="POST" action="../procesos/asistencia_salida.php">
    <?php echo csrfInput(); ?>
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

  <?php if ($totalPaginas > 0): ?>
  <div class="pagination">
    <div class="pagination-info">
      Mostrando <?php echo $mostrandoInicio; ?>-<?php echo $mostrandoFin; ?> de <?php echo $totalEmpleados; ?> empleados
    </div>
    <div class="pagination-pages">
      <?php
        function buildUrl($params, $pag) {
          global $orden;
          $params["pagina"] = $pag;
          if ($orden !== "") $params["orden"] = $orden;
          return BASE_URL . "/modulos/asistencias.php?" . http_build_query($params);
        }
        $filters = array_filter([
          "q" => $q,
          "estado" => $estadoFiltro,
          "turno" => $turnoFiltro,
          "desde" => $desde,
          "hasta" => $hasta
        ], fn($v) => $v !== "");
      ?>
      <a href="<?php echo buildUrl($filters, $pagina - 1); ?>" class="<?php echo $pagina <= 1 ? 'disabled' : ''; ?>">‹ Anterior</a>
      <?php for ($i = 1; $i <= $totalPaginas; $i++): ?>
        <a href="<?php echo buildUrl($filters, $i); ?>" class="<?php echo $i === $pagina ? 'current' : ''; ?>"><?php echo $i; ?></a>
      <?php endfor; ?>
      <a href="<?php echo buildUrl($filters, $pagina + 1); ?>" class="<?php echo $pagina >= $totalPaginas ? 'disabled' : ''; ?>">Siguiente ›</a>
    </div>
  </div>
  <?php endif; ?>
</div>

<div class="modal-overlay" id="modalEmergencia">
  <div class="modal-box">
    <h3>Modo Emergencia</h3>
    <p style="font-size:13px;color:#6b7280;margin-bottom:14px">Ingresa credenciales de administrador (DIRECTORA o SUPER) para activar.</p>
    <form method="POST" action="../procesos/modo_emergencia.php">
    <?php echo csrfInput(); ?>
      <input type="hidden" name="accion" value="activar">
      <div class="field">
        <label>Usuario</label>
        <input type="text" name="usuario" required placeholder="Usuario administrador">
      </div>
      <div class="field">
        <label>Contraseña</label>
        <input type="password" name="clave" required placeholder="Contraseña">
      </div>
      <div class="modal-actions">
        <button type="button" class="btn btnL" id="btnCerrarModal">Cancelar</button>
        <button type="submit" class="btn btnP">Activar</button>
      </div>
    </form>
  </div>
</div>

<script>

(function(){
  var btn = document.getElementById('btnModoEmergencia');
  var modal = document.getElementById('modalEmergencia');
  var cerrar = document.getElementById('btnCerrarModal');
  if (btn && modal) {
    btn.addEventListener('click', function(){ modal.classList.add('show'); });
    if (cerrar) cerrar.addEventListener('click', function(){ modal.classList.remove('show'); });
    modal.addEventListener('click', function(e){ if(e.target === modal) modal.classList.remove('show'); });
  }
})();
</script>
<script>
(function(){
  var form = document.querySelector("form.filters, form.attendance-filters, form.attendance-filter-panel");

  if (!form) {
    var forms = Array.prototype.slice.call(document.querySelectorAll("form"));

    for (var i = 0; i < forms.length; i++) {
      var candidate = forms[i];
      var method = (candidate.getAttribute("method") || "get").toLowerCase();

      var hasFilterControls = candidate.querySelector(
        "input[type='search'], input[type='text'], input[type='date'], select[name='estado'], select[name='turno'], select"
      );

      var hasAttendanceActions = candidate.querySelector(
        "button[name='empleado_id'], input[name='empleado_id'], button[type='submit'].mini"
      );

      if (method === "get" && hasFilterControls && !hasAttendanceActions) {
        form = candidate;
        break;
      }
    }
  }

  if (!form || form.dataset.asistenciaUi === "1") return;

  form.dataset.asistenciaUi = "1";
  form.classList.add("attendance-filter-panel");

  var originalChildren = Array.prototype.slice.call(form.childNodes);

  var head = document.createElement("div");
  head.className = "attendance-filter-head";

  var titleBox = document.createElement("div");
  titleBox.className = "attendance-filter-titlebox";
  titleBox.innerHTML = '<div class="attendance-filter-title">Filtros de asistencia</div><div class="attendance-filter-subtitle">Busqueda automatica, orden y rango de consulta.</div>';

  var actions = document.createElement("div");
  actions.className = "attendance-filter-actions";

  var emergencyButton = document.querySelector(".btn-emergency, button[name='modo_emergencia'], a[href*='modo_emergencia']");
  var emergencyCarrier = null;

  if (emergencyButton) {
    emergencyButton.classList.add("attendance-emergency-action");

    var emergencyForm = emergencyButton.closest("form");

    if (emergencyForm && emergencyForm !== form && !form.contains(emergencyForm)) {
      emergencyCarrier = emergencyForm;
      emergencyCarrier.classList.add("attendance-emergency-wrapper");
      actions.appendChild(emergencyCarrier);
    } else {
      emergencyCarrier = emergencyButton;
      actions.appendChild(emergencyButton);
    }
  }

  head.appendChild(titleBox);
  head.appendChild(actions);

  var grid = document.createElement("div");
  grid.className = "attendance-filter-grid";

  originalChildren.forEach(function(node){
    if (node.nodeType === 3 && node.textContent.trim() === "") return;

    if (emergencyCarrier) {
      if (node === emergencyCarrier) return;
      if (node.nodeType === 1 && node.contains(emergencyCarrier)) return;
    }

    grid.appendChild(node);
  });

  form.appendChild(head);
  form.appendChild(grid);

  var submitButtons = grid.querySelectorAll('button[type="submit"], input[type="submit"]');
  submitButtons.forEach(function(btn){
    btn.classList.add("attendance-submit-hidden");
    btn.setAttribute("aria-hidden", "true");
    btn.setAttribute("tabindex", "-1");
  });

  var clearLinks = Array.prototype.slice.call(grid.querySelectorAll("a")).filter(function(a){
    return (a.textContent || "").trim().toLowerCase().indexOf("limpiar") !== -1;
  });

  clearLinks.forEach(function(a, index){
    a.classList.add("attendance-clear-action");

    if (index > 0) {
      a.classList.add("attendance-duplicate-clear");
      a.style.display = "none";
    }
  });

  var controls = Array.prototype.slice.call(grid.querySelectorAll("input, select")).filter(function(el){
    return el.type !== "hidden" && el.type !== "submit";
  });

  controls.forEach(function(control){
    if (control.closest(".attendance-field")) return;

    var wrapper = document.createElement("label");
    wrapper.className = "attendance-field";

    var name = (control.getAttribute("name") || "").toLowerCase();
    var type = (control.getAttribute("type") || "").toLowerCase();
    var placeholder = (control.getAttribute("placeholder") || "").toLowerCase();
    var labelText = "Filtro";

    if (type === "date" && name.indexOf("desde") !== -1) labelText = "Desde";
    else if (type === "date" && name.indexOf("hasta") !== -1) labelText = "Hasta";
    else if (type === "date") labelText = "Fecha";
    else if (name.indexOf("turno") !== -1) labelText = "Turno";
    else if (name.indexOf("estado") !== -1) labelText = "Estado";
    else if (type === "text" || type === "search" || placeholder.indexOf("buscar") !== -1 || name.indexOf("bus") !== -1 || name.indexOf("q") !== -1) labelText = "Busqueda";

    var span = document.createElement("span");
    span.textContent = labelText;

    control.parentNode.insertBefore(wrapper, control);
    wrapper.appendChild(span);
    wrapper.appendChild(control);

    if (labelText === "Busqueda") {
      wrapper.classList.add("attendance-field-search");
    }
  });

  var orderLinks = Array.prototype.slice.call(grid.querySelectorAll("a")).filter(function(a){
    var text = (a.textContent || "").trim().toLowerCase();
    return text.indexOf("orden") !== -1;
  });

  if (orderLinks.length > 0) {
    var orderGroup = document.createElement("div");
    orderGroup.className = "attendance-order-group";

    var orderLabel = document.createElement("span");
    orderLabel.className = "attendance-order-label";
    orderLabel.textContent = "Orden";
    orderGroup.appendChild(orderLabel);

    orderLinks[0].parentNode.insertBefore(orderGroup, orderLinks[0]);

    orderLinks.forEach(function(a){
      a.classList.add("attendance-order-action");
      orderGroup.appendChild(a);
    });
  }

  var isSubmitting = false;

  function submitForm(){
    if (isSubmitting) return;
    isSubmitting = true;

    window.setTimeout(function(){
      if (form.requestSubmit) {
        form.requestSubmit();
      } else {
        form.submit();
      }
    }, 80);
  }

  var timer = null;

  function debounceSubmit(){
    window.clearTimeout(timer);
    timer = window.setTimeout(submitForm, 650);
  }

  grid.querySelectorAll("select, input[type='date']").forEach(function(control){
    control.addEventListener("change", submitForm);
  });

  grid.querySelectorAll("input[type='text'], input[type='search']").forEach(function(control){
    control.setAttribute("autocomplete", "off");
    control.addEventListener("input", debounceSubmit);
  });
})();
</script>
<script>
(function(){
  function cleanText(value){
    return (value || "")
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .trim();
  }

  function findByText(patterns){
    var items = Array.prototype.slice.call(document.querySelectorAll("a, button"));

    return items.filter(function(el){
      var text = cleanText(el.textContent);

      return patterns.some(function(pattern){
        return text.indexOf(pattern) !== -1;
      });
    });
  }

  var alphaLinks = findByText(["orden alfabetico", "orden alfab"]);
  var hierarchyLinks = findByText(["orden por jerarquia", "jerarquia"]);
  var alphaLink = alphaLinks.length ? alphaLinks[0] : null;
  var form = document.querySelector("form.attendance-filter-panel, form.filters, form.attendance-filters");

  if (alphaLink && form) {
    try {
      var alphaUrl = new URL(alphaLink.href, window.location.href);
      var currentUrl = new URL(window.location.href);
      var foundOrder = false;
      var needsRedirect = false;

      alphaUrl.searchParams.forEach(function(value, key){
        var keyLower = key.toLowerCase();
        var isOrderKey = (
          keyLower.indexOf("orden") !== -1 ||
          keyLower.indexOf("order") !== -1 ||
          keyLower.indexOf("sort") !== -1
        );

        if (!isOrderKey) return;

        foundOrder = true;

        if (!form.querySelector('input[type="hidden"][name="' + key + '"]')) {
          var hidden = document.createElement("input");
          hidden.type = "hidden";
          hidden.name = key;
          hidden.value = value;
          form.appendChild(hidden);
        }

        if (currentUrl.searchParams.get(key) !== value) {
          currentUrl.searchParams.set(key, value);
          needsRedirect = true;
        }
      });

      if (foundOrder && needsRedirect && !window.sessionStorage.getItem("asistencias_alpha_auto")) {
        window.sessionStorage.setItem("asistencias_alpha_auto", "1");
        window.location.replace(currentUrl.toString());
        return;
      }
    } catch(e) {}
  }

  alphaLinks.concat(hierarchyLinks).forEach(function(el){
    el.remove();
  });

  var clearItems = Array.prototype.slice.call(document.querySelectorAll("a, button")).filter(function(el){
    return cleanText(el.textContent) === "limpiar";
  });

  clearItems.forEach(function(el, index){
    if (index > 0) {
      el.remove();
    }
  });

  function getCellText(row, index){
    var cell = row.children[index];
    return cell ? cleanText(cell.textContent) : "";
  }

  function parseNumber(value){
    var digits = (value || "").replace(/[^\d]/g, "");
    var parsed = parseInt(digits, 10);

    return isNaN(parsed) ? 0 : parsed;
  }

  function parseDate(value){
    value = (value || "").trim();

    if (!value || value === "-") return 0;

    var iso = value.match(/\d{4}-\d{2}-\d{2}/);
    if (iso) return new Date(iso[0] + "T00:00:00").getTime();

    var latin = value.match(/(\d{2})\/(\d{2})\/(\d{4})/);
    if (latin) return new Date(latin[3] + "-" + latin[2] + "-" + latin[1] + "T00:00:00").getTime();

    return 0;
  }

  function enhanceHeader(th, label, type, columnIndex, initialDir){
    if (!th || th.dataset.sortReady === "1") return;

    th.dataset.sortReady = "1";
    th.classList.add("th-sort");

    var button = document.createElement("button");
    button.type = "button";
    button.className = "table-sort-button";
    button.dataset.dir = initialDir || "asc";
    button.innerHTML = '<span class="sort-arrow">' + (button.dataset.dir === "asc" ? "&uarr;" : "&darr;") + '</span><span>' + label + '</span>';

    button.addEventListener("click", function(){
      var table = th.closest("table");
      var tbody = table ? table.querySelector("tbody") : null;

      if (!tbody) return;

      var rows = Array.prototype.slice.call(tbody.querySelectorAll("tr"));
      var dir = button.dataset.dir === "asc" ? "asc" : "desc";
      var next = dir === "asc" ? "desc" : "asc";

      rows.sort(function(a, b){
        var av;
        var bv;

        if (type === "number") {
          av = parseNumber(a.children[columnIndex] ? a.children[columnIndex].textContent : "");
          bv = parseNumber(b.children[columnIndex] ? b.children[columnIndex].textContent : "");
        } else if (type === "date") {
          av = parseDate(a.children[columnIndex] ? a.children[columnIndex].textContent : "");
          bv = parseDate(b.children[columnIndex] ? b.children[columnIndex].textContent : "");
        } else {
          av = getCellText(a, columnIndex);
          bv = getCellText(b, columnIndex);
        }

        if (av < bv) return dir === "asc" ? -1 : 1;
        if (av > bv) return dir === "asc" ? 1 : -1;
        return 0;
      });

      rows.forEach(function(row){
        tbody.appendChild(row);
      });

      button.dataset.dir = next;

      var arrow = button.querySelector(".sort-arrow");
      if (arrow) arrow.innerHTML = next === "asc" ? "&uarr;" : "&darr;";
    });

    th.innerHTML = "";
    th.appendChild(button);
  }

  Array.prototype.slice.call(document.querySelectorAll("table")).forEach(function(table){
    var headers = Array.prototype.slice.call(table.querySelectorAll("thead th"));

    headers.forEach(function(th, index){
      var text = cleanText(th.textContent);

      if (text === "nombre") {
        enhanceHeader(th, "Nombre", "text", index, "asc");
      }

      if (text.indexOf("cedula") !== -1) {
        enhanceHeader(th, "Cedula", "number", index, "desc");
      }

      if (text.indexOf("ultima asistencia") !== -1) {
        enhanceHeader(th, "Ultima asistencia", "date", index, "desc");
      }
    });
  });
})();
</script>
<script>
(function(){
  function clean(value){
    return (value || "").replace(/\s+/g, " ").trim();
  }

  function normalizeHeaders(){
    var tables = Array.prototype.slice.call(document.querySelectorAll("table"));

    tables.forEach(function(table){
      table.classList.add("attendance-table-head-uniform");

      var headers = Array.prototype.slice.call(table.querySelectorAll("thead th"));

      headers.forEach(function(th){
        if (!th) return;

        var sortButton = th.querySelector(".table-sort-button");

        if (sortButton) {
          sortButton.classList.add("table-head-chip", "is-sortable");

          var arrow = sortButton.querySelector(".sort-arrow");
          var label = null;

          Array.prototype.slice.call(sortButton.children).forEach(function(child){
            if (!child.classList.contains("sort-arrow") && !label) {
              label = child;
            }
          });

          if (!label) {
            label = document.createElement("span");
            label.textContent = clean(sortButton.textContent);
            sortButton.insertBefore(label, sortButton.firstChild);
          }

          label.classList.add("table-head-label");

          if (arrow) {
            arrow.classList.add("table-head-icon");
            sortButton.appendChild(arrow);
          }

          return;
        }

        if (th.querySelector(".table-head-chip.is-static")) return;

        var text = clean(th.textContent);
        if (!text) return;

        th.innerHTML = "";

        var chip = document.createElement("span");
        chip.className = "table-head-chip is-static";

        var labelSpan = document.createElement("span");
        labelSpan.className = "table-head-label";
        labelSpan.textContent = text;

        var iconSpan = document.createElement("span");
        iconSpan.className = "table-head-icon table-head-placeholder";
        iconSpan.setAttribute("aria-hidden", "true");
        iconSpan.textContent = "↑";

        chip.appendChild(labelSpan);
        chip.appendChild(iconSpan);
        th.appendChild(chip);
      });
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", normalizeHeaders);
  } else {
    normalizeHeaders();
  }
})();
</script>
<script>
(function(){
  function normalizeText(value){
    return (value || "")
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .replace(/\s+/g, " ")
      .trim();
  }

  function fixHeaderLabels(){
    var labels = Array.prototype.slice.call(document.querySelectorAll(".attendance-table-head-uniform .table-head-label"));

    labels.forEach(function(label){
      var text = normalizeText(label.textContent);

      if (text.indexOf("ultima asistencia") !== -1) {
        label.textContent = "Ultima asist.";
        label.setAttribute("title", "Ultima asistencia");
      }

      if (text.indexOf("entrada / salida") !== -1 || text.indexOf("entrada/salida") !== -1) {
        label.textContent = "Entrada / salida";
      }
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", fixHeaderLabels);
  } else {
    fixHeaderLabels();
  }
})();
</script>
<script>
(function(){
  function clean(value){
    return (value || "").replace(/\s+/g, " ").trim();
  }

  function normalize(value){
    return clean(value)
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "");
  }

  function improveDates(){
    var inputs = Array.prototype.slice.call(document.querySelectorAll(".attendance-filter-panel input[type='date']"));

    inputs.forEach(function(input){
      var field = input.closest(".attendance-field");
      if (!field) return;

      field.classList.add("attendance-field-date");

      Array.prototype.slice.call(field.querySelectorAll(".attendance-date-visual, .attendance-date-display, .attendance-date-clean-value, .attendance-date-clean-space, .attendance-date-clean-icon")).forEach(function(el){
        el.remove();
      });

      var label = field.querySelector("span");
      if (label) {
        var labelText = normalize(label.textContent);
        if (labelText.indexOf("desde") !== -1) label.textContent = "DESDE";
        if (labelText.indexOf("hasta") !== -1) label.textContent = "HASTA";
      }

      var space = document.createElement("span");
      space.className = "attendance-date-clean-space";
      space.setAttribute("aria-hidden", "true");

      var icon = document.createElement("span");
      icon.className = "attendance-date-clean-icon";
      icon.setAttribute("aria-hidden", "true");

      field.insertBefore(space, input);
      field.insertBefore(icon, input);
    });
  }

  function fixClearButton(){
    var clearItems = Array.prototype.slice.call(document.querySelectorAll("a, button")).filter(function(el){
      return normalize(el.textContent) === "limpiar";
    });

    clearItems.forEach(function(el, index){
      if (index === 0) {
        el.classList.add("attendance-clear-action");
      } else {
        el.remove();
      }
    });
  }

  function fullHeaders(){
    var map = [
      { test:["nombre"], label:"Nombre" },
      { test:["cedula"], label:"Cedula" },
      { test:["cargo"], label:"Cargo" },
      { test:["turno"], label:"Turno" },
      { test:["estado hoy"], label:"Estado hoy" },
      { test:["entrada / salida", "entrada/salida", "entrada"], label:"Entrada / salida" },
      { test:["acciones"], label:"Acciones" },
      { test:["ultima asistencia", "ultima asist"], label:"Ultima asistencia" }
    ];

    Array.prototype.slice.call(document.querySelectorAll("table")).forEach(function(table){
      table.classList.add("attendance-table-head-uniform");

      Array.prototype.slice.call(table.querySelectorAll("thead th")).forEach(function(th){
        var chip = th.querySelector(".table-head-chip, .table-sort-button");
        if (!chip) return;

        var label = chip.querySelector(".table-head-label");
        if (!label) return;

        var current = normalize(label.textContent);

        map.forEach(function(item){
          var match = item.test.some(function(pattern){
            return current.indexOf(pattern) !== -1;
          });

          if (match) {
            label.textContent = item.label;
            label.setAttribute("title", item.label);
          }
        });

        var arrow = chip.querySelector(".sort-arrow, .table-head-icon");

        if (arrow) {
          arrow.style.background = "transparent";
          arrow.style.border = "0";
          arrow.style.boxShadow = "none";
        }

        if (!chip.querySelector(".sort-arrow") && arrow) {
          arrow.classList.add("table-head-placeholder");
          arrow.textContent = ".";
        }
      });
    });
  }

  function run(){
    improveDates();
    fixClearButton();
    fullHeaders();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", run);
  } else {
    run();
  }
})();
</script>
<script>
(function(){
  function bindDatePickers(){
    var inputs = Array.prototype.slice.call(document.querySelectorAll(".attendance-filter-panel input[type='date']"));

    inputs.forEach(function(input){
      if (input.dataset.datePickerFixed === "1") return;

      var field = input.closest(".attendance-field-date") || input.closest(".attendance-field");
      if (!field) return;

      input.dataset.datePickerFixed = "1";
      field.classList.add("attendance-field-date");
      field.setAttribute("tabindex", "0");
      field.setAttribute("role", "button");

      function openPicker(event){
        if (event) {
          event.preventDefault();
          event.stopPropagation();
        }

        field.classList.add("is-date-picker-focused");

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

        window.setTimeout(function(){
          field.classList.remove("is-date-picker-focused");
        }, 900);
      }

      field.addEventListener("click", openPicker);

      field.addEventListener("keydown", function(event){
        var key = event.key || "";

        if (key === "Enter" || key === " ") {
          openPicker(event);
        }
      });
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", bindDatePickers);
  } else {
    bindDatePickers();
  }
})();
</script>
<?php require_once __DIR__ . "/../includes/footer.php"; ?>



