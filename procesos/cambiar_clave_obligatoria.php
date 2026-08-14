<?php
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";

requireLogin();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {

  go(
    BASE_URL .
    "/cambiar_clave_obligatoria.php"
  );
}

verifyCsrfOrRedirect(
  BASE_URL .
  "/cambiar_clave_obligatoria.php?err=" .
  urlencode(
    "Solicitud invalida. Intenta nuevamente."
  )
);

$clave =
  (string)(
    $_POST["clave"]
    ?? ""
  );

$claveConfirmar =
  (string)(
    $_POST["clave_confirmar"]
    ?? ""
  );

if (
  $clave === "" ||
  $claveConfirmar === ""
) {

  go(
    BASE_URL .
    "/cambiar_clave_obligatoria.php?err=" .
    urlencode(
      "Completa ambos campos."
    )
  );
}

if (
  $clave !==
  $claveConfirmar
) {

  go(
    BASE_URL .
    "/cambiar_clave_obligatoria.php?err=" .
    urlencode(
      "La confirmacion no coincide."
    )
  );
}

$errorPolitica =
  errorPoliticaClaveUsuario(
    $clave
  );

if (
  $errorPolitica !== ""
) {

  go(
    BASE_URL .
    "/cambiar_clave_obligatoria.php?err=" .
    urlencode(
      $errorPolitica
    )
  );
}

$usuarioId =
  (int)(
    $_SESSION["user"]["id"]
    ?? $_SESSION["usuario_id"]
    ?? 0
  );

if ($usuarioId <= 0) {

  cerrarSesionUsuarioSistema(
    "Sesion invalida."
  );
}

$stmt =
  $pdo->prepare("
    SELECT
      clave,
      debe_cambiar_clave,
      version_sesion
    FROM usuarios
    WHERE id = ?
    LIMIT 1
  ");

$stmt->execute([
  $usuarioId
]);

$usuario =
  $stmt->fetch(
    PDO::FETCH_ASSOC
  );

if (!$usuario) {

  cerrarSesionUsuarioSistema(
    "La cuenta ya no esta disponible."
  );
}

if (
  (int)(
    $usuario["debe_cambiar_clave"]
    ?? 0
  ) !== 1
) {

  go(
    BASE_URL .
    "/modulos/asistencias.php"
  );
}

$hashActual =
  (string)(
    $usuario["clave"]
    ?? ""
  );

if (
  verificarClaveUsuario(
    $clave,
    $hashActual
  )
) {

  go(
    BASE_URL .
    "/cambiar_clave_obligatoria.php?err=" .
    urlencode(
      "La nueva clave no puede ser igual a la clave temporal."
    )
  );
}

$nuevoHash =
  crearHashClaveUsuario(
    $clave
  );

$pdo->beginTransaction();

try {

  $stmt =
    $pdo->prepare("
      UPDATE usuarios
      SET
        clave = ?,
        debe_cambiar_clave = 0,
        version_sesion =
          version_sesion + 1,
        clave_actualizada_en = NOW()
      WHERE
        id = ?
        AND debe_cambiar_clave = 1
    ");

  $stmt->execute([
    $nuevoHash,
    $usuarioId
  ]);

  if (
    $stmt->rowCount() !== 1
  ) {

    throw new RuntimeException(
      "No se pudo completar el cambio de clave."
    );
  }

  $stmt =
    $pdo->prepare("
      SELECT
        version_sesion
      FROM usuarios
      WHERE id = ?
      LIMIT 1
    ");

  $stmt->execute([
    $usuarioId
  ]);

  $nuevaVersion =
    (int)$stmt->fetchColumn();

  if (
    $nuevaVersion <= 0
  ) {

    throw new RuntimeException(
      "No se pudo validar la nueva sesion."
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
    "/cambiar_clave_obligatoria.php?err=" .
    urlencode(
      "No se pudo guardar la nueva clave."
    )
  );
}

session_regenerate_id(
  true
);

$_SESSION["version_sesion"] =
  $nuevaVersion;

$_SESSION["debe_cambiar_clave"] =
  0;

go(
  BASE_URL .
  "/modulos/asistencias.php?msg=" .
  urlencode(
    "Tu clave fue actualizada correctamente."
  )
);