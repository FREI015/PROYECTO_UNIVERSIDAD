(function () {
  "use strict";

  var MENSAJE = "Este campo es obligatorio.";

  function ready(fn) {
    if (document.readyState !== "loading") {
      fn();
      return;
    }
    document.addEventListener("DOMContentLoaded", fn);
  }

  function esRequerido(control) {
    return control instanceof HTMLInputElement ||
      control instanceof HTMLSelectElement ||
      control instanceof HTMLTextAreaElement;
  }

  function labelDe(control) {
    var parent = control.closest(".field");
    if (parent) {
      var label = parent.querySelector("label");
      if (label) return label;
    }

    if (control.id && typeof CSS !== "undefined" && CSS.escape) {
      var porFor = document.querySelector("label[for='" + CSS.escape(control.id) + "']");
      if (porFor) return porFor;
    }

    if (control.labels && control.labels.length > 0) {
      return control.labels[0];
    }

    if (control.parentElement) {
      var hermano = control.parentElement.querySelector("label");
      if (hermano) return hermano;
    }

    return null;
  }

  function marcarRequeridos() {
    var controles = Array.prototype.slice.call(
      document.querySelectorAll("input[required], select[required], textarea[required]")
    );

    controles.forEach(function (control) {
      if (!esRequerido(control)) return;
      if (control.dataset.reqMarked === "1") return;

      control.dataset.reqMarked = "1";

      var label = labelDe(control);
      if (label && !/\*/.test(label.textContent || "")) {
        label.classList.add("req");
      }

      control.addEventListener("invalid", function () {
        if (control.validity && control.validity.valueMissing) {
          control.setCustomValidity(MENSAJE);
        }
      });

      ["input", "change"].forEach(function (evt) {
        control.addEventListener(evt, function () {
          control.setCustomValidity("");
        });
      });
    });
  }

  ready(marcarRequeridos);
})();
