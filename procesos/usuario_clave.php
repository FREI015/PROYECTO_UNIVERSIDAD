<?php
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";

requireLogin();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
  go(
    BASE_URL .
    "/modulos/usuarios.php?err=" .
    urlencode(
      "Acceso invalido."
    )
  );
}

requirePermiso(
  "cambiar_clave_usuarios",
  BASE_URL . "/modulos/usuarios.php"
);

verifyCsrfOrRedirect(
  BASE_URL .
  "/modulos/usuarios.php?err=" .
  urlencode(
    "Solicitud invalida. Intenta nuevamente."
  )
);

$id =
  (int)(
    $_POST["id"]
    ?? 0
  );

if ($id <= 0) {

  go(
    BASE_URL .
    "/modulos/usuarios.php?err=" .
    urlencode(
      "Usuario invalido."
    )
  );
}

$stmt =
  $pdo->prepare("
    SELECT
      id,
      usuario,
      rol,
      estado
    FROM usuarios
    WHERE id = ?
    LIMIT 1
  ");

$stmt->execute([
  $id
]);

$usuarioObjetivo =
  $stmt->fetch(
    PDO::FETCH_ASSOC
  );

if (!$usuarioObjetivo) {

  go(
    BASE_URL .
    "/modulos/usuarios.php?err=" .
    urlencode(
      "Usuario no encontrado."
    )
  );
}

if (
  !puedeRestablecerAccesoUsuario(
    $usuarioObjetivo
  )
) {

  go(
    BASE_URL .
    "/modulos/usuarios.php?err=" .
    urlencode(
      "No tienes permiso para restablecer el acceso de ese usuario."
    )
  );
}

$claveTemporal =
  generarClaveTemporalUsuario(
    16
  );

$hash =
  crearHashClaveUsuario(
    $claveTemporal
  );

$pdo->beginTransaction();

try {

  $stmt =
    $pdo->prepare("
      UPDATE usuarios
      SET
        clave = ?,
        debe_cambiar_clave = 1,
        version_sesion =
          version_sesion + 1,
        clave_actualizada_en = NOW()
      WHERE id = ?
    ");

  $stmt->execute([
    $hash,
    $id
  ]);

  if (
    $stmt->rowCount() !== 1
  ) {

    throw new RuntimeException(
      "No se pudo restablecer la cuenta."
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
    "/modulos/usuarios.php?err=" .
    urlencode(
      "No se pudo restablecer el acceso."
    )
  );
}

$_SESSION["restablecimiento_clave"] = [
  "usuario" =>
    (string)$usuarioObjetivo["usuario"],

  "clave_temporal" =>
    $claveTemporal,

  "creada_en" =>
    date(
      "Y-m-d H:i:s"
    ),
];

go(
  BASE_URL .
  "/modulos/usuarios.php?msg=" .
  urlencode(
    "Acceso restablecido. Entrega la clave temporal al usuario."
  )
);