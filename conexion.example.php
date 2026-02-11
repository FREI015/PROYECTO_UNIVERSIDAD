<?php
// conexion.example.php
// Copia este archivo como: includes/conexion.php y coloca tus credenciales locales.

\ = "localhost";
\ = "control_asistencia";
\ = "root";
\ = "";

// Ejemplo con PDO (ajusta a tu código real)
try {
    \ = new PDO("mysql:host=\;dbname=\;charset=utf8mb4", \, \, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);
} catch (Exception \) {
    die("Error de conexión: " . \->getMessage());
}
