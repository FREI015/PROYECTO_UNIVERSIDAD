<?php
ob_start();

function limpiarSalidaAntesPdf(string $debugFile): void {
  $salida = "";

  while (ob_get_level() > 0) {
    $contenido = ob_get_contents();

    if ($contenido !== false && $contenido !== "") {
      $salida .= $contenido;
    }

    @ob_end_clean();
  }

  if ($salida !== "") {
    @file_put_contents($debugFile, $salida);
  }
}
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";
requirePermiso("ver_reportes", BASE_URL . "/modulos/reportes.php");

function reportePdfParamEntero(array $keys): ?int {
  foreach ($keys as $key) {
    if (isset($_REQUEST[$key]) && trim((string)$_REQUEST[$key]) !== "") {
      $valor = (int)$_REQUEST[$key];
      return $valor > 0 ? $valor : null;
    }
  }

  return null;
}

function reportePdfSetParamTurno(int $turnoId): void {
  foreach (["turno_id", "turno", "turnoId"] as $key) {
    $_GET[$key] = (string)$turnoId;
    $_POST[$key] = (string)$turnoId;
    $_REQUEST[$key] = (string)$turnoId;
  }
}

function reportePdfTurnoNombrePorId(PDO $pdo, int $turnoId): string {
  if ($turnoId <= 0) {
    return "";
  }

  $stmt = $pdo->prepare("SELECT nombre FROM turnos WHERE id = ? LIMIT 1");
  $stmt->execute([$turnoId]);

  return strtoupper(trim((string)$stmt->fetchColumn()));
}

function reportePdfTurnoIdPermitido(PDO $pdo, int $turnoId): bool {
  if (tieneAlcanceGlobalTurnos()) {
    return true;
  }

  $turnoNombre = reportePdfTurnoNombrePorId($pdo, $turnoId);

  return puedeVerTurno($turnoNombre);
}

function reportePdfEmpleadoPermitido(PDO $pdo, int $empleadoId): bool {
  if (tieneAlcanceGlobalTurnos()) {
    return true;
  }

  if ($empleadoId <= 0) {
    return false;
  }

  $stmt = $pdo->prepare("
    SELECT t.nombre
    FROM empleados e
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE e.id = ?
    LIMIT 1
  ");
  $stmt->execute([$empleadoId]);
  $turnoNombre = (string)$stmt->fetchColumn();

  return puedeVerTurno($turnoNombre);
}

function reportePdfPrimerTurnoPermitidoId(PDO $pdo): ?int {
  if (tieneAlcanceGlobalTurnos()) {
    return null;
  }

  $turnos = turnosPermitidosPorRol();

  if ($turnos === []) {
    return null;
  }

  $placeholders = implode(",", array_fill(0, count($turnos), "?"));
  $stmt = $pdo->prepare("SELECT id FROM turnos WHERE UPPER(nombre) IN ($placeholders) ORDER BY id LIMIT 1");
  $stmt->execute($turnos);

  $turnoId = (int)$stmt->fetchColumn();

  return $turnoId > 0 ? $turnoId : null;
}

function reportePdfDenegar(string $mensaje): void {
  header("Location: " . BASE_URL . "/modulos/reportes.php?err=" . urlencode($mensaje));
  exit;
}

function reportePdfAplicarAlcance(PDO $pdo): void {
  if (tieneAlcanceGlobalTurnos()) {
    return;
  }

  $empleadoId = reportePdfParamEntero(["empleado_id", "empleado", "empleadoId"]);
  $turnoId = reportePdfParamEntero(["turno_id", "turno", "turnoId"]);

  if ($empleadoId !== null && !reportePdfEmpleadoPermitido($pdo, $empleadoId)) {
    reportePdfDenegar("No tienes permiso para generar reporte de ese empleado.");
  }

  if ($turnoId !== null && !reportePdfTurnoIdPermitido($pdo, $turnoId)) {
    reportePdfDenegar("No tienes permiso para generar reporte de ese turno.");
  }

  if ($empleadoId === null && $turnoId === null) {
    $turnoPermitidoId = reportePdfPrimerTurnoPermitidoId($pdo);

    if ($turnoPermitidoId === null) {
      reportePdfDenegar("No tienes turnos disponibles para generar reportes.");
    }

    reportePdfSetParamTurno($turnoPermitidoId);
  }
}

reportePdfAplicarAlcance($pdo);

date_default_timezone_set("America/Caracas");

/**
 * TCPDF portable (dentro del proyecto)
 * Ruta: control_asistencia/libs/tcpdf/tcpdf.php
 */
require_once __DIR__ . "/../libs/tcpdf/tcpdf.php";

// Helpers
function clampDate($d, $fallback) {
  $d = trim((string)$d);
  if ($d === "") return $fallback;
  if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $d)) return $fallback;
  return $d;
}

function pdfEsc($value): string {
  return htmlspecialchars((string)$value, ENT_QUOTES, "UTF-8");
}


function reportePdfAgregarCintillo(TCPDF $pdf): void {
  // MB13B-R2-CINTILLO-PDF
  $cintilloJpg = __DIR__ . "/../assets/img/institucional/cintillo_institucional_final.jpeg";
  $cintilloPng = __DIR__ . "/../assets/img/institucional/cintillo_institucional_final.jpeg";

  if (is_file($cintilloJpg)) {
    $pdf->Image($cintilloJpg, 10, 7, 190, 0, "JPG", "", "T", false, 300, "C");
    $pdf->SetY(42);
    return;
  }

  if (is_file($cintilloPng)) {
    $pdf->Image($cintilloPng, 10, 7, 190, 0, "PNG", "", "T", false, 300, "C");
    $pdf->SetY(42);
    return;
  }

  $pdf->SetY(8);
  $pdf->SetFont("helvetica", "", 8);
  $pdf->Cell(0, 4, "Ministerio del Poder Popular para la Educación", 0, 1, "C");
  $pdf->SetFont("helvetica", "B", 14);
  $pdf->Cell(0, 6, "EDUCACIÓN", 0, 1, "C");
  $pdf->SetFont("helvetica", "B", 7);
  $pdf->Cell(0, 4, "E.B.N Dr. Enrique Delgado Palacios   CIRCUITO LONGARAY   Cod. Plantel OD723101   Cod. Institucional 00673395   RIF 305187355", 0, 1, "C");
  $pdf->Ln(4);
}
function rangeFromPeriodo(string $periodo, string $fechaBase): array {
  $dt = new DateTime($fechaBase);
  $periodo = strtoupper(trim($periodo));
  $label = "";

  if ($periodo === "DIARIO") {
    $desde = $dt->format("Y-m-d");
    $hasta = $desde;
    $label = "Diario ($desde)";
    return [$desde, $hasta, $label];
  }

  if ($periodo === "SEMANAL") {
    // Semana LUN-DOM
    $dow = (int)$dt->format("N"); // 1=Lunes ... 7=Dom
    $start = (clone $dt)->modify("-" . ($dow - 1) . " days");
    $end   = (clone $start)->modify("+6 days");
    $desde = $start->format("Y-m-d");
    $hasta = $end->format("Y-m-d");
    $label = "Semanal ($desde al $hasta)";
    return [$desde, $hasta, $label];
  }

  if ($periodo === "QUINCENAL") {
    $day = (int)$dt->format("j");
    $y = (int)$dt->format("Y");
    $m = (int)$dt->format("m");

    if ($day <= 15) {
      $desde = sprintf("%04d-%02d-01", $y, $m);
      $hasta = sprintf("%04d-%02d-15", $y, $m);
    } else {
      $desde = sprintf("%04d-%02d-16", $y, $m);
      $hasta = (new DateTime(sprintf("%04d-%02d-01", $y, $m)))->modify("last day of this month")->format("Y-m-d");
    }
    $label = "Quincenal ($desde al $hasta)";
    return [$desde, $hasta, $label];
  }

  if ($periodo === "MENSUAL") {
    $start = (clone $dt)->modify("first day of this month");
    $end   = (clone $dt)->modify("last day of this month");
    $desde = $start->format("Y-m-d");
    $hasta = $end->format("Y-m-d");
    $label = "Mensual ($desde al $hasta)";
    return [$desde, $hasta, $label];
  }

  if ($periodo === "TRIMESTRAL") {
    $y = (int)$dt->format("Y");
    $m = (int)$dt->format("m");
    $q = (int)floor(($m - 1) / 3) + 1;
    $mStart = ($q - 1) * 3 + 1;

    $start = new DateTime(sprintf("%04d-%02d-01", $y, $mStart));
    $end = (clone $start)->modify("+2 months")->modify("last day of this month");

    $desde = $start->format("Y-m-d");
    $hasta = $end->format("Y-m-d");
    $label = "Trimestral (Q$q) ($desde al $hasta)";
    return [$desde, $hasta, $label];
  }

  // PERSONALIZADO (si no pasan desde/hasta caerá al mes)
  $start = (clone $dt)->modify("first day of this month");
  $end   = (clone $dt)->modify("last day of this month");
  $desde = $start->format("Y-m-d");
  $hasta = $end->format("Y-m-d");
  $label = "Personalizado ($desde al $hasta)";
  return [$desde, $hasta, $label];
}

function dateListInclusive(string $desde, string $hasta): array {
  $out = [];
  $d1 = new DateTime($desde);
  $d2 = new DateTime($hasta);
  if ($d2 < $d1) return $out;

  while ($d1 <= $d2) {
    $out[] = $d1->format("Y-m-d");
    $d1->modify("+1 day");
  }
  return $out;
}

// Inputs
$periodo    = strtoupper(trim($_GET["periodo"] ?? "DIARIO"));
$fechaBase  = clampDate($_GET["fecha_base"] ?? "", date("Y-m-d"));
$turnoIdRaw = trim($_GET["turno_id"] ?? "");
$empleadoId = (int)($_GET["empleado_id"] ?? 0);

$desdeIn = trim($_GET["desde"] ?? "");
$hastaIn = trim($_GET["hasta"] ?? "");

// Reporte individual de un empleado.
$esIndividual = ($periodo === "INDIVIDUAL" && $empleadoId > 0);

// Si el usuario pone desde/hasta, usamos ese rango; si no, calculamos por periodo/fecha_base.
if ($desdeIn !== "" && $hastaIn !== "" && preg_match('/^\d{4}-\d{2}-\d{2}$/', $desdeIn) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $hastaIn)) {
  $desde = $desdeIn;
  $hasta = $hastaIn;
  $label = "Rango ($desde al $hasta)";
} elseif ($esIndividual) {
  // Para individual, usar el rango proporcionado o mes actual
  if ($desdeIn !== "" && $hastaIn !== "") {
    $label = "Individual ($desde al $hasta)";
  } else {
    [$desde, $hasta, $label] = rangeFromPeriodo("MENSUAL", date("Y-m-d"));
    $label = str_replace("Mensual", "Individual", $label);
  }
} else {
  [$desde, $hasta, $label] = rangeFromPeriodo($periodo, $fechaBase);
}

$turnoId = ($turnoIdRaw === "") ? null : (int)$turnoIdRaw;
$dates = dateListInclusive($desde, $hasta);

// 1) Empleados

// Busca solo el empleado solicitado para reporte individual.
if ($esIndividual) {
  $sqlEmp = "
    SELECT e.id, e.cedula, e.nombres, e.apellidos, e.estado,
           c.nombre AS cargo,
           t.nombre AS turno
    FROM empleados e
    JOIN cargos c ON c.id = e.cargo_id
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE e.id = ?
  ";
  $stmt = $pdo->prepare($sqlEmp);
  $stmt->execute([$empleadoId]);
  $empleados = $stmt->fetchAll(PDO::FETCH_ASSOC);
} else {
  // Reporte general de empleados activos.
  $sqlEmp = "
    SELECT e.id, e.cedula, e.nombres, e.apellidos, e.estado,
           c.nombre AS cargo,
           t.nombre AS turno
    FROM empleados e
    JOIN cargos c ON c.id = e.cargo_id
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE e.estado='ACTIVO'
  ";
  $paramsEmp = [];

  if ($turnoId !== null) {
    $sqlEmp .= " AND e.turno_id = ? ";
    $paramsEmp[] = $turnoId;
  }

  $sqlEmp .= " ORDER BY e.apellidos, e.nombres ";

  $stmt = $pdo->prepare($sqlEmp);
  $stmt->execute($paramsEmp);
  $empleados = $stmt->fetchAll(PDO::FETCH_ASSOC);
}

if (!$empleados) {
  $pdf = new TCPDF("P", "mm", "A4", true, "UTF-8", false);
  $pdf->SetCreator("Control de Asistencia");
  $pdf->SetTitle("Reporte de Asistencias");
  $pdf->SetMargins(12, 12, 12);
  $pdf->AddPage();
reportePdfAgregarCintillo($pdf);
  $pdf->SetFont("helvetica", "", 12);
  $pdf->Write(0, "No hay empleados activos para el filtro seleccionado.", "", 0, "L", true, 0, false, false, 0);
  $pdf->Output("reporte.pdf", "I");
  exit;
}

$empIds = array_map(fn($r)=> (int)$r["id"], $empleados);
$placeholders = implode(",", array_fill(0, count($empIds), "?"));

// 2) Data en bloque
// asistencias en rango
$sqlAsis = "
  SELECT empleado_id, fecha, estado, minutos_tarde, salida_estado, minutos_salida_tardia, observacion_sistema
  FROM asistencias
  WHERE fecha BETWEEN ? AND ?
    AND empleado_id IN ($placeholders)
";
$stmt = $pdo->prepare($sqlAsis);
$stmt->execute(array_merge([$desde, $hasta], $empIds));
$asisRows = $stmt->fetchAll(PDO::FETCH_ASSOC);

// permisos solapados en rango
$sqlPerm = "
  SELECT empleado_id, fecha_inicio, fecha_fin, tipo, motivo
  FROM permisos
  WHERE estado='ACTIVO'
    AND fecha_fin >= ?
    AND fecha_inicio <= ?
    AND empleado_id IN ($placeholders)
";
$stmt = $pdo->prepare($sqlPerm);
$stmt->execute(array_merge([$desde, $hasta], $empIds));
$permRows = $stmt->fetchAll(PDO::FETCH_ASSOC);

// reposos solapados en rango
$sqlRepo = "
  SELECT empleado_id, fecha_inicio, fecha_fin, tipo, motivo
  FROM reposos
  WHERE estado='ACTIVO'
    AND fecha_fin >= ?
    AND fecha_inicio <= ?
    AND empleado_id IN ($placeholders)
";
$stmt = $pdo->prepare($sqlRepo);
$stmt->execute(array_merge([$desde, $hasta], $empIds));
$repoRows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$statusMap = [];
foreach ($empIds as $id) {
  $statusMap[$id] = [];
  foreach ($dates as $d) {
    $statusMap[$id][$d] = [
      'estado' => 'AUSENTE',
      'detalle' => 'Sin justificación',
      'minutos_tarde' => 0
    ];
  }
}

// aplicar reposos
foreach ($repoRows as $r) {
  $eid = (int)$r["empleado_id"];
  $ini = $r["fecha_inicio"];
  $fin = $r["fecha_fin"];
  $tipo = trim((string)$r["tipo"]);
  $mot  = trim((string)($r["motivo"] ?? ""));

  $dini = max($ini, $desde);
  $dfin = min($fin, $hasta);

  foreach (dateListInclusive($dini, $dfin) as $d) {
    if (!isset($statusMap[$eid][$d])) continue;
    $statusMap[$eid][$d] = [
      'estado' => 'REPOSO',
      'detalle' => "Reposo: {$tipo}" . ($mot !== "" ? " - {$mot}" : ""),
      'minutos_tarde' => 0
    ];
  }
}

// aplicar permisos (si no hay reposo)
foreach ($permRows as $p) {
  $eid = (int)$p["empleado_id"];
  $ini = $p["fecha_inicio"];
  $fin = $p["fecha_fin"];
  $tipo = trim((string)$p["tipo"]);
  $mot  = trim((string)($p["motivo"] ?? ""));

  $dini = max($ini, $desde);
  $dfin = min($fin, $hasta);

  foreach (dateListInclusive($dini, $dfin) as $d) {
    if (!isset($statusMap[$eid][$d])) continue;
    if ($statusMap[$eid][$d]['estado'] === 'REPOSO') continue;

    $statusMap[$eid][$d] = [
      'estado' => 'PERMISO',
      'detalle' => "Permiso: {$tipo}" . ($mot !== "" ? " - {$mot}" : ""),
      'minutos_tarde' => 0
    ];
  }
}

// aplicar asistencias (si no hay reposo/permiso)
// CORREGIDO para ENUM('ASISTIO','RETARDO','FALTA')
foreach ($asisRows as $a) {
  $eid = (int)$a["empleado_id"];
  $f = $a["fecha"];
  if (!isset($statusMap[$eid][$f])) continue;

  if ($statusMap[$eid][$f]["estado"] === "REPOSO" || $statusMap[$eid][$f]["estado"] === "PERMISO") {
    continue;
  }

  $minT = (int)($a["minutos_tarde"] ?? 0);
  $est = strtoupper((string)$a["estado"]);
  $salidaEstado = strtoupper(trim((string)($a["salida_estado"] ?? "")));
  $minSalidaTardia = (int)($a["minutos_salida_tardia"] ?? 0);
  $obsSalida = trim((string)($a["observacion_sistema"] ?? ""));
  $detalleSalida = "";

  if ($salidaEstado === "SALIDA_TARDIA" || $minSalidaTardia > 0) {
    $detalleSalida = " | Salida tardía" . ($minSalidaTardia > 0 ? " ({$minSalidaTardia} min)" : "");
  } elseif ($obsSalida !== "" && $salidaEstado !== "NORMAL") {
    $detalleSalida = " | " . $obsSalida;
  }

  if ($est === "FALTA") {
    $statusMap[$eid][$f] = [
      "estado" => "AUSENTE",
      "detalle" => "Falta (registrada)",
      "minutos_tarde" => 0
    ];
    continue;
  }

  if ($est === "RETARDO" || $minT > 0) {
    $statusMap[$eid][$f] = [
      "estado" => "RETARDO",
      "detalle" => "Retardo" . ($minT > 0 ? " ({$minT} min)" : "") . $detalleSalida,
      "minutos_tarde" => $minT
    ];
  } else {
    $estadoDia = $detalleSalida !== "" ? "SALIDA_TARDIA" : "A_TIEMPO";
    $detalleDia = $detalleSalida !== "" ? "Asistió a tiempo" . $detalleSalida : "Asistió a tiempo";

    $statusMap[$eid][$f] = [
      "estado" => $estadoDia,
      "detalle" => $detalleDia,
      "minutos_tarde" => 0
    ];
  }
}

// 4) Estadísticas
$sumGlobal = [
  'empleados' => count($empleados),
  'dias' => count($dates),
  'a_tiempo' => 0,
  'retardo' => 0,
  "salida_tardia" => 0,
  'permiso' => 0,
  'reposo' => 0,
  'ausente' => 0,
  'asistio' => 0,
];

$resumen = [];
$incidencias = [];

foreach ($empleados as $emp) {
  $eid = (int)$emp["id"];
  $nombre = trim($emp["nombres"] . " " . $emp["apellidos"]);

  $cnt = [
    'a_tiempo' => 0,
    'retardo' => 0,
    "salida_tardia" => 0,
    'permiso' => 0,
    'reposo' => 0,
    'ausente' => 0,
    'asistio' => 0,
  ];

  foreach ($dates as $d) {
    $st = $statusMap[$eid][$d]['estado'];

    if ($st === "A_TIEMPO" || $st === "SALIDA_TARDIA") $cnt["a_tiempo"]++;
    if ($st === "SALIDA_TARDIA") $cnt["salida_tardia"]++;
    elseif ($st === 'RETARDO') $cnt['retardo']++;
    elseif ($st === 'PERMISO') $cnt['permiso']++;
    elseif ($st === 'REPOSO') $cnt['reposo']++;
    else $cnt['ausente']++;

    $cnt['asistio'] = $cnt['a_tiempo'] + $cnt['retardo'];

    // detalle: guardar todo lo que NO sea "a tiempo"
    if ($st !== 'A_TIEMPO') {
      $incidencias[] = [
        'fecha' => $d,
        'cedula' => $emp["cedula"],
        'empleado' => $nombre,
        'turno' => $emp["turno"] ?? "—",
        'estado' => $st,
        'detalle' => $statusMap[$eid][$d]['detalle'],
      ];
    }
  }

  $resumen[] = [
    'cedula' => $emp["cedula"],
    'empleado' => $nombre,
    'cargo' => $emp["cargo"],
    'turno' => $emp["turno"] ?? "—",
    'asistio' => $cnt['asistio'],
    'a_tiempo' => $cnt['a_tiempo'],
    'retardo' => $cnt['retardo'],
    "salida_tardia" => $cnt["salida_tardia"],
    'permiso' => $cnt['permiso'],
    'reposo' => $cnt['reposo'],
    'ausente' => $cnt['ausente'],
  ];

  $sumGlobal['a_tiempo'] += $cnt['a_tiempo'];
  $sumGlobal['retardo']  += $cnt['retardo'];
  $sumGlobal["salida_tardia"] += $cnt["salida_tardia"];
  $sumGlobal['permiso']  += $cnt['permiso'];
  $sumGlobal['reposo']   += $cnt['reposo'];
  $sumGlobal['ausente']  += $cnt['ausente'];
}

$sumGlobal['asistio'] = $sumGlobal['a_tiempo'] + $sumGlobal['retardo'];

usort($incidencias, function($a, $b){
  if ($a['fecha'] === $b['fecha']) return strcmp($a['empleado'], $b['empleado']);
  return strcmp($a['fecha'], $b['fecha']);
});

// Limitar incidencias para que el PDF no sea gigante
$maxDetalle = 800;
$detalleExcedido = count($incidencias) > $maxDetalle;
if ($detalleExcedido) {
  $incidencias = array_slice($incidencias, 0, $maxDetalle);
}

// 5) Crear PDF
$pdf = new TCPDF("P", "mm", "A4", true, "UTF-8", false);
$pdf->SetCreator("Control de Asistencia");
$pdf->SetAuthor("Sistema Control de Asistencia");
$pdf->SetTitle("Reporte de Asistencias");
$pdf->SetMargins(12, 12, 12);
$pdf->SetAutoPageBreak(true, 12);
$pdf->AddPage();
reportePdfAgregarCintillo($pdf);
$pdf->SetFont("helvetica", "", 10);

$generado = date("Y-m-d H:i");
$turnoTxt = ($turnoId === null) ? "Todos" : ("Turno ID: " . $turnoId);

// Título y nombre del archivo para reporte individual.
$tituloReporte = "Reporte de Asistencia - " . $label;
$filename = "reporte_{$desde}_{$hasta}.pdf";

if ($esIndividual && count($empleados) > 0) {
  $empNombre = trim($empleados[0]["nombres"] . " " . $empleados[0]["apellidos"]);
  $empCedula = formatCedula($empleados[0]["cedula"]);
  $empCedulaRaw = $empleados[0]["cedula"];
  $tituloReporte = "Reporte Individual - " . $empNombre . " (" . $empCedula . ")";
  $filename = "reporte_individual_" . $empCedulaRaw . "_{$desde}_{$hasta}.pdf";
}

$html = '
<style>
  h1{font-size:16px;margin:0 0 6px 0;}
  h2{font-size:12px;margin:12px 0 6px 0;}
  .meta{font-size:10px;color:#555;line-height:1.35;}
  .box{border:1px solid #ddd;padding:8px;border-radius:6px;margin:10px 0;}
  table{width:100%;border-collapse:collapse;}
  th,td{border:1px solid #ddd;padding:6px;font-size:9.5px;}
  th{background:#f3f6fb;font-weight:bold;}
</style>

<h1>'.$tituloReporte.'</h1>
<div class="meta">
  Generado: '.$generado.'<br>
  Rango: <strong>'.$desde.'</strong> al <strong>'.$hasta.'</strong><br>
  Turno: '.$turnoTxt.'<br>
  Empleados: <strong>'.$sumGlobal["empleados"].'</strong> | Días en rango: <strong>'.$sumGlobal["dias"].'</strong>
</div>

<div class="box">
  <table>
    <tr>
      <th>Total Asistió</th><th>A tiempo</th><th>Retardos</th><th>Salidas tardías</th><th>Permisos</th><th>Reposos</th><th>Ausencias</th>
    </tr>
    <tr>
      <td>'.$sumGlobal["asistio"].'</td>
      <td>'.$sumGlobal["a_tiempo"].'</td>
      <td>'.$sumGlobal["retardo"].'</td>
      <td>'.$sumGlobal["salida_tardia"].'</td>
      <td>'.$sumGlobal["permiso"].'</td>
      <td>'.$sumGlobal["reposo"].'</td>
      <td>'.$sumGlobal["ausente"].'</td>
    </tr>
  </table>
</div>

';

// En reporte individual se muestra la ficha del empleado.
if ($esIndividual && count($empleados) > 0) {
  $empInfo = $empleados[0];
  $empNombreCompleto = pdfEsc(trim($empInfo["nombres"] . " " . $empInfo["apellidos"]));
  $empCargo = pdfEsc($empInfo["cargo"]);
  $empTurno = pdfEsc($empInfo["turno"] ?? "—");

  $html .= '
<div class="box">
  <strong>Empleado:</strong> '.$empNombreCompleto.'<br>
  <strong>Cargo:</strong> '.$empCargo.'<br>
  <strong>Turno:</strong> '.$empTurno.'
</div>

<h2>Resumen de asistencia</h2>
';

  if (count($resumen) > 0) {
    $r = $resumen[0];
    $html .= '<div class="box">
      <table>
        <tr>
          <th>Total Asistió</th><th>A tiempo</th><th>Retardos</th><th>Salidas tardías</th><th>Permisos</th><th>Reposos</th><th>Ausencias</th>
        </tr>
        <tr>
          <td>'.$r["asistio"].'</td>
          <td>'.$r["a_tiempo"].'</td>
          <td>'.$r["retardo"].'</td>
          <td>'.$r["salida_tardia"].'</td>
          <td>'.$r["permiso"].'</td>
          <td>'.$r["reposo"].'</td>
          <td>'.$r["ausente"].'</td>
        </tr>
      </table>
    </div>';
  }
} else {
  // Reporte general: mostrar resumen por empleado
  $html .= '<h2>Resumen por empleado</h2>
<table>
  <tr>
    <th>Cédula</th><th>Empleado</th><th>Turno</th>
    <th>Asistió</th><th>A tiempo</th><th>Tarde</th><th>Permiso</th><th>Reposo</th><th>Ausente</th>
  </tr>';

  foreach ($resumen as $r) {
    $html .= '<tr>
      <td>'.pdfEsc(formatCedula($r["cedula"])).'</td>
      <td>'.pdfEsc($r["empleado"]).'</td>
      <td>'.pdfEsc($r["turno"]).'</td>
      <td>'.$r["asistio"].'</td>
      <td>'.$r["a_tiempo"].'</td>
      <td>'.$r["retardo"].'</td>
      <td>'.$r["salida_tardia"].'</td>
      <td>'.$r["permiso"].'</td>
      <td>'.$r["reposo"].'</td>
      <td>'.$r["ausente"].'</td>
    </tr>';
  }

  $html .= '</table>';
}

$html .= '

<h2>Detalle de incidencias (no a tiempo)</h2>';

if ($detalleExcedido) {
  $html .= '<div class="meta">Detalle limitado a '.$maxDetalle.' registros. Use rangos más cortos para ver el detalle completo.</div>';
}

$html .= '<table>
  <tr>
    <th>Fecha</th><th>Cédula</th><th>Empleado</th><th>Turno</th><th>Estado</th><th>Detalle / Justificación</th>
  </tr>';

foreach ($incidencias as $i) {
  $html .= '<tr>
    <td>'.pdfEsc($i["fecha"]).'</td>
    <td>'.pdfEsc(formatCedula($i["cedula"])).'</td>
    <td>'.pdfEsc($i["empleado"]).'</td>
    <td>'.pdfEsc($i["turno"]).'</td>
    <td>'.pdfEsc($i["estado"]).'</td>
    <td>'.pdfEsc($i["detalle"]).'</td>
  </tr>';
}

$html .= '</table>';

$pdf->writeHTML($html, true, false, true, false, '');

$debugSalidaPdf = __DIR__ . "/../_fixes/salida_detectada_antes_pdf.txt";
limpiarSalidaAntesPdf($debugSalidaPdf);

if (headers_sent($archivoHeaders, $lineaHeaders)) {
  die("No se pudo generar el PDF porque ya se enviaron encabezados en: " . $archivoHeaders . " línea " . $lineaHeaders);
}

$pdf->Output($filename, "I");
exit;


