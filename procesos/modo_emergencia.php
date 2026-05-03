<?php
// procesos/modo_emergencia.php
// Activa o desactiva el modo emergencia tras validar credenciales de admin
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/conexion.php";

noCache();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Acceso inválido"));
}

// Verificar acción: activar o desactivar
$accion = trim($_POST["accion"] ?? "");

// Si es desactivar, solo requiere que esté en modo emergencia
if ($accion === "desactivar") {
  if (!empty($_SESSION['modo_emergencia'])) {
    unset($_SESSION['modo_emergencia']);
    go(BASE_URL . "/modulos/asistencias.php?msg=" . urlencode("Modo emergencia desactivado"));
  }
  go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("El modo emergencia no estaba activo"));
}

// Si es activar, validar credenciales de admin
if ($accion === "activar") {
  $usuario = trim($_POST["usuario"] ?? "");
  $clave   = (string)($_POST["clave"] ?? "");

  if ($usuario === "" || $clave === "") {
    go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Completa usuario y clave"));
  }

  // Validar contra tabla usuarios con rol de admin (DIRECTORA o SUPER)
  $stmt = $pdo->prepare(
    "SELECT id, usuario, clave, rol, estado FROM usuarios 
     WHERE (rol = 'DIRECTORA' OR rol = 'SUPER') AND usuario = ? LIMIT 1"
  );
  $stmt->execute([$usuario]);
  $user = $stmt->fetch(PDO::FETCH_ASSOC);

  if (!$user) {
    go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Credenciales de administrador inválidas"));
  }

  $estado = strtoupper(trim((string)($user["estado"] ?? "")));
  if ($estado !== "ACTIVO") {
    go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("El administrador está inactivo"));
  }

  // Comparar clave (sin hash, igual que login_procesar.php)
  $stored = (string)($user["clave"] ?? "");
  if ($stored !== $clave) {
    go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Credenciales de administrador inválidas"));
  }

  // Activar modo emergencia
  $_SESSION['modo_emergencia'] = true;
  go(BASE_URL . "/modulos/asistencias.php?msg=" . urlencode("Modo emergencia activado"));
}

go(BASE_URL . "/modulos/asistencias.php?err=" . urlencode("Acción no reconocida"));
