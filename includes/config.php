<?php
// includes/config.php
// Base del proyecto: sesión + constantes de rutas

if (session_status() !== PHP_SESSION_ACTIVE) {
  session_start();
}

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
