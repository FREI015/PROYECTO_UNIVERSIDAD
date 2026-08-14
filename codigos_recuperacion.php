<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";

noCache();
requireLogin();
require_once __DIR__ . "/includes/conexion.php";

$usuarioActualRecuperacion =
  usuarioActual();

$usuarioIdRecuperacion =
  (int)(
    $usuarioActualRecuperacion["id"]
    ?? $_SESSION["usuario_id"]
    ?? 0
  );

if ($usuarioIdRecuperacion <= 0) {
  cerrarSesionUsuarioSistema(
    "Sesion invalida. Inicia sesion nuevamente."
  );
}

$rolRecuperacion =
  strtoupper(
    trim(
      (string)rolActual()
    )
  );

$esCuentaAdministrativaRecuperacion =
  in_array(
    $rolRecuperacion,
    [
      "DIRECTORA",
      "SUBDIRECTOR",
    ],
    true
  );

$msg =
  trim(
    (string)(
      $_GET["msg"]
      ?? ""
    )
  );

$err =
  trim(
    (string)(
      $_GET["err"]
      ?? ""
    )
  );

$stmt =
  $pdo->prepare("
    SELECT COUNT(*)
    FROM usuario_codigos_recuperacion
    WHERE
      usuario_id = ?
      AND usado_en IS NULL
      AND revocado_en IS NULL
  ");

$stmt->execute([
  $usuarioIdRecuperacion
]);

$codigosActivos =
  (int)$stmt->fetchColumn();

$loteGenerado =
  $_SESSION["codigos_recuperacion_generados"]
  ?? null;

unset(
  $_SESSION["codigos_recuperacion_generados"]
);

$codigosMostrar = [];
$creadosEn = "";

if (
  is_array(
    $loteGenerado
  ) &&
  (int)(
    $loteGenerado["usuario_id"]
    ?? 0
  ) === $usuarioIdRecuperacion &&
  is_array(
    $loteGenerado["codigos"]
    ?? null
  )
) {
  $codigosMostrar =
    array_values(
      array_filter(
        $loteGenerado["codigos"],
        static fn($codigo): bool =>
          is_string($codigo) &&
          $codigo !== ""
      )
    );

  $creadosEn =
    (string)(
      $loteGenerado["creados_en"]
      ?? ""
    );
}

$pageTitle =
  "Codigos de recuperacion";

$active =
  "recuperacion";

require_once __DIR__ . "/includes/header.php";
?>

<style>
.recovery-wrap{
  max-width:900px;
  margin:0 auto;
}

.recovery-card{
  padding:22px;
}

.recovery-title{
  margin:0;
  font-size:24px;
  font-weight:950;
  color:#223548;
}

.recovery-sub{
  margin:7px 0 20px;
  color:#64748b;
  line-height:1.55;
  font-size:14px;
  font-weight:650;
}

.recovery-status{
  display:flex;
  gap:14px;
  align-items:center;
  justify-content:space-between;
  padding:15px 17px;
  border:1px solid #dce5ee;
  border-radius:16px;
  background:#f8fafc;
  margin:0 0 18px;
}

.recovery-status strong{
  font-size:20px;
  color:#223548;
}

.recovery-warning{
  margin:16px 0;
  padding:15px 17px;
  border:1px solid #f0c36d;
  border-radius:16px;
  background:#fff8e7;
  color:#5f4b16;
  line-height:1.55;
  font-size:13px;
  font-weight:750;
}

.recovery-codes{
  display:grid;
  grid-template-columns:repeat(2,minmax(0,1fr));
  gap:10px;
  margin:16px 0 22px;
}

.recovery-code{
  display:block;
  padding:13px 14px;
  border:1px solid #dce5ee;
  border-radius:13px;
  background:#f8fafc;
  color:#172033;
  font-family:Consolas,"Courier New",monospace;
  font-size:14px;
  font-weight:850;
  letter-spacing:.3px;
  overflow-wrap:anywhere;
}

.recovery-form{
  margin-top:18px;
  padding-top:20px;
  border-top:1px solid #e6ebf1;
}

.recovery-field label{
  display:block;
  margin:0 0 7px;
  font-size:13px;
  font-weight:850;
}

.recovery-input{
  width:100%;
  max-width:440px;
  min-height:48px;
  padding:0 13px;
  border:1px solid #d6dee8;
  border-radius:13px;
  background:#fff;
  font-size:14px;
}

.recovery-actions{
  margin-top:13px;
}

.recovery-btn{
  border:0;
  border-radius:13px;
  min-height:46px;
  padding:0 18px;
  background:#800020;
  color:#fff;
  font-weight:900;
  cursor:pointer;
}

.recovery-note{
  margin-top:12px;
  color:#64748b;
  font-size:12px;
  line-height:1.5;
}

.recovery-profile-back{
  display:inline-flex;
  align-items:center;
  justify-content:center;
  min-height:42px;
  margin-top:18px;
  padding:8px 14px;
  border:1px solid #d7c1c8;
  border-radius:12px;
  background:#fff;
  color:#800020;
  text-decoration:none;
  font-size:13px;
  font-weight:900;
}

@media(max-width:700px){
  .recovery-codes{
    grid-template-columns:1fr;
  }

  .recovery-status{
    align-items:flex-start;
    flex-direction:column;
  }
}
</style>

<div class="recovery-wrap">

  <div class="card recovery-card">

    <h1 class="recovery-title">
      Codigos de recuperacion
    </h1>

    <p class="recovery-sub">
      Estos codigos permiten recuperar exclusivamente tu propia cuenta
      si olvidas la clave. Guarda el lote en un lugar privado y seguro.
    </p>

    <?php if ($msg !== ""): ?>
      <div class="alert ok">
        <?php echo e($msg); ?>
      </div>
    <?php endif; ?>

    <?php if ($err !== ""): ?>
      <div class="alert bad">
        <?php echo e($err); ?>
      </div>
    <?php endif; ?>

    <div class="recovery-status">
      <span>
        Codigos activos actualmente
      </span>

      <strong data-active-recovery-count>
        <?php echo $codigosActivos; ?>
      </strong>
    </div>

    <?php if ($codigosActivos === 0): ?>

      <div class="recovery-warning">

        <strong>
          Recuperacion no configurada.
        </strong>

        <br>

        <?php if ($esCuentaAdministrativaRecuperacion): ?>

          Esta es una cuenta administrativa.
          Genera y guarda este lote antes de cerrar sesion.
          Por seguridad, otro administrador no puede
          restablecer la clave de esta cuenta administrativa.

        <?php else: ?>

          Genera un lote para poder recuperar tu propia cuenta
          si olvidas la clave.

        <?php endif; ?>

      </div>

    <?php endif; ?>

    <?php if ($codigosMostrar !== []): ?>

      <div class="recovery-warning">
        <strong>
          Guarda estos codigos ahora.
        </strong>
        <br>
        Por seguridad se muestran una sola vez.
        Si pierdes este lote, deberas generar uno nuevo.
        Generar otro lote revoca automaticamente el anterior.
      </div>

      <div
        class="recovery-codes"
        data-recovery-batch
      >
        <?php foreach ($codigosMostrar as $codigo): ?>

          <code
            class="recovery-code"
            data-recovery-code
          ><?php echo e($codigo); ?></code>

        <?php endforeach; ?>
      </div>

      <?php if ($creadosEn !== ""): ?>
        <p class="recovery-note">
          Lote generado:
          <?php echo e($creadosEn); ?>
        </p>
      <?php endif; ?>

    <?php endif; ?>

    <form
      class="recovery-form"
      method="POST"
      action="<?php echo e(BASE_URL); ?>/procesos/codigos_recuperacion_generar.php"
      autocomplete="off"
      onsubmit="return confirm('Generar un nuevo lote? Los codigos activos anteriores dejaran de funcionar.');"
    >

      <?php echo csrfInput(); ?>

      <div class="recovery-field">
        <label for="clave_actual_recuperacion">
          Clave actual
        </label>

        <input
          id="clave_actual_recuperacion"
          class="recovery-input"
          type="password"
          name="clave_actual"
          required
          autocomplete="current-password"
          placeholder="Confirma tu clave actual"
        >
      </div>

      <div class="recovery-actions">
        <button
          class="recovery-btn"
          type="submit"
        >
          <?php echo $codigosActivos > 0
            ? "Regenerar 8 codigos"
            : "Generar 8 codigos"; ?>
        </button>
      </div>

      <p class="recovery-note">
        El sistema no guarda estos codigos en texto plano.
        Solo conserva una version protegida para poder validarlos.
      </p>

    </form>

    <a
      class="recovery-profile-back"
      href="<?php echo e(BASE_URL); ?>/mi_perfil.php"
    >
      Volver a Mi perfil
    </a>

  </div>

</div>

<?php
require_once __DIR__ . "/includes/footer.php";
?>