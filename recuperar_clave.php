<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";

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
  <title>Recuperar clave</title>

  <style>
    *{
      box-sizing:border-box;
    }

    body{
      margin:0;
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:28px 18px;
      background:#f5f2eb;
      color:#243447;
      font-family:Arial,sans-serif;
    }

    .recovery-box{
      width:100%;
      max-width:520px;
      background:#fff;
      border:1px solid #e3ddd2;
      border-radius:24px;
      padding:28px;
      box-shadow:0 18px 55px rgba(15,23,42,.08);
    }

    .recovery-title{
      margin:0;
      font-size:27px;
      font-weight:950;
      color:#223548;
    }

    .recovery-sub{
      margin:9px 0 22px;
      color:#64748b;
      font-size:14px;
      line-height:1.6;
      font-weight:650;
    }

    .recovery-alert{
      margin:0 0 18px;
      padding:13px 15px;
      border-radius:13px;
      background:#fff1f2;
      border:1px solid #fecdd3;
      color:#9f1239;
      font-size:13px;
      font-weight:750;
      line-height:1.5;
    }

    .recovery-field{
      margin:0 0 15px;
    }

    .recovery-field label{
      display:block;
      margin:0 0 7px;
      font-size:13px;
      font-weight:850;
    }

    .recovery-input{
      width:100%;
      min-height:48px;
      padding:0 13px;
      border:1px solid #d6dee8;
      border-radius:13px;
      background:#fff;
      color:#172033;
      font-size:14px;
      outline:none;
    }

    .recovery-input:focus{
      border-color:#800020;
      box-shadow:0 0 0 3px rgba(128,0,32,.08);
    }

    .recovery-help{
      margin:7px 0 0;
      color:#64748b;
      font-size:12px;
      line-height:1.5;
    }

    .recovery-btn{
      width:100%;
      min-height:49px;
      margin-top:5px;
      border:0;
      border-radius:13px;
      background:#800020;
      color:#fff;
      font-weight:900;
      font-size:14px;
      cursor:pointer;
    }

    .recovery-back{
      display:block;
      margin-top:17px;
      text-align:center;
      color:#800020;
      font-size:13px;
      font-weight:850;
      text-decoration:none;
    }

    .recovery-security{
      margin-top:20px;
      padding-top:17px;
      border-top:1px solid #e7ebf0;
      color:#64748b;
      font-size:12px;
      line-height:1.55;
    }
  </style>
</head>

<body>

  <main class="recovery-box">

    <h1 class="recovery-title">
      Recuperar clave
    </h1>

    <p class="recovery-sub">
      Ingresa tu usuario, uno de tus códigos de recuperación
      y la nueva clave que deseas establecer.
    </p>

    <?php if ($err !== ""): ?>
      <div class="recovery-alert">
        <?php echo e($err); ?>
      </div>
    <?php endif; ?>

    <form
      method="POST"
      action="<?php echo e(BASE_URL); ?>/procesos/recuperar_clave.php"
      autocomplete="off"
    >

      <?php echo csrfInput(); ?>

      <div class="recovery-field">
        <label for="usuario_recuperacion">
          Usuario
        </label>

        <input
          id="usuario_recuperacion"
          class="recovery-input"
          type="text"
          name="usuario"
          maxlength="50"
          required
          autocomplete="username"
          placeholder="Tu usuario"
        >
      </div>

      <div class="recovery-field">
        <label for="codigo_recuperacion">
          Código de recuperación
        </label>

        <input
          id="codigo_recuperacion"
          class="recovery-input"
          type="text"
          name="codigo_recuperacion"
          maxlength="64"
          required
          autocomplete="off"
          autocapitalize="characters"
          spellcheck="false"
          placeholder="XXXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXX"
        >

        <p class="recovery-help">
          Usa uno de los códigos que guardaste previamente.
          Cada código puede utilizarse una sola vez.
        </p>
      </div>

      <div class="recovery-field">
        <label for="clave_nueva">
          Nueva clave
        </label>

        <input
          id="clave_nueva"
          class="recovery-input"
          type="password"
          name="clave_nueva"
          minlength="10"
          required
          autocomplete="new-password"
          placeholder="Nueva clave"
        >
      </div>

      <div class="recovery-field">
        <label for="clave_confirmar">
          Confirmar nueva clave
        </label>

        <input
          id="clave_confirmar"
          class="recovery-input"
          type="password"
          name="clave_confirmar"
          minlength="10"
          required
          autocomplete="new-password"
          placeholder="Repite la nueva clave"
        >

        <p class="recovery-help">
          Mínimo 10 caracteres, incluyendo mayúscula,
          minúscula y número.
        </p>
      </div>

      <button
        class="recovery-btn"
        type="submit"
      >
        Establecer nueva clave
      </button>

    </form>

    <a
      class="recovery-back"
      href="<?php echo e(BASE_URL); ?>/login.php"
    >
      Volver al inicio de sesión
    </a>

    <div class="recovery-security">
      Por seguridad, el sistema no indica si un usuario o
      un código específico existen. Los intentos fallidos
      están limitados.
    </div>

  </main>

</body>
</html>