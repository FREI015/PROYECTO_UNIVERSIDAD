<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";
require_once __DIR__ . "/includes/conexion.php";

noCache();

// Si ya está logueado, redirige a asistencias
if (isLogged()) {
  $next = safeNext($_GET["next"] ?? "", BASE_URL . "/modulos/asistencias.php");
  go($next);
}

$err  = trim($_GET["err"] ?? "");
$next = safeNext($_GET["next"] ?? "", BASE_URL . "/modulos/asistencias.php");

$ACTION = BASE_URL . "/procesos/login_procesar.php";
$logo   = BASE_URL . "/assets/img/logo_institucion.png";
$fondo  = BASE_URL . "/assets/img/Gemini_Generated_Image_3t4ws33t4ws33t4w.png";
$theme  = BASE_URL . "/assets/css/app-theme.css?v=login-institucional";
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Acceso al sistema</title>
<link rel="stylesheet" href="<?php echo e($theme); ?>">

<style>
:root{
  --ink:#18202b;
  --muted:#657184;
  --paper:#fffaf0;
  --card:#ffffff;
  --line:rgba(255,255,255,.30);
  --deep:#111827;
  --deep2:#1f2937;
  --gold:#c9a24d;
  --gold2:#e5c878;
  --danger-bg:#fff1f1;
  --danger:#7f1d1d;
  --shadow:0 28px 80px rgba(0,0,0,.30);
}

*{
  box-sizing:border-box;
}

html,body{
  min-height:100%;
}

body{
  margin:0;
  font-family:'Segoe UI', Tahoma, Verdana, sans-serif;
  color:var(--ink);
  background:
    linear-gradient(90deg, rgba(10,14,22,.80), rgba(10,14,22,.48), rgba(10,14,22,.70)),
    url('<?php echo e($fondo); ?>') center / cover no-repeat fixed;
}

.login-page{
  min-height:100vh;
  display:flex;
  flex-direction:column;
  position:relative;
  overflow:hidden;
}

.login-page::before{
  content:"";
  position:absolute;
  inset:0;
  background:
    radial-gradient(circle at 20% 20%, rgba(255,255,255,.12), transparent 28%),
    radial-gradient(circle at 80% 80%, rgba(201,162,77,.16), transparent 30%);
  pointer-events:none;
}

.login-header{
  position:relative;
  z-index:2;
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:18px;
  padding:22px 34px;
}

.brand{
  display:flex;
  align-items:center;
  gap:14px;
  min-width:0;
}

.brand-logo{
  width:58px;
  height:58px;
  border-radius:18px;
  background:rgba(255,255,255,.92);
  border:1px solid rgba(255,255,255,.55);
  padding:7px;
  object-fit:contain;
  box-shadow:0 14px 34px rgba(0,0,0,.22);
}

.brand-text{
  color:#fff;
  min-width:0;
  text-shadow:0 3px 16px rgba(0,0,0,.78);
}

.brand-title{
  font-size:20px;
  line-height:1.1;
  font-weight:950;
  letter-spacing:.2px;
}

.brand-subtitle{
  margin-top:4px;
  font-size:12px;
  font-weight:800;
  letter-spacing:1px;
  text-transform:none;
  color:#fffdf7;
}

.header-badge{
  display:inline-flex;
  align-items:center;
  gap:9px;
  padding:10px 14px;
  border-radius:999px;
  color:#fff;
  background:rgba(255,255,255,.12);
  border:1px solid rgba(255,255,255,.25);
  backdrop-filter:blur(12px);
  font-size:12px;
  font-weight:900;
  letter-spacing:.5px;
  text-transform:none;
}

.header-badge::before{
  content:"";
  width:8px;
  height:8px;
  border-radius:50%;
  background:var(--gold2);
  box-shadow:0 0 0 5px rgba(229,200,120,.15);
}

.login-main{
  position:relative;
  z-index:2;
  flex:1;
  display:flex;
  align-items:center;
  justify-content:center;
  padding:26px 24px 40px;
}

.login-frame{
  width:min(1120px, 96vw);
  min-height:590px;
  display:grid;
  grid-template-columns:1.08fr .92fr;
  border-radius:32px;
  overflow:hidden;
  background:rgba(255,255,255,.14);
  border:1px solid rgba(255,255,255,.28);
  box-shadow:var(--shadow);
  backdrop-filter:blur(18px);
}

.cover{
  position:relative;
  display:flex;
  flex-direction:column;
  justify-content:flex-end;
  padding:48px;
  color:#fff;
  background:
    linear-gradient(180deg, rgba(17,24,39,.10), rgba(17,24,39,.70)),
    url('<?php echo e($fondo); ?>') center / cover no-repeat;
}

.cover::after{
  content:"";
  position:absolute;
  inset:0;
  background:
    linear-gradient(135deg, rgba(17,24,39,.45), rgba(17,24,39,.18), rgba(0,0,0,.62));
}

.cover-content{
  position:relative;
  z-index:1;
  max-width:620px;
}

.cover-kicker{
  display:inline-flex;
  align-items:center;
  gap:10px;
  margin-bottom:18px;
  padding:9px 13px;
  border-radius:999px;
  background:rgba(255,255,255,.14);
  border:1px solid rgba(255,255,255,.24);
  color:#fffdf7;
  font-size:12px;
  font-weight:950;
  letter-spacing:1px;
  text-transform:none;
  backdrop-filter:blur(10px);
}

.cover-kicker::before{
  content:"";
  width:34px;
  height:2px;
  background:var(--gold2);
  border-radius:999px;
}

.cover h1{
  margin:0;
  font-size:clamp(34px, 4.4vw, 52px);
  line-height:1;
  letter-spacing:-1.5px;
  font-weight:950;
  text-shadow:0 4px 20px rgba(0,0,0,.85);
}

.cover p{
  margin:20px 0 0;
  max-width:500px;
  color:#ffffff;
  font-size:16px;
  line-height:1.65;
  font-weight:700;
}

.cover-actions{
  margin-top:28px;
  display:flex;
  flex-wrap:wrap;
  gap:10px;
}

.cover-pill{
  padding:10px 13px;
  border-radius:999px;
  background:rgba(255,255,255,.13);
  border:1px solid rgba(255,255,255,.22);
  color:#ffffff;
  font-size:12px;
  font-weight:900;
  backdrop-filter:blur(10px);
}

.form-side{
  display:flex;
  align-items:center;
  justify-content:center;
  padding:46px 40px;
  background:
    linear-gradient(180deg, rgba(255,255,255,.97), rgba(255,250,240,.96));
}

.login-card{
  width:100%;
  max-width:430px;
}

.login-card-top{
  margin-bottom:24px;
}

.login-card-top .mini-logo{
  width:72px;
  height:72px;
  object-fit:contain;
  border-radius:22px;
  padding:9px;
  background:#fff;
  border:1px solid #eadfca;
  box-shadow:0 15px 34px rgba(17,24,39,.12);
  margin-bottom:18px;
}

.login-card h2{
  margin:0;
  font-size:32px;
  line-height:1.1;
  color:var(--deep);
  letter-spacing:-.8px;
  font-weight:950;
}

.login-card .lead{
  margin:10px 0 0;
  color:var(--muted);
  font-size:14px;
  line-height:1.55;
  font-weight:750;
}

.login-alert{
  margin:0 0 18px;
  padding:13px 14px;
  border-radius:16px;
  background:var(--danger-bg);
  border:1px solid #fecaca;
  color:var(--danger);
  font-size:13px;
  font-weight:900;
}

.login-form{
  display:flex;
  flex-direction:column;
  gap:15px;
}

.field label{
  display:block;
  margin:0 0 7px;
  color:#334155;
  font-size:13px;
  font-weight:950;
}

.input{
  width:100%;
  height:50px;
  border-radius:16px;
  border:1px solid #d2c4ad;
  background:#fff;
  padding:0 15px;
  color:var(--deep);
  font-size:14px;
  font-weight:800;
  transition:border-color .18s ease, box-shadow .18s ease, transform .18s ease;
}

.input:focus{
  outline:none;
  border-color:var(--gold);
  box-shadow:0 0 0 4px rgba(201,162,77,.18);
}

.input::placeholder{
  color:#a1a8b3;
}

.btn-login{
  height:52px;
  border:0;
  border-radius:16px;
  margin-top:4px;
  color:#fff;
  background:linear-gradient(135deg, #1f2937, #111827);
  box-shadow:0 16px 32px rgba(17,24,39,.26);
  font-size:15px;
  font-weight:950;
  letter-spacing:.2px;
  cursor:pointer;
  transition:transform .18s ease, box-shadow .18s ease, filter .18s ease;
}

.btn-login:hover{
  transform:translateY(-1px);
  filter:brightness(1.04);
  box-shadow:0 20px 38px rgba(17,24,39,.32);
}

.form-note{
  margin-top:18px;
  padding:14px 15px;
  border-radius:18px;
  background:#faf7ef;
  border:1px solid #eadfca;
  color:#6b7280;
  font-size:12px;
  line-height:1.45;
  font-weight:800;
}

.login-footer{
  position:relative;
  z-index:2;
  padding:0 22px 24px;
  text-align:center;
  color:#fffdf7;
  font-size:12px;
  font-weight:800;
  text-shadow:0 2px 12px rgba(0,0,0,.82);
}

@media (max-width:940px){
  .login-frame{
    grid-template-columns:1fr;
  }

  .cover{
    min-height:330px;
    padding:36px;
  }

  .form-side{
    padding:34px 24px;
  }
}

@media (max-width:640px){
  .login-header{
    align-items:flex-start;
    flex-direction:column;
    padding:18px;
  }

  .header-badge{
    width:100%;
    justify-content:center;
  }

  .login-main{
    padding:12px;
  }

  .login-frame{
    width:100%;
    border-radius:24px;
  }

  .cover{
    padding:28px 22px;
  }

  .cover h1{
    font-size:36px;
  }

  .cover p{
    font-size:14px;
  }

  .form-side{
    padding:28px 20px;
  }

  .login-card h2{
    font-size:28px;
  }
}

/* FORZADO FINAL TEXTO CLARO LOGIN */
.cover h1,
.cover h1 *,
.cover p,
.cover p *,
.cover-pill,
.cover-pill *,
.cover-kicker,
.cover-kicker *,
.header-badge,
.header-badge * {
  color: #ffffff !important;
  -webkit-text-fill-color: #ffffff !important;
  text-shadow: 0 3px 18px rgba(0,0,0,.95) !important;
}

.cover h1 {
  font-weight: 950 !important;
}

.cover p {
  font-weight: 850 !important;
}

.cover-pill {
  background: rgba(255,255,255,.18) !important;
  border: 1px solid rgba(255,255,255,.55) !important;
  box-shadow: 0 8px 22px rgba(0,0,0,.22) !important;
}

.cover-kicker {
  background: rgba(255,255,255,.16) !important;
  border: 1px solid rgba(255,255,255,.45) !important;
}

.header-badge {
  background: rgba(255,255,255,.16) !important;
  border: 1px solid rgba(255,255,255,.45) !important;
}
/* FIN FORZADO FINAL TEXTO CLARO LOGIN */


/* OVERRIDE FINAL LOGIN PERSONALIZADO */

/* Fondo general más oscuro */
body{
  background:
    linear-gradient(90deg, rgba(6,10,18,.88), rgba(6,10,18,.68), rgba(6,10,18,.84)),
    url('<?php echo e($fondo); ?>') center / cover no-repeat fixed !important;
}

/* Oscurecer un poco más la zona izquierda sin perder la imagen */
.cover{
  background:
    linear-gradient(180deg, rgba(17,24,39,.24), rgba(17,24,39,.78)),
    url('<?php echo e($fondo); ?>') center / cover no-repeat !important;
}

.cover::after{
  background:
    linear-gradient(135deg, rgba(17,24,39,.58), rgba(17,24,39,.28), rgba(0,0,0,.72)) !important;
}

/* Letras institucionales en dorado */
.brand-title,
.brand-title *,
.brand-subtitle,
.brand-subtitle *,
.header-badge,
.header-badge *{
  color:#e7c76a !important;
  -webkit-text-fill-color:#e7c76a !important;
  text-shadow:0 3px 16px rgba(0,0,0,.82) !important;
}

/* Badge sistema escolar más armónico */
.header-badge{
  background:rgba(0,0,0,.24) !important;
  border:1px solid rgba(231,199,106,.55) !important;
  box-shadow:0 8px 22px rgba(0,0,0,.22) !important;
}

.header-badge::before{
  background:#e7c76a !important;
  box-shadow:0 0 0 5px rgba(231,199,106,.18) !important;
}

/* También el kicker superior de la portada puede ir en dorado */
.cover-kicker,
.cover-kicker *{
  color:#f0d98c !important;
  -webkit-text-fill-color:#f0d98c !important;
  text-shadow:0 2px 12px rgba(0,0,0,.82) !important;
  border-color:rgba(240,217,140,.42) !important;
}

/* Mantener el resto de textos de la portada claros */
.cover h1,
.cover h1 *,
.cover p,
.cover p *,
.cover-pill,
.cover-pill *{
  color:#ffffff !important;
  -webkit-text-fill-color:#ffffff !important;
  text-shadow:0 3px 18px rgba(0,0,0,.92) !important;
}

/* Pills visibles */
.cover-pill{
  background:rgba(255,255,255,.16) !important;
  border:1px solid rgba(255,255,255,.42) !important;
  box-shadow:0 8px 22px rgba(0,0,0,.22) !important;
}

/* Footer legible */
.login-footer{
  color:rgba(255,255,255,.96) !important;
  text-shadow:0 3px 16px rgba(0,0,0,.84) !important;
}

/* FIN OVERRIDE FINAL LOGIN PERSONALIZADO */

</style>
</head>

<body>
  <div class="login-page">

    <header class="login-header">
      <div class="brand">
        <img class="brand-logo" src="<?php echo e($logo); ?>" alt="Logo institucional">
        <div class="brand-text">
          <div class="brand-title">Control de Asistencia</div>
          <div class="brand-subtitle">E.B.N. Dr. Enrique Delgado Palacios</div>
        </div>
      </div>

      <div class="header-badge">Sistema escolar</div>
    </header>

    <main class="login-main">
      <section class="login-frame">

        <div class="cover">
          <div class="cover-content">
            <div class="cover-kicker">Control institucional</div>
            <h1>Control de Asistencia</h1>
            <p>
              Plataforma institucional para administrar asistencia, personal,
              permisos, reposos, usuarios y reportes con una experiencia clara,
              ordenada y segura.
            </p>

            <div class="cover-actions">
              <div class="cover-pill">Asistencia</div>
              <div class="cover-pill">Personal</div>
              <div class="cover-pill">Permisos</div>
              <div class="cover-pill">Reportes PDF</div>
            </div>
          </div>
        </div>

        <div class="form-side">
          <div class="login-card">

            <div class="login-card-top">
              <img class="mini-logo" src="<?php echo e($logo); ?>" alt="Logo institucional">
              <h2>Bienvenido</h2>
              <p class="lead">Ingresa tus credenciales para acceder al panel principal del sistema.</p>
            </div>

            <?php if ($err): ?>
              <div class="login-alert"><?php echo e($err); ?></div>
            <?php endif; ?>

            <form class="login-form" method="POST" action="<?php echo e($ACTION); ?>" autocomplete="on">
              <?php echo csrfInput(); ?>
              <input type="hidden" name="next" value="<?php echo e($next); ?>">

              <div class="field">
                <label for="usuario">Usuario</label>
                <input
                  id="usuario"
                  class="input"
                  type="text"
                  name="usuario"
                  required
                  autocomplete="username"
                  placeholder="Escribe tu usuario"
                >
              </div>

              <div class="field">
                <label for="clave">Clave</label>
                <input
                  id="clave"
                  class="input"
                  type="password"
                  name="clave"
                  required
                  autocomplete="current-password"
                  placeholder="Escribe tu clave"
                >
              </div>

              <button class="btn-login" type="submit">Entrar al sistema</button>
            </form>

            <div class="form-note">
              Acceso autorizado únicamente para usuarios registrados. Las opciones disponibles dependen del rol asignado.
            </div>

          </div>
        </div>

      </section>
    </main>

    <footer class="login-footer">
      © E.B.N. Dr. Enrique Delgado Palacios — Sistema de Control de Asistencia
    </footer>

  </div>
</body>
</html>


