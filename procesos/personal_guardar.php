<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
requireLogin();
require_once __DIR__ . "/../includes/conexion.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Acceso inválido"));
  exit;
}

$nombres   = trim($_POST["nombres"] ?? "");
$apellidos = trim($_POST["apellidos"] ?? "");
$cedula    = trim($_POST["cedula"] ?? "");
$cargo_id  = (int)($_POST["cargo_id"] ?? 0);
$turno_id  = (int)($_POST["turno_id"] ?? 0);

if ($nombres === "" || $apellidos === "" || $cedula === "" || $cargo_id <= 0 || $turno_id <= 0) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Completa todos los campos (incluye turno)."));
  exit;
}

// Validar cargo existe
$stmt = $pdo->prepare("SELECT id FROM cargos WHERE id=? LIMIT 1");
$stmt->execute([$cargo_id]);
if (!$stmt->fetch()) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Cargo inválido"));
  exit;
}

// Validar turno existe
$stmt = $pdo->prepare("SELECT id FROM turnos WHERE id=? LIMIT 1");
$stmt->execute([$turno_id]);
if (!$stmt->fetch()) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Turno inválido"));
  exit;
}

// Evitar duplicado por cédula
$stmt = $pdo->prepare("SELECT id FROM empleados WHERE cedula=? LIMIT 1");
$stmt->execute([$cedula]);
if ($stmt->fetch()) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("Ya existe un empleado con esa cédula"));
  exit;
}

// Insertar empleado
$ins = $pdo->prepare("
  INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado)
  VALUES (?, ?, ?, NULL, ?, 'TURNO', ?, 'ACTIVO')
");
$ins->execute([$cedula, $nombres, $apellidos, $cargo_id, $turno_id]);

header("Location: " . BASE_URL . "/modulos/personal.php?msg=" . urlencode("Personal registrado con turno correctamente"));
exit;
