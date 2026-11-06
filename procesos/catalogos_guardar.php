<?php
// H07_CATALOGOS_INTEGRIDAD_V2

require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/funciones.php';

requireLogin();

if (!esRolGlobal()) {
    http_response_code(403);
    exit('Acceso restringido a administracion.');
}

require_once __DIR__ . '/../includes/conexion.php';
require_once __DIR__ . '/../includes/auditoria.php';

$volver = BASE_URL . '/modulos/personal.php?catalogos=1';

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    header('Location: ' . $volver);
    exit;
}

verifyCsrfOrRedirect(
    $volver . '&cat_err=' . urlencode('Solicitud invalida.')
);

function catalogoTerminar(string $tipo, string $texto): void {
    header(
        'Location: ' . BASE_URL .
        '/modulos/personal.php?catalogos=1&cat_' .
        $tipo . '=' . urlencode($texto) .
        '#configurar-cargos-turnos'
    );
    exit;
}

function catalogoIdPost(): int {
    $raw = $_POST['id'] ?? '';

    if ($raw === '' || $raw === null) {
        return 0;
    }

    $id = filter_var(
        $raw,
        FILTER_VALIDATE_INT,
        ['options' => ['min_range' => 1]]
    );

    if ($id === false) {
        throw new InvalidArgumentException('Identificador invalido.');
    }

    return (int)$id;
}

function catalogoLongitud(string $texto): int {
    $n = preg_match_all('/./us', $texto);

    if ($n === false) {
        throw new InvalidArgumentException('Texto no valido.');
    }

    return $n;
}

function catalogoContar(PDO $pdo, string $sql, int $id): int {
    $st = $pdo->prepare($sql);
    $st->execute([$id]);

    return (int)$st->fetchColumn();
}

function catalogoInstitucional(int $id, string $nombre): bool {
    $oficiales = [
        1 => 'MATUTINO',
        2 => 'VESPERTINO',
        3 => 'COMPLETO'
    ];

    return isset($oficiales[$id]) ||
        in_array(
            strtoupper(trim($nombre)),
            array_values($oficiales),
            true
        );
}

function catalogoCargoInstitucional(string $nombre): bool {
    return in_array(
        strtoupper(trim($nombre)),
        ['DOCENTE', 'ADMINISTRATIVO', 'OBRERO', 'DIRECTIVO'],
        true
    );
}

function catalogoSoportaTurnosAdicionales(): bool {
    return function_exists('tipoTurnoVentanas') &&
        tipoTurnoVentanas('OTRO', 2147483647) === 'OTRO';
}

$accion = trim((string)($_POST['accion'] ?? ''));

if (!in_array(
    $accion,
    [
        'guardar_cargo',
        'guardar_turno',
        'eliminar_cargo',
        'eliminar_turno'
    ],
    true
)) {
    catalogoTerminar('err', 'Operacion no permitida.');
}

try {

    $pdo->setAttribute(
        PDO::ATTR_ERRMODE,
        PDO::ERRMODE_EXCEPTION
    );

    $id = catalogoIdPost();

    $nombre = strtoupper(
        trim((string)($_POST['nombre'] ?? ''))
    );

    $pdo->beginTransaction();

    // ----------------------------------------------------
    // GUARDAR CARGO
    // ----------------------------------------------------

    if ($accion === 'guardar_cargo') {

        $descripcion = trim(
            (string)($_POST['descripcion'] ?? '')
        );

        if (
            $nombre === '' ||
            catalogoLongitud($nombre) > 80 ||
            catalogoLongitud($descripcion) > 200
        ) {
            throw new InvalidArgumentException(
                'Nombre o descripcion de cargo invalidos.'
            );
        }

        $st = $pdo->prepare(
            'SELECT id FROM cargos WHERE nombre = ? AND id <> ? LIMIT 1'
        );

        $st->execute([$nombre, $id]);

        if ($st->fetchColumn()) {
            throw new InvalidArgumentException(
                'Ya existe un cargo con ese nombre.'
            );
        }

        $nuevo = [
            'nombre' => $nombre,
            'descripcion' => $descripcion !== '' ? $descripcion : null
        ];

        if ($id > 0) {

            $st = $pdo->prepare(
                'SELECT id, nombre, descripcion
                 FROM cargos WHERE id = ? FOR UPDATE'
            );

            $st->execute([$id]);
            $actual = $st->fetch(PDO::FETCH_ASSOC);

            if (!$actual) {
                throw new InvalidArgumentException('El cargo no existe.');
            }

            $antes = [
                'nombre' => (string)$actual['nombre'],
                'descripcion' => $actual['descripcion']
            ];

            $esInstitucional = catalogoCargoInstitucional($antes['nombre']);

            $nuevoEsInstitucional = catalogoCargoInstitucional($nuevo['nombre']);

            if ($esInstitucional && $nuevo !== $antes) {
                throw new InvalidArgumentException(
                    'Los cuatro cargos institucionales estan protegidos.'
                );
            }

            if (!$esInstitucional && $nuevoEsInstitucional) {
                throw new InvalidArgumentException(
                    'Ese nombre esta reservado para un cargo institucional.'
                );
            }

            $empleados = catalogoContar(
                $pdo,
                'SELECT COUNT(*) FROM empleados WHERE cargo_id = ?',
                $id
            );

            if ($empleados > 0 && $nuevo !== $antes) {
                throw new InvalidArgumentException(
                    "El cargo tiene $empleados empleados asignados. "
                    . "No se permite modificarlo."
                );
            }

            if ($nuevo !== $antes) {

                $st = $pdo->prepare(
                    'UPDATE cargos
                     SET nombre = ?, descripcion = ?
                     WHERE id = ?'
                );

                $st->execute([
                    $nuevo['nombre'],
                    $nuevo['descripcion'],
                    $id
                ]);

                registrarAuditoria(
                    $pdo,
                    'ACTUALIZAR_CARGO',
                    'cargos',
                    $id,
                    ['anterior' => $antes, 'nuevo' => $nuevo]
                );
            }

        } else {

            if (catalogoCargoInstitucional($nuevo['nombre'])) {
                throw new InvalidArgumentException(
                    'Ese nombre esta reservado para un cargo institucional.'
                );
            }

            $st = $pdo->prepare(
                'INSERT INTO cargos (nombre, descripcion) VALUES (?, ?)'
            );

            $st->execute([
                $nuevo['nombre'],
                $nuevo['descripcion']
            ]);

            registrarAuditoria(
                $pdo,
                'CREAR_CARGO',
                'cargos',
                (int)$pdo->lastInsertId(),
                ['anterior' => null, 'nuevo' => $nuevo]
            );
        }

    // ----------------------------------------------------
    // ELIMINAR CARGO
    // ----------------------------------------------------

    } elseif ($accion === 'eliminar_cargo') {

        if ($id <= 0) {
            throw new InvalidArgumentException('Cargo invalido.');
        }

        $st = $pdo->prepare(
            'SELECT id, nombre, descripcion
             FROM cargos WHERE id = ? FOR UPDATE'
        );

        $st->execute([$id]);
        $actual = $st->fetch(PDO::FETCH_ASSOC);

        if (!$actual) {
            throw new InvalidArgumentException('El cargo no existe.');
        }

        if (catalogoCargoInstitucional((string)$actual['nombre'])) {
            throw new InvalidArgumentException(
                'No se puede eliminar un cargo institucional.'
            );
        }

        $empleados = catalogoContar(
            $pdo,
            'SELECT COUNT(*) FROM empleados WHERE cargo_id = ?',
            $id
        );

        if ($empleados > 0) {
            throw new InvalidArgumentException(
                'No se puede eliminar un cargo con empleados asignados.'
            );
        }

        $st = $pdo->prepare('DELETE FROM cargos WHERE id = ?');
        $st->execute([$id]);

        registrarAuditoria(
            $pdo,
            'ELIMINAR_CARGO',
            'cargos',
            $id,
            ['anterior' => $actual, 'nuevo' => null]
        );

    // ----------------------------------------------------
    // GUARDAR TURNO
    // ----------------------------------------------------

    } elseif ($accion === 'guardar_turno') {

        $inicio = trim((string)($_POST['hora_inicio'] ?? ''));
        $fin = trim((string)($_POST['hora_fin'] ?? ''));

        $horaValida = '/^(?:[01][0-9]|2[0-3]):[0-5][0-9]$/';

        if (
            $nombre === '' ||
            catalogoLongitud($nombre) > 50 ||
            !preg_match($horaValida, $inicio) ||
            !preg_match($horaValida, $fin) ||
            strcmp($inicio, $fin) >= 0
        ) {
            throw new InvalidArgumentException(
                'Nombre u horarios invalidos. Inicio debe ser anterior al fin.'
            );
        }

        $st = $pdo->prepare(
            'SELECT id FROM turnos WHERE nombre = ? AND id <> ? LIMIT 1'
        );

        $st->execute([$nombre, $id]);

        if ($st->fetchColumn()) {
            throw new InvalidArgumentException(
                'Ya existe un turno con ese nombre.'
            );
        }

        $nuevo = [
            'nombre' => $nombre,
            'hora_inicio' => $inicio . ':00',
            'hora_fin' => $fin . ':00'
        ];

        $oficiales = [
            1 => [
                'nombre' => 'MATUTINO',
                'hora_inicio' => '07:00:00',
                'hora_fin' => '12:00:00'
            ],
            2 => [
                'nombre' => 'VESPERTINO',
                'hora_inicio' => '13:00:00',
                'hora_fin' => '17:00:00'
            ],
            3 => [
                'nombre' => 'COMPLETO',
                'hora_inicio' => '07:00:00',
                'hora_fin' => '17:00:00'
            ]
        ];

        if ($id > 0) {

            $st = $pdo->prepare(
                'SELECT id, nombre, hora_inicio, hora_fin
                 FROM turnos WHERE id = ? FOR UPDATE'
            );

            $st->execute([$id]);
            $actual = $st->fetch(PDO::FETCH_ASSOC);

            if (!$actual) {
                throw new InvalidArgumentException('El turno no existe.');
            }

            $antes = [
                'nombre' => strtoupper((string)$actual['nombre']),
                'hora_inicio' => (string)$actual['hora_inicio'],
                'hora_fin' => (string)$actual['hora_fin']
            ];

            if (isset($oficiales[$id])) {

                if ($nuevo !== $oficiales[$id]) {
                    throw new InvalidArgumentException(
                        'Los turnos institucionales estan protegidos.'
                    );
                }

            } else {

                if (
                    in_array(
                        $nombre,
                        array_column($oficiales, 'nombre'),
                        true
                    )
                ) {
                    throw new InvalidArgumentException(
                        'Nombre reservado para un turno institucional.'
                    );
                }

                $cambia = $nuevo !== $antes;

                if ($cambia && !catalogoSoportaTurnosAdicionales()) {
                    throw new InvalidArgumentException(
                        'El motor de asistencia no admite turnos adicionales.'
                    );
                }

                $empleados = catalogoContar(
                    $pdo,
                    'SELECT COUNT(*) FROM empleados WHERE turno_id = ?',
                    $id
                );

                $historicas = catalogoContar(
                    $pdo,
                    'SELECT COUNT(*) FROM asistencias
                     WHERE turno_id_marcaje = ?',
                    $id
                );

                $sinTurno = h07_count(
                    $pdo,
                    'SELECT COUNT(*) FROM asistencias
                     WHERE turno_id_marcaje IS NULL'
                );

                if (
                    $cambia &&
                    ($empleados > 0 || $historicas > 0 || $sinTurno > 0)
                ) {
                    throw new InvalidArgumentException(
                        'Turno protegido: tiene dependencias o historial.'
                    );
                }

                if ($cambia) {

                    $st = $pdo->prepare(
                        'UPDATE turnos
                         SET nombre = ?, hora_inicio = ?, hora_fin = ?
                         WHERE id = ?'
                    );

                    $st->execute([
                        $nuevo['nombre'],
                        $nuevo['hora_inicio'],
                        $nuevo['hora_fin'],
                        $id
                    ]);

                    registrarAuditoria(
                        $pdo,
                        'ACTUALIZAR_TURNO',
                        'turnos',
                        $id,
                        [
                            'anterior' => $antes,
                            'nuevo' => $nuevo,
                            'empleados' => $empleados,
                            'asistencias' => $historicas
                        ]
                    );
                }
            }

        } else {

            if (
                in_array(
                    $nombre,
                    array_column($oficiales, 'nombre'),
                    true
                )
            ) {
                throw new InvalidArgumentException(
                    'Nombre reservado para un turno institucional.'
                );
            }

            if (!catalogoSoportaTurnosAdicionales()) {
                throw new InvalidArgumentException(
                    'El motor de asistencia no admite turnos adicionales.'
                );
            }

            $st = $pdo->prepare(
                'INSERT INTO turnos (nombre, hora_inicio, hora_fin)
                 VALUES (?, ?, ?)'
            );

            $st->execute([
                $nuevo['nombre'],
                $nuevo['hora_inicio'],
                $nuevo['hora_fin']
            ]);

            registrarAuditoria(
                $pdo,
                'CREAR_TURNO',
                'turnos',
                (int)$pdo->lastInsertId(),
                ['anterior' => null, 'nuevo' => $nuevo]
            );
        }

    // ----------------------------------------------------
    // ELIMINAR TURNO
    // ----------------------------------------------------

    } else {

        if ($id <= 0) {
            throw new InvalidArgumentException('Turno invalido.');
        }

        $st = $pdo->prepare(
            'SELECT id, nombre, hora_inicio, hora_fin
             FROM turnos WHERE id = ? FOR UPDATE'
        );

        $st->execute([$id]);
        $actual = $st->fetch(PDO::FETCH_ASSOC);

        if (!$actual) {
            throw new InvalidArgumentException('El turno no existe.');
        }

        if (catalogoInstitucional($id, $actual['nombre'])) {
            throw new InvalidArgumentException(
                'No se puede eliminar un turno institucional.'
            );
        }

        $empleados = catalogoContar(
            $pdo,
            'SELECT COUNT(*) FROM empleados WHERE turno_id = ?',
            $id
        );

        $historicas = catalogoContar(
            $pdo,
            'SELECT COUNT(*) FROM asistencias
             WHERE turno_id_marcaje = ?',
            $id
        );

        $sinTurno = h07_count(
            $pdo,
            'SELECT COUNT(*) FROM asistencias
             WHERE turno_id_marcaje IS NULL'
        );

        if ($empleados > 0 || $historicas > 0 || $sinTurno > 0) {
            throw new InvalidArgumentException(
                'No se puede eliminar: existen dependencias historicas.'
            );
        }

        $st = $pdo->prepare('DELETE FROM turnos WHERE id = ?');
        $st->execute([$id]);

        registrarAuditoria(
            $pdo,
            'ELIMINAR_TURNO',
            'turnos',
            $id,
            ['anterior' => $actual, 'nuevo' => null]
        );
    }

    $pdo->commit();

    catalogoTerminar('msg', 'Operacion realizada correctamente.');

} catch (InvalidArgumentException $e) {

    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }

    catalogoTerminar('err', $e->getMessage());

} catch (PDOException $e) {

    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }

    error_log('Error SQL catalogos: ' . $e->getMessage());

    catalogoTerminar(
        'err',
        'Nombre duplicado, dependencia protegida o error de base de datos.'
    );

} catch (Throwable $e) {

    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }

    error_log('Error catalogos: ' . $e->getMessage());

    catalogoTerminar(
        'err',
        'No se pudo completar la operacion.'
    );
}