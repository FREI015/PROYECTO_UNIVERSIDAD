<?php

$cintilloFinal = BASE_URL . "/assets/img/institucional/cintillo_institucional_final.jpeg?v=13e-r6";
?>

<style>
  /* ============================================================
   MB13E-R6 - CINTILLO FINAL EN IMAGEN CENTRADO
   ============================================================ */

  .cintillo-final-r6 {
    width: 100%;
    position: relative;
    z-index: 50;
    margin: 0;
    padding: 0;
    background: #ffffff;
    border: 0;
    box-shadow: none;
    overflow: hidden;
    line-height: 0;

    display: flex;
    justify-content: center;
    align-items: center;
  }

  .cintillo-final-r6-inner {
    width: 70%;
    margin: 0 auto;
    padding: 0;
    background: #ffffff;
    line-height: 0;
  }

  .cintillo-final-r6-img {
    display: block;
    width: 70%;
    max-width: none;
    height: auto;
    margin: 0 auto;
    padding: 0;
    object-fit: contain;
    object-position: center center;
    image-rendering: auto;
  }

  /* Evita línea entre cintillo y navegación */
  .cintillo-final-r6+.app-topline {
    margin-top: 0 !important;
    border-top: 0 !important;
  }

  /* FIN MB13E-R6 */
</style>

<div class="cintillo-final-r6" role="banner" aria-label="Cintillo institucional">
  <div class="cintillo-final-r6-inner">
    <img
      class="cintillo-final-r6-img"
      src="<?php echo e($cintilloFinal); ?>"
      alt="Cintillo institucional">
  </div>
</div>
