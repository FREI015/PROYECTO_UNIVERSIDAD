<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";
require_once __DIR__ . "/includes/conexion.php";

noCache();

if (isLogged()) {
  $next = safeNext($_GET["next"] ?? "", BASE_URL . "/modulos/asistencias.php");
  go($next);
}

$err  = trim($_GET["err"] ?? "");
$next = safeNext($_GET["next"] ?? "", BASE_URL . "/modulos/asistencias.php");

$ACTION = BASE_URL . "/procesos/login_procesar.php";
$logo   = BASE_URL . "/assets/img/logo_institucion.png";

$fondoRel  = "/assets/img/login/fondo_login_institucional.jpeg";
$fondoPath = __DIR__ . $fondoRel;
$fondo     = is_file($fondoPath) ? (BASE_URL . $fondoRel . "?v=13d-r6") : "";

$theme = BASE_URL . "/assets/css/app-theme.css?v=login-13d-r6";
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Acceso al sistema</title>
<link rel="stylesheet" href="<?php echo e($theme); ?>">

<style>
/* ============================================================
   MB13D-R3 - LOGIN CLARO DE UN SOLO PANEL
   ============================================================ */

html,
body{
  min-height:100%;
}

body{
  margin:0;
  font-family:"Segoe UI", Tahoma, Arial, sans-serif;
  color:var(--text, #223548);
  background:#F6F8FB;
}

.login-light-page{
  min-height:calc(100vh - 54px);
  position:relative;
  display:flex;
  align-items:center;
  justify-content:center;
  overflow:hidden;
  padding:42px 18px 30px;
  background:
    radial-gradient(circle at 14% 18%, rgba(128,0,32,.10), transparent 30%),
    radial-gradient(circle at 84% 78%, rgba(36,52,71,.10), transparent 34%),
    linear-gradient(180deg, #F7F9FC 0%, #EEF3F8 100%);
}

<?php if ($fondo): ?>
.login-light-page::before{
  content:"";
  position:absolute;
  inset:0;
  background:
    linear-gradient(180deg, rgba(247,249,252,.22), rgba(247,249,252,.16)),
    url('<?php echo e($fondo); ?>') center / cover no-repeat;
  opacity:1;
  filter:none;
  pointer-events:none;
}
<?php endif; ?>

.login-light-page::after{
  content:"";
  position:absolute;
  inset:0;
  background:
    radial-gradient(circle at center, rgba(255,255,255,.18), transparent 36%),
    linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.02));
  pointer-events:none;
}

.login-light-shell{
  position:relative;
  z-index:2;
  width:min(490px, 100%);
}

.login-light-card{
  width:100%;
  background:rgba(255,255,255,.97);
  border:1px solid rgba(220,229,238,.95);
  border-radius:30px;
  box-shadow:0 22px 65px rgba(34,53,72,.16);
  overflow:hidden;
}

.login-light-head{
  padding:30px 30px 21px;
  text-align:center;
  background:
    linear-gradient(180deg, #FFFFFF 0%, #FAFBFD 100%);
  border-bottom:1px solid rgba(220,229,238,.95);
}

.login-light-logo-box{
  width:88px;
  height:88px;
  margin:0 auto 15px;
  display:flex;
  align-items:center;
  justify-content:center;
  border-radius:26px;
  background:#FFFFFF;
  border:1px solid rgba(220,229,238,.95);
  box-shadow:0 14px 34px rgba(34,53,72,.12);
}

.login-light-logo{
  width:69px;
  height:69px;
  display:block;
  object-fit:contain;
}

.login-light-chip{
  display:inline-flex;
  align-items:center;
  justify-content:center;
  gap:8px;
  min-height:30px;
  margin-bottom:12px;
  padding:6px 14px;
  border-radius:999px;
  color:var(--primary-strong, #600018);
  background:var(--primary-soft, #F4E6EA);
  border:1px solid rgba(128,0,32,.14);
  font-size:12px;
  font-weight:900;
  letter-spacing:.35px;
}

.login-light-chip::before{
  content:"";
  width:8px;
  height:8px;
  border-radius:50%;
  background:var(--primary, #800020);
  box-shadow:0 0 0 4px rgba(128,0,32,.10);
}

.login-light-plantel{
  margin:0;
  color:var(--text, #223548);
  font-size:20px;
  line-height:1.18;
  font-weight:950;
  letter-spacing:-.35px;
}

.login-light-subtitle{
  margin:8px 0 0;
  color:var(--text-soft, #5D6E80);
  font-size:13px;
  line-height:1.45;
  font-weight:750;
}

.login-light-body{
  padding:25px 30px 30px;
}

.login-light-title{
  margin:0;
  text-align:center;
  color:var(--text, #223548);
  font-size:29px;
  line-height:1.1;
  font-weight:950;
  letter-spacing:-.8px;
}

.login-light-lead{
  max-width:360px;
  margin:10px auto 22px;
  text-align:center;
  color:var(--text-soft, #5D6E80);
  font-size:14px;
  line-height:1.55;
  font-weight:650;
}

.login-light-alert{
  margin:0 0 18px;
  padding:13px 14px;
  border-radius:16px;
  background:var(--danger-soft, #FFF1F1);
  border:1px solid #FECACA;
  color:var(--danger, #B85C5C);
  font-size:13px;
  font-weight:850;
}

.login-light-form{
  display:flex;
  flex-direction:column;
  gap:15px;
}

.login-light-field label{
  display:block;
  margin:0 0 8px;
  color:var(--text, #223548);
  font-size:13px;
  font-weight:850;
}

.login-light-input{
  width:100%;
  min-height:52px;
  border-radius:17px;
  border:1px solid var(--border, #DCE5EE);
  background:#FFFFFF;
  padding:0 15px;
  color:var(--text, #223548);
  font-size:14px;
  font-weight:750;
  transition:border-color .18s ease, box-shadow .18s ease, background .18s ease;
}

.login-light-input:focus{
  outline:none;
  border-color:var(--primary, #800020);
  box-shadow:0 0 0 4px rgba(128,0,32,.13);
  background:#fff;
}

.login-light-input::placeholder{
  color:var(--text-muted, #8593A3);
  font-weight:650;
}

.login-light-btn{
  width:100%;
  min-height:54px;
  margin-top:4px;
  border:0;
  border-radius:17px;
  color:#fff;
  background:
    linear-gradient(135deg, var(--primary, #800020), var(--primary-strong, #600018));
  box-shadow:0 16px 32px rgba(128,0,32,.23);
  font-size:15px;
  font-weight:950;
  letter-spacing:.2px;
  cursor:pointer;
  transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
}

.login-light-btn:hover{
  transform:translateY(-1px);
  filter:brightness(1.04);
  box-shadow:0 20px 38px rgba(128,0,32,.28);
}

.login-light-note{
  margin-top:18px;
  padding:14px 15px;
  border-radius:18px;
  background:var(--surface-soft, #F3F6FA);
  border:1px solid var(--border, #DCE5EE);
  color:var(--text-soft, #5D6E80);
  font-size:12px;
  line-height:1.45;
  font-weight:750;
  text-align:center;
}

.login-light-footer{
  position:relative;
  z-index:2;
  margin-top:17px;
  text-align:center;
  color:#5D6E80;
  font-size:12px;
  font-weight:750;
}

@media (max-width:640px){
  .login-light-page{
    min-height:calc(100vh - 50px);
    padding:26px 12px 22px;
  }

  .login-light-card{
    border-radius:25px;
  }

  .login-light-head{
    padding:24px 20px 18px;
  }

  .login-light-body{
    padding:22px 20px 24px;
  }

  .login-light-logo-box{
    width:78px;
    height:78px;
    border-radius:22px;
  }

  .login-light-logo{
    width:62px;
    height:62px;
  }

  .login-light-plantel{
    font-size:18px;
  }

  .login-light-title{
    font-size:25px;
  }
}

/* FIN MB13D-R3 */
</style>
</head>

<body>
<?php
require_once __DIR__ . "/includes/cintillo_institucional.php";
?>

<div class="login-light-page">
  <main class="login-light-shell" aria-label="Acceso al sistema">

    <section class="login-light-card">

      <div class="login-light-head">
        <div class="login-light-logo-box">
          <img class="login-light-logo" src="<?php echo e($logo); ?>" alt="Escudo institucional">
        </div>

        <div class="login-light-chip">Sistema escolar</div>

        <h1 class="login-light-plantel">E.B.N. “Dr. Enrique Delgado Palacios”</h1>
        <p class="login-light-subtitle">Sistema de Control de Asistencia</p>
      </div>

      <div class="login-light-body">
        <h2 class="login-light-title">Bienvenido</h2>
        <p class="login-light-lead">
          Ingresa tus credenciales para acceder al panel principal del sistema.
        </p>

        <?php if ($err): ?>
          <div class="login-light-alert"><?php echo e($err); ?></div>
        <?php endif; ?>

        <form class="login-light-form" method="POST" action="<?php echo e($ACTION); ?>" autocomplete="on">
          <?php echo csrfInput(); ?>
          <input type="hidden" name="next" value="<?php echo e($next); ?>">

          <div class="login-light-field">
            <label for="usuario">Usuario</label>
            <input
              id="usuario"
              class="login-light-input"
              type="text"
              name="usuario"
              required
              autocomplete="username"
              placeholder="Escribe tu usuario"
            >
          </div>

          <div class="login-light-field">
            <label for="clave">Clave</label>
            <input
              id="clave"
              class="login-light-input"
              type="password"
              name="clave"
              required
              autocomplete="current-password"
              placeholder="Escribe tu clave"
            >
          </div>

          <button class="login-light-btn" type="submit">Entrar al sistema</button>
        </form>

        <div class="login-light-note">
          Acceso exclusivo para usuarios registrados. Las funciones disponibles dependen del rol asignado.
        </div>
      </div>

    </section>

    <div class="login-light-footer">
      © E.B.N. Dr. Enrique Delgado Palacios
    </div>

  </main>
</div>

</body>
</html>