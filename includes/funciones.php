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

function generarCodigoBarra(int $empleadoId): string {
  return 'EMP' . str_pad((string)$empleadoId, 5, '0', STR_PAD_LEFT);
}

