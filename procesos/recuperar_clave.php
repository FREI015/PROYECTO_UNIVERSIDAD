<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";

if (
  $_SERVER["REQUEST_METHOD"]
  !== "POST"
) {
  go(
    BASE_URL .
    "/recuperar_clave.php"
  );
}

$mensajeGenerico =
  "No se pudo completar la recuperación. Verifica los datos o inténtalo más tarde.";

$urlGenerica =
  BASE_URL .
  "/recuperar_clave.php?err=" .
  urlencode(
    $mensajeGenerico
  );

verifyCsrfOrRedirect(
  BASE_URL .
  "/recuperar_clave.php?err=" .
  urlencode(
    "Solicitud inválida. Intenta nuevamente."
  )
);

$usuarioIngresado =
  normalizarUsuarioRecuperacion(
    (string)(
      $_POST["usuario"]
      ?? ""
    )
  );

$usuarioRate =
  substr(
    $usuarioIngresado,
    0,
    50
  );

$codigoIngresado =
  (string)(
    $_POST["codigo_recuperacion"]
    ?? ""
  );

$claveNueva =
  (string)(
    $_POST["clave_nueva"]
    ?? ""
  );

$claveConfirmar =
  (string)(
    $_POST["clave_confirmar"]
    ?? ""
  );

$ip =
  ipClienteRecuperacion();

/*
 * El limite se consulta antes de validar usuario/codigo.
 *
 * 5 fallos por usuario O por IP dentro de 15 minutos.
 */
$estadoLimite =
  estadoRateLimitRecuperacion(
    $pdo,
    $usuarioRate,
    $ip
  );

if (
  !(
    $estadoLimite["permitido"]
    ?? false
  )
) {
  go(
    $urlGenerica
  );
}

/*
 * La politica de la NUEVA clave puede informarse
 * sin revelar si la cuenta existe.
 */
if (
  $claveNueva === "" ||
  $claveConfirmar === ""
) {
  go(
    BASE_URL .
    "/recuperar_clave.php?err=" .
    urlencode(
      "Debes indicar y confirmar la nueva clave."
    )
  );
}

if (
  !hash_equals(
    $claveNueva,
    $claveConfirmar
  )
) {
  go(
    BASE_URL .
    "/recuperar_clave.php?err=" .
    urlencode(
      "Las nuevas claves no coinciden."
    )
  );
}

$errorPolitica =
  errorPoliticaClaveUsuario(
    $claveNueva
  );

if ($errorPolitica !== "") {
  go(
    BASE_URL .
    "/recuperar_clave.php?err=" .
    urlencode(
      $errorPolitica
    )
  );
}

$formatoUsuarioValido = (
  $usuarioIngresado !== "" &&
  strlen(
    $usuarioIngresado
  ) <= 50
);

$codigoPartes =
  parsearCodigoRecuperacionUsuario(
    $codigoIngresado
  );

if (
  !$formatoUsuarioValido ||
  !$codigoPartes
) {

  registrarIntentoRecuperacion(
    $pdo,
    $usuarioRate,
    $ip,
    false
  );

  go(
    $urlGenerica
  );
}

$selector =
  (string)$codigoPartes["selector"];

$secreto =
  (string)$codigoPartes["secreto"];

/*
 * Ambas consultas se realizan siempre antes de decidir
 * si las credenciales de recuperacion son validas.
 */
$stmtUsuario =
  $pdo->prepare("
    SELECT
      id,
      usuario,
      clave,
      estado
    FROM usuarios
    WHERE usuario = ?
    LIMIT 1
  ");

$stmtUsuario->execute([
  $usuarioIngresado
]);

$usuarioDb =
  $stmtUsuario->fetch(
    PDO::FETCH_ASSOC
  );

$stmtCodigo =
  $pdo->prepare("
    SELECT
      id,
      usuario_id,
      selector,
      codigo_hash,
      usado_en,
      revocado_en
    FROM usuario_codigos_recuperacion
    WHERE selector = ?
    LIMIT 1
  ");

$stmtCodigo->execute([
  $selector
]);

$codigoDb =
  $stmtCodigo->fetch(
    PDO::FETCH_ASSOC
  );

/*
 * Incluso cuando el selector no existe se ejecuta
 * password_verify sobre un hash valido de descarte.
 *
 * Esto reduce diferencias obvias entre caminos
 * de validacion.
 */
$hashVerificacion = "";

if ($codigoDb) {

  $hashVerificacion =
    (string)(
      $codigoDb["codigo_hash"]
      ?? ""
    );

}
else {

  $hashVerificacion =
    crearHashCodigoRecuperacionUsuario(
      "CODIGO-DUMMY-RECUPERACION"
    );
}

$secretoValido =
  verificarCodigoRecuperacionUsuario(
    $secreto,
    $hashVerificacion
  );

$credencialValida = (
  is_array(
    $usuarioDb
  ) &&
  strtoupper(
    trim(
      (string)(
        $usuarioDb["estado"]
        ?? ""
      )
    )
  ) === "ACTIVO" &&
  is_array(
    $codigoDb
  ) &&
  (int)(
    $codigoDb["usuario_id"]
    ?? 0
  ) === (int)(
    $usuarioDb["id"]
    ?? 0
  ) &&
  $codigoDb["usado_en"] === null &&
  $codigoDb["revocado_en"] === null &&
  $secretoValido
);

if (!$credencialValida) {

  registrarIntentoRecuperacion(
    $pdo,
    $usuarioRate,
    $ip,
    false
  );

  go(
    $urlGenerica
  );
}

/*
 * El usuario ya demostro posesion de un codigo valido.
 * Ahora podemos rechazar reutilizacion de su clave actual.
 */
if (
  verificarClaveUsuario(
    $claveNueva,
    (string)(
      $usuarioDb["clave"]
      ?? ""
    )
  )
) {
  go(
    BASE_URL .
    "/recuperar_clave.php?err=" .
    urlencode(
      "La nueva clave debe ser diferente a la clave actual."
    )
  );
}

$nuevoHash =
  crearHashClaveUsuario(
    $claveNueva
  );

/*
 * Consumo y cambio de clave atomicos.
 */
$pdo->beginTransaction();

try {

  $stmtUsuarioLock =
    $pdo->prepare("
      SELECT
        id,
        usuario,
        clave,
        estado
      FROM usuarios
      WHERE id = ?
      LIMIT 1
      FOR UPDATE
    ");

  $stmtUsuarioLock->execute([
    (int)$usuarioDb["id"]
  ]);

  $usuarioLock =
    $stmtUsuarioLock->fetch(
      PDO::FETCH_ASSOC
    );

  $stmtCodigoLock =
    $pdo->prepare("
      SELECT
        id,
        usuario_id,
        codigo_hash,
        usado_en,
        revocado_en
      FROM usuario_codigos_recuperacion
      WHERE id = ?
      LIMIT 1
      FOR UPDATE
    ");

  $stmtCodigoLock->execute([
    (int)$codigoDb["id"]
  ]);

  $codigoLock =
    $stmtCodigoLock->fetch(
      PDO::FETCH_ASSOC
    );

  $estadoBloqueadoValido = (
    is_array(
      $usuarioLock
    ) &&
    strtoupper(
      trim(
        (string)(
          $usuarioLock["estado"]
          ?? ""
        )
      )
    ) === "ACTIVO" &&
    is_array(
      $codigoLock
    ) &&
    (int)(
      $codigoLock["usuario_id"]
      ?? 0
    ) === (int)(
      $usuarioLock["id"]
      ?? 0
    ) &&
    $codigoLock["usado_en"] === null &&
    $codigoLock["revocado_en"] === null &&
    verificarCodigoRecuperacionUsuario(
      $secreto,
      (string)(
        $codigoLock["codigo_hash"]
        ?? ""
      )
    )
  );

  if (!$estadoBloqueadoValido) {
    throw new RuntimeException(
      "RECOVERY_CREDENTIAL_CHANGED"
    );
  }

  $stmtUsar =
    $pdo->prepare("
      UPDATE usuario_codigos_recuperacion
      SET usado_en = NOW()
      WHERE
        id = ?
        AND usado_en IS NULL
        AND revocado_en IS NULL
    ");

  $stmtUsar->execute([
    (int)$codigoLock["id"]
  ]);

  if (
    $stmtUsar->rowCount()
    !== 1
  ) {
    throw new RuntimeException(
      "RECOVERY_CODE_NOT_CONSUMED"
    );
  }

  $stmtClave =
    $pdo->prepare("
      UPDATE usuarios
      SET
        clave = ?,
        debe_cambiar_clave = 0,
        version_sesion = version_sesion + 1,
        clave_actualizada_en = NOW()
      WHERE
        id = ?
        AND estado = 'ACTIVO'
    ");

  $stmtClave->execute([
    $nuevoHash,
    (int)$usuarioLock["id"]
  ]);

  if (
    $stmtClave->rowCount()
    !== 1
  ) {
    throw new RuntimeException(
      "RECOVERY_PASSWORD_NOT_UPDATED"
    );
  }

  registrarIntentoRecuperacion(
    $pdo,
    $usuarioRate,
    $ip,
    true
  );

  $pdo->commit();

}
catch (Throwable $e) {

  if (
    $pdo->inTransaction()
  ) {
    $pdo->rollBack();
  }

  /*
   * Ningun detalle interno se devuelve al usuario.
   */
  go(
    $urlGenerica
  );
}

/*
 * No hay auto-login.
 *
 * version_sesion fue incrementada y cualquier sesion
 * previa de esa cuenta queda invalidada por requireLogin().
 */
go(
  BASE_URL .
  "/login.php?recuperada=1"
);