<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";
require_once __DIR__ . "/includes/conexion.php";

date_default_timezone_set("America/Caracas");

$hoy = date("Y-m-d");
$barcode_msg = trim($_GET["barcode_msg"] ?? "");
$barcode_type = trim($_GET["barcode_type"] ?? "");

$ultimos = [];
try {
  $stmt = $pdo->prepare("
    SELECT
      CONCAT(e.nombres, ' ', e.apellidos) AS nombre,
      e.cedula,
      e.codigo_barra,
      a.hora_entrada,
      a.hora_salida,
      a.estado,
      a.minutos_tarde,
      a.horas_trabajadas,
      a.fecha
    FROM asistencias a
    JOIN empleados e ON e.id = a.empleado_id
    WHERE a.fecha = ?
    ORDER BY a.creado_en DESC
    LIMIT 10
  ");
  $stmt->execute([$hoy]);
  $ultimos = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (Throwable $e) {
  $ultimos = [];
}
?><!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Registrar Asistencia - Control de Asistencia</title>
  <style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif}
    body{
      background:linear-gradient(135deg,#0b6efd 0%,#1a4fa0 100%);
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:20px;
    }
    .kiosk{
      background:#ffffff;
      border-radius:32px;
      padding:40px;
      max-width:600px;
      width:100%;
      box-shadow:0 20px 60px rgba(0,0,0,.20);
    }
    .kiosk-header{
      text-align:center;
      margin-bottom:28px;
    }
    .kiosk-logo{
      width:80px;
      height:80px;
      object-fit:contain;
      margin-bottom:12px;
      border-radius:18px;
      background:#f3f6fb;
      padding:10px;
    }
    .kiosk-header h1{
      font-size:22px;
      font-weight:950;
      color:#111827;
      margin-bottom:4px;
    }
    .kiosk-header p{
      color:#6b7280;
      font-size:13px;
    }

    .kiosk-msg{
      padding:14px 16px;
      border-radius:16px;
      font-weight:800;
      font-size:15px;
      margin-bottom:18px;
      text-align:center;
      line-height:1.5;
    }
    .kiosk-msg.success{
      background:#ecfdf3;
      border:1px solid #bfe7d1;
      color:#166534;
    }
    .kiosk-msg.error{
      background:#fee2e2;
      border:1px solid #fecaca;
      color:#991b1b;
    }

    .kiosk-scanner{
      background:#f8fafc;
      border:2px solid #e9edf4;
      border-radius:20px;
      padding:24px;
      margin-bottom:24px;
    }
    .kiosk-scanner label{
      display:block;
      font-size:13px;
      font-weight:900;
      color:#374151;
      margin-bottom:10px;
      text-align:center;
      text-transform:uppercase;
      letter-spacing:.05em;
    }
    .kiosk-input-wrap{
      display:flex;
      gap:10px;
    }
    .kiosk-input{
      flex:1;
      padding:14px 18px;
      border:2px solid #d6dee8;
      border-radius:14px;
      font-size:22px;
      font-weight:800;
      letter-spacing:3px;
      outline:none;
      background:#ffffff;
      color:#111827;
      font-family:'Courier New',monospace;
      text-transform:uppercase;
      transition:border-color .15s ease,box-shadow .15s ease;
    }
    .kiosk-input:focus{
      border-color:#0b6efd;
      box-shadow:0 0 0 4px rgba(11,110,253,.12);
    }
    .kiosk-input::placeholder{
      color:#9ca3af;
      font-size:14px;
      letter-spacing:0;
      text-transform:none;
      font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
    }
    .kiosk-btn{
      padding:14px 24px;
      background:#0b6efd;
      color:#fff;
      border:none;
      border-radius:14px;
      font-weight:900;
      font-size:15px;
      cursor:pointer;
      white-space:nowrap;
      transition:filter .12s ease;
    }
    .kiosk-btn:hover{filter:brightness(1.06)}
    .kiosk-btn:active{filter:brightness(.96)}

    .kiosk-history{
      margin-top:8px;
    }
    .kiosk-history h2{
      font-size:15px;
      font-weight:900;
      color:#374151;
      margin-bottom:12px;
      display:flex;
      align-items:center;
      gap:8px;
    }
    .kiosk-history h2 span{
      font-size:12px;
      font-weight:700;
      color:#9ca3af;
    }
    .kiosk-table{
      width:100%;
      border-collapse:collapse;
    }
    .kiosk-table th{
      text-align:left;
      font-size:11px;
      font-weight:900;
      color:#9ca3af;
      text-transform:uppercase;
      letter-spacing:.04em;
      padding:0 0 8px;
    }
    .kiosk-table td{
      padding:10px 0;
      border-bottom:1px solid #f3f4f6;
      font-size:13px;
      color:#374151;
    }
    .kiosk-table tr:last-child td{border-bottom:none}
    .kiosk-badge{
      display:inline-block;
      padding:3px 8px;
      border-radius:8px;
      font-size:11px;
      font-weight:900;
    }
    .kiosk-badge.ok{background:#dcfce7;color:#166534}
    .kiosk-badge.late{background:#fef3c7;color:#92400e}
    .kiosk-badge.in{background:#dbeafe;color:#1d4ed8}
    .kiosk-badge.out{background:#f3e8ff;color:#6b21a8}

    .kiosk-empty{
      text-align:center;
      color:#9ca3af;
      font-size:13px;
      padding:24px 0;
    }

    .kiosk-back{
      text-align:center;
      margin-top:20px;
    }
    .kiosk-back a{
      display:inline-block;
      padding:12px 14px;
      border-radius:16px;
      border:1px solid #d2c4ad;
      background:#faf7ef;
      color:#334155;
      font-size:13px;
      font-weight:900;
      text-decoration:none;
      transition:background .15s ease, border-color .15s ease;
    }
    .kiosk-back a:hover{
      background:#f3efe3;
      border-color:#c9a24d;
      color:#111827;
    }

    @media(max-width:520px){
      .kiosk{padding:24px 18px}
      .kiosk-input-wrap{flex-direction:column}
      .kiosk-btn{width:100%}
    }
  </style>
</head>
<body>
  <div class="kiosk">
    <div class="kiosk-header">
      <img class="kiosk-logo" src="<?php echo e(BASE_URL); ?>/assets/img/insignia.png" alt="Logo institucional">
      <h1>Registrar Asistencia</h1>
      <p>Escanea tu c&oacute;digo de barras para registrar entrada o salida</p>
    </div>

    <?php if ($barcode_msg): ?>
      <div class="kiosk-msg <?php echo e($barcode_type === 'success' ? 'success' : 'error'); ?>">
        <?php echo e($barcode_msg); ?>
      </div>
    <?php endif; ?>

    <div class="kiosk-scanner">
      <label>C&oacute;digo de Barras</label>
      <form class="kiosk-input-wrap" method="POST" action="<?php echo e(BASE_URL); ?>/procesos/asistencia_barcode.php" id="kioskForm">
        <input type="hidden" name="redirect_to" value="<?php echo e(BASE_URL); ?>/login_empleado.php">
        <input type="text" name="codigo_barra" id="kioskInput" class="kiosk-input"
               placeholder="Escanea o escribe el c&oacute;digo..." autocomplete="off" autofocus inputmode="text">
        <button type="submit" class="kiosk-btn">Registrar</button>
      </form>
    </div>

    <div class="kiosk-history">
      <h2>&Uacute;ltimos registros <span>(hoy)</span></h2>
      <?php if (!$ultimos): ?>
        <div class="kiosk-empty">No hay registros de asistencia hoy.</div>
      <?php else: ?>
        <table class="kiosk-table">
          <thead>
            <tr>
              <th>Empleado</th>
              <th>Entrada</th>
              <th>Salida</th>
              <th>Estado</th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($ultimos as $r): ?>
              <?php
                $estadoClase = "ok";
                $estadoTexto = "A tiempo";
                if (strtoupper($r["estado"] ?? "") === "RETARDO") {
                  $estadoClase = "late";
                  $estadoTexto = "Retardo " . (int)($r["minutos_tarde"] ?? 0) . "min";
                }
              ?>
              <tr>
                <td><strong><?php echo e($r["nombre"] ?? ""); ?></strong></td>
                <td><?php echo e($r["hora_entrada"] ?? "—"); ?></td>
                <td><?php echo e($r["hora_salida"] ?? "—"); ?></td>
                <td><span class="kiosk-badge <?php echo e($estadoClase); ?>"><?php echo e($estadoTexto); ?></span></td>
              </tr>
            <?php endforeach; ?>
          </tbody>
        </table>
      <?php endif; ?>
    </div>

    <div class="kiosk-back">
      <a href="<?php echo e(BASE_URL); ?>/index.php">Volver al inicio</a>
    </div>
  </div>

  <script>
  (function(){
    var input = document.getElementById('kioskInput');
    var form = document.getElementById('kioskForm');
    if (!input || !form) return;

    form.addEventListener('submit', function(){
      var val = input.value.trim();
      if (val === '') {
        input.focus();
        return false;
      }
    });

    input.addEventListener('focus', function(){ this.select(); });

    input.addEventListener('keydown', function(e){
      if (e.key === 'Enter') {
        e.preventDefault();
        form.requestSubmit();
      }
    });

    var params = new URLSearchParams(window.location.search);
    if (params.get('barcode_msg')) {
      input.value = '';
      input.focus();
      if (window.history && window.history.replaceState) {
        var url = new URL(window.location.href);
        url.searchParams.delete('barcode_msg');
        url.searchParams.delete('barcode_type');
        url.searchParams.delete('ok_asistencia');
        url.searchParams.delete('empleado_id');
        url.searchParams.delete('estado');
        url.searchParams.delete('hora');
        url.searchParams.delete('min_tarde');
        window.history.replaceState({}, '', url.toString());
      }
    }
  })();
  </script>
</body>
</html>
