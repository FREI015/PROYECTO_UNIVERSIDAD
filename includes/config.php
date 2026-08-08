<?php
// includes/config.php
// Base del proyecto: sesión + constantes de rutas

// Configuración de timeout de sesión (producción)
ini_set('session.gc_maxlifetime', 3600);
ini_set('session.use_strict_mode', 1);
ini_set('session.use_only_cookies', 1);
session_set_cookie_params([
  'lifetime' => 0,
  'path'     => '/',
  'domain'   => '',
  'secure'   => (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off'),
  'httponly' => true,
  'samesite' => 'Strict',
]);

if (session_status() !== PHP_SESSION_ACTIVE) {
  session_start();
}

// Verificar expiración por inactividad (30 min = 1800 seg)
$tiempoMaximoInactividad = 1800;
if (!empty($_SESSION['_ultimo_acceso'])) {
  $inactividad = time() - $_SESSION['_ultimo_acceso'];
  if ($inactividad > $tiempoMaximoInactividad) {
    $_SESSION = [];
    session_unset();
    session_destroy();
    $redirect = (isset($_SERVER['REQUEST_URI']) ? '?next=' . urlencode($_SERVER['REQUEST_URI']) : '');
    header('Location: ' . ($BASE_PATH ?? '/') . '/login.php' . $redirect);
    exit;
  }
}
$_SESSION['_ultimo_acceso'] = time();

// Establecer la zona horaria de Caracas
date_default_timezone_set("America/Caracas");

// Configuración de rutas del proyecto
$docRoot = realpath($_SERVER["DOCUMENT_ROOT"] ?? "");
$projRoot = realpath(__DIR__ . "/.."); // carpeta del proyecto (control_asistencia)

$basePath = "/control_asistencia"; // fallback
if ($docRoot && $projRoot) {
  $docRootN = str_replace("\\", "/", $docRoot);
  $projRootN = str_replace("\\", "/", $projRoot);

  if (strpos($projRootN, $docRootN) === 0) {
    $rel = substr($projRootN, strlen($docRootN));
    $rel = "/" . ltrim($rel, "/");
    $basePath = rtrim($rel, "/");
    if ($basePath === "") $basePath = "/";
  }
}

$scheme = (!empty($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] !== "off") ? "https" : "http";
$host   = $_SERVER["HTTP_HOST"] ?? "localhost";
$origin = $scheme . "://" . $host;

define("BASE_PATH", $basePath);  // ej: /control_asistencia
define("BASE_URL",  $basePath);  // para href/src
define("BASE_ORIGIN", $origin);  // ej: http://localhost

// Definir la constante para la tolerancia de minutos en los retrasos
if (!defined('RETARDO_TOLERANCIA_MINUTOS')) {
  define('RETARDO_TOLERANCIA_MINUTOS', 5); // 5 minutos de tolerancia para retrasos
}

if (!defined('ASISTENCIA_MARGEN_ANTES_MINUTOS')) {
    define('ASISTENCIA_MARGEN_ANTES_MINUTOS', 5);
}
