<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/funciones.php';
requireLogin();
requirePermiso('ver_reposos', BASE_URL . '/index.php');
require_once __DIR__ . '/../includes/conexion.php';

$id = filter_var($_GET['id'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
if ($id === false || $id === null) {
    http_response_code(404);
    exit('Documento no encontrado.');
}
$stmt = $pdo->prepare('SELECT r.justificativo_archivo, t.nombre AS turno FROM reposos r
    JOIN empleados e ON e.id = r.empleado_id
    LEFT JOIN turnos t ON t.id = e.turno_id WHERE r.id = ? LIMIT 1');
$stmt->execute([(int)$id]);
$registro = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$registro || !puedeVerTurno((string)($registro['turno'] ?? ''))) {
    http_response_code(404);
    exit('Documento no encontrado.');
}
$relativa = (string)($registro['justificativo_archivo'] ?? '');
if (!preg_match('#^uploads/justificativos/[a-f0-9]{32}\.(pdf|jpg|png)$#D', $relativa)) {
    http_response_code(404);
    exit('Documento no encontrado.');
}
$directorio = realpath(__DIR__ . '/../uploads/justificativos');
$archivo = realpath(__DIR__ . '/../' . $relativa);
if ($directorio === false || $archivo === false || !is_file($archivo) ||
    dirname($archivo) !== $directorio) {
    http_response_code(404);
    exit('Documento no encontrado.');
}
$extension = strtolower(pathinfo($archivo, PATHINFO_EXTENSION));
$tipos = ['pdf' => 'application/pdf', 'jpg' => 'image/jpeg', 'png' => 'image/png'];
if (!isset($tipos[$extension])) {
    http_response_code(404);
    exit('Documento no encontrado.');
}
header('Content-Type: ' . $tipos[$extension]);
header('Content-Length: ' . (string)filesize($archivo));
header('Content-Disposition: attachment; filename="justificativo_' . (int)$id . '.' . $extension . '"');
header('X-Content-Type-Options: nosniff');
header('Cache-Control: no-store, private');
header('Content-Security-Policy: sandbox');
readfile($archivo);
exit;
