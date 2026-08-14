<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/conexion.php";

noCache();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  go(BASE_URL . "/login.php");
}

verifyCsrfOrRedirect(
  BASE_URL .
  "/login.php?err=" .
  urlencode(
    "Solicitud invalida. Intenta nuevamente."
  )
);

$usuario = trim(
  (string)(
    $_POST["usuario"]
    ?? ""
  )
);

$clave = (string)(
  $_POST["clave"]
  ?? ""
);

$next = safeNext(
  $_POST["next"]
  ?? "",
  BASE_URL .
  "/modulos/asistencias.php"
);

if ($usuario === "" || $clave === "") {
  go(
    BASE_URL .
    "/login.php?err=" .
    urlencode(
      "Completa usuario y clave"
    ) .
    "&next=" .
    urlencode($next)
  );
}

$usuarioRate = normalizarUsuarioLogin(
  $usuario
);

$ip = ipClienteLogin();

$rate = estadoRateLimitLogin(
  $pdo,
  $usuarioRate,
  $ip
);

if (!($rate["permitido"] ?? false)) {
  go(
    BASE_URL .
    "/login.php?err=" .
    urlencode(
      "Demasiados intentos fallidos. Espera 15 minutos antes de intentar nuevamente."
    ) .
    "&next=" .
    urlencode($next)
  );
}

$stmt = $pdo->prepare("
  SELECT
    id,
    usuario,
    clave,
    rol,
    estado,
    debe_cambiar_clave,
    version_sesion
  FROM usuarios
  WHERE usuario = ?
  LIMIT 1
");

$stmt->execute([
  $usuario
]);

$user = $stmt->fetch(
  PDO::FETCH_ASSOC
);

$accesoValido =
  is_array($user)
  &&
  strtoupper(
    trim(
      (string)(
        $user["estado"]
        ?? ""
      )
    )
  ) === "ACTIVO"
  &&
  password_verify(
    $clave,
    (string)(
      $user["clave"]
      ?? ""
    )
  );

if (!$accesoValido) {
  registrarIntentoLogin(
    $pdo,
    $usuarioRate,
    $ip,
    false
  );

  purgarIntentosLoginAntiguos(
    $pdo
  );

  go(
    BASE_URL .
    "/login.php?err=" .
    urlencode(
      "ACCESO DENEGADO"
    ) .
    "&next=" .
    urlencode($next)
  );
}

limpiarFallosLogin(
  $pdo,
  $usuarioRate,
  $ip
);

registrarIntentoLogin(
  $pdo,
  $usuarioRate,
  $ip,
  true
);

purgarIntentosLoginAntiguos(
  $pdo
);

session_regenerate_id(
  true
);

$_SESSION["user"] = [
  "id" => (int)$user["id"],
  "usuario" => (string)$user["usuario"],
  "rol" => ((string)($user["rol"] ?? "")) !== ""
    ? (string)$user["rol"]
    : "—",
];

$_SESSION["usuario_id"] =
  (int)$user["id"];

$_SESSION["usuario"] =
  (string)$user["usuario"];

$_SESSION["rol"] =
  (string)(
    $user["rol"]
    ?? ""
  );

$_SESSION["version_sesion"] =
  max(
    1,
    (int)(
      $user["version_sesion"]
      ?? 1
    )
  );

$_SESSION["debe_cambiar_clave"] =
  (int)(
    $user["debe_cambiar_clave"]
    ?? 0
  );

if (
  (int)(
    $_SESSION["debe_cambiar_clave"]
    ?? 0
  ) === 1
) {
  go(
    BASE_URL .
    "/cambiar_clave_obligatoria.php"
  );
}

go($next);