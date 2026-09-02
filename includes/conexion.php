<?php
// conexion.example.php
// Copia este archivo como includes/conexion.php y ajusta tus credenciales locales.

$DB_HOST = "localhost";
$DB_NAME = "control_asistencia";
$DB_USER = "root";
$DB_PASS = "";

// ===== mysqli ($conexion) =====
$conexion = mysqli_connect($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
if (!$conexion) {
    http_response_code(500); exit("No se pudo conectar con la base de datos.");
}
mysqli_set_charset($conexion, "utf8mb4");

// Zona horaria MySQL: Venezuela UTC-4
@mysqli_query($conexion, "SET time_zone = '-04:00'");

// ===== PDO ($pdo) =====
try {
    $dsn = "mysql:host={$DB_HOST};dbname={$DB_NAME};charset=utf8mb4";
    $pdo = new PDO($dsn, $DB_USER, $DB_PASS, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    // Zona horaria MySQL: Venezuela UTC-4
    $pdo->exec("SET time_zone = '-04:00'");
} catch (Throwable $e) {
    http_response_code(500); exit("No se pudo conectar con la base de datos.");
}
