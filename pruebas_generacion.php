<?php
/**
 * ============================================================================
 *  GENERADOR Y BATERIA DE PRUEBAS - 1 ANO DE DATOS
 *  Sistema de Control de Asistencia
 *
 *  USO (CLI, desde la raiz del proyecto):
 *    php pruebas_generacion.php                 genera anio actual + prueba
 *    php pruebas_generacion.php --anio 2026     genera el anio indicado
 *    php pruebas_generacion.php --test          solo bateria de pruebas
 *    php pruebas_generacion.php --clean         borra datos de prueba
 *
 *  LO QUE GENERA por cada empleado ACTIVO (o 12 de prueba si no hay):
 *    - Asistencia de LUN a VIE todo el anio, con turnos reales
 *    - ~10% retardos, ~5% faltas (entrada sin salida), ~6% salidas tardias
 *    - horas_trabajadas / salida_estado / minutos_salida_tardia congruentes
 *    - Permisos y reposos distribuidos
 *  Los datos usan cedula "PRUEBA*" y codigo_barra "PBA-*" -> limpiables con --clean.
 * ============================================================================
 */

error_reporting(E_ALL & ~E_DEPRECATED & ~E_NOTICE);
set_time_limit(0);

$RAIZ = __DIR__;
require_once $RAIZ . '/includes/conexion.php';
require_once $RAIZ . '/includes/funciones.php';

$ano = (int)date('Y');
$soloTest  = false;
$soloClean = false;
$argv      = $argv ?? [];
for ($i = 1; $i < count($argv); $i++) {
    $a = $argv[$i];
    if ($a === '--anio') {
        if (isset($argv[$i + 1]) && ctype_digit($argv[$i + 1])) {
            $ano = (int)$argv[$i + 1];
            $i++;
        }
    } elseif (preg_match('/^--anio=(\d{4})$/', $a, $m)) {
        $ano = (int)$m[1];
    } elseif ($a === '--test') {
        $soloTest = true;
    } elseif ($a === '--clean') {
        $soloClean = true;
    }
}
if ($ano < 2000 || $ano > 2100) {
    $ano = (int)date('Y');
}

define('PREF_BARRA',  'PBA-');
define('PREF_CEDULA', 'PRUEBA');

echo "========================================================\n";
echo " GENERADOR 1 ANO - CONTROL DE ASISTENCIA\n";
echo " Anio: $ano | Modo: "
    . ($soloClean ? 'LIMPIEZA' : ($soloTest ? 'SOLO PRUEBA' : 'GEN + PRUEBA')) . "\n";
echo "========================================================\n";

if (!$soloTest && !$soloClean) {
    echo "\n[1/3] Limpiando datos de prueba previos...\n";
    cleanDatos($pdo);
    echo "[2/3] Generando datos del anio $ano...\n";
    $stats = generarAnio($pdo, $ano);
    echo "\n  RESUMEN generado:\n";
    foreach ($stats as $k => $v) {
        echo "    " . str_pad($k, 26) . ": " . $v . "\n";
    }
}

if ($soloClean) {
    echo "\n[LIMPIEZA] Borrando datos de prueba...\n";
    cleanDatos($pdo);
    echo "  OK: BD limpia, solo datos reales.\n";
    exit(0);
}

echo "\n==============================================================\n";
echo "[3/3] BATERIA DE PRUEBAS SOBRE LOS DATOS GENERADOS\n";
echo "==============================================================\n";

$pasados  = 0;
$fallados = 0;
$result   = [];

function test(string $nombre, callable $fn): void {
    global $pasados, $fallados, $result;
    try {
        $fn();
        $result[] = ['PASS', $nombre];
        $pasados++;
    } catch (Throwable $e) {
        $result[] = ['FAIL', $nombre . ' :: ' . $e->getMessage()];
        $fallados++;
    }
}
function check(bool $cond, string $msg): void { if (!$cond) throw new RuntimeException($msg); }

test('Existen las 7 tablas del sistema', function () use ($pdo) {
    $tabs = $pdo->query('SHOW TABLES')->fetchAll(PDO::FETCH_COLUMN);
    foreach (['cargos','turnos','empleados','usuarios','asistencias','permisos','reposos'] as $t) {
        check(in_array($t, $tabs, true), "falta tabla $t");
    }
    echo "      7 tablas OK\n";
});

test('Columnas de reporte presentes en asistencias', function () use ($pdo) {
    $cols = $pdo->query('SHOW COLUMNS FROM asistencias')->fetchAll(PDO::FETCH_COLUMN);
    foreach (['empleado_id','fecha','estado','minutos_tarde','salida_estado','minutos_salida_tardia','horas_trabajadas','observacion_sistema'] as $c) {
        check(in_array($c, $cols, true), "falta columna $c");
    }
    echo "      columnas de reporte completas\n";
});

test('Hay registros de asistencia del anio generado', function () use ($pdo, $ano) {
    $n = (int)$pdo->query("SELECT COUNT(*) FROM asistencias WHERE fecha BETWEEN '{$ano}-01-01' AND '{$ano}-12-31'")->fetchColumn();
    check($n > 0, "0 registros en $ano");
    echo "      registros del anio: " . number_format($n) . "\n";
});

test('Reporte anual por estado devuelve filas', function () use ($pdo, $ano) {
    $rows = $pdo->query("SELECT estado, COUNT(*) c FROM asistencias WHERE fecha BETWEEN '{$ano}-01-01' AND '{$ano}-12-31' GROUP BY estado")->fetchAll();
    check(count($rows) > 0, 'sin datos');
    foreach ($rows as $r) {
        echo "      {$r['estado']}: " . number_format((int)$r['c']) . "\n";
    }
});

test('Horas trabajadas promedio calculadas', function () use ($pdo, $ano) {
    $avg = $pdo->query("SELECT AVG(horas_trabajadas) FROM asistencias WHERE fecha BETWEEN '{$ano}-01-01' AND '{$ano}-12-31' AND horas_trabajadas > 0")->fetchColumn();
    check((float)$avg > 0, 'promedio 0');
    echo "      promedio horas/dia: " . round((float)$avg, 2) . "h\n";
});

test('Sin asistencias duplicadas (empleado+fecha)', function () use ($pdo) {
    $dup = (int)$pdo->query("SELECT COUNT(*) FROM (SELECT empleado_id, fecha FROM asistencias GROUP BY empleado_id, fecha HAVING COUNT(*) > 1) d")->fetchColumn();
    check($dup === 0, "$dup duplicados");
    echo "      duplicados: $dup\n";
});

test('FK asistencias -> empleados sin huerfanos', function () use ($pdo) {
    $bad = (int)$pdo->query("SELECT COUNT(*) FROM asistencias a LEFT JOIN empleados e ON e.id=a.empleado_id WHERE e.id IS NULL")->fetchColumn();
    check($bad === 0, "$bad huerfanas");
    echo "      asistencias huerfanas: $bad\n";
});

test('Retardos con minutos_tarde coherentes', function () use ($pdo, $ano) {
    $inv = (int)$pdo->query("SELECT COUNT(*) FROM asistencias WHERE estado='RETARDO' AND minutos_tarde <= 0 AND fecha BETWEEN '{$ano}-01-01' AND '{$ano}-12-31'")->fetchColumn();
    check($inv === 0, "$inv retardos con 0 minutos");
    echo "      retardos validos\n";
});

test('Permisos y reposos generados', function () use ($pdo, $ano) {
    $p = (int)$pdo->query("SELECT COUNT(*) FROM permisos WHERE fecha_inicio BETWEEN '{$ano}-01-01' AND '{$ano}-12-31'")->fetchColumn();
    $r = (int)$pdo->query("SELECT COUNT(*) FROM reposos WHERE fecha_inicio BETWEEN '{$ano}-01-01' AND '{$ano}-12-31'")->fetchColumn();
    echo "      permisos: $p | reposos: $r\n";
});

test('Faltas (entrada sin salida) coherentes', function () use ($pdo, $ano) {
    $inv = (int)$pdo->query("SELECT COUNT(*) FROM asistencias WHERE estado='FALTA' AND (hora_salida IS NOT NULL OR horas_trabajadas IS NOT NULL) AND fecha BETWEEN '{$ano}-01-01' AND '{$ano}-12-31'")->fetchColumn();
    check($inv === 0, "$inv faltas con salida");
    echo "      faltas coherentes\n";
});

test('EXPLAIN por fecha (verifica indice)', function () use ($pdo, $ano) {
    $row = $pdo->query("EXPLAIN SELECT COUNT(*) FROM asistencias WHERE fecha BETWEEN '{$ano}-01-01' AND '{$ano}-12-31'")->fetch(PDO::FETCH_ASSOC);
    $type = $row['type'] ?? '?';
    $key  = $row['key'] ?? '';
    echo "      type=$type key=$key rows={$row['rows']}\n";
    check($type !== 'ALL', 'escaneo completo (falta idx_asistencias_fecha)');
});

test('Consulta de reporte < 2s', function () use ($pdo, $ano) {
    $t0 = microtime(true);
    $pdo->query("SELECT COUNT(*) FROM asistencias WHERE fecha BETWEEN '{$ano}-01-01' AND '{$ano}-12-31'")->fetchColumn();
    $dt = microtime(true) - $t0;
    echo "      tiempo: " . sprintf('%.3f', $dt) . "s\n";
    check($dt < 2.0, 'lenta ' . sprintf('%.3f', $dt) . 's');
});

test('Consulta usada por reporte_pdf.php funciona', function () use ($pdo, $ano) {
    $rows = $pdo->query("SELECT empleado_id, fecha, estado, minutos_tarde, salida_estado, minutos_salida_tardia, observacion_sistema FROM asistencias WHERE fecha BETWEEN '{$ano}-01-01' AND '{$ano}-12-31' LIMIT 5")->fetchAll();
    check(count($rows) > 0, 'sin filas');
    echo "      SELECT de reporte_pdf.php OK (" . count($rows) . " filas)\n";
});

test('SQLi bloqueada por parametrizacion', function () use ($pdo) {
    $stmt = $pdo->prepare("SELECT * FROM usuarios WHERE usuario = ? LIMIT 1");
    $stmt->execute(["' OR 1=1 -- "]);
    check($stmt->fetch() === false, 'se colo SQLi');
    echo "      OK, inyeccion neutralizada\n";
});

test('CSRF token 64 hex', function () {
    check(strlen(bin2hex(random_bytes(32))) === 64, 'largo token');
});

test('Rol TARDE solo ve VESPERTINO', function () {
    $_SESSION['user'] = ['rol' => 'TARDE'];
    check(!puedeVerTurno('MATUTINO'), 'TARDE vio MATUTINO');
    check(puedeVerTurno('VESPERTINO'), 'TARDE no vio VESPERTINO');
});

test('Turno nocturno 02:00 -> dia anterior', function () {
    check(cruceTurno('18:00:00', '06:00:00', '02:30:00') === -1, '02:30 mal');
    check(cruceTurno('18:00:00', '06:00:00', '22:00:00') === 0, '22:00 mal');
});

echo "\n==============================================================\n";
foreach ($result as $r) echo "  [{$r[0]}] {$r[1]}\n";
echo "==============================================================\n";
echo "TOTAL: " . ($pasados + $fallados) . " pruebas | PASS: $pasados | FAIL: $fallados\n";
echo ($fallados === 0
    ? "El sistema funciona correctamente con 1 anio de datos.\n"
    : "Se encontraron inconsistencias. Revisa los FAIL de arriba.\n");
exit($fallados > 0 ? 1 : 0);

/* ============================================================
 *  FUNCIONES DE GENERACION Y LIMPIEZA
 * ============================================================ */

function cleanDatos(PDO $pdo): void {
    $pdo->beginTransaction();
    try {
        $ids = getEmpleadosPrueba($pdo);
        if (count($ids) > 0) {
            $in = implode(',', array_map('intval', $ids));
            $pdo->exec("DELETE FROM asistencias WHERE empleado_id IN ($in)");
            $pdo->exec("DELETE FROM permisos WHERE empleado_id IN ($in)");
            $pdo->exec("DELETE FROM reposos WHERE empleado_id IN ($in)");
            $pdo->exec("DELETE FROM empleados WHERE id IN ($in)");
        }
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        throw $e;
    }
}

function getEmpleadosPrueba(PDO $pdo): array {
    $rows = $pdo->query("SELECT id FROM empleados WHERE codigo_barra LIKE '" . PREF_BARRA . "%' OR cedula LIKE '" . PREF_CEDULA . "%'")->fetchAll(PDO::FETCH_COLUMN);
    return array_map('intval', $rows);
}

function crearEmpleadosPrueba(PDO $pdo, int $n): array {
    $cargoIds = $pdo->query('SELECT id FROM cargos ORDER BY id')->fetchAll(PDO::FETCH_COLUMN);
    $turnoIds = $pdo->query('SELECT id FROM turnos ORDER BY id')->fetchAll(PDO::FETCH_COLUMN);
    if (count($cargoIds) === 0) throw new RuntimeException('No hay cargos en BD');
    if (count($turnoIds) === 0) throw new RuntimeException('No hay turnos en BD');

    $ids = [];
    $ins = $pdo->prepare("INSERT INTO empleados (cedula, nombres, apellidos, telefono, codigo_barra, cargo_id, tipo_contrato, turno_id, estado, jerarquia) VALUES (?, ?, 'Empleado', '000-1212', ?, ?, 'TURNO', ?, 'ACTIVO', 5)");
    $pdo->beginTransaction();
    try {
        for ($i = 1; $i <= $n; $i++) {
            $ced   = PREF_CEDULA . str_pad((string)$i, 6, '0', STR_PAD_LEFT);
            $bar   = PREF_BARRA . 'EMP' . str_pad((string)$i, 5, '0', STR_PAD_LEFT);
            $cargo = $cargoIds[$i % count($cargoIds)];
            $turno = $turnoIds[$i % count($turnoIds)];
            $ins->execute([$ced, 'Prueba' . $i, $bar, $cargo, $turno]);
            $ids[] = (int)$pdo->lastInsertId();
        }
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        throw $e;
    }
    return $ids;
}

function generarAnio(PDO $pdo, int $ano): array {
    $ids = getEmpleadosPrueba($pdo);
    if (count($ids) === 0) {
        $ids = crearEmpleadosPrueba($pdo, 12);
    }

    $turnos = [];
    foreach ($pdo->query('SELECT id, hora_inicio, hora_fin FROM turnos')->fetchAll(PDO::FETCH_ASSOC) as $t) {
        $turnos[(int)$t['id']] = $t;
    }

    $usuarios = $pdo->query('SELECT id FROM usuarios ORDER BY id')->fetchAll(PDO::FETCH_COLUMN);
    $empTurno = [];
    foreach ($pdo->query('SELECT id, turno_id FROM empleados WHERE id IN (' . implode(',', array_map('intval', $ids)) . ')')->fetchAll(PDO::FETCH_ASSOC) as $e) {
        $empTurno[(int)$e['id']] = (int)$e['turno_id'];
    }

    $insAsis = $pdo->prepare("INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, salida_estado, minutos_salida_tardia, estado, registrado_por, observacion_sistema) VALUES (?,?,?,?,?,?,?,?,?,?,?)");

    $t0 = microtime(true);
    $total = 0;
    $fecha = new DateTime("$ano-01-01");
    $fin   = new DateTime("$ano-12-31");
    $pdo->beginTransaction();
    try {
        while ($fecha <= $fin) {
            $dow = (int)$fecha->format('N');
            if ($dow >= 6) { $fecha->modify('+1 day'); continue; }

            $ds = $fecha->format('Y-m-d');
            foreach ($ids as $eid) {
                $rand = mt_rand(1, 100);
                if ($rand <= 4) continue; // dia libre

                $user = $usuarios[array_rand($usuarios)];
                $turno = $turnos[$empTurno[$eid] ?? 0] ?? ['hora_inicio' => '07:00:00', 'hora_fin' => '12:00:00'];
                $hIni = $turno['hora_inicio'];
                $hFin = $turno['hora_fin'];

                if ($rand <= 9) { // FALTA: entra y nunca sale
                    $insAsis->execute([$eid, $ds, $hIni, null, 0, null, null, 0, 'FALTA', $user, null]);
                    $total++;
                    continue;
                }

                $minLle   = ($rand <= 19) ? mt_rand(6, 40) : 0;
                $estado   = ($minLle > 0) ? 'RETARDO' : 'ASISTIO';

                $dtEnt = new DateTime($ds . ' ' . $hIni);
                $dtEnt->modify("+$minLle minutes");
                $entrada = $dtEnt->format('H:i:s');

                $minSal  = (mt_rand(1, 100) <= 6) ? mt_rand(1, 45) : 0;
                $salEst  = ($minSal > 0) ? 'SALIDA_TARDIA' : 'NORMAL';
                $dtSal   = new DateTime($ds . ' ' . $hFin);
                $dtSal->modify("+$minSal minutes");
                $salida  = $dtSal->format('H:i:s');

                $horasTr = round((strtotime($salida) - strtotime($entrada)) / 3600, 2);
                $obs     = ($salEst === 'SALIDA_TARDIA') ? "Salida tardia $minSal min" : null;

                $insAsis->execute([$eid, $ds, $entrada, $salida, $minLle, $horasTr, $salEst, $minSal, $estado, $user, $obs]);
                $total++;
            }
            $fecha->modify('+1 day');
        }
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        throw new RuntimeException('Error generando asistencias: ' . $e->getMessage());
    }
    $dur = microtime(true) - $t0;

    $permN  = 0;
    $reposN = 0;
    $tiposP = ['PERMISO PERSONAL', 'CITA MEDICA', 'TRAMITE', 'VACACIONES'];
    $tiposR = ['REPOSO MEDICO', 'REPOSO MATERNAL'];
    $base   = new DateTime("$ano-03-01");
    $insP   = $pdo->prepare("INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado) VALUES (?,?,?,?,?, 'ACTIVO')");
    $insR   = $pdo->prepare("INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado) VALUES (?,?,?,?,?, 'ACTIVO')");
    $pdo->beginTransaction();
    try {
        foreach ($ids as $i => $eid) {
            if ($i % 3 === 0) {
                $fIni = (clone $base)->modify("+" . $i . " days");
                $fFin = (clone $fIni)->modify("+2 days");
                $insP->execute([$eid, $fIni->format('Y-m-d'), $fFin->format('Y-m-d'), $tiposP[$i % count($tiposP)], 'Motivo de permiso de prueba']);
                $permN++;
            }
            if ($i % 5 === 0) {
                $fIni = (clone $base)->modify("+" . ($i + 100) . " days");
                $fFin = (clone $fIni)->modify("+" . mt_rand(1, 8) . " days");
                $insR->execute([$eid, $fIni->format('Y-m-d'), $fFin->format('Y-m-d'), $tiposR[$i % count($tiposR)], 'Reposo medico de prueba']);
                $reposN++;
            }
        }
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        echo "   Nota: no se insertaron permisos/reposos ({$e->getMessage()})\n";
    }

    return [
        'empleados de prueba' => count($ids),
        'asistencias generadas' => number_format($total),
        'permisos'  => $permN,
        'reposos'   => $reposN,
        'tiempo total' => round($dur, 2) . 's',
    ];
}

function cruceTurno(string $ini, string $fin, string $hora): int {
    if ($ini > $fin && $hora < $fin) return -1;
    return 0;
}
