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
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Acceso al sistema</title>

<style>
:root{
  --blue:#0b6efd;
  --bg:#f3f6fb;
  --card:#ffffff;
  --muted:#6c757d;
  --radius:18px;
  --shadow:0 20px 40px rgba(0,0,0,.25);
}

*{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Tahoma,Verdana,sans-serif}

body{
  min-height:100vh;
  background:
    linear-gradient(rgba(15,23,42,.55), rgba(15,23,42,.55)),
    url('<?php echo $fondo; ?>') center / cover no-repeat fixed;
  display:flex;
  flex-direction:column;
}

.topbar{
  background:rgba(11,110,253,.95);
  color:#fff;
  display:flex;
  align-items:center;
  justify-content:space-between;
  padding:14px 20px;
  box-shadow:0 4px 16px rgba(0,0,0,.25);
}
.brand{
  display:flex;
  gap:12px;
  align-items:center;
}
.brand img{
  width:44px;height:44px;
  border-radius:12px;
  background:rgba(255,255,255,.15);
  padding:6px;
}
.brand .t1{
  font-size:20px;
  font-weight:950;
}

.wrap{
  flex:1;
  display:flex;
  align-items:center;
  justify-content:center;
  padding:24px;
}

.card{
  width:min(460px,96vw);
  background:rgba(255,255,255,.95);
  backdrop-filter: blur(6px);
  border-radius:var(--radius);
  box-shadow:var(--shadow);
  padding:26px;
}

.card h2{
  font-size:28px;
  font-weight:950;
  margin-bottom:6px;
  color:#111827;
}
.card p{
  color:var(--muted);
  font-size:14px;
  margin-bottom:18px;
  font-weight:800;
}

.alert{
  background:#ffd6d6;
  color:#7a1111;
  padding:12px;
  border-radius:12px;
  font-weight:900;
  margin-bottom:14px;
}

label{
  font-size:13px;
  font-weight:950;
  margin:10px 0 6px;
  display:block;
}

.input{
  width:100%;
  padding:13px 14px;
  border-radius:12px;
  border:1px solid #d6dee8;
  font-weight:800;
}
.input:focus{
  outline:none;
  border-color:var(--blue);
  box-shadow:0 0 0 4px rgba(11,110,253,.15);
}

.btn{
  width:100%;
  margin-top:18px;
  padding:14px;
  border:none;
  border-radius:14px;
  background:var(--blue);
  color:#fff;
  font-size:15px;
  font-weight:950;
  cursor:pointer;
}
.btn:hover{filter:brightness(.97)}

.footer{
  text-align:center;
  padding:14px;
  font-size:12px;
  font-weight:900;
  color:#e5e7eb;
}
</style>
</head>

<body>

<div class="topbar">
  <div class="brand">
    <img src="<?php echo e($logo); ?>" alt="Logo">
    <div class="t1">Control de Asistencia</div>
  </div>
</div>

<div class="wrap">
  <div class="card">
    <h2>Bienvenido</h2>
    <p>Ingresa tus credenciales para continuar.</p>

    <?php if ($err): ?>
      <div class="alert"><?php echo e($err); ?></div>
    <?php endif; ?>

    <form method="POST" action="<?php echo e($ACTION); ?>">
    <?php echo csrfInput(); ?>
      <input type="hidden" name="next" value="<?php echo e($next); ?>">

      <label>Usuario</label>
      <input class="input" type="text" name="usuario" required>

      <label>Clave</label>
      <input class="input" type="password" name="clave" required>

      <button class="btn">Entrar</button>
    </form>
  </div>
</div>

<div class="footer">
  © E.B.N. Dr Enrique Delgado Palacios — Sistema de Control de Asistencia
</div>

</body>
</html>
