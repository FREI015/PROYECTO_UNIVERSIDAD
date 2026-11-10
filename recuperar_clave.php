<?php

require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";

noCache();

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
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:24px;
    background:#f5f2eb;
    color:#243447;
    font-family:Arial,sans-serif;
}

.recovery-box{
    width:100%;
    max-width:520px;
    padding:30px;
    background:#fff;
    border:1px solid #e3ddd2;
    border-radius:24px;
    box-shadow:0 18px 55px rgba(15,23,42,.08);
}

h1{
    margin:0 0 12px;
    font-size:27px;
    color:#223548;
}

p{
    font-size:14px;
    line-height:1.7;
    color:#64748b;
}

.notice{
    margin:22px 0;
    padding:17px;
    border:1px solid #e8d7bb;
    border-radius:15px;
    background:#faf7ef;
    color:#57472e;
    line-height:1.7;
    font-size:14px;
}

.back{
    display:block;
    padding:15px;
    margin-top:20px;
    border-radius:13px;
    background:#800020;
    color:white;
    text-align:center;
    text-decoration:none;
    font-weight:900;
}
</style>
</head>

<body>

<main class="recovery-box">

    <h1>Recuperación de acceso</h1>

    <p>
        Para proteger las cuentas del sistema,
        la recuperación automática mediante códigos
        personales ya no está disponible.
    </p>

    <div class="notice">
        <strong>¿Olvidaste tu contraseña?</strong>

        <br><br>

        Debes comunicarte con Dirección para solicitar
        el restablecimiento de tu cuenta.

        <br><br>

        Una vez que recibas tu contraseña temporal,
        podrás ingresar al sistema y se te solicitará
        establecer una nueva contraseña personal.
    </div>

    <a class="back"
       href="<?php echo e(BASE_URL); ?>/login.php">
        Volver al inicio de sesión
    </a>

</main>

</body>
</html>