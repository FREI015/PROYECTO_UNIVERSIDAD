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