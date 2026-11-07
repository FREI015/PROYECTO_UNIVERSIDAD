<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";
require_once __DIR__ . "/includes/conexion.php";

date_default_timezone_set("America/Caracas");

$hoy = date("Y-m-d");
$barcode_msg = trim($_GET["barcode_msg"] ?? "");
$barcode_type = trim($_GET["barcode_type"] ?? "");
$okAsistencia = trim($_GET["ok_asistencia"] ?? "");
$okEmpleadoId = (int)($_SESSION["kiosk_ok_empleado_id"] ?? 0);
unset($_SESSION["kiosk_ok_empleado_id"]);
$okEstado = trim($_GET["estado"] ?? "");
$okHora = trim($_GET["hora"] ?? "");
$okMinTarde = (int)($_GET["min_tarde"] ?? 0);
$okSalidaEstado = trim($_GET["salida_estado"] ?? "");
$okMinSalidaTardia = (int)($_GET["min_salida_tardia"] ?? 0);

$okEmpleado = null;

if (
  $barcode_type === "success" &&
  in_array(
    $okAsistencia,
    ["entrada", "salida"],
    true
  ) &&
  $okEmpleadoId > 0
) {
  $stmtOk = $pdo->prepare("
    SELECT
      id,
      nombres,
      apellidos,
      foto_archivo
    FROM empleados
    WHERE id = ?
    LIMIT 1
  ");

  $stmtOk->execute([
    $okEmpleadoId
  ]);

  $okEmpleado =
    $stmtOk->fetch(PDO::FETCH_ASSOC) ?: null;
}

?><!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Control de Asistencia - Kiosco</title>
  <style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif}
    :root{
      --ink:#0f172a;
      --ink-soft:#475569;
      --blue-950:#07142f;
      --blue-900:#0b2a6b;
      --blue-700:#0b4fbf;
      --blue-500:#0b6efd;
      --blue-100:#e8f1ff;
      --line:#dbe5f1;
      --success:#166534;
      --success-bg:#ecfdf3;
      --error:#991b1b;
      --error-bg:#fef2f2;
      --warning:#92400e;
      --warning-bg:#fffbeb;
    }
    body{
      background:linear-gradient(135deg,#0b6efd 0%,#1a4fa0 100%);
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:24px;
      color:var(--ink);
      overflow-x:hidden;
      position:relative;
    }
    .kiosk{
      position:relative;
      z-index:1;
      background:linear-gradient(180deg,#ffffff 0%,#f8fbff 100%);
      border:1px solid rgba(255,255,255,.72);
      border-radius:28px;
      padding:32px 36px 24px;
      max-width:720px;
      width:100%;
      box-shadow:0 30px 80px rgba(2,6,23,.36),inset 0 1px 0 rgba(255,255,255,.7);
    }
    .kiosk-header{
      display:flex;
      align-items:center;
      gap:18px;
      padding-bottom:22px;
      margin-bottom:22px;
      border-bottom:1px solid var(--line);
    }
    .kiosk-logo{
      width:64px;
      height:64px;
      object-fit:contain;
      flex:none;
      border-radius:16px;
      background:var(--blue-100);
      padding:8px;
    }
    .kiosk-header h1{
      font-size:clamp(20px,3vw,28px);
      font-weight:900;
      color:var(--blue-900);
      line-height:1.1;
      letter-spacing:.06em;
    }
    .kiosk-header p{
      color:var(--ink-soft);
      font-size:14px;
      font-weight:600;
      margin-top:5px;
    }

    .kiosk-msg{
      padding:16px 18px;
      border-radius:18px;
      border:1px solid transparent;
      font-weight:800;
      font-size:16px;
      margin-bottom:20px;
      text-align:center;
      line-height:1.45;
      animation:kioskMsgIn .25s ease-out;
    }
    .kiosk-msg.success{
      background:var(--success-bg);
      border-color:#bfe7d1;
      color:var(--success);
    }
    .kiosk-msg.error{
      background:var(--error-bg);
      border-color:#fecaca;
      color:var(--error);
    }
    .kiosk-msg.warning{
      background:var(--warning-bg);
      border-color:#fde68a;
      color:var(--warning);
    }
    .kiosk-msg.info{
      background:#eff6ff;
      border-color:#bfdbfe;
      color:#1e40af;
    }
    .kiosk-msg-detail{
      display:block;
      margin-top:6px;
      font-size:13px;
      font-weight:700;
      line-height:1.4;
    }
    @keyframes kioskMsgIn{
      from{opacity:0;transform:translateY(-6px)}
      to{opacity:1;transform:none}
    }

    .kiosk-person{
      display:flex;
      align-items:center;
      gap:16px;
      padding:16px;
      margin-bottom:18px;
      border-radius:18px;
      background:#f8fafc;
      border:1px solid #e5e7eb;
    }
    .kiosk-person-photo,
    .kiosk-person-photo-empty{
      width:76px;
      height:76px;
      min-width:76px;
      border-radius:50%;
      object-fit:cover;
      border:3px solid #ffffff;
      box-shadow:0 4px 14px rgba(15,23,42,.12);
      background:#e8eef7;
    }
    .kiosk-person-photo-empty{
      display:flex;
      align-items:center;
      justify-content:center;
      font-size:30px;
      font-weight:950;
      color:#1d4ed8;
    }
    .kiosk-person-info{
      min-width:0;
    }
    .kiosk-person-name{
      color:#111827;
      font-size:18px;
      font-weight:950;
      line-height:1.25;
      margin-bottom:5px;
    }
    .kiosk-person-action{
      color:#475569;
      font-size:13px;
      font-weight:800;
      line-height:1.5;
    }
    .kiosk-person-action strong{
      color:#0f172a;
    }
    .kiosk-scan-panel{
      position:relative;
      overflow:hidden;
      text-align:center;
      padding:26px 24px 24px;
      border-radius:24px;
      border:1px solid #cfe0f7;
      background:
        radial-gradient(circle at 50% 0%,rgba(11,110,253,.10),transparent 62%),
        linear-gradient(180deg,#ffffff 0%,#eef6ff 100%);
      box-shadow:inset 0 1px 0 rgba(255,255,255,.85);
      transition:border-color .2s ease,box-shadow .2s ease;
    }
    .kiosk-scan-panel::after{
      content:"";
      position:absolute;
      inset:14px;
      border:1px dashed rgba(11,79,191,.16);
      border-radius:18px;
      pointer-events:none;
    }
    .kiosk.is-processing .kiosk-scan-panel{
      border-color:#7dd3fc;
      box-shadow:0 0 0 4px rgba(14,165,233,.12),inset 0 1px 0 rgba(255,255,255,.85);
    }
    .kiosk-scan-visual{
      width:190px;
      height:145px;
      margin:0 auto 4px;
    }
    .kiosk-scan-icon{
      display:block;
      width:100%;
      height:100%;
      filter:drop-shadow(0 12px 22px rgba(11,79,191,.14));
    }
    .kiosk-scan-beam{
      animation:kioskBeam 2.8s ease-in-out infinite;
    }
    .kiosk.is-processing .kiosk-scan-beam{
      animation-duration:1.1s;
    }
    @keyframes kioskBeam{
      0%,100%{transform:translateY(0)}
      50%{transform:translateY(46px)}
    }
    .kiosk-scan-title{
      max-width:540px;
      margin:0 auto;
      color:var(--blue-900);
      font-size:clamp(18px,2.6vw,23px);
      font-weight:900;
      line-height:1.3;
      letter-spacing:.04em;
    }
    .kiosk-scan-help{
      max-width:430px;
      margin:10px auto 0;
      color:var(--ink-soft);
      font-size:14px;
      font-weight:600;
      line-height:1.5;
    }
    .kiosk-progress{
      display:inline-flex;
      align-items:center;
      gap:9px;
      margin-top:16px;
      padding:9px 14px;
      border-radius:999px;
      background:#e0f2fe;
      color:#075985;
      font-size:13px;
      font-weight:800;
    }
    .kiosk-spinner{
      width:16px;
      height:16px;
      border-radius:50%;
      border:2px solid rgba(3,105,161,.22);
      border-top-color:#0369a1;
      animation:kioskSpin .8s linear infinite;
    }
    @keyframes kioskSpin{
      to{transform:rotate(360deg)}
    }
    .kiosk-capture{
      position:fixed;
      top:0;
      left:0;
      width:1px;
      height:1px;
      overflow:hidden;
      clip-path:inset(50%);
      white-space:nowrap;
      pointer-events:none;
    }
    .kiosk-capture-input{
      width:1px;
      height:1px;
      margin:0;
      padding:0;
      border:0;
      outline:none;
      opacity:0;
      background:transparent;
      color:transparent;
      caret-color:transparent;
    }
    .kiosk-back{
      text-align:center;
      margin-top:20px;
    }
    .kiosk-back a{
      display:inline-block;
      padding:11px 16px;
      border-radius:14px;
      border:1px solid var(--line);
      background:#ffffff;
      color:var(--ink-soft);
      font-size:13px;
      font-weight:800;
      text-decoration:none;
      transition:background .15s ease,border-color .15s ease,color .15s ease;
    }
    .kiosk-back a:hover{
      background:var(--blue-100);
      border-color:#b9d2f5;
      color:var(--blue-900);
    }

    @media(max-width:600px){
      body{padding:14px}
      .kiosk{padding:24px 18px 20px;border-radius:22px}
      .kiosk-header{gap:12px}
      .kiosk-logo{width:52px;height:52px}
      .kiosk-scan-panel{padding:22px 16px}
      .kiosk-scan-visual{width:158px;height:120px}
    }
    @media(prefers-reduced-motion:reduce){
      .kiosk-scan-beam,.kiosk-spinner{animation:none}
      .kiosk-msg{animation:none}
    }
  </style>
</head>
<body>
  <div class="kiosk">
    <div class="kiosk-header">
      <img class="kiosk-logo" src="<?php echo e(BASE_URL); ?>/assets/img/insignia.png" alt="Logo institucional">
      <div>
        <h1>CONTROL DE ASISTENCIA</h1>
        <p>Registro de entrada y salida del personal</p>
      </div>
    </div>

    <?php
      $claseMensaje = "error";

      if ($barcode_type === "success") {
        $claseMensaje = "success";
      } elseif ($barcode_type === "warning") {
        $claseMensaje = "warning";
      } elseif ($barcode_type === "info") {
        $claseMensaje = "info";
      }
    ?>
    <div
      id="kioskMsg"
      class="kiosk-msg <?php echo e($claseMensaje); ?>"
      role="status"
      aria-live="polite"
      <?php echo $barcode_msg === "" ? 'style="display:none"' : ''; ?>
    >
      <span id="kioskMsgText"><?php echo e($barcode_msg); ?></span>
      <span id="kioskMsgDetail" class="kiosk-msg-detail"></span>
    </div>

    <?php if ($okEmpleado): ?>
      <?php
        $okNombre = trim(
          (string)$okEmpleado["nombres"] .
          " " .
          (string)$okEmpleado["apellidos"]
        );

        $okFotoUrl = fotoEmpleadoUrl(
          $okEmpleado["foto_archivo"] ?? null,
          true
        );

        $okInicial = strtoupper(
          substr(
            trim($okNombre),
            0,
            1
          )
        );

        if ($okInicial === "") {
          $okInicial = "—";
        }

        $okAccionTexto =
          $okAsistencia === "salida"
            ? "Salida registrada"
            : "Entrada registrada";

        $okDetalleEstado = "";

        if ($okAsistencia === "entrada") {
          if (
            strtoupper($okEstado) === "RETARDO"
          ) {
            $okDetalleEstado =
              "Retardo: " .
              $okMinTarde .
              " min";
          } else {
            $okDetalleEstado = "A tiempo";
          }
        } elseif ($okSalidaEstado !== "") {
          if (
            $okSalidaEstado ===
            "SALIDA_TARDIA"
          ) {
            $okDetalleEstado =
              "Salida tardía: " .
              $okMinSalidaTardia .
              " min";
          } else {
            $okDetalleEstado =
              str_replace(
                "_",
                " ",
                $okSalidaEstado
              );
          }
        }
      ?>

      <div class="kiosk-person">
        <?php if ($okFotoUrl !== ""): ?>
          <img
            class="kiosk-person-photo"
            src="<?php echo e($okFotoUrl); ?>"
            alt="Foto de <?php echo e($okNombre); ?>"
          >
        <?php else: ?>
          <div class="kiosk-person-photo-empty">
            <?php echo e($okInicial); ?>
          </div>
        <?php endif; ?>

        <div class="kiosk-person-info">
          <div class="kiosk-person-name">
            <?php echo e($okNombre); ?>
          </div>

          <div class="kiosk-person-action">
            <strong>
              <?php echo e($okAccionTexto); ?>
            </strong>

            <?php if ($okHora !== ""): ?>
              · <?php echo e($okHora); ?>
            <?php endif; ?>

            <?php if ($okDetalleEstado !== ""): ?>
              <br>
              <?php echo e($okDetalleEstado); ?>
            <?php endif; ?>
          </div>
        </div>
      </div>
    <?php endif; ?>
    <section class="kiosk-scan-panel" aria-labelledby="kioskScanTitle">
      <div class="kiosk-scan-visual" aria-hidden="true">
        <svg class="kiosk-scan-icon" viewBox="0 0 200 150" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
          <rect x="38" y="26" width="124" height="88" rx="14" fill="#ffffff" stroke="#0b4fbf" stroke-width="3"/>
          <path d="M38 40c0-7.7 6.3-14 14-14h96c7.7 0 14 6.3 14 14v8H38v-8Z" fill="#dbeafe"/>
          <circle cx="66" cy="68" r="13" fill="#bfdbfe"/>
          <path d="M48 94c2-13 9-19 18-19s16 6 18 19" fill="#bfdbfe"/>
          <g fill="#0b2a6b">
            <rect x="98" y="56" width="6" height="38" rx="2"/>
            <rect x="109" y="50" width="3" height="44" rx="1.5"/>
            <rect x="116" y="56" width="7" height="38" rx="2"/>
            <rect x="127" y="52" width="3" height="42" rx="1.5"/>
            <rect x="134" y="58" width="6" height="36" rx="2"/>
            <rect x="144" y="54" width="3" height="40" rx="1.5"/>
          </g>
          <rect x="98" y="98" width="49" height="5" rx="2.5" fill="#93c5fd"/>
          <g class="kiosk-scan-beam">
            <rect x="32" y="38" width="136" height="10" rx="5" fill="#22c55e" opacity=".18"/>
            <rect x="32" y="41" width="136" height="4" rx="2" fill="#22c55e"/>
          </g>
          <path d="M22 52V30h22M178 52V30h-22M22 88v22h22M178 88v22h-22" stroke="#22c55e" stroke-width="4" stroke-linecap="round"/>
        </svg>
      </div>
      <h2 class="kiosk-scan-title" id="kioskScanTitle">ESCANEE SU CARNET PARA REGISTRAR SU ASISTENCIA</h2>
      <p class="kiosk-scan-help">Acerque el carnet al lector; el registro es autom&aacute;tico.</p>
      <div id="kioskProgress" class="kiosk-progress" aria-hidden="true" style="display:none">
        <span class="kiosk-spinner"></span>
        <span>Procesando lectura...</span>
      </div>
    </section>

    <form class="kiosk-capture" method="POST" action="<?php echo e(BASE_URL); ?>/procesos/asistencia_barcode.php" id="kioskForm">
      <?php echo csrfInput(); ?>
      <input type="hidden" name="redirect_to" value="<?php echo e(BASE_URL); ?>/login_empleado.php">
      <input type="text" name="codigo_barra" id="kioskInput" class="kiosk-capture-input"
             aria-label="Receptor del c&oacute;digo de barras" autocomplete="off" autocapitalize="off"
             spellcheck="false" inputmode="none" tabindex="-1" autofocus>
    </form>


    <div class="kiosk-back">
      <a href="<?php echo e(BASE_URL); ?>/index.php">Volver al inicio</a>
    </div>
  </div>

  <script>
  (function(){
    var input = document.getElementById('kioskInput');
    var form = document.getElementById('kioskForm');
    var msgBox = document.getElementById('kioskMsg');
    var msgText = document.getElementById('kioskMsgText');
    var msgDetail = document.getElementById('kioskMsgDetail');
    var personCard = document.querySelector('.kiosk-person');
    var kiosk = document.querySelector('.kiosk');
    var progress = document.getElementById('kioskProgress');

    if (!input || !form) return;

    var endpoint = form.getAttribute('action') || '';
    var tokenEndpoint = endpoint.replace(/asistencia_barcode\.php(?:\?.*)?$/i, 'kiosk_token.php');
    var csrfInput = form.querySelector('input[name="csrf_token"]');
    var cola = [];
    var procesando = false;
    var contador = 0;
    var audioCtx = null;

    function nuevoRequestId() {
      try {
        if (window.crypto && typeof window.crypto.randomUUID === 'function') {
          return window.crypto.randomUUID();
        }
      } catch (e) {}

      contador += 1;
      return 'req-' + Date.now() + '-' + contador + '-' + Math.random().toString(36).slice(2, 10);
    }

    function actualizarToken() {
      if (!tokenEndpoint) return Promise.resolve(false);

      return fetch(tokenEndpoint, {
        method: 'GET',
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Accept': 'application/json'
        },
        credentials: 'same-origin',
        cache: 'no-store'
      }).then(function(resp) {
        return resp.json();
      }).then(function(data) {
        if (data && data.ok && data.csrf_token && csrfInput) {
          csrfInput.value = data.csrf_token;
          return true;
        }

        return false;
      }).catch(function() {
        return false;
      });
    }

    function enfocar() {
      try {
        input.focus({ preventScroll: true });
      } catch (e) {
        input.focus();
      }
    }

    function ocultarTarjetaAnterior() {
      if (personCard) personCard.style.display = 'none';
    }

    function mostrarMensaje(tipo, texto, detalle) {
      if (!msgBox) return;

      msgBox.style.display = '';
      msgBox.className = 'kiosk-msg ' + tipo;

      if (msgText) msgText.textContent = texto || '';
      if (msgDetail) msgDetail.textContent = detalle || '';

      var enProceso = tipo === 'info';

      if (progress) {
        progress.style.display = enProceso ? 'inline-flex' : 'none';
      }

      if (kiosk) {
        kiosk.classList.toggle('is-processing', enProceso);
      }
    }

    function prepararAudio() {
      try {
        if (!audioCtx) {
          var Ctx = window.AudioContext || window.webkitAudioContext;
          if (!Ctx) return;
          audioCtx = new Ctx();
        }
        if (audioCtx.state === 'suspended') audioCtx.resume();
      } catch (e) {}
    }

    function sonar(tipo) {
      try {
        prepararAudio();
        if (!audioCtx) return;

        var frecuencias = tipo === 'success'
          ? [880, 1180]
          : (tipo === 'warning' ? [520] : [220]);

        var duracion = tipo === 'success' ? 0.09 : 0.22;
        var inicio = audioCtx.currentTime;

        frecuencias.forEach(function(freq, i) {
          var osc = audioCtx.createOscillator();
          var gain = audioCtx.createGain();
          var t = inicio + (i * duracion);

          osc.type = 'sine';
          osc.frequency.value = freq;
          gain.gain.setValueAtTime(0.0001, t);
          gain.gain.exponentialRampToValueAtTime(0.10, t + 0.01);
          gain.gain.exponentialRampToValueAtTime(0.0001, t + duracion);

          osc.connect(gain);
          gain.connect(audioCtx.destination);
          osc.start(t);
          osc.stop(t + duracion + 0.02);
        });
      } catch (e) {}
    }

    function codigosDesdeTexto(texto) {
      return String(texto || '')
        .split(/\r?\n/)
        .map(function(c) { return c.trim(); })
        .filter(function(c) { return c !== ''; });
    }

    function encolar(texto) {
      var codigos = codigosDesdeTexto(texto);
      if (!codigos.length) return;

      codigos.forEach(function(codigo) {
        cola.push({
          codigo: codigo,
          requestId: nuevoRequestId(),
          intentos: 0,
          csrfIntentos: 0
        });
      });

      procesarCola();
    }

    function procesarCola() {
      if (procesando || cola.length === 0) return;
      procesando = true;

      Promise.resolve().then(function() {
        return enviarItem(cola.shift());
      }).catch(function() {}).then(function() {
        procesando = false;
        input.value = '';
        enfocar();
        procesarCola();
      });
    }

    function detalleResultado(data) {
      var partes = [];

      if (data.empleado) partes.push(data.empleado);

      if (data.accion === 'entrada') {
        partes.push('ENTRADA' + (data.hora ? ' · ' + data.hora : ''));

        if (data.estado === 'RETARDO') {
          partes.push('Retardo: ' + (parseInt(data.minutos_tarde, 10) || 0) + ' min');
        }
      } else if (data.accion === 'salida') {
        partes.push('SALIDA' + (data.hora ? ' · ' + data.hora : ''));

        if (data.salida_estado === 'SALIDA_TARDIA') {
          partes.push('Salida tardía: ' + (parseInt(data.minutos_salida_tardia, 10) || 0) + ' min');
        } else if (data.salida_estado && data.salida_estado !== 'NORMAL') {
          partes.push(String(data.salida_estado).replace(/_/g, ' '));
        }
      } else if (data.hora) {
        partes.push('Hora: ' + data.hora);
      }

      return partes.join(' · ');
    }

    function enviarItem(item) {
      ocultarTarjetaAnterior();
      mostrarMensaje(
        'info',
        'Procesando lectura...',
        cola.length > 0 ? ('Pendientes en cola: ' + cola.length) : ''
      );

      var datos = new FormData();
      datos.append('csrf_token', csrfInput ? csrfInput.value : '');
      datos.append('codigo_barra', item.codigo);
      datos.append('request_id', item.requestId);

      var controlador = typeof AbortController === 'function' ? new AbortController() : null;
      var temporizador = null;

      if (controlador) {
        temporizador = setTimeout(function() {
          try { controlador.abort(); } catch (e) {}
        }, 10000);
      }

      function finalizarPeticion() {
        if (temporizador) {
          clearTimeout(temporizador);
          temporizador = null;
        }
      }

      return fetch(endpoint, {
        method: 'POST',
        body: datos,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Accept': 'application/json'
        },
        credentials: 'same-origin',
        cache: 'no-store',
        signal: controlador ? controlador.signal : undefined
      }).then(function(resp) {
        return resp.text().then(function(texto) {
          var data = null;

          try {
            data = JSON.parse(texto);
          } catch (e) {}

          if (!data || typeof data !== 'object') {
            throw new Error('Respuesta no válida del servidor.');
          }

          return data;
        });
      }).then(function(data) {
        finalizarPeticion();
        return data;
      }, function(error) {
        finalizarPeticion();
        throw error;
      }).then(function(data) {
        if (data.type === 'csrf' && item.csrfIntentos < 1) {
          item.csrfIntentos += 1;

          return actualizarToken().then(function() {
            return enviarItem(item);
          });
        }

        if (data.ok) {
          mostrarMensaje(
            'success',
            data.message || 'Asistencia registrada correctamente.',
            detalleResultado(data)
          );
          sonar('success');
        } else if (data.type === 'warning') {
          mostrarMensaje(
            'warning',
            data.message || 'Lectura repetida ignorada.',
            ''
          );
          sonar('warning');
        } else {
          mostrarMensaje(
            'error',
            data.message || 'No se pudo registrar la asistencia.',
            ''
          );
          sonar('error');
        }
      }).catch(function() {
        if (item.intentos < 1) {
          item.intentos += 1;

          return new Promise(function(resolve) {
            setTimeout(resolve, 800);
          }).then(function() {
            return enviarItem(item);
          });
        }

        mostrarMensaje(
          'error',
          'Error de conexión con el servidor. Verifica la red e intenta de nuevo.',
          ''
        );
        sonar('error');
      });
    }

    function tomarEntradaActual() {
      var valor = input.value;

      if (String(valor || '').trim() === '') {
        enfocar();
        return;
      }

      input.value = '';
      encolar(valor);
      enfocar();
    }

    form.addEventListener('submit', function(e) {
      e.preventDefault();
      prepararAudio();
      tomarEntradaActual();
    });

    input.addEventListener('keydown', function(e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        prepararAudio();
        tomarEntradaActual();
      }
    });

    input.addEventListener('paste', function(e) {
      var texto = '';

      try {
        texto = (e.clipboardData || window.clipboardData).getData('text') || '';
      } catch (err) {}

      if (/[\r\n]/.test(texto)) {
        e.preventDefault();
        input.value = '';
        encolar(texto);
        enfocar();
      }
    });

    input.addEventListener('focus', function() { this.select(); });

    input.addEventListener('blur', function() {
      setTimeout(function() {
        if (!document.hidden) enfocar();
      }, 80);
    });

    setInterval(function() {
      if (document.activeElement === document.body) enfocar();
    }, 1500);

    setInterval(actualizarToken, 10 * 60 * 1000);

    document.addEventListener('visibilitychange', function() {
      if (!document.hidden) {
        enfocar();
        actualizarToken();
      }
    });

    var params = new URLSearchParams(window.location.search);

    if (params.get('barcode_msg')) {
      if (window.history && window.history.replaceState) {
        var url = new URL(window.location.href);
        url.searchParams.delete('barcode_msg');
        url.searchParams.delete('barcode_type');
        url.searchParams.delete('ok_asistencia');
        url.searchParams.delete('empleado_id');
        url.searchParams.delete('estado');
        url.searchParams.delete('hora');
        url.searchParams.delete('min_tarde');
        url.searchParams.delete('salida_estado');
        url.searchParams.delete('min_salida_tardia');
        window.history.replaceState({}, '', url.toString());
      }
    }

    enfocar();
  })();
  </script>
</body>
</html>
