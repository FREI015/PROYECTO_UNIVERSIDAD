<?php

$docRoot = realpath($_SERVER["DOCUMENT_ROOT"] ?? "");
$projRoot = realpath(__DIR__ . "/..");
$basePath = "/" . basename($projRoot ?: dirname(__DIR__));

if ($docRoot && $projRoot) {
  $docRootN = rtrim(str_replace("\\", "/", $docRoot), "/");
  $projRootN = rtrim(str_replace("\\", "/", $projRoot), "/");

  if ($projRootN === $docRootN) {
    $basePath = "/";
  } elseif (strpos($projRootN, $docRootN . "/") === 0) {
    $rel = substr($projRootN, strlen($docRootN));
    $basePath = "/" . trim($rel, "/");
  }
}

if ($basePath !== "/") {
  $basePath = "/" . trim($basePath, "/");
}

$baseUrl = $basePath === "/" ? "" : $basePath;
$scheme = (!empty($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] !== "off") ? "https" : "http";
$host = $_SERVER["HTTP_HOST"] ?? "localhost";
$origin = $scheme . "://" . $host;

define("BASE_PATH", $basePath);
define("BASE_URL", $baseUrl);
define("BASE_ORIGIN", $origin);

date_default_timezone_set("America/Caracas");

ini_set("session.gc_maxlifetime", 3600);
ini_set("session.use_strict_mode", 1);
ini_set("session.use_only_cookies", 1);

session_set_cookie_params([
  "lifetime" => 0,
  "path" => "/",
  "domain" => "",
  "secure" => (!empty($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] !== "off"),
  "httponly" => true,
  "samesite" => "Strict",
]);

if (session_status() !== PHP_SESSION_ACTIVE) {
  session_start();
}

$tiempoMaximoInactividad = 1800;

if (!empty($_SESSION["_ultimo_acceso"])) {
  $inactividad = time() - (int)$_SESSION["_ultimo_acceso"];

  if ($inactividad > $tiempoMaximoInactividad) {
    $_SESSION = [];
    session_unset();
    session_destroy();

    $redirect = isset($_SERVER["REQUEST_URI"]) && $_SERVER["REQUEST_URI"] !== ""
      ? "?next=" . urlencode($_SERVER["REQUEST_URI"])
      : "";

    header("Location: " . BASE_URL . "/login.php" . $redirect);
    exit;
  }
}

$_SESSION["_ultimo_acceso"] = time();

if (!defined("RETARDO_TOLERANCIA_MINUTOS")) {
  define("RETARDO_TOLERANCIA_MINUTOS", 5);
}

if (!defined("ASISTENCIA_MARGEN_ANTES_MINUTOS")) {
  define("ASISTENCIA_MARGEN_ANTES_MINUTOS", 5);
}

// Tolerancia simetrica de salida: 5 minutos antes y 5 despues.
if (!defined("SALIDA_TARDIA_TOLERANCIA_MINUTOS")) {
  define("SALIDA_TARDIA_TOLERANCIA_MINUTOS", 5);
}

/**
 * Ventanas horarias del primer turno.
 *
 * La ventana determina si se permite marcar. El calculo de
 * retardos de la entrada se conserva con RETARDO_TOLERANCIA_MINUTOS.
 */
if (!defined("PRIMER_TURNO_ID")) {
  define("PRIMER_TURNO_ID", 1);
}

if (!defined("PRIMER_TURNO_NOMBRE")) {
  define("PRIMER_TURNO_NOMBRE", "MATUTINO");
}

if (!defined("PRIMER_TURNO_ENTRADA_DESDE")) {
  define("PRIMER_TURNO_ENTRADA_DESDE", "06:55:00");
}

if (!defined("PRIMER_TURNO_ENTRADA_PUNTUAL_HASTA")) {
  define("PRIMER_TURNO_ENTRADA_PUNTUAL_HASTA", "07:05:00");
}

if (!defined("PRIMER_TURNO_ENTRADA_HASTA")) {
  define("PRIMER_TURNO_ENTRADA_HASTA", "09:00:00");
}

if (!defined("PRIMER_TURNO_SALIDA_DESDE")) {
  define("PRIMER_TURNO_SALIDA_DESDE", "11:55:00");
}

if (!defined("PRIMER_TURNO_SALIDA_HASTA")) {
  define("PRIMER_TURNO_SALIDA_HASTA", "13:00:00");
}

/**
 * Ventanas horarias del segundo turno.
 *
 * El turno vespertino inicia a la 1:00 PM segun la institucion.
 * Las ventanas de marcaje parten de la hora configurada en MySQL.
 */
if (!defined("SEGUNDO_TURNO_ID")) {
  define("SEGUNDO_TURNO_ID", 2);
}

if (!defined("SEGUNDO_TURNO_NOMBRE")) {
  define("SEGUNDO_TURNO_NOMBRE", "VESPERTINO");
}

if (!defined("SEGUNDO_TURNO_ENTRADA_DESDE")) {
  define("SEGUNDO_TURNO_ENTRADA_DESDE", "12:55:00");
}

if (!defined("SEGUNDO_TURNO_ENTRADA_PUNTUAL_HASTA")) {
  define("SEGUNDO_TURNO_ENTRADA_PUNTUAL_HASTA", "13:05:00");
}

if (!defined("SEGUNDO_TURNO_ENTRADA_HASTA")) {
  define("SEGUNDO_TURNO_ENTRADA_HASTA", "15:00:00");
}

if (!defined("SEGUNDO_TURNO_SALIDA_DESDE")) {
  define("SEGUNDO_TURNO_SALIDA_DESDE", "16:55:00");
}

if (!defined("SEGUNDO_TURNO_SALIDA_HASTA")) {
  define("SEGUNDO_TURNO_SALIDA_HASTA", "18:00:00");
}

/**
 * Ventanas horarias del turno completo.
 *
 * Reutiliza la entrada del primer turno y la salida del segundo turno.
 * No se duplican horarios: cualquier ajuste en esas ventanas se refleja
 * automaticamente en el turno completo.
 */
if (!defined("TURNO_COMPLETO_ID")) {
  define("TURNO_COMPLETO_ID", 3);
}

if (!defined("TURNO_COMPLETO_NOMBRE")) {
  define("TURNO_COMPLETO_NOMBRE", "COMPLETO");
}