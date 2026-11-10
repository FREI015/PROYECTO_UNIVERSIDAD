<?php

require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";
require_once __DIR__ . "/../includes/auditoria.php";

requireLogin();

$destino = BASE_URL . "/modulos/usuarios.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    go($destino . "?err=" . urlencode("Solicitud invalida."));
}

requirePermiso(
    "cambiar_clave_usuarios",
    $destino
);

verifyCsrfOrRedirect(
    $destino . "?err=" .
    urlencode("Solicitud invalida. Intenta nuevamente.")
);

$actor = usuarioActual();

$actorId = (int)($actor["id"] ?? 0);

$rolActor = strtoupper(
    trim((string)($actor["rol"] ?? ""))
);

if (
    $actorId <= 0 ||
    !in_array($rolActor, ["DIRECTORA", "SUBDIRECTOR"], true)
) {
    go(
        $destino . "?err=" .
        urlencode("No tienes autorizacion para esta operacion.")
    );
}

$id = (int)($_POST["id"] ?? 0);

if ($id <= 0) {
    go(
        $destino . "?err=" .
        urlencode("Usuario invalido.")
    );
}

/*
 * Evita que una credencial temporal anterior
 * permanezca visible si una nueva operacion falla.
 */
unset($_SESSION["restablecimiento_clave"]);

$claveTemporal = "";
$usuarioObjetivo = null;

try {

    $pdo->beginTransaction();

    /*
     * Bloqueo de la cuenta objetivo.
     * La validacion de permisos se repite dentro
     * de la transaccion.
     */
    $stmt = $pdo->prepare("
        SELECT
            id,
            usuario,
            rol,
            estado
        FROM usuarios
        WHERE id = ?
        LIMIT 1
        FOR UPDATE
    ");

    $stmt->execute([$id]);

    $usuarioObjetivo = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$usuarioObjetivo) {
        throw new RuntimeException("TARGET_NOT_FOUND");
    }

    if (
        !puedeRestablecerAccesoUsuario($usuarioObjetivo)
    ) {
        throw new RuntimeException("TARGET_NOT_ALLOWED");
    }

    $rolObjetivo = strtoupper(
        trim((string)$usuarioObjetivo["rol"])
    );

    $estadoObjetivo = strtoupper(
        trim((string)$usuarioObjetivo["estado"])
    );

    if (
        !in_array($rolObjetivo, ["DIURNO", "TARDE"], true) ||
        $estadoObjetivo !== "ACTIVO"
    ) {
        throw new RuntimeException("TARGET_STATE_INVALID");
    }

    /*
     * Generacion de credencial temporal.
     */
    $claveTemporal = generarClaveTemporalUsuario(16);

    $hash = crearHashClaveUsuario($claveTemporal);

    /*
     * Restablecimiento de acceso e invalidacion
     * de las sesiones anteriores.
     */
    $stmtUpdate = $pdo->prepare("
        UPDATE usuarios
        SET
            clave = ?,
            debe_cambiar_clave = 1,
            version_sesion = version_sesion + 1,
            clave_actualizada_en = NOW()
        WHERE
            id = ?
            AND estado = 'ACTIVO'
            AND rol IN ('DIURNO', 'TARDE')
    ");

    $stmtUpdate->execute([
        $hash,
        $id
    ]);

    if ($stmtUpdate->rowCount() !== 1) {
        throw new RuntimeException("PASSWORD_UPDATE_FAILED");
    }

    /*
     * Revocacion de todos los codigos pendientes.
     */
    $stmtRevocar = $pdo->prepare("
        UPDATE usuario_codigos_recuperacion
        SET revocado_en = NOW()
        WHERE
            usuario_id = ?
            AND usado_en IS NULL
            AND revocado_en IS NULL
    ");

    $stmtRevocar->execute([$id]);

    /*
     * Auditoria: nunca se almacena la clave temporal.
     */
    registrarAuditoria(
        $pdo,
        "RESTABLECER_ACCESO",
        "usuarios",
        $id,
        [
            "metodo" => "administrativo",
            "usuario_objetivo" => (string)$usuarioObjetivo["usuario"],
            "rol_objetivo" => $rolObjetivo,
            "rol_actor" => $rolActor
        ]
    );

    $pdo->commit();

} catch (Throwable $e) {

    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }

    error_log(
        "[RESTABLECIMIENTO_ADMINISTRATIVO] " .
        $e->getMessage()
    );

    go(
        $destino . "?err=" .
        urlencode("No se pudo restablecer el acceso.")
    );
}

/*
 * La clave temporal se conserva exclusivamente
 * en la sesion para su entrega inmediata.
 */
$_SESSION["restablecimiento_clave"] = [
    "actor_id" => $actorId,
    "usuario" => (string)$usuarioObjetivo["usuario"],
    "clave_temporal" => $claveTemporal,
    "creada_en" => time()
];

go(
    $destino . "?msg=" .
    urlencode("Acceso restablecido. Entrega la clave temporal al usuario.")
);