<?php

$cintilloArchivo =
    __DIR__ .
    "/../assets/img/institucional/cintillo_institucional_final.png";

$cintilloVersion =
    @filemtime($cintilloArchivo)
    ?: 1;

$cintilloFinal =
    BASE_URL .
    "/assets/img/institucional/cintillo_institucional_final.png?v=" .
    (string)$cintilloVersion;

?>

<style>

/* ==========================================================
   BLOQUE 10B1N
   CINTILLO PANORAMICO NATIVO

   Fuente real:
   5015 x 314 px

   Proporcion:
   15.971 : 1

   La propia imagen ya tiene la proporcion correcta.

   Por eso:
   - no usamos cover
   - no usamos contain
   - no usamos height fija
   - no usamos clamp
   - no recortamos
   - no deformamos
   ========================================================== */

.cintillo-final-r6{
  display:block;

  width:100%;
  max-width:none;

  margin:0;
  padding:0;

  background:#ffffff;

  border:0;
  box-shadow:none;

  overflow:hidden;

  line-height:0;
}

.cintillo-final-r6-inner{
  display:block;

  width:100%;
  max-width:none;

  margin:0;
  padding:0;

  background:#ffffff;

  line-height:0;
}

.cintillo-final-r6-img{
  display:block;

  width:100%;
  height:auto;

  max-width:none;

  margin:0;
  padding:0;

  border:0;

  image-rendering:auto;
}

/*
 * El propio ratio panoramico controla la altura:
 *
 * monitor ancho  -> mayor ancho y altura proporcional
 * laptop         -> reduce proporcionalmente
 * tablet         -> reduce proporcionalmente
 * movil          -> reduce proporcionalmente
 *
 * Toda la imagen permanece visible.
 */

.cintillo-final-r6 + .app-topline{
  margin-top:0 !important;
  border-top:0 !important;
}

</style>

<div
  class="cintillo-final-r6"
  role="banner"
  aria-label="Cintillo institucional"
>
  <div class="cintillo-final-r6-inner">

    <img
      class="cintillo-final-r6-img"
      src="<?php echo e($cintilloFinal); ?>"
      alt="Cintillo institucional"
      width="5015"
      height="314"
      loading="eager"
      fetchpriority="high"
    >

  </div>
</div>