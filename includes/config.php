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

$scriptActual = str_replace(
  "\\",
  "/",
  (string)($_SERVER["SCRIPT_NAME"] ?? "")
);

$esFotoKiosco =
  substr($scriptActual, -strlen("/procesos/foto_empleado.php")) === "/procesos/foto_empleado.php" &&
  isset($_GET["k"]) &&
  (string)$_GET["k"] !== "";

$esRutaKiosco =
  substr($scriptActual, -strlen("/login_empleado.php")) === "/login_empleado.php" ||
  substr($scriptActual, -strlen("/procesos/asistencia_barcode.php")) === "/procesos/asistencia_barcode.php" ||
  substr($scriptActual, -strlen("/procesos/kiosk_token.php")) === "/procesos/kiosk_token.php" ||
  $esFotoKiosco;

if ($esRutaKiosco) {
  session_name("KIOSKSESSID");
}

ini_set(
  "session.gc_maxlifetime",
  $esRutaKiosco ? 28800 : 3600
);
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

if (!defined("SESSION_IDLE_TIMEOUT_SECONDS")) {
  define("SESSION_IDLE_TIMEOUT_SECONDS", 300);
}

$tiempoMaximoInactividad = SESSION_IDLE_TIMEOUT_SECONDS;

if (!$esRutaKiosco && !empty($_SESSION["_ultimo_acceso"])) {
  $inactividad = time() - (int)$_SESSION["_ultimo_acceso"];

  if ($inactividad > $tiempoMaximoInactividad) {
    $_SESSION = [];
    session_unset();
    session_destroy();

    $requestUri = (string)($_SERVER["REQUEST_URI"] ?? "");
    $requestPath = (string)(parse_url($requestUri, PHP_URL_PATH) ?? "");
    $redirect = "";

    if ($requestPath !== "" && substr($requestPath, -strlen("/login.php")) !== "/login.php") {
      $redirect = "&next=" . urlencode($requestUri);
    }

    header("Location: " . BASE_URL . "/login.php?expired=1" . $redirect);
    exit;
  }
}

/*
 * Solo las acciones reales del usuario renuevan la sesion.
 * Las peticiones automaticas en segundo plano no deben reiniciar
 * el contador de inactividad.
 */
$esActividadExplicita =
  (string)($_SERVER["HTTP_X_APP_ACTIVITY"] ?? "") === "1";

$esPeticionSegundoPlano =
  !$esActividadExplicita &&
  (
    !empty($_SERVER["HTTP_X_REQUESTED_WITH"]) ||
    stripos((string)($_SERVER["HTTP_ACCEPT"] ?? ""), "application/json") !== false
  );

/*
 * El latido del frontend extiende la sesion unicamente dentro de
 * procesos/sesion_actividad.php, despues de validar el CSRF.
 */
if (!$esRutaKiosco && !$esPeticionSegundoPlano && !$esActividadExplicita) {
  $_SESSION["_ultimo_acceso"] = time();
}

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

/**
 * Kiosco Barcode to PC.
 */
if (!defined("BARCODE_RATE_LIMIT_POR_MINUTO")) {
  define("BARCODE_RATE_LIMIT_POR_MINUTO", 120);
}

if (!defined("BARCODE_DUPLICADO_SEGUNDOS")) {
  define("BARCODE_DUPLICADO_SEGUNDOS", 5);
}