<?php
// includes/funciones.php
require_once __DIR__ . "/config.php"; // ✅ asegura BASE_URL/BASE_ORIGIN y sesión

function e($value) {
  return htmlspecialchars((string)$value, ENT_QUOTES, "UTF-8");
}

function noCache() {
  header("Cache-Control: no-store, no-cache, must-revalidate");
  header("Cache-Control: post-check=0, pre-check=0", false);
  header("Pragma: no-cache");
}

function isLogged(): bool {
  if (!empty($_SESSION["user"]) && !empty($_SESSION["user"]["id"])) return true;
  if (!empty($_SESSION["usuario_id"])) return true;
  if (!empty($_SESSION["usuario"])) return true;
  return false;
}

function go(string $url) {
  header("Location: " . $url);
  exit;
}

function safeNext($next, $default = ""): string {
  $default = $default ?: (BASE_URL . "/modulos/asistencias.php");
  $next = trim((string)$next);
  if ($next === "") return $default;

  // absoluta http(s)
  if (preg_match('~^https?://~i', $next)) {
    // Solo permitir si es de este mismo origen
    if (strpos($next, BASE_ORIGIN) === 0) return $next;
    return $default;
  }

  // ruta absoluta del sitio (/control_asistencia/...)
  if (isset($next[0]) && $next[0] === "/") {
    // permitir solo si apunta al mismo proyecto
    if (BASE_PATH !== "/" && strpos($next, BASE_PATH . "/") !== 0) return $default;
    return $next; // Location acepta rutas absolutas del sitio
  }

  // relativa
  return BASE_URL . "/" . ltrim($next, "/");
}

function requireLogin() {
  if (isLogged()) return;

  $req  = $_SERVER["REQUEST_URI"] ?? (BASE_PATH . "/");
  $next = BASE_ORIGIN . $req;

  $login = BASE_URL . "/login.php?next=" . urlencode($next);
  header("Location: " . $login);
  exit;
}
