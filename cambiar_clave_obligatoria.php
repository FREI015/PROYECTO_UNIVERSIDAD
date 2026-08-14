<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";

noCache();
requireLogin();

if (
  (int)(
    $_SESSION["debe_cambiar_clave"]
    ?? 0
  ) !== 1
) {

  go(
    BASE_URL .
    "/modulos/asistencias.php"
  );
}

$user =
  usuarioActual();

$usuario =
  (string)(
    $user["usuario"]
    ?? "Usuario"
  );

$err =
  trim(
    (string)(
      $_GET["err"]
      ?? ""
    )
  );
?>
<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta
  name="viewport"
  content="width=device-width,initial-scale=1"
>
<title>Cambiar clave</title>

<style>
*{
  box-sizing:border-box;
}

body{
  margin:0;
  min-height:100vh;
  display:grid;
  place-items:center;
  padding:24px;
  font-family:Arial,sans-serif;
  background:#f5f7fb;
  color:#1f2937;
}

.card{
  width:min(100%,520px);
  background:#fff;
  border:1px solid #e5e7eb;
  border-radius:18px;
  padding:28px;
  box-shadow:
    0 18px 45px
    rgba(0,0,0,.08);
}

h1{
  margin:0 0 10px;
  font-size:25px;
}

p{
  line-height:1.5;
}

.field{
  margin-top:16px;
}

label{
  display:block;
  margin-bottom:7px;
  font-weight:700;
}

input{
  width:100%;
  padding:12px 14px;
  border:1px solid #cbd5e1;
  border-radius:10px;
  font-size:16px;
}

button{
  width:100%;
  margin-top:20px;
  padding:13px;
  border:0;
  border-radius:10px;
  background:#1d4ed8;
  color:#fff;
  font-weight:700;
  cursor:pointer;
}

.alert{
  background:#fff1f2;
  border:1px solid #fecdd3;
  color:#9f1239;
  border-radius:10px;
  padding:12px;
  margin-top:15px;
}

.note{
  background:#f8fafc;
  border-radius:10px;
  padding:12px;
  margin-top:16px;
  font-size:14px;
}

.logout{
  display:block;
  margin-top:18px;
  text-align:center;
}
</style>

</head>
<body>

<div class="card">

  <h1>
    Define tu nueva clave
  </h1>

  <p>
    Hola,
    <strong>
      <?php echo e($usuario); ?>
    </strong>.
    Estas usando una clave temporal y debes reemplazarla antes de continuar.
  </p>

  <?php if ($err !== ""): ?>

    <div class="alert">
      <?php echo e($err); ?>
    </div>

  <?php endif; ?>

  <div class="note">
    La nueva clave debe tener al menos 10 caracteres,
    una mayuscula, una minuscula y un numero.
    No puede ser igual a la clave temporal.
  </div>

  <form
    method="POST"
    action="<?php echo e(
      BASE_URL .
      "/procesos/cambiar_clave_obligatoria.php"
    ); ?>"
  >

    <?php echo csrfInput(); ?>

    <div class="field">

      <label for="clave">
        Nueva clave
      </label>

      <input
        id="clave"
        name="clave"
        type="password"
        minlength="10"
        autocomplete="new-password"
        required
      >

    </div>

    <div class="field">

      <label for="clave_confirmar">
        Confirmar nueva clave
      </label>

      <input
        id="clave_confirmar"
        name="clave_confirmar"
        type="password"
        minlength="10"
        autocomplete="new-password"
        required
      >

    </div>

    <button type="submit">
      Guardar nueva clave
    </button>

  </form>

  <a
    class="logout"
    href="<?php echo e(
      BASE_URL .
      "/procesos/logout.php"
    ); ?>"
  >
    Cerrar sesion
  </a>

</div>

</body>
</html>