<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/conexion.php";

noCache();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  go(BASE_URL . "/login.php");
}


verifyCsrfOrRedirect(BASE_URL . "/login.php?err=" . urlencode("Solicitud inválida. Intenta nuevamente."));
$usuario = trim($_POST["usuario"] ?? "");
$clave   = (string)($_POST["clave"] ?? "");
$next    = safeNext($_POST["next"] ?? "", BASE_URL . "/modulos/asistencias.php");

if ($usuario === "" || $clave === "") {
  go(BASE_URL . "/login.php?err=" . urlencode("Completa usuario y clave") . "&next=" . urlencode($next));
}

$stmt = $pdo->prepare("SELECT id, usuario, clave, rol, estado FROM usuarios WHERE usuario=? LIMIT 1");
$stmt->execute([$usuario]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
  go(BASE_URL . "/login.php?err=" . urlencode("ACCESO DENEGADO") . "&next=" . urlencode($next));
}

$estado = strtoupper(trim((string)($user["estado"] ?? "")));
if ($estado !== "ACTIVO") {
  go(BASE_URL . "/login.php?err=" . urlencode("Usuario inactivo") . "&next=" . urlencode($next));
}

$stored = (string)($user["clave"] ?? "");

if (!password_verify($clave, $stored)) {
  go(BASE_URL . "/login.php?err=" . urlencode("ACCESO DENEGADO") . "&next=" . urlencode($next));
}

session_regenerate_id(true);

$_SESSION["user"] = [
  "id"      => (int)$user["id"],
  "usuario" => (string)$user["usuario"],
  "rol"     => ((string)($user["rol"] ?? "")) !== "" ? (string)$user["rol"] : "—",
];

$_SESSION["usuario_id"] = (int)$user["id"];
$_SESSION["usuario"]    = (string)$user["usuario"];
$_SESSION["rol"]        = (string)($user["rol"] ?? "");

go($next);
