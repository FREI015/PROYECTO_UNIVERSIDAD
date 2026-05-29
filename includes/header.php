<?php
// includes/header.php
require_once __DIR__ . "/config.php";
require_once __DIR__ . "/funciones.php";

noCache();

$pageTitle = $pageTitle ?? "Módulo";
$active    = $active ?? "";

$usuario = $_SESSION["user"]["usuario"] ?? "Usuario";
$rol     = $_SESSION["user"]["rol"] ?? "—";
$inicial = strtoupper(mb_substr((string)$usuario, 0, 1, "UTF-8"));

$logo = BASE_URL . "/assets/img/logo_institucion.png";
$logoutUrl = BASE_URL . "/procesos/logout.php";
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title><?php echo e($pageTitle); ?> - Control de Asistencia</title>

  <style>
    :root{
      --blue:#0b6efd;
      --dark:#2f343a;
      --bg:#f3f6fb;
      --card:#ffffff;
      --muted:#6c757d;
      --radius:14px;
      --shadow: 0 10px 22px rgba(0,0,0,.06);
      --shadow2: 0 2px 10px rgba(15,23,42,.06);
      --border:#e9edf4;

      --danger:#dc2626;
      --danger2:#b91c1c;
    }

    *{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif}
    body{background:var(--bg);color:#222;min-height:100vh}

    .topbar{
      background:var(--blue);
      color:#fff;
      display:flex;
      align-items:center;
      justify-content:space-between;
      padding:14px 18px;
      box-shadow:0 2px 10px rgba(0,0,0,.10);
    }
    .brand{display:flex;gap:12px;align-items:center}
    .brand img{
      width:42px;height:42px;object-fit:contain;
      background:rgba(255,255,255,.15);
      border-radius:12px;padding:5px
    }
    .brand .t1{font-weight:950;font-size:20px;line-height:1}

    .userbox{
      display:flex;
      align-items:center;
      gap:12px;
    }

    .usercard{
      display:flex;
      align-items:center;
      gap:10px;
      padding:8px 10px;
      border-radius:14px;
      background:rgba(255,255,255,.12);
      border:1px solid rgba(255,255,255,.18);
      box-shadow:0 2px 10px rgba(0,0,0,.08);
    }

    .avatar{
      width:38px;height:38px;border-radius:999px;
      background:rgba(255,255,255,.22);
      display:flex;align-items:center;justify-content:center;
      font-weight:950;
      border:1px solid rgba(255,255,255,.22);
    }

    .uinfo{
      display:flex;
      flex-direction:column;
      line-height:1.1;
      min-width: 140px;
    }
    .uinfo .u{
      font-weight:950;
      font-size:13px;
      letter-spacing:.2px;
    }
    .uinfo .r{
      font-size:11px;
      opacity:.92;
    }

    .btn-salir{
      appearance:none;
      border:none;
      color:#fff;
      font-weight:950;
      border-radius:12px;
      padding:9px 12px;
      cursor:pointer;
      background:linear-gradient(180deg,var(--danger),var(--danger2));
      box-shadow:0 6px 16px rgba(220,38,38,.25);
      display:inline-flex;
      align-items:center;
      gap:8px;
      transition:transform .08s ease, filter .15s ease, box-shadow .15s ease;
      white-space:nowrap;
    }
    .btn-salir:hover{
      filter:brightness(1.03);
      box-shadow:0 8px 18px rgba(220,38,38,.33);
    }
    .btn-salir:active{
      transform:translateY(1px);
    }
    .btn-salir svg{
      width:16px;height:16px;display:block;fill:none;stroke:#fff;stroke-width:2;
      stroke-linecap:round;stroke-linejoin:round;
      opacity:.95;
    }

    .nav{
      background:var(--dark);
      display:flex;
      align-items:center;
      gap:8px;
      padding:10px 12px;
      flex-wrap:wrap;
    }
    .nav a{
      color:#fff;text-decoration:none;
      padding:10px 14px;
      border-radius:12px;
      font-weight:900;font-size:14px;
      opacity:.92;
      display:inline-flex;
      align-items:center;
      justify-content:center;
    }
    .nav a:hover{background:rgba(255,255,255,.08);opacity:1}
    .nav a.active{background:var(--blue);opacity:1}

    .container{
      max-width:1180px;
      margin:18px auto;
      padding:0 14px;
    }

    .card{
      background:var(--card);
      border-radius:var(--radius);
      box-shadow:var(--shadow2);
      padding:16px;
      border:1px solid var(--border);
    }
    .h1{font-size:20px;font-weight:950;margin:0 0 6px}
    .sub{color:var(--muted);margin:0 0 14px;font-size:13px}

    .alert{padding:12px 14px;border-radius:12px;font-weight:900;margin:12px 0}
    .alert.ok{background:#d1f2d8;color:#0a5a1f}
    .alert.bad{background:#ffd6d6;color:#7a1111}

    table{width:100%;border-collapse:collapse;margin-top:10px}
    th,td{padding:12px;border-bottom:1px solid var(--border);text-align:left;font-size:13px;vertical-align:top}
    th{background:#f6f8fc;font-size:12px;font-weight:950}

    .btn{
      padding:10px 14px;border-radius:12px;border:1px solid transparent;
      cursor:pointer;font-weight:900;display:inline-flex;align-items:center;justify-content:center;
      text-decoration:none;
    }
    .btn-primary{background:var(--blue);color:#fff;box-shadow:var(--shadow2)}
    .btn-light{background:#eef2f7;color:#111;border-color:#d6dee8}
  </style>
  <link rel="stylesheet" href="<?php echo e(BASE_URL); ?>/assets/css/app-theme.css?v=1">
</head>
<body>

<?php
  $headerUser = usuarioActual();
  $headerUsuarioNombre = trim((string)($headerUser["usuario"] ?? ($_SESSION["usuario"] ?? "Usuario")));
  $headerRol = rolActual();
  $headerRolesDisponibles = function_exists("rolesUsuarioDisponibles") ? rolesUsuarioDisponibles() : [];
  $headerRolLabel = $headerRolesDisponibles[$headerRol] ?? $headerRol;
  $headerTurnos = turnosPermitidosPorRol();
  if (tieneAlcanceGlobalTurnos()) {
    $headerAlcanceTexto = "Alcance general";
  } elseif ($headerTurnos !== []) {
    $headerAlcanceTexto = "Turno " . implode(", ", $headerTurnos);
  } else {
    $headerAlcanceTexto = "Sin alcance asignado";
  }
  $headerFecha = date("d/m/Y");
?>

<header class="app-topline">
  <div class="app-topline-inner">
    <a class="app-brand" href="<?php echo e(BASE_URL); ?>/index.php" aria-label="Inicio">
      <span class="app-brand-logo">
        <img src="<?php echo e($logo); ?>" alt="Logo institucional">
      </span>
      <span class="app-brand-copy">
        <strong>Control de Asistencia</strong>
        <small>Panel operativo</small>
      </span>
    </a>

    <nav class="app-main-nav" aria-label="Navegacion principal">
      <a class="<?php echo $active==='inicio'?'active':''; ?>" href="<?php echo e(BASE_URL); ?>/index.php">Inicio</a>
      <a class="<?php echo $active==='asistencias'?'active':''; ?>" href="<?php echo e(BASE_URL); ?>/modulos/asistencias.php">Asistencias</a>

      <?php if (puede("ver_permisos")): ?>
        <a class="<?php echo $active==='permisos'?'active':''; ?>" href="<?php echo e(BASE_URL); ?>/modulos/permisos.php">Permisos</a>
      <?php endif; ?>

      <?php if (puede("ver_reposos")): ?>
        <a class="<?php echo $active==='reposos'?'active':''; ?>" href="<?php echo e(BASE_URL); ?>/modulos/reposos.php">Reposos</a>
      <?php endif; ?>

      <?php if (puede("ver_reportes")): ?>
        <a class="<?php echo $active==='reportes'?'active':''; ?>" href="<?php echo e(BASE_URL); ?>/modulos/reportes.php">Reportes</a>
      <?php endif; ?>

      <?php if (puede("ver_personal")): ?>
        <a class="<?php echo $active==='personal'?'active':''; ?>" href="<?php echo e(BASE_URL); ?>/modulos/personal.php">Personal</a>
      <?php endif; ?>

      <?php if (usuarioPuedeAccederModuloUsuarios()): ?>
        <a class="<?php echo $active==='usuarios'?'active':''; ?>" href="<?php echo e(BASE_URL); ?>/modulos/usuarios.php">Usuarios</a>
      <?php endif; ?>
    </nav>

    <div class="app-user-actions">
      <span class="app-user-identity">
        <span class="app-user-role"><?php echo e($headerRolLabel); ?></span>
        <span class="app-user-meta"><?php echo e($headerAlcanceTexto); ?> | <?php echo e($headerFecha); ?></span>
      </span>
      <a class="app-logout" href="<?php echo e($logoutUrl); ?>">Salir</a>
    </div>
  </div>
</header>

<div class="container">



