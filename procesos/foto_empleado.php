<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/funciones.php';
require_once __DIR__ . '/../includes/conexion.php';

$nombre = (string)($_GET['archivo'] ?? '');
if (!preg_match('/\A[a-zA-Z0-9_.-]+\.(?:jpe?g|png|webp)\z/i', $nombre) || strpos($nombre, '..') !== false) {
  http_response_code(404); exit;
}
$st = $pdo->prepare('SELECT e.id, t.nombre AS turno FROM empleados e LEFT JOIN turnos t ON t.id=e.turno_id WHERE e.foto_archivo = ? LIMIT 1');
$st->execute(['uploads/empleados/' . $nombre]);
$emp = $st->fetch(PDO::FETCH_ASSOC);
if (!$emp) { http_response_code(404); exit; }

// El kiosco solo puede consultar la foto autorizada tras un marcaje exitoso.
$kiosco = $_SESSION['kiosk_foto_autorizada'] ?? null;
$accesoKiosco = is_array($kiosco)
    && in_array((string)($_SERVER['REMOTE_ADDR'] ?? ''), ['127.0.0.1', '::1'], true)
    && (int)($kiosco['expira'] ?? 0) >= time()
    && hash_equals((string)($kiosco['archivo'] ?? ''), $nombre)
    && hash_equals((string)($kiosco['token'] ?? ''), (string)($_GET['k'] ?? ''))
    && (string)($kiosco['token'] ?? '') !== '';

if (!$accesoKiosco) {
  if (!isLogged()) {
    http_response_code(403);
    exit;
  }
  // Revalida usuario activo, version de sesion y cambio de clave obligatorio.
  requireLogin();
  if (!(puede('ver_personal') || puede('ver_asistencias'))
      || !puedeVerTurno((string)($emp['turno'] ?? ''))) {
    http_response_code(403);
    exit;
  }
}

$dir = realpath(__DIR__ . '/../uploads/empleados');
$path = realpath(__DIR__ . '/../uploads/empleados/' . $nombre);
if (!$dir || !$path || dirname($path) !== $dir || !is_file($path)) {
  http_response_code(404); exit;
}
$tipos = ['jpg'=>'image/jpeg','jpeg'=>'image/jpeg','png'=>'image/png','webp'=>'image/webp'];
$ext = strtolower(pathinfo($path, PATHINFO_EXTENSION));
if (!isset($tipos[$ext])) { http_response_code(404); exit; }
header('Content-Type: ' . $tipos[$ext]);
header('Cache-Control: private, no-store');
header('X-Content-Type-Options: nosniff');
header('Content-Disposition: inline; filename="foto.' . $ext . '"');
readfile($path);
exit;
