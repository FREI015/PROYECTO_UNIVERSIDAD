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
$clave = (string)($_POST["clave"] ?? "");
$claveConfirmar = (string)($_POST["clave_confirmar"] ?? "");

if ($id <= 0) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Usuario inválido."));
}

if ($clave === "" || $claveConfirmar === "") {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Completa la clave y su confirmacion."));
}

if (strlen($clave) < 6) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("La clave debe tener al menos 6 caracteres."));
}

if ($clave !== $claveConfirmar) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("La confirmacion de clave no coincide."));
}

$stmt = $pdo->prepare("SELECT id, usuario, rol, estado FROM usuarios WHERE id = ? LIMIT 1");
$stmt->execute([$id]);
$usuarioObjetivo = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$usuarioObjetivo) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Usuario no encontrado."));
}

if (!puedeGestionarUsuarioActual($usuarioObjetivo)) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("No tienes permiso para cambiar la clave de ese usuario."));
}

$hash = crearHashClaveUsuario($clave);

$stmt = $pdo->prepare("UPDATE usuarios SET clave = ? WHERE id = ?");
$stmt->execute([$hash, $id]);

go(BASE_URL . "/modulos/usuarios.php?msg=" . urlencode("Clave actualizada correctamente."));



