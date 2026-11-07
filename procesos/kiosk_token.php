<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";

header("Content-Type: application/json; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("X-Content-Type-Options: nosniff");

$ipKiosco = (string)($_SERVER["REMOTE_ADDR"] ?? "");

if (!in_array($ipKiosco, ["127.0.0.1", "::1"], true)) {
  http_response_code(403);
  echo json_encode([
    "ok" => false,
    "message" => "El kiosco solo puede utilizarse desde esta computadora."
  ], JSON_UNESCAPED_UNICODE);
  exit;
}

echo json_encode([
  "ok" => true,
  "csrf_token" => csrfToken()
], JSON_UNESCAPED_UNICODE);
