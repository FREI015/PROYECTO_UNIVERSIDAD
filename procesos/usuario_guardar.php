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

$usuario = trim((string)($_POST["usuario"] ?? ""));
$clave = (string)($_POST["clave"] ?? "");
$claveConfirmar = (string)($_POST["clave_confirmar"] ?? "");
$rol = normalizarRolUsuario((string)($_POST["rol"] ?? ""));
$estado = normalizarEstadoUsuario((string)($_POST["estado"] ?? "ACTIVO"));

if ($usuario === "" || $clave === "" || $claveConfirmar === "" || $rol === "" || $estado === "") {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Completa todos los campos requeridos."));
}

if (!preg_match('/^[A-Za-z0-9_.-]{3,50}$/', $usuario)) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("El usuario debe tener 3 a 50 caracteres y solo letras, numeros, punto, guion o guion bajo."));
}

if (strlen($clave) < 6) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("La clave debe tener al menos 6 caracteres."));
}

if ($clave !== $claveConfirmar) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("La confirmacion de clave no coincide."));
}

if (!rolUsuarioValido($rol)) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Rol inválido."));
}

if (!estadoUsuarioValido($estado)) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Estado inválido."));
}

if (!puedeGestionarRolUsuario($rol)) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("No tienes permiso para crear usuarios con ese rol."));
}

$stmt = $pdo->prepare("SELECT id FROM usuarios WHERE usuario = ? LIMIT 1");
$stmt->execute([$usuario]);

if ($stmt->fetch(PDO::FETCH_ASSOC)) {
  go(BASE_URL . "/modulos/usuarios.php?err=" . urlencode("Ya existe un usuario con ese nombre."));
}

$hash = crearHashClaveUsuario($clave);

$stmt = $pdo->prepare("
  INSERT INTO usuarios (usuario, clave, rol, estado)
  VALUES (?, ?, ?, ?)
");

$stmt->execute([$usuario, $hash, $rol, $estado]);

go(BASE_URL . "/modulos/usuarios.php?msg=" . urlencode("Usuario creado correctamente."));



