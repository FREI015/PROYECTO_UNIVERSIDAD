<?php
require_once __DIR__ . "/includes/config.php";
require_once __DIR__ . "/includes/funciones.php";

noCache();
requireLogin();

require_once __DIR__ . "/includes/conexion.php";

$usuarioSesion =
  usuarioActual();

$usuarioId =
  (int)(
    $usuarioSesion["id"]
    ?? $_SESSION["usuario_id"]
    ?? 0
  );

if ($usuarioId <= 0) {

  cerrarSesionUsuarioSistema(
    "Sesion invalida. Inicia sesion nuevamente."
  );
}

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
    SELECT
      id,
      usuario,
      rol,
      estado,
      debe_cambiar_clave,
      version_sesion,
      clave_actualizada_en
    FROM usuarios
    WHERE id = ?
    LIMIT 1
  ");

$stmt->execute([
  $usuarioId
]);

$perfil =
  $stmt->fetch(
    PDO::FETCH_ASSOC
  );

if (!$perfil) {

  cerrarSesionUsuarioSistema(
    "La cuenta ya no esta disponible."
  );
}

$estado =
  strtoupper(
    trim(
      (string)(
        $perfil["estado"]
        ?? ""
      )
    )
  );

if ($estado !== "ACTIVO") {

  cerrarSesionUsuarioSistema(
    "Usuario inactivo."
  );
}

if (
  (int)(
    $perfil["debe_cambiar_clave"]
    ?? 0
  ) === 1
) {

  go(
    BASE_URL .
    "/cambiar_clave_obligatoria.php"
  );
}

$rol =
  strtoupper(
    trim(
      (string)(
        $perfil["rol"]
        ?? ""
      )
    )
  );

$roles =
  rolesUsuarioDisponibles();

$rolLabel =
  $roles[$rol]
  ?? $rol;

$esAdministrativo =
  in_array(
    $rol,
    [
      "DIRECTORA",
      "SUBDIRECTOR",
    ],
    true
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
  $usuarioId
]);

$codigosActivos =
  (int)$stmt->fetchColumn();

$recuperacionConfigurada =
  $codigosActivos > 0;

$claveActualizada =
  trim(
    (string)(
      $perfil["clave_actualizada_en"]
      ?? ""
    )
  );

if ($claveActualizada === "") {

  $claveActualizadaTexto =
    "Sin cambios registrados";

} else {

  $timestamp =
    strtotime(
      $claveActualizada
    );

  $claveActualizadaTexto =
    $timestamp !== false
      ? date(
          "d/m/Y H:i",
          $timestamp
        )
      : $claveActualizada;
}

$pageTitle =
  "Mi perfil";

$active =
  "perfil";

require_once __DIR__ . "/includes/header.php";
?>

<style>

.profile-wrap{
  width:min(100%,1040px);
  margin:0 auto;
}

.profile-heading{
  margin-bottom:18px;
}

.profile-heading h1{
  margin:0;
  color:var(--primary-strong);
  font-size:26px;
  font-weight:950;
}

.profile-heading p{
  margin:7px 0 0;
  color:var(--text-muted);
  line-height:1.5;
}

.profile-grid{
  display:grid;
  grid-template-columns:
    repeat(2,minmax(0,1fr));
  gap:16px;
}

.profile-card{
  padding:20px;
  background:#fff;
  border:1px solid var(--border);
  border-radius:18px;
  box-shadow:
    0 8px 22px
    rgba(38,53,72,.055);
}

.profile-card-wide{
  grid-column:1 / -1;
}

.profile-card h2{
  margin:0 0 15px;
  color:var(--primary-strong);
  font-size:17px;
  font-weight:950;
}

.profile-data{
  display:grid;
  gap:10px;
}

.profile-item{
  padding:13px 14px;
  background:#f8fafc;
  border:1px solid #e0e7ef;
  border-radius:13px;
}

.profile-label{
  display:block;
  color:var(--text-muted);
  font-size:11px;
  font-weight:850;
  text-transform:uppercase;
  letter-spacing:.04em;
}

.profile-value{
  display:block;
  margin-top:5px;
  color:var(--text);
  font-size:14px;
  font-weight:900;
  overflow-wrap:anywhere;
}

.profile-actions{
  display:flex;
  gap:9px;
  flex-wrap:wrap;
  margin-top:15px;
}

.profile-action{
  display:inline-flex;
  align-items:center;
  justify-content:center;
  min-height:42px;
  padding:9px 14px;
  border:1px solid #d7c1c8;
  border-radius:12px;
  background:var(--primary-soft);
  color:var(--primary-strong);
  text-decoration:none;
  font-size:13px;
  font-weight:900;
}

.profile-security-note{
  margin:12px 0 0;
  padding:14px;
  border-radius:13px;
  background:#f8fafc;
  border:1px solid #e0e7ef;
  color:var(--text-muted);
  font-size:13px;
  line-height:1.55;
}

.profile-recovery-state{
  margin:0 0 14px;
  padding:14px 15px;
  border-radius:14px;
  font-size:13px;
  line-height:1.5;
  font-weight:750;
}

.profile-recovery-state strong{
  display:block;
  margin-bottom:4px;
}

.profile-recovery-state.ok{
  background:#edf8f2;
  border:1px solid #b9dfc9;
  color:#24623e;
}

.profile-recovery-state.bad{
  background:#fff4e8;
  border:1px solid #e7bf82;
  color:#6f4815;
}

.profile-recovery-state.critical{
  background:#fff0f1;
  border:1px solid #e4a8af;
  color:#7d1f2d;
}

.profile-password-form{
  display:grid;
  grid-template-columns:
    repeat(3,minmax(0,1fr));
  gap:14px;
  margin-top:5px;
}

.profile-field label{
  display:block;
  margin:0 0 7px;
  color:var(--text);
  font-size:12px;
  font-weight:900;
}

.profile-input{
  width:100%;
  min-height:46px;
  padding:0 12px;
  border:1px solid #d6dee8;
  border-radius:12px;
  background:#fff;
  color:var(--text);
  font-size:14px;
  outline:none;
}

.profile-input:focus{
  border-color:var(--primary);
  box-shadow:
    0 0 0 3px
    rgba(128,0,32,.08);
}

.profile-form-actions{
  grid-column:1 / -1;
  display:flex;
  align-items:center;
  gap:12px;
  flex-wrap:wrap;
  margin-top:2px;
}

.profile-submit{
  min-height:44px;
  padding:9px 17px;
  border:0;
  border-radius:12px;
  background:var(--primary);
  color:#fff;
  font-size:13px;
  font-weight:950;
  cursor:pointer;
}

.profile-password-help{
  margin:0;
  color:var(--text-muted);
  font-size:12px;
  line-height:1.5;
}

@media(max-width:820px){

  .profile-password-form{
    grid-template-columns:1fr;
  }

  .profile-form-actions{
    grid-column:1;
  }
}

@media(max-width:760px){

  .profile-grid{
    grid-template-columns:1fr;
  }

  .profile-card-wide{
    grid-column:1;
  }
}

</style>

<div class="profile-wrap">

  <div class="profile-heading">

    <h1>
      Mi perfil
    </h1>

    <p>
      Datos y seguridad de tu propia cuenta de acceso.
    </p>

  </div>

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

  <div class="profile-grid">

    <section class="profile-card">

      <h2>
        Datos de mi cuenta
      </h2>

      <div class="profile-data">

        <div class="profile-item">

          <span class="profile-label">
            Usuario
          </span>

          <span class="profile-value">
            <?php echo e($perfil["usuario"]); ?>
          </span>

        </div>

        <div class="profile-item">

          <span class="profile-label">
            Rol
          </span>

          <span class="profile-value">
            <?php echo e($rolLabel); ?>
          </span>

        </div>

        <div class="profile-item">

          <span class="profile-label">
            Estado
          </span>

          <span class="profile-value">
            <?php echo e($perfil["estado"]); ?>
          </span>

        </div>

        <div class="profile-item">

          <span class="profile-label">
            Ultima actualizacion de clave
          </span>

          <span class="profile-value">
            <?php echo e($claveActualizadaTexto); ?>
          </span>

        </div>

      </div>

    </section>

    <section class="profile-card">

      <h2>
        Recuperacion de cuenta
      </h2>

      <?php if ($recuperacionConfigurada): ?>

        <div class="profile-recovery-state ok">

          <strong>
            Recuperacion configurada
          </strong>

          Tienes
          <?php echo e((string)$codigosActivos); ?>
          codigos activos de un solo uso.

        </div>

      <?php elseif ($esAdministrativo): ?>

        <div class="profile-recovery-state critical">

          <strong>
            Recuperacion no configurada
          </strong>

          Esta cuenta administrativa tiene 0 codigos activos.
          Genera y guarda tu lote antes de cerrar sesion.
          Por seguridad, otro administrador no puede
          restablecer la clave de esta cuenta administrativa.

        </div>

      <?php else: ?>

        <div class="profile-recovery-state bad">

          <strong>
            Recuperacion no configurada
          </strong>

          Tienes 0 codigos activos.
          Genera un lote para poder recuperar tu propia cuenta
          si olvidas la clave.

        </div>

      <?php endif; ?>

      <div class="profile-item">

        <span class="profile-label">
          Codigos de recuperacion activos
        </span>

        <span class="profile-value">
          <?php echo e((string)$codigosActivos); ?>
        </span>

      </div>

      <p class="profile-security-note">

        Los codigos son personales y de un solo uso.
        El sistema almacena solamente una version protegida
        y el lote en texto visible se muestra una sola vez
        al generarlo.

      </p>

      <div class="profile-actions">

        <a
          class="profile-action"
          href="<?php echo e(BASE_URL); ?>/codigos_recuperacion.php"
        >
          <?php echo $codigosActivos > 0
            ? "Administrar codigos"
            : "Configurar recuperacion"; ?>
        </a>

      </div>

    </section>

    <section class="profile-card profile-card-wide">

      <h2>
        Cambiar mi clave
      </h2>

      <form
        class="profile-password-form"
        method="POST"
        action="<?php echo e(BASE_URL); ?>/procesos/mi_perfil_clave.php"
        autocomplete="off"
      >

        <?php echo csrfInput(); ?>

        <div class="profile-field">

          <label for="perfil_clave_actual">
            Clave actual
          </label>

          <input
            id="perfil_clave_actual"
            class="profile-input"
            type="password"
            name="clave_actual"
            required
            autocomplete="current-password"
          >

        </div>

        <div class="profile-field">

          <label for="perfil_clave_nueva">
            Nueva clave
          </label>

          <input
            id="perfil_clave_nueva"
            class="profile-input"
            type="password"
            name="clave_nueva"
            minlength="10"
            required
            autocomplete="new-password"
          >

        </div>

        <div class="profile-field">

          <label for="perfil_clave_confirmar">
            Confirmar nueva clave
          </label>

          <input
            id="perfil_clave_confirmar"
            class="profile-input"
            type="password"
            name="clave_confirmar"
            minlength="10"
            required
            autocomplete="new-password"
          >

        </div>

        <div class="profile-form-actions">

          <button
            class="profile-submit"
            type="submit"
          >
            Actualizar mi clave
          </button>

          <p class="profile-password-help">

            Minimo 10 caracteres, con mayuscula,
            minuscula y numero.
            El cambio invalida las otras sesiones abiertas
            de tu cuenta y mantiene activa esta sesion.

          </p>

        </div>

      </form>

    </section>

  </div>

</div>

<?php
require_once __DIR__ . "/includes/footer.php";
?>