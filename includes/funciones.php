<?php
// includes/funciones.php
require_once __DIR__ . "/config.php";

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

  if ($next === "") {
    return $default;
  }

  if (preg_match('/[\r\n]/', $next)) {
    return $default;
  }

  if (preg_match('~^https?://~i', $next)) {
    $target = parse_url($next);
    $origin = parse_url(BASE_ORIGIN);

    if (!is_array($target) || !is_array($origin)) {
      return $default;
    }

    $targetScheme = strtolower((string)($target["scheme"] ?? ""));
    $originScheme = strtolower((string)($origin["scheme"] ?? ""));
    $targetHost = strtolower((string)($target["host"] ?? ""));
    $originHost = strtolower((string)($origin["host"] ?? ""));

    $targetPort = isset($target["port"])
      ? (int)$target["port"]
      : ($targetScheme === "https" ? 443 : 80);

    $originPort = isset($origin["port"])
      ? (int)$origin["port"]
      : ($originScheme === "https" ? 443 : 80);

    if (
      $targetScheme !== $originScheme ||
      $targetHost !== $originHost ||
      $targetPort !== $originPort
    ) {
      return $default;
    }

    $path = (string)($target["path"] ?? "/");

    if (
      BASE_PATH !== "/" &&
      $path !== BASE_PATH &&
      strpos($path, BASE_PATH . "/") !== 0
    ) {
      return $default;
    }

    return $next;
  }

  if (isset($next[0]) && $next[0] === "/") {
    if (strncmp($next, "//", 2) === 0) {
      return $default;
    }

    $path = parse_url($next, PHP_URL_PATH);

    if (!is_string($path)) {
      return $default;
    }

    if (
      BASE_PATH !== "/" &&
      $path !== BASE_PATH &&
      strpos($path, BASE_PATH . "/") !== 0
    ) {
      return $default;
    }

    return $next;
  }

  $normal = str_replace("\\", "/", $next);

  if (preg_match('~(^|/)\.\.?(/|$)~', $normal)) {
    return $default;
  }

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

function formatCedula($cedula) {
  $cedula = (string)$cedula;
  if (!is_numeric($cedula) || $cedula === "") return $cedula;
  $num = (int)$cedula;
  return number_format($num, 0, ",", ".");
}


function csrfToken(): string {
  if (empty($_SESSION["csrf_token"]) || !is_string($_SESSION["csrf_token"])) {
    $_SESSION["csrf_token"] = bin2hex(random_bytes(32));
  }

  return $_SESSION["csrf_token"];
}

function csrfInput(): string {
  return '<input type="hidden" name="csrf_token" value="' . e(csrfToken()) . '">';
}

function verifyCsrfOrRedirect(string $redirectUrl): void {
  $token = $_POST["csrf_token"] ?? "";
  $sessionToken = $_SESSION["csrf_token"] ?? "";

  if (!is_string($token) || !is_string($sessionToken) || $token === "" || $sessionToken === "" || !hash_equals($sessionToken, $token)) {
    go($redirectUrl);
  }
}


function claveGuardadaEsHash(string $claveGuardada): bool {
  $info = password_get_info($claveGuardada);
  return !empty($info["algo"]);
}

function verificarClaveUsuario(string $claveIngresada, string $claveGuardada): bool {
  if ($claveGuardada === "" || !claveGuardadaEsHash($claveGuardada)) {
    return false;
  }

  return password_verify($claveIngresada, $claveGuardada);
}

function claveNecesitaRehash(string $claveGuardada): bool {
  if (!claveGuardadaEsHash($claveGuardada)) {
    return false;
  }

  return password_needs_rehash($claveGuardada, PASSWORD_DEFAULT);
}

function crearHashClaveUsuario(string $clave): string {
  $hash = password_hash($clave, PASSWORD_DEFAULT);

  if (!is_string($hash) || $hash === "") {
    throw new RuntimeException("No se pudo proteger la clave.");
  }

  return $hash;
}


function usuarioActual(): array {
  return $_SESSION["user"] ?? [];
}

function rolActual(): string {
  $user = usuarioActual();
  return strtoupper(trim((string)($user["rol"] ?? "")));
}

function esRolGlobal(?string $rol = null): bool {
  $rol = strtoupper(trim((string)($rol ?? rolActual())));
  return in_array($rol, ["DIRECTORA", "SUBDIRECTOR"], true);
}

function permisosPorRol(): array {
  return [
    "DIRECTORA" => ["*"],
    "SUBDIRECTOR" => ["ver_asistencias", "marcar_asistencia", "ver_personal", "ver_permisos", "ver_reposos", "ver_reportes", "administrar_usuarios"],

    // Roles operativos por turno.
    // Roles operativos limitados por filtros de turno
    // en Personal, Permisos, Reposos, Reportes y PDF.
    "DIURNO" => ["ver_asistencias", "marcar_asistencia", "ver_personal", "ver_permisos", "ver_reposos", "ver_reportes"],
    "TARDE" => ["ver_asistencias", "marcar_asistencia", "ver_personal", "ver_permisos", "ver_reposos", "ver_reportes"],
    "VESPERTINO" => ["ver_asistencias", "marcar_asistencia", "ver_personal", "ver_permisos", "ver_reposos", "ver_reportes"],
    "NOCTURNO" => ["ver_asistencias", "marcar_asistencia", "ver_personal", "ver_permisos", "ver_reposos", "ver_reportes"],
  ];
}

function puede(string $permiso): bool {
  $rol = rolActual();
  $mapa = permisosPorRol();

  if (!isset($mapa[$rol])) {
    return false;
  }

  return in_array("*", $mapa[$rol], true) || in_array($permiso, $mapa[$rol], true);
}

function requirePermiso(string $permiso, string $redirect = ""): void {
  if (puede($permiso)) {
    return;
  }

  $redirect = $redirect !== "" ? $redirect : (BASE_URL . "/modulos/asistencias.php");
  $sep = strpos($redirect, "?") === false ? "?" : "&";
  $url = $redirect . $sep . "err=" . urlencode("No tienes permiso para realizar esta acción.");

  if (function_exists("go")) {
    go($url);
  }

  header("Location: " . $url);
  exit;
}

function turnosPermitidosPorRol(?string $rol = null): array {
  $rol = strtoupper(trim((string)($rol ?? rolActual())));

  if (esRolGlobal($rol)) {
    return [];
  }

  $mapa = [
    "DIURNO" => ["MATUTINO"],
    "TARDE" => ["VESPERTINO"],
    "VESPERTINO" => ["VESPERTINO"],
    "NOCTURNO" => ["NOCTURNO"],
  ];

  return $mapa[$rol] ?? [];
}

function tieneAlcanceGlobalTurnos(?string $rol = null): bool {
  return esRolGlobal($rol);
}

function puedeVerTurno(?string $turnoNombre, ?string $rol = null): bool {
  $turnoNombre = strtoupper(trim((string)$turnoNombre));

  if ($turnoNombre === "") {
    return false;
  }

  if (tieneAlcanceGlobalTurnos($rol)) {
    return true;
  }

  return in_array($turnoNombre, turnosPermitidosPorRol($rol), true);
}

function filtroTurnosPermitidosSql(string $aliasTurno = "t", array &$params = []): string {
  $turnos = turnosPermitidosPorRol();

  if ($turnos === []) {
    return "";
  }

  $placeholders = [];

  foreach ($turnos as $turno) {
    $placeholders[] = "?";
    $params[] = $turno;
  }

  return " AND UPPER(" . $aliasTurno . ".nombre) IN (" . implode(",", $placeholders) . ") ";
}

function rolesUsuarioDisponibles(): array {
  return [
    "DIURNO" => "Diurno / Matutino",
    "TARDE" => "Tarde / Vespertino",
    "DIRECTORA" => "Directora",
    "SUBDIRECTOR" => "Subdirector",
  ];
}

function estadosUsuarioDisponibles(): array {
  return [
    "ACTIVO" => "Activo",
    "INACTIVO" => "Inactivo",
  ];
}

function puedeAdministrarUsuarios(): bool {
  return puede("administrar_usuarios");
}

function puedeGestionarRolUsuario(?string $rolObjetivo): bool {
  $rolActual = rolActual();
  $rolObjetivo = strtoupper(trim((string)$rolObjetivo));

  if ($rolObjetivo === "") {
    return false;
  }

  if ($rolActual === "DIRECTORA") {
    return in_array($rolObjetivo, ["SUBDIRECTOR", "DIURNO", "TARDE"], true);
  }

  if ($rolActual === "SUBDIRECTOR") {
    return in_array($rolObjetivo, ["DIURNO", "TARDE"], true);
  }

  return false;
}

function puedeGestionarUsuarioActual(?array $usuarioObjetivo): bool {
  if (!$usuarioObjetivo) {
    return false;
  }

  $rolObjetivo = strtoupper(trim((string)($usuarioObjetivo["rol"] ?? "")));
  return puedeGestionarRolUsuario($rolObjetivo);
}

function normalizarRolUsuario(string $rol): string {
  return strtoupper(trim($rol));
}

function normalizarEstadoUsuario(string $estado): string {
  return strtoupper(trim($estado));
}

function rolUsuarioValido(string $rol): bool {
  return array_key_exists(normalizarRolUsuario($rol), rolesUsuarioDisponibles());
}

function estadoUsuarioValido(string $estado): bool {
  return array_key_exists(normalizarEstadoUsuario($estado), estadosUsuarioDisponibles());
}

function usuarioPuedeAccederModuloUsuarios(): bool {
  return puedeAdministrarUsuarios();
}

function empleadoPorCodigoBarra(PDO $pdo, string $codigo): ?array {
  $codigo = trim($codigo);
  if ($codigo === "") return null;
  $stmt = $pdo->prepare("SELECT id, nombres, apellidos, cedula, codigo_barra FROM empleados WHERE codigo_barra = ? LIMIT 1");
  $stmt->execute([$codigo]);
  $emp = $stmt->fetch(PDO::FETCH_ASSOC);
  return $emp ?: null;
}

function generarCodigoBarra(int $empleadoId): string {
  return 'EMP' . str_pad((string)$empleadoId, 5, '0', STR_PAD_LEFT);
}

