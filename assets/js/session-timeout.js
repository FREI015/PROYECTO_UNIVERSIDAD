(function () {
  "use strict";

  var cfg = window.APP_SESSION;

  if (!cfg || !cfg.timeoutMs || !cfg.loginUrl) return;

  var idleMs = Math.max(60000, Number(cfg.timeoutMs) || 300000);
  var heartbeatEveryMs = Math.min(30000, Math.max(5000, Math.floor(idleMs / 20)));
  var lastActivity = Date.now();
  var lastHeartbeat = 0;
  var heartbeatProgramado = null;
  var expired = false;

  var eventos = [
    "mousedown",
    "mousemove",
    "keydown",
    "scroll",
    "touchstart",
    "click",
    "input",
    "change",
    "submit"
  ];

  function enviarLatido() {
    if (expired || !cfg.heartbeatUrl) return;

    var ahora = Date.now();
    var restante = heartbeatEveryMs - (ahora - lastHeartbeat);

    if (restante > 0) {
      if (!heartbeatProgramado) {
        heartbeatProgramado = window.setTimeout(function () {
          heartbeatProgramado = null;
          enviarLatido();
        }, restante);
      }

      return;
    }

    lastHeartbeat = ahora;

    var cuerpo = "csrf_token=" + encodeURIComponent(cfg.csrf || "");

    try {
      fetch(cfg.heartbeatUrl, {
        method: "POST",
        credentials: "same-origin",
        cache: "no-store",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
          "X-Requested-With": "XMLHttpRequest",
          "X-App-Activity": "1"
        },
        body: cuerpo
      }).then(function (respuesta) {
        if (respuesta && respuesta.redirected && respuesta.url.indexOf("/login.php") !== -1) {
          expirar();
        }
      }).catch(function () {});
    } catch (e) {}
  }

  function marcarActividad() {
    if (expired) return;

    lastActivity = Date.now();
    enviarLatido();
  }

  eventos.forEach(function (evento) {
    document.addEventListener(evento, marcarActividad, {
      passive: true,
      capture: true
    });
  });

  function expirar() {
    if (expired) return;

    expired = true;

    if (heartbeatProgramado) {
      window.clearTimeout(heartbeatProgramado);
      heartbeatProgramado = null;
    }

    if (window.AppFeedback && typeof window.AppFeedback.show === "function") {
      window.AppFeedback.show(
        "bad",
        "Tu sesión expiró por inactividad. Inicia sesión nuevamente."
      );

      window.setTimeout(function () {
        window.location.href = cfg.loginUrl;
      }, 1200);

      return;
    }

    window.location.href = cfg.loginUrl;
  }

  window.setInterval(function () {
    if (expired) return;

    if (Date.now() - lastActivity >= idleMs) {
      expirar();
    }
  }, 1000);
})();
