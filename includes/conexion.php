<?php
require_once __DIR__ . "/config.php";

$DB_HOST = "localhost";
$DB_NAME = "control_asistencia";
$DB_USER = "root";
$DB_PASS = "";

try {
    $dsn = "mysql:host={$DB_HOST};dbname={$DB_NAME};charset=utf8mb4";

    $pdo = new PDO($dsn, $DB_USER, $DB_PASS, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    $pdo->exec("SET time_zone = '-04:00'");
} catch (Throwable $e) {
    http_response_code(500);
    exit("No se pudo conectar con la base de datos.");
}
