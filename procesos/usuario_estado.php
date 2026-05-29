<?php
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";

requireLogin();
if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Acceso inválido"));
}

if (!usuarioPuedeAccederModuloUsuarios()) {
  go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("No tienes permiso para administrar usuarios."));
}

verifyCsrfOrRedirect(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Solicitud inválida. Intenta nuevamente."));

$id = (int)($_POST["id"] ?? 0);
$nuevoEstado = normalizarEstadoUsuario((string)($_POST["estado"] ?? ""));

if ($id <= 0) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Usuario inválido."));
}

if (!estadoUsuarioValido($nuevoEstado)) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Estado inválido."));
}

$stmt = $pdo->prepare("SELECT id, usuario, rol, estado FROM usuarios WHERE id = ? LIMIT 1");
$stmt->execute([$id]);
$usuarioObjetivo = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$usuarioObjetivo) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Usuario no encontrado."));
}

$userActual = usuarioActual();
$idActual = (int)($userActual["id"] ?? ($_SESSION["usuario_id"] ?? 0));

if ($idActual > 0 && (int)$usuarioObjetivo["id"] === $idActual) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("No puedes cambiar el estado de tu propia cuenta."));
}

if (!puedeGestionarUsuarioActual($usuarioObjetivo)) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("No tienes permiso para modificar ese usuario."));
}

$estadoActual = normalizarEstadoUsuario((string)$usuarioObjetivo["estado"]);

if ($estadoActual === $nuevoEstado) {
  go(BASE_URL . "/modulos/usuarios.php?msg=" . urlencode("El usuario ya tiene ese estado."));
}

$stmt = $pdo->prepare("UPDATE usuarios SET estado = ? WHERE id = ?");
$stmt->execute([$nuevoEstado, $id]);

$mensaje = $nuevoEstado === "ACTIVO" ? "Usuario activado correctamente." : "Usuario inactivado correctamente.";

go(BASE_URL . "/modulos/usuarios.php?msg=" . urlencode($mensaje));



