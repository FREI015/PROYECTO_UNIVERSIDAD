<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";
requireLogin();
require_once __DIR__ . "/includes/conexion.php";

date_default_timezone_set("America/Caracas");

$pageTitle = "Inicio";
$active = "inicio";

$usuarioActual = usuarioActual();
$rolActual = rolActual();
$rolesDisponiblesInicio = rolesUsuarioDisponibles();
$rolLabel = $rolesDisponiblesInicio[$rolActual] ?? $rolActual;
$nombreUsuario = trim((string)($usuarioActual["usuario"] ?? "Usuario"));

$tieneAlcanceGlobal = tieneAlcanceGlobalTurnos();
$turnosPermitidos = turnosPermitidosPorRol();

$alcanceTexto = $tieneAlcanceGlobal ? "Acceso general" : implode(", ", $turnosPermitidos);
if ($alcanceTexto === "") {
  $alcanceTexto = "Sin alcance asignado";
}

$hoy = date("Y-m-d");

function inicioTableExists(PDO $pdo, string $table): bool {
  try {
    $stmt = $pdo->prepare("SHOW TABLES LIKE ?");
    $stmt->execute([$table]);
    return (bool)$stmt->fetchColumn();
  } catch (Throwable $e) {
    return false;
  }
}

function inicioFirstColumn(PDO $pdo, string $table, array $columns): string {
  foreach ($columns as $column) {
    try {
      $stmt = $pdo->prepare("SHOW COLUMNS FROM `$table` LIKE ?");
      $stmt->execute([$column]);

      if ($stmt->fetchColumn()) {
        return $column;
      }
    } catch (Throwable $e) {
      continue;
    }
  }

  return "";
}

function inicioScalar(PDO $pdo, string $sql, array $params = []): int {
  try {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return (int)$stmt->fetchColumn();
  } catch (Throwable $e) {
    return 0;
  }
}

function inicioRows(PDO $pdo, string $sql, array $params = []): array {
  try {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
  } catch (Throwable $e) {
    return [];
  }
}

function inicioScopeWhere(string $aliasTurno, array &$params): string {
  if (tieneAlcanceGlobalTurnos()) {
    return "";
  }

  $sql = filtroTurnosPermitidosSql($aliasTurno, $params);

  if (trim($sql) === "") {
    return " AND 1 = 0 ";
  }

  return $sql;
}

function inicioNum(int $n): string {
  return number_format($n, 0, ",", ".");
}

function inicioFechaMenor(string $a, string $b): string {
  return strtotime($a) <= strtotime($b) ? $a : $b;
}

function inicioPeriodoLabel(string $desde, string $hasta): string {
  if ($desde === $hasta) {
    return date("d/m/Y", strtotime($desde));
  }

  return date("d/m/Y", strtotime($desde)) . " - " . date("d/m/Y", strtotime($hasta));
}

function inicioPeriodoAsistencia(PDO $pdo, string $desde, string $hasta, bool $asistenciasExiste, string $fechaCol, string $empleadoCol, string $estadoCol): array {
  if (!$asistenciasExiste || $fechaCol === "" || $empleadoCol === "") {
    return [
      "asistencias" => 0,
      "retardos" => 0,
    ];
  }

  $paramsAsistencias = [$desde, $hasta];
  $scopeAsistencias = inicioScopeWhere("t", $paramsAsistencias);

  $asistencias = inicioScalar($pdo, "
    SELECT COUNT(*)
    FROM asistencias a
    JOIN empleados e ON e.id = a.`$empleadoCol`
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE a.`$fechaCol` BETWEEN ? AND ?
    $scopeAsistencias
  ", $paramsAsistencias);

  $retardos = 0;

  if ($estadoCol !== "") {
    $paramsRetardos = [$desde, $hasta];
    $scopeRetardos = inicioScopeWhere("t", $paramsRetardos);

    $retardos = inicioScalar($pdo, "
      SELECT COUNT(*)
      FROM asistencias a
      JOIN empleados e ON e.id = a.`$empleadoCol`
      LEFT JOIN turnos t ON t.id = e.turno_id
      WHERE a.`$fechaCol` BETWEEN ? AND ?
        AND UPPER(a.`$estadoCol`) = 'RETARDO'
      $scopeRetardos
    ", $paramsRetardos);
  }

  return [
    "asistencias" => $asistencias,
    "retardos" => $retardos,
  ];
}

function inicioPeriodoPermisos(PDO $pdo, string $desde, string $hasta): int {
  $params = [$hasta, $desde];
  $scope = inicioScopeWhere("t", $params);

  return inicioScalar($pdo, "
    SELECT COUNT(*)
    FROM permisos p
    JOIN empleados e ON e.id = p.empleado_id
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE p.fecha_inicio <= ?
      AND p.fecha_fin >= ?
    $scope
  ", $params);
}

function inicioPeriodoReposos(PDO $pdo, string $desde, string $hasta): int {
  $params = [$hasta, $desde];
  $scope = inicioScopeWhere("t", $params);

  return inicioScalar($pdo, "
    SELECT COUNT(*)
    FROM reposos r
    JOIN empleados e ON e.id = r.empleado_id
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE r.fecha_inicio <= ?
      AND r.fecha_fin >= ?
    $scope
  ", $params);
}

$scopeParams = [];
$scopeSql = inicioScopeWhere("t", $scopeParams);

$totalActivos = inicioScalar($pdo, "
  SELECT COUNT(*)
  FROM empleados e
  LEFT JOIN turnos t ON t.id = e.turno_id
  WHERE e.estado = 'ACTIVO'
  $scopeSql
", $scopeParams);

$asistenciasExiste = inicioTableExists($pdo, "asistencias");
$fechaCol = $asistenciasExiste ? inicioFirstColumn($pdo, "asistencias", ["fecha", "fecha_asistencia"]) : "";
$empleadoCol = $asistenciasExiste ? inicioFirstColumn($pdo, "asistencias", ["empleado_id", "id_empleado"]) : "";
$estadoCol = $asistenciasExiste ? inicioFirstColumn($pdo, "asistencias", ["estado"]) : "";
$horaEntradaCol = $asistenciasExiste ? inicioFirstColumn($pdo, "asistencias", ["hora_entrada", "entrada"]) : "";
$minTardeCol = $asistenciasExiste ? inicioFirstColumn($pdo, "asistencias", ["min_tarde", "minutos_tarde"]) : "";

$presentesHoy = 0;
$retardosHoy = 0;
$actividadHoy = [];

if ($asistenciasExiste && $fechaCol !== "" && $empleadoCol !== "") {
  $paramsPresentes = [$hoy];
  $scopePresentes = inicioScopeWhere("t", $paramsPresentes);

  $presentesHoy = inicioScalar($pdo, "
    SELECT COUNT(DISTINCT a.`$empleadoCol`)
    FROM asistencias a
    JOIN empleados e ON e.id = a.`$empleadoCol`
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE a.`$fechaCol` = ?
    $scopePresentes
  ", $paramsPresentes);

  if ($estadoCol !== "") {
    $paramsRetardos = [$hoy];
    $scopeRetardos = inicioScopeWhere("t", $paramsRetardos);

    $retardosHoy = inicioScalar($pdo, "
      SELECT COUNT(DISTINCT a.`$empleadoCol`)
      FROM asistencias a
      JOIN empleados e ON e.id = a.`$empleadoCol`
      LEFT JOIN turnos t ON t.id = e.turno_id
      WHERE a.`$fechaCol` = ?
        AND UPPER(a.`$estadoCol`) = 'RETARDO'
      $scopeRetardos
    ", $paramsRetardos);
  }

  $selectEstado = $estadoCol !== "" ? "a.`$estadoCol` AS estado" : "'REGISTRADO' AS estado";
  $selectHora = $horaEntradaCol !== "" ? "a.`$horaEntradaCol` AS hora_entrada" : "'' AS hora_entrada";
  $selectMin = $minTardeCol !== "" ? "a.`$minTardeCol` AS min_tarde" : "0 AS min_tarde";
  $orderCol = $horaEntradaCol !== "" ? "a.`$horaEntradaCol`" : "a.id";

  $paramsActividad = [$hoy];
  $scopeActividad = inicioScopeWhere("t", $paramsActividad);

  $actividadHoy = inicioRows($pdo, "
    SELECT
      CONCAT(e.nombres, ' ', e.apellidos) AS empleado,
      e.cédula,
      c.nombre AS cargo,
      COALESCE(t.nombre, 'SIN TURNO') AS turno,
      $selectEstado,
      $selectHora,
      $selectMin
    FROM asistencias a
    JOIN empleados e ON e.id = a.`$empleadoCol`
    LEFT JOIN cargos c ON c.id = e.cargo_id
    LEFT JOIN turnos t ON t.id = e.turno_id
    WHERE a.`$fechaCol` = ?
    $scopeActividad
    ORDER BY $orderCol DESC
    LIMIT 5
  ", $paramsActividad);
}

$paramsPermisosHoy = [$hoy, $hoy];
$scopePermisosHoy = inicioScopeWhere("t", $paramsPermisosHoy);

$permisosHoy = inicioScalar($pdo, "
  SELECT COUNT(*)
  FROM permisos p
  JOIN empleados e ON e.id = p.empleado_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  WHERE p.fecha_inicio <= ?
    AND p.fecha_fin >= ?
  $scopePermisosHoy
", $paramsPermisosHoy);

$paramsRepososHoy = [$hoy, $hoy];
$scopeRepososHoy = inicioScopeWhere("t", $paramsRepososHoy);

$repososHoy = inicioScalar($pdo, "
  SELECT COUNT(*)
  FROM reposos r
  JOIN empleados e ON e.id = r.empleado_id
  LEFT JOIN turnos t ON t.id = e.turno_id
  WHERE r.fecha_inicio <= ?
    AND r.fecha_fin >= ?
  $scopeRepososHoy
", $paramsRepososHoy);

$sinRegistrar = max(0, $totalActivos - $presentesHoy - $permisosHoy - $repososHoy);

$paramsTurnos = [];
$scopeTurnos = inicioScopeWhere("t", $paramsTurnos);

$resumenTurnos = inicioRows($pdo, "
  SELECT
    COALESCE(t.nombre, 'SIN TURNO') AS turno,
    COUNT(*) AS total
  FROM empleados e
  LEFT JOIN turnos t ON t.id = e.turno_id
  WHERE e.estado = 'ACTIVO'
  $scopeTurnos
  GROUP BY COALESCE(t.nombre, 'SIN TURNO')
  ORDER BY COALESCE(t.nombre, 'SIN TURNO')
", $paramsTurnos);

$diaActual = (int)date("j");
$mesActual = (int)date("n");
$anioActual = (int)date("Y");
$trimestreActual = (int)ceil($mesActual / 3);
$mesInicioTrimestre = (($trimestreActual - 1) * 3) + 1;
$mesInicioSemestre = $mesActual <= 6 ? 1 : 7;

$periodosBase = [
  [
    "nombre" => "Hoy",
    "detalle" => "Operacion diaria",
    "desde" => $hoy,
    "hasta_plan" => $hoy,
  ],
  [
    "nombre" => "Semana",
    "detalle" => "Semana actual",
    "desde" => date("Y-m-d", strtotime("monday this week")),
    "hasta_plan" => date("Y-m-d", strtotime("sunday this week")),
  ],
  [
    "nombre" => "Quincena",
    "detalle" => $diaActual <= 15 ? "Primera quincena" : "Segunda quincena",
    "desde" => $diaActual <= 15 ? date("Y-m-01") : date("Y-m-16"),
    "hasta_plan" => $diaActual <= 15 ? date("Y-m-15") : date("Y-m-t"),
  ],
  [
    "nombre" => "Mes",
    "detalle" => "Mes actual",
    "desde" => date("Y-m-01"),
    "hasta_plan" => date("Y-m-t"),
  ],
  [
    "nombre" => "Trimestre",
    "detalle" => "Trimestre actual",
    "desde" => sprintf("%04d-%02d-01", $anioActual, $mesInicioTrimestre),
    "hasta_plan" => date("Y-m-t", strtotime(sprintf("%04d-%02d-01", $anioActual, $mesInicioTrimestre + 2))),
  ],
  [
    "nombre" => "Semestre",
    "detalle" => "Semestre actual",
    "desde" => sprintf("%04d-%02d-01", $anioActual, $mesInicioSemestre),
    "hasta_plan" => date("Y-m-t", strtotime(sprintf("%04d-%02d-01", $anioActual, $mesInicioSemestre + 5))),
  ],
];

$periodosResumen = [];

foreach ($periodosBase as $periodo) {
  $hastaCorte = inicioFechaMenor($periodo["hasta_plan"], $hoy);
  $corteActivo = $hastaCorte !== $periodo["hasta_plan"];

  $asistenciaPeriodo = inicioPeriodoAsistencia(
    $pdo,
    $periodo["desde"],
    $hastaCorte,
    $asistenciasExiste,
    $fechaCol,
    $empleadoCol,
    $estadoCol
  );

  $periodosResumen[] = [
    "nombre" => $periodo["nombre"],
    "detalle" => $corteActivo ? "Corte al dia" : $periodo["detalle"],
    "rango" => inicioPeriodoLabel($periodo["desde"], $hastaCorte),
    "asistencias" => $asistenciaPeriodo["asistencias"],
    "retardos" => $asistenciaPeriodo["retardos"],
    "permisos" => inicioPeriodoPermisos($pdo, $periodo["desde"], $hastaCorte),
    "reposos" => inicioPeriodoReposos($pdo, $periodo["desde"], $hastaCorte),
  ];
}

require_once __DIR__ . "/includes/header.php";
?>
<div class="exec-shell">
  <section class="exec-grid">
    <main>
      <div class="exec-card">
        <div class="exec-card-pad">
          <h2 class="exec-section-title">Resumen del dia</h2>
          <p class="exec-section-sub">Lectura compacta del estado actual de asistencia.</p>
        </div>

        <div class="exec-today">
          <div class="exec-today-item">
            <span>Personal</span>
            <strong><?php echo e(inicioNum($totalActivos)); ?></strong>
          </div>
          <div class="exec-today-item">
            <span>Presentes</span>
            <strong><?php echo e(inicioNum($presentesHoy)); ?></strong>
          </div>
          <div class="exec-today-item">
            <span>Retardos</span>
            <strong><?php echo e(inicioNum($retardosHoy)); ?></strong>
          </div>
          <div class="exec-today-item">
            <span>Sin registrar</span>
            <strong><?php echo e(inicioNum($sinRegistrar)); ?></strong>
          </div>
          <div class="exec-today-item">
            <span>Permisos</span>
            <strong><?php echo e(inicioNum($permisosHoy)); ?></strong>
          </div>
          <div class="exec-today-item">
            <span>Reposos</span>
            <strong><?php echo e(inicioNum($repososHoy)); ?></strong>
          </div>
        </div>
      </div>

      <div class="exec-card exec-card-pad" style="margin-top:18px">
        <h2 class="exec-section-title">Resumen ejecutivo por periodo</h2>
        <p class="exec-section-sub">Periodos con corte automatico hasta la fecha actual.</p>

        <div class="period-grid">
          <?php foreach ($periodosResumen as $periodo): ?>
            <article class="period-card">
              <div>
                <div class="period-head">
                  <div>
                    <div class="period-name"><?php echo e($periodo["nombre"]); ?></div>
                    <div class="period-range"><?php echo e($periodo["rango"]); ?></div>
                  </div>
                  <span class="period-badge"><?php echo e($periodo["detalle"]); ?></span>
                </div>
              </div>

              <div class="period-metrics">
                <div class="period-metric">
                  <span>Asistencias</span>
                  <strong><?php echo e(inicioNum((int)$periodo["asistencias"])); ?></strong>
                </div>
                <div class="period-metric">
                  <span>Retardos</span>
                  <strong><?php echo e(inicioNum((int)$periodo["retardos"])); ?></strong>
                </div>
                <div class="period-metric">
                  <span>Permisos</span>
                  <strong><?php echo e(inicioNum((int)$periodo["permisos"])); ?></strong>
                </div>
                <div class="period-metric">
                  <span>Reposos</span>
                  <strong><?php echo e(inicioNum((int)$periodo["reposos"])); ?></strong>
                </div>
              </div>
            </article>
          <?php endforeach; ?>
        </div>
      </div>
    </main>

    <aside>
      <div class="exec-card exec-card-pad side-block">
        <h2 class="exec-section-title">Personal por turno</h2>
        <p class="exec-section-sub">Distribución activa dentro del alcance visible.</p>

        <?php if (!$resumenTurnos): ?>
          <div class="exec-empty">No hay turnos visibles para tu perfil.</div>
        <?php else: ?>
          <?php foreach ($resumenTurnos as $turno): ?>
            <div class="turno-line">
              <span class="turno-name"><?php echo e($turno["turno"] ?? "SIN TURNO"); ?></span>
              <span class="turno-count"><?php echo e(inicioNum((int)($turno["total"] ?? 0))); ?></span>
            </div>
          <?php endforeach; ?>
        <?php endif; ?>
      </div>

      <div class="exec-card exec-card-pad side-block">
        <h2 class="exec-section-title">Actividad reciente</h2>
        <p class="exec-section-sub">Ultimos movimientos registrados hoy.</p>

        <?php if (!$actividadHoy): ?>
          <div class="exec-empty">Todavia no hay registros de asistencia para mostrar hoy.</div>
        <?php else: ?>
          <div class="recent-list">
            <?php foreach ($actividadHoy as $row): ?>
              <?php
                $estado = strtoupper((string)($row["estado"] ?? "REGISTRADO"));
                $chipClass = $estado === "RETARDO" ? "chip-warning" : "chip-success";
              ?>
              <div class="recent-line">
                <div>
                  <div class="recent-name"><?php echo e($row["empleado"] ?? ""); ?></div>
                  <div class="recent-meta">
                    <?php echo e($row["cargo"] ?? ""); ?> |
                    <?php echo e($row["turno"] ?? ""); ?> |
                    Hora: <?php echo e($row["hora_entrada"] ?? ""); ?>
                    <?php if ((int)($row["min_tarde"] ?? 0) > 0): ?>
                      | Retardo: <?php echo (int)$row["min_tarde"]; ?> min
                    <?php endif; ?>
                  </div>
                </div>
                <span class="chip <?php echo e($chipClass); ?>"><?php echo e($estado); ?></span>
              </div>
            <?php endforeach; ?>
          </div>
        <?php endif; ?>
      </div>
    </aside>
  </section>
</div>

<?php require_once __DIR__ . "/includes/footer.php"; ?>


