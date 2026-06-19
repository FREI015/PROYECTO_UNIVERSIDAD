(function () {
  function ready(fn) {
    if (document.readyState !== "loading") {
      fn();
      return;
    }
    document.addEventListener("DOMContentLoaded", fn);
  }

  function injectStyles() {
    if (document.getElementById("appFeedbackStyles")) return;

    var style = document.createElement("style");
    style.id = "appFeedbackStyles";
    style.textContent =
      ".app-feedback-stack{position:fixed;top:18px;right:18px;z-index:9999;display:grid;gap:10px;max-width:360px;width:calc(100% - 36px);pointer-events:none}" +
      ".app-feedback-toast{pointer-events:auto;border-radius:16px;padding:14px 16px;background:#fff;color:#0f172a;border:1px solid rgba(15,23,42,.12);box-shadow:0 18px 40px rgba(15,23,42,.16);display:grid;grid-template-columns:1fr auto;gap:10px;align-items:start;font-size:14px;line-height:1.35;transform:translateY(-8px);opacity:0;transition:opacity .22s ease,transform .22s ease}" +
      ".app-feedback-toast.is-visible{transform:translateY(0);opacity:1}" +
      ".app-feedback-toast.is-ok{border-left:5px solid #16a34a}" +
      ".app-feedback-toast.is-bad{border-left:5px solid #dc2626}" +
      ".app-feedback-toast strong{display:block;margin-bottom:2px;font-size:14px}" +
      ".app-feedback-close{border:0;background:transparent;color:#64748b;font-size:18px;line-height:1;cursor:pointer;padding:0 0 0 8px}" +
      ".app-feedback-working{opacity:.72;cursor:wait!important}";

    document.head.appendChild(style);
  }

  function getStack() {
    var el = document.querySelector(".app-feedback-stack");
    if (el) return el;

    el = document.createElement("div");
    el.className = "app-feedback-stack";
    document.body.appendChild(el);
    return el;
  }

  function showToast(type, message) {
    if (!message) return;

    injectStyles();

    var item = document.createElement("div");
    var isError = type === "bad";

    item.className = "app-feedback-toast " + (isError ? "is-bad" : "is-ok");
    item.setAttribute("role", isError ? "alert" : "status");

    var body = document.createElement("div");
    var title = document.createElement("strong");
    title.textContent = isError ? "Atención" : "Listo";

    var text = document.createElement("div");
    text.textContent = message;

    var close = document.createElement("button");
    close.type = "button";
    close.className = "app-feedback-close";
    close.setAttribute("aria-label", "Cerrar");
    close.textContent = "×";

    body.appendChild(title);
    body.appendChild(text);
    item.appendChild(body);
    item.appendChild(close);

    close.addEventListener("click", function () {
      item.remove();
    });

    getStack().appendChild(item);

    window.setTimeout(function () {
      item.classList.add("is-visible");
    }, 20);

    window.setTimeout(function () {
      item.classList.remove("is-visible");
      window.setTimeout(function () {
        item.remove();
      }, 260);
    }, isError ? 6200 : 4600);
  }

  function readMessages() {
    var ok = document.querySelector(".alert.ok");
    var bad = document.querySelector(".alert.bad");

    if (ok) showToast("ok", ok.textContent.trim());
    if (bad) showToast("bad", bad.textContent.trim());
  }

  function protectForms() {
    var forms = Array.prototype.slice.call(document.querySelectorAll("form"));

    forms.forEach(function (form) {
      var action = String(form.getAttribute("action") || "");
      var isAttendance = action.indexOf("asistencia_entrada.php") !== -1 || action.indexOf("asistencia_salida.php") !== -1;

      if (!isAttendance) return;

      form.addEventListener("submit", function (event) {
        if (form.dataset.enviando === "1") {
          event.preventDefault();
          return;
        }

        form.dataset.enviando = "1";

        var buttons = Array.prototype.slice.call(form.querySelectorAll("button[type='submit'], input[type='submit']"));

        buttons.forEach(function (button) {
          button.classList.add("app-feedback-working");
          button.disabled = true;

          if (button.tagName.toLowerCase() === "button") {
            button.dataset.textoOriginal = button.textContent;
            button.textContent = "Procesando...";
          }
        });
      });
    });
  }

  ready(function () {
    readMessages();
    protectForms();
  });
})();