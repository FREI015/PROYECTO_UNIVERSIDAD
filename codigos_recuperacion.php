<?php

require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/conexion.php";
require_once __DIR__ . "/includes/funciones.php";

noCache();

requireLogin();

/*
 * Elimina cualquier lote pendiente de visualizacion
 * que haya quedado en la sesion.
 */
unset(
    $_SESSION["codigos_recuperacion_generados"]
);

?>
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Recuperación de acceso</title>

<style>
*{box-sizing:border-box}

body{
    margin:0;
    padding:25px;
    background:#f5f2eb;
    color:#243447;
    font-family:Arial,sans-serif;
}

.container{
    width:100%;
    max-width:760px;
    margin:35px auto;
    padding:28px;
    border:1px solid #e3ddd2;
    border-radius:20px;
    background:#fff;
    box-shadow:0 12px 35px rgba(15,23,42,.06);
}

h1{
    margin-top:0;
    color:#223548;
    font-size:25px;
}

.notice{
    margin-top:20px;
    padding:18px;
    border-radius:14px;
    background:#faf7ef;
    border:1px solid #e8d7bb;
    line-height:1.7;
    color:#57472e;
}

p{
    color:#64748b;
    line-height:1.7;
    font-size:14px;
}

.back{
    display:inline-block;
    margin-top:20px;
    padding:13px 18px;
    background:#800020;
    border-radius:12px;
    color:#fff;
    font-weight:850;
    text-decoration:none;
}
</style>
</head>

<body>

<main class="container">

    <h1>Recuperación de acceso</h1>

    <p>
        La administración de códigos personales
        de recuperación fue deshabilitada.
    </p>

    <div class="notice">

        <strong>Política de recuperación de contraseñas</strong>

        <br><br>

        Ya no es posible generar, regenerar ni utilizar
        códigos personales de recuperación.

        <br><br>

        El personal debe solicitar a Dirección
        el restablecimiento de su cuenta.

        <br><br>

        Los procedimientos de emergencia para
        las cuentas administrativas se gestionarán
        mediante un mecanismo independiente.

    </div>

    <a class="back"
       href="<?php echo e(BASE_URL); ?>/mi_perfil.php">
        Volver a Mi perfil
    </a>

</main>

</body>
</html>