<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";

noCache();
requireLogin();

if (
  $_SERVER["REQUEST_METHOD"]
  !== "POST"
) {

  go(
    BASE_URL .
    "/mi_perfil.php"
  );
}

verifyCsrfOrRedirect(
  BASE_URL .
  "/mi_perfil.php?err=" .
  urlencode(
    "Solicitud invalida. Intenta nuevamente."
  )
);

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

$claveActual =
  (string)(
    $_POST["clave_actual"]
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

if (
  $claveActual === "" ||
  $claveNueva === "" ||
  $claveConfirmar === ""
) {

  go(
    BASE_URL .
    "/mi_perfil.php?err=" .
    urlencode(
      "Completa los tres campos de clave."
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
    "/mi_perfil.php?err=" .
    urlencode(
      "La confirmacion de la nueva clave no coincide."
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
    "/mi_perfil.php?err=" .
    urlencode(
      $errorPolitica
    )
  );
}

/*
 * Primera lectura.
 *
 * El usuario objetivo NO viene de GET ni POST.
 * Siempre se obtiene desde la sesion autenticada.
 */
$stmt =
  $pdo->prepare("
    SELECT
      id,
      clave,
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

if (
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
    "Usuario inactivo."
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

$hashActual =
  (string)(
    $usuarioDb["clave"]
    ?? ""
  );

if (
  !verificarClaveUsuario(
    $claveActual,
    $hashActual
  )
) {

  go(
    BASE_URL .
    "/mi_perfil.php?err=" .
    urlencode(
      "La clave actual no es correcta."
    )
  );
}

if (
  verificarClaveUsuario(
    $claveNueva,
    $hashActual
  )
) {

  go(
    BASE_URL .
    "/mi_perfil.php?err=" .
    urlencode(
      "La nueva clave debe ser diferente a la clave actual."
    )
  );
}

$nuevoHash =
  crearHashClaveUsuario(
    $claveNueva
  );

$pdo->beginTransaction();

try {

  /*
   * Segunda validacion bajo lock.
   *
   * Evita una condicion de carrera si la clave
   * o el estado de la cuenta cambia entre lecturas.
   */
  $stmt =
    $pdo->prepare("
      SELECT
        id,
        clave,
        estado,
        debe_cambiar_clave,
        version_sesion
      FROM usuarios
      WHERE id = ?
      LIMIT 1
      FOR UPDATE
    ");

  $stmt->execute([
    $usuarioId
  ]);

  $usuarioLock =
    $stmt->fetch(
      PDO::FETCH_ASSOC
    );

  if (
    !$usuarioLock ||
    strtoupper(
      trim(
        (string)(
          $usuarioLock["estado"]
          ?? ""
        )
      )
    ) !== "ACTIVO" ||
    (int)(
      $usuarioLock["debe_cambiar_clave"]
      ?? 0
    ) === 1
  ) {

    throw new RuntimeException(
      "PROFILE_PASSWORD_INVALID_ACCOUNT_STATE"
    );
  }

  if (
    !verificarClaveUsuario(
      $claveActual,
      (string)(
        $usuarioLock["clave"]
        ?? ""
      )
    )
  ) {

    throw new RuntimeException(
      "PROFILE_PASSWORD_CHANGED_DURING_OPERATION"
    );
  }

  if (
    verificarClaveUsuario(
      $claveNueva,
      (string)(
        $usuarioLock["clave"]
        ?? ""
      )
    )
  ) {

    throw new RuntimeException(
      "PROFILE_PASSWORD_REUSE"
    );
  }

  $stmtUpdate =
    $pdo->prepare("
      UPDATE usuarios
      SET
        clave = ?,
        version_sesion =
          version_sesion + 1,
        clave_actualizada_en = NOW()
      WHERE
        id = ?
        AND estado = 'ACTIVO'
        AND debe_cambiar_clave = 0
    ");

  $stmtUpdate->execute([
    $nuevoHash,
    $usuarioId
  ]);

  if (
    $stmtUpdate->rowCount()
    !== 1
  ) {

    throw new RuntimeException(
      "PROFILE_PASSWORD_NOT_UPDATED"
    );
  }

  $stmtVersion =
    $pdo->prepare("
      SELECT
        version_sesion
      FROM usuarios
      WHERE id = ?
      LIMIT 1
    ");

  $stmtVersion->execute([
    $usuarioId
  ]);

  $nuevaVersion =
    (int)$stmtVersion->fetchColumn();

  if ($nuevaVersion <= 0) {

    throw new RuntimeException(
      "PROFILE_SESSION_VERSION_INVALID"
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
    "/mi_perfil.php?err=" .
    urlencode(
      "No se pudo actualizar la clave. Intenta nuevamente."
    )
  );
}

/*
 * La misma sesion que realizo el cambio
 * recibe inmediatamente la nueva version.
 *
 * Las otras sesiones conservan la version anterior
 * y requireLogin() las invalidara.
 */
session_regenerate_id(
  true
);

$_SESSION["version_sesion"] =
  $nuevaVersion;

$_SESSION["debe_cambiar_clave"] =
  0;

go(
  BASE_URL .
  "/mi_perfil.php?msg=" .
  urlencode(
    "Tu clave fue actualizada correctamente."
  )
);