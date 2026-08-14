<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";

requireLogin();

if (
  $_SERVER["REQUEST_METHOD"]
  !== "POST"
) {
  go(
    BASE_URL .
    "/codigos_recuperacion.php"
  );
}

verifyCsrfOrRedirect(
  BASE_URL .
  "/codigos_recuperacion.php?err=" .
  urlencode(
    "Solicitud invalida. Intenta nuevamente."
  )
);

$claveActual =
  (string)(
    $_POST["clave_actual"]
    ?? ""
  );

if ($claveActual === "") {
  go(
    BASE_URL .
    "/codigos_recuperacion.php?err=" .
    urlencode(
      "Debes confirmar tu clave actual."
    )
  );
}

$usuarioSesion =
  usuarioActual();

$usuarioId =
  (int)(
    $usuarioSesion["id"]
    ?? $_SESSION["usuario_id"]
    ?? 0
  );

if ($usuarioId <= 0) {
  cerrarSesionUsuarioSistema(
    "Sesion invalida. Inicia sesion nuevamente."
  );
}

/*
 * Primera validacion fuera de la transaccion.
 * Evita generar hashes si la clave actual es incorrecta.
 */
$stmt =
  $pdo->prepare("
    SELECT
      id,
      clave,
      estado,
      debe_cambiar_clave
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

if (
  !$usuarioDb ||
  strtoupper(
    trim(
      (string)(
        $usuarioDb["estado"]
        ?? ""
      )
    )
  ) !== "ACTIVO"
) {
  cerrarSesionUsuarioSistema(
    "La cuenta ya no esta disponible."
  );
}

if (
  (int)(
    $usuarioDb["debe_cambiar_clave"]
    ?? 0
  ) === 1
) {
  go(
    BASE_URL .
    "/cambiar_clave_obligatoria.php"
  );
}

if (
  !verificarClaveUsuario(
    $claveActual,
    (string)(
      $usuarioDb["clave"]
      ?? ""
    )
  )
) {
  go(
    BASE_URL .
    "/codigos_recuperacion.php?err=" .
    urlencode(
      "La clave actual no es correcta."
    )
  );
}

/*
 * Generamos el lote antes de abrir la transaccion.
 * Ningun codigo se persiste todavia.
 */
$lote = [];
$selectoresLote = [];

while (
  count($lote) < 8
) {
  $generado =
    generarCodigoRecuperacionUsuario();

  $selector =
    (string)(
      $generado["selector"]
      ?? ""
    );

  if (
    $selector === "" ||
    isset(
      $selectoresLote[$selector]
    )
  ) {
    continue;
  }

  $selectoresLote[$selector] =
    true;

  $lote[] =
    $generado;
}

$pdo->beginTransaction();

try {

  /*
   * Bloquea exclusivamente la fila de la cuenta actual.
   * La identidad siempre sale de la sesion.
   */
  $stmt =
    $pdo->prepare("
      SELECT
        id,
        clave,
        estado,
        debe_cambiar_clave
      FROM usuarios
      WHERE id = ?
      LIMIT 1
      FOR UPDATE
    ");

  $stmt->execute([
    $usuarioId
  ]);

  $usuarioBloqueado =
    $stmt->fetch(
      PDO::FETCH_ASSOC
    );

  if (
    !$usuarioBloqueado ||
    strtoupper(
      trim(
        (string)(
          $usuarioBloqueado["estado"]
          ?? ""
        )
      )
    ) !== "ACTIVO" ||
    (int)(
      $usuarioBloqueado["debe_cambiar_clave"]
      ?? 0
    ) === 1
  ) {
    throw new RuntimeException(
      "Estado de cuenta invalido."
    );
  }

  /*
   * Se vuelve a verificar la misma clave dentro del lock
   * para evitar condiciones de carrera con un cambio de clave.
   */
  if (
    !verificarClaveUsuario(
      $claveActual,
      (string)(
        $usuarioBloqueado["clave"]
        ?? ""
      )
    )
  ) {
    throw new RuntimeException(
      "La clave cambio durante la operacion."
    );
  }

  $stmtRevocar =
    $pdo->prepare("
      UPDATE usuario_codigos_recuperacion
      SET revocado_en = NOW()
      WHERE
        usuario_id = ?
        AND usado_en IS NULL
        AND revocado_en IS NULL
    ");

  $stmtRevocar->execute([
    $usuarioId
  ]);

  $stmtInsert =
    $pdo->prepare("
      INSERT INTO usuario_codigos_recuperacion (
        usuario_id,
        selector,
        codigo_hash,
        creado_en,
        usado_en,
        revocado_en
      )
      VALUES (
        ?,
        ?,
        ?,
        NOW(),
        NULL,
        NULL
      )
    ");

  foreach ($lote as $generado) {

    $stmtInsert->execute([
      $usuarioId,
      (string)$generado["selector"],
      (string)$generado["codigo_hash"]
    ]);
  }

  $stmtContar =
    $pdo->prepare("
      SELECT COUNT(*)
      FROM usuario_codigos_recuperacion
      WHERE
        usuario_id = ?
        AND usado_en IS NULL
        AND revocado_en IS NULL
    ");

  $stmtContar->execute([
    $usuarioId
  ]);

  if (
    (int)$stmtContar->fetchColumn()
    !== 8
  ) {
    throw new RuntimeException(
      "El lote activo no contiene exactamente 8 codigos."
    );
  }

  $pdo->commit();

} catch (Throwable $e) {

  if (
    $pdo->inTransaction()
  ) {
    $pdo->rollBack();
  }

  go(
    BASE_URL .
    "/codigos_recuperacion.php?err=" .
    urlencode(
      "No se pudo generar el lote de recuperacion."
    )
  );
}

/*
 * El plaintext existe solamente en la sesion actual
 * hasta la primera carga de codigos_recuperacion.php.
 */
$_SESSION["codigos_recuperacion_generados"] = [
  "usuario_id" =>
    $usuarioId,

  "codigos" =>
    array_map(
      static fn(array $item): string =>
        (string)(
          $item["codigo"]
          ?? ""
        ),
      $lote
    ),

  "creados_en" =>
    date(
      "Y-m-d H:i:s"
    ),
];

go(
  BASE_URL .
  "/codigos_recuperacion.php?msg=" .
  urlencode(
    "Nuevo lote de 8 codigos generado correctamente."
  )
);