<?php
// Datos de conexión 
$DB_HOST = "localhost";
$DB_NAME = "control_asistencia";
$DB_USER = "root";
$DB_PASS = "";

// ===== mysqli ($conexion) =====
$conexion = mysqli_connect($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
if (!$conexion) {
    die("Conexión mysqli fallida: " . mysqli_connect_error());
}
mysqli_set_charset($conexion, "utf8mb4");

// ✅ TZ MySQL (sesión) - Venezuela UTC-4
@mysqli_query($conexion, "SET time_zone = '-04:00'");

// ===== PDO ($pdo) =====
try {
    $dsn = "mysql:host={$DB_HOST};dbname={$DB_NAME};charset=utf8mb4";
    $pdo = new PDO($dsn, $DB_USER, $DB_PASS, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    // ✅ TZ MySQL (sesión) - Venezuela UTC-4
    $pdo->exec("SET time_zone = '-04:00'");

} catch (Throwable $e) {
    die("Conexión PDO fallida: " . $e->getMessage());
}
