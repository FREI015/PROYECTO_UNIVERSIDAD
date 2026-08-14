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

function cerrarSesionUsuarioSistema(string $mensaje = ""): void {
  $_SESSION = [];

  if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();

    setcookie(
      session_name(),
      "",
      time() - 42000,
      $params["path"],
      $params["domain"],
      $params["secure"],
      $params["httponly"]
    );
  }

  if (session_status() === PHP_SESSION_ACTIVE) {
    session_destroy();
  }

  $url = BASE_URL . "/login.php";

  if ($mensaje !== "") {
    $url .= "?err=" . urlencode($mensaje);
  }

  header("Location: " . $url);
  exit;
}

function esRutaCambioClaveObligatoria(): bool {
  $script = str_replace(
    "\\",
    "/",
    (string)($_SERVER["SCRIPT_NAME"] ?? "")
  );

  return str_ends_with(
    $script,
    "/cambiar_clave_obligatoria.php"
  );
}

function requireLogin() {
  if (!isLogged()) {
    $req =
      $_SERVER["REQUEST_URI"]
      ?? (BASE_PATH . "/");

    $next =
      BASE_ORIGIN . $req;

    $login =
      BASE_URL .
      "/login.php?next=" .
      urlencode($next);

    header(
      "Location: " . $login
    );

    exit;
  }

  global
    $pdo,
    $conexion,
    $DB_HOST,
    $DB_NAME,
    $DB_USER,
    $DB_PASS;

  if (
    !isset($pdo) ||
    !($pdo instanceof PDO)
  ) {
    require_once
      __DIR__ .
      "/conexion.php";
  }

  if (
    !isset($pdo) ||
    !($pdo instanceof PDO)
  ) {
    cerrarSesionUsuarioSistema(
      "No se pudo validar la sesion."
    );
  }

  $usuarioId = (int)(
    $_SESSION["user"]["id"]
    ?? $_SESSION["usuario_id"]
    ?? 0
  );

  if ($usuarioId <= 0) {

    cerrarSesionUsuarioSistema(
      "Sesion invalida. Inicia sesion nuevamente."
    );
  }

  $stmt = $pdo->prepare("
    SELECT
      id,
      usuario,
      rol,
      estado,
      debe_cambiar_clave,
      version_sesion
    FROM usuarios
    WHERE id = ?
    LIMIT 1
  ");

  $stmt->execute([
    $usuarioId
  ]);

  $usuarioDb =
    $stmt->fetch(
      PDO::FETCH_ASSOC
    );

  if (!$usuarioDb) {

    cerrarSesionUsuarioSistema(
      "La cuenta ya no esta disponible."
    );
  }

  $estado =
    strtoupper(
      trim(
        (string)(
          $usuarioDb["estado"]
          ?? ""
        )
      )
    );

  if ($estado !== "ACTIVO") {

    cerrarSesionUsuarioSistema(
      "Usuario inactivo."
    );
  }

  $versionDb =
    max(
      1,
      (int)(
        $usuarioDb["version_sesion"]
        ?? 1
      )
    );

  $versionSesion =
    (int)(
      $_SESSION["version_sesion"]
      ?? 0
    );

  if (
    $versionSesion <= 0 ||
    $versionSesion !== $versionDb
  ) {

    cerrarSesionUsuarioSistema(
      "Tu sesion ya no es valida. Inicia sesion nuevamente."
    );
  }

  $_SESSION["user"] = [
    "id" =>
      (int)$usuarioDb["id"],

    "usuario" =>
      (string)$usuarioDb["usuario"],

    "rol" =>
      (string)$usuarioDb["rol"],
  ];

  $_SESSION["usuario_id"] =
    (int)$usuarioDb["id"];

  $_SESSION["usuario"] =
    (string)$usuarioDb["usuario"];

  $_SESSION["rol"] =
    (string)$usuarioDb["rol"];

  $_SESSION["debe_cambiar_clave"] =
    (int)(
      $usuarioDb["debe_cambiar_clave"]
      ?? 0
    );

  if (
    $_SESSION["debe_cambiar_clave"] === 1 &&
    !esRutaCambioClaveObligatoria()
  ) {

    go(
      BASE_URL .
      "/cambiar_clave_obligatoria.php"
    );
  }
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


function generarClaveTemporalUsuario(int $longitud = 16): string {
  $longitud =
    max(
      12,
      $longitud
    );

  $mayusculas =
    "ABCDEFGHJKLMNPQRSTUVWXYZ";

  $minusculas =
    "abcdefghijkmnopqrstuvwxyz";

  $numeros =
    "23456789";

  $simbolos =
    "!@#$%*-_";

  $todos =
    $mayusculas .
    $minusculas .
    $numeros .
    $simbolos;

  $caracteres = [
    $mayusculas[
      random_int(
        0,
        strlen($mayusculas) - 1
      )
    ],

    $minusculas[
      random_int(
        0,
        strlen($minusculas) - 1
      )
    ],

    $numeros[
      random_int(
        0,
        strlen($numeros) - 1
      )
    ],

    $simbolos[
      random_int(
        0,
        strlen($simbolos) - 1
      )
    ],
  ];

  while (
    count($caracteres)
    < $longitud
  ) {

    $caracteres[] =
      $todos[
        random_int(
          0,
          strlen($todos) - 1
        )
      ];
  }

  for (
    $i =
      count($caracteres) - 1;

    $i > 0;

    $i--
  ) {

    $j =
      random_int(
        0,
        $i
      );

    [
      $caracteres[$i],
      $caracteres[$j]
    ] = [
      $caracteres[$j],
      $caracteres[$i]
    ];
  }

  return implode(
    "",
    $caracteres
  );
}

function errorPoliticaClaveUsuario(string $clave): string {
  if (strlen($clave) < 10) {

    return
      "La nueva clave debe tener al menos 10 caracteres.";
  }

  if (
    !preg_match(
      '/[A-Z]/',
      $clave
    )
  ) {

    return
      "La nueva clave debe incluir al menos una letra mayuscula.";
  }

  if (
    !preg_match(
      '/[a-z]/',
      $clave
    )
  ) {

    return
      "La nueva clave debe incluir al menos una letra minuscula.";
  }

  if (
    !preg_match(
      '/[0-9]/',
      $clave
    )
  ) {

    return
      "La nueva clave debe incluir al menos un numero.";
  }

  return "";
}

function puedeRestablecerAccesoUsuario(?array $usuarioObjetivo): bool {
  if (!$usuarioObjetivo) {
    return false;
  }

  $rolActor =
    strtoupper(
      trim(
        (string)rolActual()
      )
    );

  if (
    !in_array(
      $rolActor,
      [
        "DIRECTORA",
        "SUBDIRECTOR"
      ],
      true
    )
  ) {
    return false;
  }

  $rolObjetivo =
    strtoupper(
      trim(
        (string)(
          $usuarioObjetivo["rol"]
          ?? ""
        )
      )
    );

  if (
    !in_array(
      $rolObjetivo,
      [
        "DIURNO",
        "TARDE"
      ],
      true
    )
  ) {
    return false;
  }

  $estadoObjetivo =
    strtoupper(
      trim(
        (string)(
          $usuarioObjetivo["estado"]
          ?? ""
        )
      )
    );

  if (
    $estadoObjetivo !== "ACTIVO"
  ) {
    return false;
  }

  if (
    !puede(
      "cambiar_clave_usuarios"
    )
  ) {
    return false;
  }

  return
    puedeGestionarUsuarioActual(
      $usuarioObjetivo
    );
}
/**
 * Genera un codigo de recuperacion con dos partes:
 *
 * SELECTOR-SECRETO
 *
 * - El selector permite localizar un unico registro y no es secreto.
 * - El secreto tiene aproximadamente 100 bits de entropia.
 * - Solo el hash del secreto debe persistirse en la BD.
 */
function generarCodigoRecuperacionUsuario(): array {
  $selector =
    strtoupper(
      bin2hex(
        random_bytes(
          6
        )
      )
    );

  $alfabeto =
    "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

  $secreto = "";

  for (
    $i = 0;
    $i < 20;
    $i++
  ) {
    $secreto .=
      $alfabeto[
        random_int(
          0,
          strlen($alfabeto) - 1
        )
      ];
  }

  $hash =
    crearHashCodigoRecuperacionUsuario(
      $secreto
    );

  return [
    "selector" =>
      $selector,

    "codigo" =>
      $selector .
      "-" .
      $secreto,

    "codigo_hash" =>
      $hash,
  ];
}

/**
 * Valida y separa un codigo de recuperacion.
 *
 * Retorna:
 * [
 *   "selector" => "...",
 *   "secreto" => "..."
 * ]
 *
 * o null si el formato no es valido.
 */
function parsearCodigoRecuperacionUsuario(string $codigo): ?array {
  $codigo =
    strtoupper(
      trim(
        $codigo
      )
    );

  if (
    !preg_match(
      '/^([A-F0-9]{12})-([A-HJ-NP-Z2-9]{20})$/',
      $codigo,
      $partes
    )
  ) {
    return null;
  }

  return [
    "selector" =>
      (string)$partes[1],

    "secreto" =>
      (string)$partes[2],
  ];
}

function crearHashCodigoRecuperacionUsuario(string $secreto): string {
  $hash =
    password_hash(
      $secreto,
      PASSWORD_DEFAULT
    );

  if (
    !is_string(
      $hash
    ) ||
    $hash === ""
  ) {
    throw new RuntimeException(
      "No se pudo proteger el codigo de recuperacion."
    );
  }

  return $hash;
}

function verificarCodigoRecuperacionUsuario(
  string $secreto,
  string $hash
): bool {
  if (
    $secreto === "" ||
    $hash === ""
  ) {
    return false;
  }

  return
    password_verify(
      $secreto,
      $hash
    );
}

/**
 * Los nombres de usuario actuales usan caracteres ASCII.
 * Normalizamos para que el rate limit no pueda evadirse
 * cambiando mayusculas/minusculas o agregando espacios.
 */
function normalizarUsuarioRecuperacion(string $usuario): string {
  return
    strtolower(
      trim(
        $usuario
      )
    );
}

/**
 * Solo se confia en REMOTE_ADDR.
 *
 * No se usan X-Forwarded-For / X-Real-IP porque el proyecto
 * no tiene actualmente un proxy confiable configurado.
 */
function normalizarIpRecuperacion(string $ip): string {
  $ip =
    trim(
      $ip
    );

  if (
    filter_var(
      $ip,
      FILTER_VALIDATE_IP
    ) === false
  ) {
    return "0.0.0.0";
  }

  return $ip;
}

function ipClienteRecuperacion(): string {
  return
    normalizarIpRecuperacion(
      (string)(
        $_SERVER["REMOTE_ADDR"]
        ?? ""
      )
    );
}

/**
 * Regla pura de rate limit:
 * menos de 5 fallos por usuario Y menos de 5 por IP.
 */
function recuperacionPermitidaPorConteos(
  int $fallosUsuario,
  int $fallosIp,
  int $limite = 5
): bool {
  $limite =
    max(
      1,
      $limite
    );

  return
    $fallosUsuario < $limite &&
    $fallosIp < $limite;
}

/**
 * Consulta el estado del rate limit sin modificar la BD.
 *
 * Ventana por defecto:
 * 15 minutos.
 *
 * Limite por defecto:
 * 5 fallos por usuario O por IP.
 */
function estadoRateLimitRecuperacion(
  PDO $pdo,
  string $usuario,
  string $ip,
  ?DateTimeImmutable $ahora = null,
  int $limite = 5,
  int $ventanaMinutos = 15
): array {
  $usuario =
    normalizarUsuarioRecuperacion(
      $usuario
    );

  $ip =
    normalizarIpRecuperacion(
      $ip
    );

  $limite =
    max(
      1,
      $limite
    );

  $ventanaMinutos =
    max(
      1,
      $ventanaMinutos
    );

  if ($ahora === null) {
    $zonaNombre =
      date_default_timezone_get();

    if ($zonaNombre === "") {
      $zonaNombre =
        "America/Caracas";
    }

    $ahora =
      new DateTimeImmutable(
        "now",
        new DateTimeZone(
          $zonaNombre
        )
      );
  }

  $desde =
    $ahora
      ->modify(
        "-" .
        $ventanaMinutos .
        " minutes"
      )
      ->format(
        "Y-m-d H:i:s"
      );

  $stmtUsuario =
    $pdo->prepare("
      SELECT COUNT(*)
      FROM recuperacion_intentos
      WHERE
        exitoso = 0
        AND usuario = ?
        AND creado_en >= ?
    ");

  $stmtUsuario->execute([
    $usuario,
    $desde
  ]);

  $fallosUsuario =
    (int)$stmtUsuario
      ->fetchColumn();

  $stmtIp =
    $pdo->prepare("
      SELECT COUNT(*)
      FROM recuperacion_intentos
      WHERE
        exitoso = 0
        AND ip = ?
        AND creado_en >= ?
    ");

  $stmtIp->execute([
    $ip,
    $desde
  ]);

  $fallosIp =
    (int)$stmtIp
      ->fetchColumn();

  return [
    "permitido" =>
      recuperacionPermitidaPorConteos(
        $fallosUsuario,
        $fallosIp,
        $limite
      ),

    "fallos_usuario" =>
      $fallosUsuario,

    "fallos_ip" =>
      $fallosIp,

    "limite" =>
      $limite,

    "ventana_minutos" =>
      $ventanaMinutos,

    "desde" =>
      $desde,
  ];
}

/**
 * Registra solamente:
 * - usuario normalizado
 * - IP validada
 * - exito/fallo
 * - fecha
 *
 * Nunca recibe ni almacena el codigo de recuperacion.
 */
function registrarIntentoRecuperacion(
  PDO $pdo,
  string $usuario,
  string $ip,
  bool $exitoso
): int {
  $usuario =
    normalizarUsuarioRecuperacion(
      $usuario
    );

  $ip =
    normalizarIpRecuperacion(
      $ip
    );

  if (
    strlen(
      $usuario
    ) > 50
  ) {
    $usuario =
      substr(
        $usuario,
        0,
        50
      );
  }

  $stmt =
    $pdo->prepare("
      INSERT INTO recuperacion_intentos (
        usuario,
        ip,
        exitoso,
        creado_en
      )
      VALUES (
        ?,
        ?,
        ?,
        NOW()
      )
    ");

  $stmt->execute([
    $usuario,
    $ip,
    $exitoso ? 1 : 0
  ]);

  return
    (int)$pdo->lastInsertId();
}

/**
 * ============================================================
 * BLOQUE 11B - RATE LIMIT LOGIN ADMINISTRATIVO
 * ============================================================
 */

function normalizarUsuarioLogin(string $usuario): string {
  $usuario = strtolower(trim($usuario));

  if (strlen($usuario) > 50) {
    $usuario = substr($usuario, 0, 50);
  }

  return $usuario;
}

function ipClienteLogin(): string {
  return normalizarIpRecuperacion(
    (string)($_SERVER["REMOTE_ADDR"] ?? "")
  );
}

function loginPermitidoPorConteos(
  int $fallosUsuarioIp,
  int $fallosIp,
  int $limiteUsuarioIp = 5,
  int $limiteIp = 20
): bool {
  return
    $fallosUsuarioIp < max(1, $limiteUsuarioIp)
    &&
    $fallosIp < max(1, $limiteIp);
}

function estadoRateLimitLogin(
  PDO $pdo,
  string $usuario,
  string $ip,
  ?DateTimeImmutable $ahora = null,
  int $limiteUsuarioIp = 5,
  int $limiteIp = 20,
  int $ventanaMinutos = 15
): array {
  $usuario = normalizarUsuarioLogin($usuario);
  $ip = normalizarIpRecuperacion($ip);
  $ventanaMinutos = max(1, $ventanaMinutos);

  if ($ahora === null) {
    $zona = date_default_timezone_get();

    if ($zona === "") {
      $zona = "America/Caracas";
    }

    $ahora = new DateTimeImmutable(
      "now",
      new DateTimeZone($zona)
    );
  }

  $desde = $ahora
    ->modify("-" . $ventanaMinutos . " minutes")
    ->format("Y-m-d H:i:s");

  $stmt = $pdo->prepare("
    SELECT COUNT(*)
    FROM login_intentos
    WHERE
      exitoso = 0
      AND usuario = ?
      AND ip = ?
      AND creado_en >= ?
  ");

  $stmt->execute([
    $usuario,
    $ip,
    $desde
  ]);

  $fallosUsuarioIp = (int)$stmt->fetchColumn();

  $stmt = $pdo->prepare("
    SELECT COUNT(*)
    FROM login_intentos
    WHERE
      exitoso = 0
      AND ip = ?
      AND creado_en >= ?
  ");

  $stmt->execute([
    $ip,
    $desde
  ]);

  $fallosIp = (int)$stmt->fetchColumn();

  return [
    "permitido" => loginPermitidoPorConteos(
      $fallosUsuarioIp,
      $fallosIp,
      $limiteUsuarioIp,
      $limiteIp
    ),
    "fallos_usuario_ip" => $fallosUsuarioIp,
    "fallos_ip" => $fallosIp,
    "limite_usuario_ip" => max(1, $limiteUsuarioIp),
    "limite_ip" => max(1, $limiteIp),
    "ventana_minutos" => $ventanaMinutos,
    "desde" => $desde,
  ];
}

function registrarIntentoLogin(
  PDO $pdo,
  string $usuario,
  string $ip,
  bool $exitoso
): int {
  $stmt = $pdo->prepare("
    INSERT INTO login_intentos (
      usuario,
      ip,
      exitoso,
      creado_en
    )
    VALUES (?, ?, ?, NOW())
  ");

  $stmt->execute([
    normalizarUsuarioLogin($usuario),
    normalizarIpRecuperacion($ip),
    $exitoso ? 1 : 0
  ]);

  return (int)$pdo->lastInsertId();
}

function limpiarFallosLogin(
  PDO $pdo,
  string $usuario,
  string $ip
): int {
  $stmt = $pdo->prepare("
    DELETE FROM login_intentos
    WHERE
      usuario = ?
      AND ip = ?
      AND exitoso = 0
  ");

  $stmt->execute([
    normalizarUsuarioLogin($usuario),
    normalizarIpRecuperacion($ip)
  ]);

  return $stmt->rowCount();
}

function purgarIntentosLoginAntiguos(
  PDO $pdo,
  int $dias = 30
): int {
  $dias = max(1, min(365, $dias));

  $sql = "
    DELETE FROM login_intentos
    WHERE creado_en < DATE_SUB(
      NOW(),
      INTERVAL " . $dias . " DAY
    )
  ";

  return (int)$pdo->exec($sql);
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

function permisosSistema(): array {
  return [
    "ver_asistencias",
    "marcar_asistencia",
    "ver_personal",
    "crear_personal",
    "cambiar_estado_personal",
    "ver_permisos",
    "crear_permisos",
    "ver_reposos",
    "crear_reposos",
    "ver_reportes",
    "ver_usuarios",
    "crear_usuarios",
    "cambiar_estado_usuarios",
    "cambiar_clave_usuarios",
  ];
}

function permisosPorRol(): array {
  $operativos = [
    "ver_asistencias",
    "marcar_asistencia",
    "ver_personal",
    "crear_personal",
    "cambiar_estado_personal",
    "ver_permisos",
    "crear_permisos",
    "ver_reposos",
    "crear_reposos",
    "ver_reportes",
  ];

  $administrativos = permisosSistema();

  return [
    "DIRECTORA" => $administrativos,
    "SUBDIRECTOR" => $administrativos,
    "DIURNO" => $operativos,
    "TARDE" => $operativos,
  ];
}

function puede(string $permiso): bool {
  $rol = rolActual();
  $mapa = permisosPorRol();

  if (!isset($mapa[$rol])) {
    return false;
  }

  return in_array($permiso, $mapa[$rol], true);
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
  return puede("crear_usuarios")
    || puede("cambiar_estado_usuarios")
    || puede("cambiar_clave_usuarios");
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
  return puede("ver_usuarios");
}

function marcarAsistenciasSinSalidaVencidas(
  PDO $pdo,
  ?DateTimeImmutable $ahora = null
): int {
  $tz = new DateTimeZone("America/Caracas");

  if ($ahora === null) {
    $ahora = new DateTimeImmutable("now", $tz);
  }

  $stmt = $pdo->prepare("
    SELECT
      a.id,
      a.fecha,
      a.hora_entrada,
      a.observacion_sistema,
      t.hora_inicio,
      t.hora_fin
    FROM asistencias a
    INNER JOIN empleados e
      ON e.id = a.empleado_id
    LEFT JOIN turnos t
      ON t.id = e.turno_id
    WHERE
      a.hora_entrada IS NOT NULL
      AND a.hora_salida IS NULL
      AND (
        a.salida_estado IS NULL
        OR TRIM(a.salida_estado) = ''
      )
      AND a.fecha <= ?
    ORDER BY a.id
  ");

  $stmt->execute([
    $ahora->format("Y-m-d")
  ]);

  $filas = $stmt->fetchAll(PDO::FETCH_ASSOC);

  if (!$filas) {
    return 0;
  }

  $actualizadas = 0;
  $transaccionPropia = !$pdo->inTransaction();

  if ($transaccionPropia) {
    $pdo->beginTransaction();
  }

  try {
    $upd = $pdo->prepare("
      UPDATE asistencias
      SET
        salida_estado = 'SIN_SALIDA',
        observacion_sistema = ?
      WHERE
        id = ?
        AND hora_salida IS NULL
        AND (
          salida_estado IS NULL
          OR TRIM(salida_estado) = ''
        )
    ");

    foreach ($filas as $fila) {
      $horaInicio = trim(
        (string)($fila["hora_inicio"] ?? "")
      );

      $horaFin = trim(
        (string)($fila["hora_fin"] ?? "")
      );

      if ($horaFin === "") {
        continue;
      }

      $finTurno = new DateTimeImmutable(
        (string)$fila["fecha"] .
        " " .
        $horaFin,
        $tz
      );

      if (
        $horaInicio !== "" &&
        $horaInicio > $horaFin
      ) {
        $finTurno = $finTurno->modify("+1 day");
      }

      if (
        $finTurno->getTimestamp() >
        $ahora->getTimestamp()
      ) {
        continue;
      }

      $nota =
        "Sin salida registrada al finalizar el turno (" .
        $horaFin .
        ").";

      $observacionActual = trim(
        (string)($fila["observacion_sistema"] ?? "")
      );

      $observacionNueva =
        $observacionActual === ""
          ? $nota
          : $observacionActual . " | " . $nota;

      $upd->execute([
        $observacionNueva,
        (int)$fila["id"]
      ]);

      $actualizadas += $upd->rowCount();
    }

    if ($transaccionPropia) {
      $pdo->commit();
    }
  } catch (Throwable $e) {
    if (
      $transaccionPropia &&
      $pdo->inTransaction()
    ) {
      $pdo->rollBack();
    }

    throw $e;
  }

  return $actualizadas;
}
function calcularSalidaAsistencia(
  string $fechaAsistencia,
  string $horaEntrada,
  string $horaInicio,
  ?string $horaFin,
  DateTimeImmutable $ahora,
  DateTimeZone $tz
): array {
  $inicio = new DateTimeImmutable($fechaAsistencia . " " . $horaEntrada, $tz);

  if ($horaFin !== null && $horaFin !== "") {
    if ($horaInicio > $horaFin && $horaEntrada < $horaFin) {
      $inicio = $inicio->modify("+1 day");
    }
  }

  $diferenciaSegundos = $ahora->getTimestamp() - $inicio->getTimestamp();

  if ($diferenciaSegundos < 0) {
    return [
      "ok" => false,
      "error" => "La hora de salida no puede ser anterior a la entrada",
    ];
  }

  $horasTrabajadas = round($diferenciaSegundos / 3600, 2);
  $salidaEstado = "NORMAL";
  $minutosSalidaTardia = 0;
  $observacionSistema = null;

  if ($horaFin !== null && $horaFin !== "") {
    $finTurno = new DateTimeImmutable(
      $fechaAsistencia . " " . $horaFin,
      $tz
    );

    if ($horaInicio > $horaFin) {
      $finTurno = $finTurno->modify("+1 day");
    }

    $diferenciaFinSegundos =
      $ahora->getTimestamp() - $finTurno->getTimestamp();

    if ($diferenciaFinSegundos > 0) {
      $minutosSalidaTardia =
        (int)ceil($diferenciaFinSegundos / 60);
    }

    $toleranciaSalidaTardia = defined(
      "SALIDA_TARDIA_TOLERANCIA_MINUTOS"
    )
      ? max(
          0,
          (int)constant("SALIDA_TARDIA_TOLERANCIA_MINUTOS")
        )
      : 0;

    if ($minutosSalidaTardia > $toleranciaSalidaTardia) {
      $salidaEstado = "SALIDA_TARDIA";
      $observacionSistema =
        "Salida tardía: {$minutosSalidaTardia} min después del fin del turno ({$horaFin}).";
    }
  } else {
    $salidaEstado = "SIN_HORARIO";
    $observacionSistema =
      "No se pudo comparar la salida porque el turno no tiene hora_fin.";
  }

  return [
    "ok" => true,
    "error" => null,
    "hora_salida" => $ahora->format("H:i:s"),
    "horas_trabajadas" => $horasTrabajadas,
    "salida_estado" => $salidaEstado,
    "minutos_salida_tardia" => $minutosSalidaTardia,
    "observacion_sistema" => $observacionSistema,
  ];
}
function fotoEmpleadoUrl(?string $fotoArchivo): string {
  $fotoArchivo = trim((string)$fotoArchivo);

  if ($fotoArchivo === "") {
    return "";
  }

  $fotoArchivo = str_replace("\\", "/", $fotoArchivo);
  $fotoArchivo = ltrim($fotoArchivo, "/");

  if (
    str_contains($fotoArchivo, "\0") ||
    str_contains($fotoArchivo, "../") ||
    str_contains($fotoArchivo, "..\\")
  ) {
    return "";
  }

  if (
    !str_starts_with(
      $fotoArchivo,
      "uploads/empleados/"
    )
  ) {
    return "";
  }

  if (
    !preg_match(
      '/\.(jpe?g|png|webp)$/i',
      $fotoArchivo
    )
  ) {
    return "";
  }

  $rutaFisica =
    dirname(__DIR__) .
    DIRECTORY_SEPARATOR .
    str_replace(
      "/",
      DIRECTORY_SEPARATOR,
      $fotoArchivo
    );

  if (!is_file($rutaFisica)) {
    return "";
  }

  $segmentos = array_map(
    "rawurlencode",
    explode("/", $fotoArchivo)
  );

  return BASE_URL . "/" . implode("/", $segmentos);
}
function empleadoPorCodigoBarra(PDO $pdo, string $codigo): ?array {
  $codigo = trim($codigo);
  if ($codigo === "") return null;
  $stmt = $pdo->prepare("SELECT id, nombres, apellidos, cedula, codigo_barra FROM empleados WHERE codigo_barra = ? LIMIT 1");
  $stmt->execute([$codigo]);
  $emp = $stmt->fetch(PDO::FETCH_ASSOC);
  return $emp ?: null;
}

function generarCodigoBarra(PDO $pdo): string {
  for ($intento = 0; $intento < 30; $intento++) {
    $codigo =
      "ASIS-" .
      strtoupper(
        bin2hex(
          random_bytes(16)
        )
      );

    $stmt = $pdo->prepare("
      SELECT COUNT(*)
      FROM empleados
      WHERE codigo_barra = ?
    ");

    $stmt->execute([
      $codigo
    ]);

    if ((int)$stmt->fetchColumn() === 0) {
      return $codigo;
    }
  }

  throw new RuntimeException(
    "No se pudo generar un codigo de barras unico."
  );
}

