<?php
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
verifyCsrfOrRedirect($volver . '&cat_err=' . urlencode('Solicitud invalida.'));

function catalogoLongitud(string $texto): int {
    $longitud = preg_match_all('/./us', $texto);
    if ($longitud === false) throw new InvalidArgumentException('Texto no valido.');
    return $longitud;
}

function catalogoTerminar(string $tipo, string $texto): void {
    header('Location: ' . BASE_URL . '/modulos/personal.php?catalogos=1&cat_' . $tipo . '=' . urlencode($texto) . '#configurar-cargos-turnos');
    exit;
}

$accion = trim((string)($_POST['accion'] ?? ''));
$id = filter_var($_POST['id'] ?? 0, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
$id = $id === false ? 0 : (int)$id;
$nombre = strtoupper(trim((string)($_POST['nombre'] ?? '')));

if (!in_array($accion, ['guardar_cargo','guardar_turno','eliminar_cargo','eliminar_turno'], true)) {
    catalogoTerminar('err', 'Operacion no permitida.');
}

try {
    $pdo->beginTransaction();
    if ($accion === 'guardar_cargo') {
        $descripcion = trim((string)($_POST['descripcion'] ?? ''));
        if ($nombre === '' || catalogoLongitud($nombre, 'UTF-8') > 80 || catalogoLongitud($descripcion, 'UTF-8') > 200) {
            throw new InvalidArgumentException('Nombre o descripcion de cargo invalidos.');
        }
        if ($id > 0) {
            $st = $pdo->prepare('SELECT nombre, descripcion FROM cargos WHERE id = ? FOR UPDATE');
            $st->execute([$id]);
            $actual = $st->fetch(PDO::FETCH_ASSOC);
            if (!$actual) throw new InvalidArgumentException('El cargo no existe.');
            $st = $pdo->prepare('SELECT COUNT(*) FROM empleados WHERE cargo_id = ?');
            $st->execute([$id]);
            $tieneEmpleados = (int)$st->fetchColumn() > 0;
            $cambia = $nombre !== strtoupper((string)$actual['nombre']) ||
                $descripcion !== trim((string)($actual['descripcion'] ?? ''));
            if ($tieneEmpleados && $cambia) {
                throw new InvalidArgumentException('Cargo asignado a empleados: crea otro cargo antes de modificarlo.');
            }
            $st = $pdo->prepare('UPDATE cargos SET nombre = ?, descripcion = ? WHERE id = ?');
            $st->execute([$nombre, $descripcion !== '' ? $descripcion : null, $id]);
        } else {
            $st = $pdo->prepare('INSERT INTO cargos (nombre, descripcion) VALUES (?, ?)');
            $st->execute([$nombre, $descripcion !== '' ? $descripcion : null]);
        }
    } elseif ($accion === 'eliminar_cargo') {
        if ($id <= 0) throw new InvalidArgumentException('Selecciona un cargo.');
        $st = $pdo->prepare('SELECT id FROM cargos WHERE id = ? FOR UPDATE');
        $st->execute([$id]);
        if (!$st->fetchColumn()) throw new InvalidArgumentException('El cargo no existe.');
        $st = $pdo->prepare('SELECT COUNT(*) FROM empleados WHERE cargo_id = ?');
        $st->execute([$id]);
        if ((int)$st->fetchColumn() > 0) throw new InvalidArgumentException('El cargo tiene empleados asignados.');
        $st = $pdo->prepare('DELETE FROM cargos WHERE id = ?');
        $st->execute([$id]);
    } elseif ($accion === 'guardar_turno') {
        $inicio = trim((string)($_POST['hora_inicio'] ?? ''));
        $fin = trim((string)($_POST['hora_fin'] ?? ''));
        $horaValida = '/^(?:[01][0-9]|2[0-3]):[0-5][0-9]$/';
        if ($nombre === '' || catalogoLongitud($nombre, 'UTF-8') > 50 ||
            !preg_match($horaValida, $inicio) || !preg_match($horaValida, $fin) || $inicio === $fin) {
            throw new InvalidArgumentException('Nombre u horarios de turno invalidos.');
        }
        if ($id > 0) {
            $st = $pdo->prepare('SELECT nombre, hora_inicio, hora_fin FROM turnos WHERE id = ? FOR UPDATE');
            $st->execute([$id]);
            $actual = $st->fetch(PDO::FETCH_ASSOC);
            if (!$actual) throw new InvalidArgumentException('El turno no existe.');
            $nombreAnterior = strtoupper((string)$actual['nombre']);
            if (in_array($nombreAnterior, ['MATUTINO', 'VESPERTINO', 'COMPLETO'], true) && $nombre !== $nombreAnterior) {
                throw new InvalidArgumentException('No puedes renombrar un turno institucional.');
            }
            $st = $pdo->prepare('SELECT COUNT(*) FROM empleados WHERE turno_id = ?');
            $st->execute([$id]);
            $tieneEmpleados = (int)$st->fetchColumn() > 0;
            $seModifica = $nombre !== $nombreAnterior || $inicio !== substr((string)$actual['hora_inicio'], 0, 5) ||
                $fin !== substr((string)$actual['hora_fin'], 0, 5);
            if ($tieneEmpleados && $seModifica) {
                throw new InvalidArgumentException('Turno asignado a empleados: crea otro turno antes de modificar horarios.');
            }
            $st = $pdo->prepare('UPDATE turnos SET nombre = ?, hora_inicio = ?, hora_fin = ? WHERE id = ?');
            $st->execute([$nombre, $inicio . ':00', $fin . ':00', $id]);
        } else {
            $st = $pdo->prepare('INSERT INTO turnos (nombre, hora_inicio, hora_fin) VALUES (?, ?, ?)');
            $st->execute([$nombre, $inicio . ':00', $fin . ':00']);
        }
    } elseif ($accion === 'eliminar_turno') {
        if ($id <= 0) throw new InvalidArgumentException('Selecciona un turno.');
        $st = $pdo->prepare('SELECT nombre FROM turnos WHERE id = ? FOR UPDATE');
        $st->execute([$id]);
        $nombreActual = strtoupper((string)$st->fetchColumn());
        if ($nombreActual === '') throw new InvalidArgumentException('Turno no encontrado.');
        if (in_array($nombreActual, ['MATUTINO','VESPERTINO','COMPLETO'], true)) {
            throw new InvalidArgumentException('No se puede eliminar un turno institucional.');
        }
        $st = $pdo->prepare('SELECT COUNT(*) FROM empleados WHERE turno_id = ?');
        $st->execute([$id]);
        if ((int)$st->fetchColumn() > 0) throw new InvalidArgumentException('El turno tiene empleados asignados.');
        $st = $pdo->prepare('DELETE FROM turnos WHERE id = ?');
        $st->execute([$id]);
    }
    $objeto = str_contains($accion, 'cargo') ? 'cargos' : 'turnos';
    $idAudit = $id > 0 ? $id : (int)$pdo->lastInsertId();
    registrarAuditoria($pdo, strtoupper($accion), $objeto, $idAudit, ['nombre' => $nombre]);
    $pdo->commit();
    catalogoTerminar('msg', 'Operacion realizada correctamente.');
} catch (InvalidArgumentException $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    catalogoTerminar('err', $e->getMessage());
} catch (Throwable $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    error_log('Error catalogos: ' . $e->getMessage());
    catalogoTerminar('err', 'No se pudo completar la operacion. Revisa duplicados o dependencias.');
}
