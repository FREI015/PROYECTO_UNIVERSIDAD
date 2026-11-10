<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";

noCache();

header("Content-Type: application/json; charset=utf-8");
header("Cache-Control: no-store");
header("X-Content-Type-Options: nosniff");

function sesionActividadResponder(int $codigo, array $datos): void {
  http_response_code($codigo);
  echo json_encode($datos, JSON_UNESCAPED_UNICODE);
  exit;
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  sesionActividadResponder(405, ["ok" => false]);
}

if (!isLogged()) {
  sesionActividadResponder(401, ["ok" => false]);
}

$token = $_POST["csrf_token"] ?? ($_SERVER["HTTP_X_CSRF_TOKEN"] ?? "");
$sessionToken = $_SESSION["csrf_token"] ?? "";

if (
  !is_string($token) ||
  !is_string($sessionToken) ||
  $token === "" ||
  $sessionToken === "" ||
  !hash_equals($sessionToken, $token)
) {
  sesionActividadResponder(403, ["ok" => false]);
}

$_SESSION["_ultimo_acceso"] = time();

sesionActividadResponder(200, ["ok" => true]);
