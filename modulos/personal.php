
<?php
require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";

requireLogin();
requirePermiso("ver_personal", BASE_URL . "/index.php");

require_once __DIR__ . "/../includes/conexion.php";

$turnosPermitidos = turnosPermitidosPorRol();
$tieneAlcanceGlobal = tieneAlcanceGlobalTurnos();
$puedeCrearPersonal = puede("crear_personal");
$puedeEditarPersonal = puede("editar_personal");
$puedeCambiarEstadoPersonal = puede("cambiar_estado_personal");
$turnoIdsPermitidos = [];

$msg = isset($_GET["msg"]) && is_string($_GET["msg"])
    ? substr(trim($_GET["msg"]), 0, 300) : "";

$err = isset($_GET["err"]) && is_string($_GET["err"])
    ? substr(trim($_GET["err"]), 0, 300) : "";

$okPersonal = isset($_GET["ok_personal"]) && is_string($_GET["ok_personal"])
    ? trim($_GET["ok_personal"]) : "";

$okEmpleadoId = filter_var(
    $_GET["empleado_id"] ?? null,
    FILTER_VALIDATE_INT,
    ["options" => ["min_range" => 1]]
);

$okEmpleadoId = $okEmpleadoId === false ? 0 : $okEmpleadoId;
$okEmpleado = null;

if ($okPersonal !== "" && $okEmpleadoId > 0) {

    $sqlOk = "
        SELECT
            e.id,
            CONCAT(e.nombres, ' ', e.apellidos) AS nombre,
            e.cedula,
            e.estado,
            e.foto_archivo,
            e.codigo_barra,
            c.nombre AS cargo,
            t.nombre AS turno
        FROM empleados e
        LEFT JOIN cargos c ON c.id = e.cargo_id
        LEFT JOIN turnos t ON t.id = e.turno_id
        WHERE e.id = ?
    ";

    $paramsOk = [$okEmpleadoId];

    if (!$tieneAlcanceGlobal) {

        $nombresTurno = is_array($turnosPermitidos)
            ? array_values(
                array_unique(
                    array_filter(
                        array_map(
                            static fn($t) => is_string($t)
                                ? strtoupper(trim($t))
                                : "",
                            $turnosPermitidos
                        )
                    )
                )
            )
            : [];

        if (!$nombresTurno) {

            $sqlOk .= " AND 1 = 0";

        } else {

            $marca = implode(
                ",",
                array_fill(0, count($nombresTurno), "?")
            );

            $sqlOk .= " AND UPPER(TRIM(t.nombre)) IN ($marca)";

            array_push($paramsOk, ...$nombresTurno);
        }
    }

    $stOk = $pdo->prepare($sqlOk . " LIMIT 1");
    $stOk->execute($paramsOk);

    $okEmpleado = $stOk->fetch(PDO::FETCH_ASSOC) ?: null;
}

$paginaValor = $_GET["pagina"] ?? 1;

$pagina = is_string($paginaValor) || is_int($paginaValor)
    ? filter_var(
        $paginaValor,
        FILTER_VALIDATE_INT,
        [
            "options" => [
                "min_range" => 1,
                "max_range" => 1000000
            ]
        ]
    )
    : false;

$pagina = $pagina === false ? 1 : $pagina;

$ordenValor = $_GET["orden"] ?? "";

$orden = is_string($ordenValor) &&
    in_array($ordenValor, ["jerarquia", "alfabetico"], true)
    ? $ordenValor
    : "";

$filtroValor = $_GET["filtro"] ?? "";

$filtroEstado = is_string($filtroValor) &&
    in_array(
        $filtroValor,
        ["ACTIVO", "SUSPENDIDO", "RETIRADO"],
        true
    )
    ? $filtroValor
    : "";

$porPagina = 10;

$cargos = $pdo->query(
    "SELECT id, nombre FROM cargos ORDER BY nombre"
)->fetchAll(PDO::FETCH_ASSOC);

if ($tieneAlcanceGlobal) {

    $turnos = $pdo->query(
        "SELECT id, nombre FROM turnos ORDER BY id"
    )->fetchAll(PDO::FETCH_ASSOC);

} else {

    $turnosPermitidos = is_array($turnosPermitidos)
        ? array_values(
            array_unique(
                array_filter(
                    array_map(
                        static fn($t) => is_string($t)
                            ? strtoupper(trim($t))
                            : "",
                        $turnosPermitidos
                    )
                )
            )
        )
        : [];

    if (!$turnosPermitidos) {

        $turnos = [];

    } else {

        $marca = implode(
            ",",
            array_fill(0, count($turnosPermitidos), "?")
        );

        $stTurnos = $pdo->prepare(
            "SELECT id, nombre
             FROM turnos
             WHERE UPPER(TRIM(nombre)) IN ($marca)
             ORDER BY id"
        );

        $stTurnos->execute($turnosPermitidos);

        $turnos = $stTurnos->fetchAll(PDO::FETCH_ASSOC);
    }

    $turnoIdsPermitidos = array_map(
        "intval",
        array_column($turnos, "id")
    );
}

$condiciones = [];
$paramsTotal = [];

if ($filtroEstado !== "") {

    $condiciones[] = "e.estado = ?";
    $paramsTotal[] = $filtroEstado;
}

if (!$tieneAlcanceGlobal) {

    if (!$turnoIdsPermitidos) {

        $condiciones[] = "1 = 0";

    } else {

        $marca = implode(
            ",",
            array_fill(0, count($turnoIdsPermitidos), "?")
        );

        $condiciones[] = "e.turno_id IN ($marca)";

        array_push($paramsTotal, ...$turnoIdsPermitidos);
    }
}

$whereEstado = $condiciones
    ? " WHERE " . implode(" AND ", $condiciones)
    : "";

$stTotal = $pdo->prepare(
    "SELECT COUNT(*) FROM empleados e" . $whereEstado
);

$stTotal->execute($paramsTotal);

$totalPersonal = (int)$stTotal->fetchColumn();

$totalPaginas = (int)ceil($totalPersonal / $porPagina);

$pagina = min($pagina, max(1, $totalPaginas));

$offset = ($pagina - 1) * $porPagina;

$ordenes = [
    "" => "ORDER BY e.apellidos, e.nombres, e.id",
    "jerarquia" => "ORDER BY c.nombre, e.apellidos, e.nombres, e.id",
    "alfabetico" => "ORDER BY e.nombres, e.apellidos, e.id"
];

$orderClause = $ordenes[$orden];

$personalStmt = $pdo->prepare("
    SELECT
        e.id,
        e.cedula,
        e.estado,
        e.codigo_barra,
        e.nombres,
        e.apellidos,
        e.cargo_id,
        e.turno_id,
        e.foto_archivo,
        CONCAT(TRIM(e.nombres), ' ', TRIM(e.apellidos)) AS nombre,
        c.nombre AS cargo,
        t.nombre AS turno
    FROM empleados e
    LEFT JOIN cargos c ON c.id = e.cargo_id
    LEFT JOIN turnos t ON t.id = e.turno_id
    $whereEstado
    $orderClause
    LIMIT $porPagina OFFSET $offset
");

$personalStmt->execute($paramsTotal);

$personal = $personalStmt->fetchAll(PDO::FETCH_ASSOC);

$mostrandoInicio = $totalPersonal > 0
    ? $offset + 1
    : 0;

$mostrandoFin = $totalPersonal > 0
    ? min($offset + $porPagina, $totalPersonal)
    : 0;

function personalListadoUrl(
    int $paginaNueva,
    string $ordenNuevo,
    string $filtroNuevo
): string {

    $q = ["pagina" => max(1, $paginaNueva)];

    if ($ordenNuevo !== "") {
        $q["orden"] = $ordenNuevo;
    }

    if ($filtroNuevo !== "") {
        $q["filtro"] = $filtroNuevo;
    }

    return rtrim(BASE_URL, "/") .
        "/modulos/personal.php?" .
        http_build_query($q, "", "&", PHP_QUERY_RFC3986);
}

function personalFotoSegura($foto): string {

    if (
        !is_string($foto) ||
        strlen($foto) > 255 ||
        str_contains($foto, "..") ||
        str_contains($foto, "\\") ||
        !preg_match(
            '~\A[a-zA-Z0-9_./-]+\.(?:jpe?g|png|webp)\z~i',
            $foto
        )
    ) {
        return "";
    }

    return fotoEmpleadoUrl($foto);
}

$pageTitle = "Personal del Plantel";
$active = "personal";

require_once __DIR__ . "/../includes/header.php";
?>

<style>
.pers-wrap{
    max-width:1180px;
    margin:0 auto;
}

.pers-card{
    padding:18px;
}

.pers-title{
    font-size:22px;
    font-weight:850;
    margin:0 0 6px;
}

.pers-sub{
    margin:0 0 14px;
    color:#6c757d;
    font-size:13px;
    font-weight:600;
    line-height:1.35;
}

.personal-success-card{
    display:flex;
    align-items:center;
    gap:14px;
    padding:14px 16px;
    border:1px solid #bfe7d1;
    background:#ecfdf3;
    border-radius:18px;
    margin:12px 0 16px;
}

.personal-success-card .success-title{
    font-weight:900;
    color:#166534;
    margin-bottom:4px;
}

.personal-success-card .success-meta{
    color:#334155;
    font-size:13px;
    line-height:1.45;
}

.personal-photo{
    width:54px;
    height:54px;
    border-radius:50%;
    object-fit:cover;
    border:1px solid #dbe4ef;
    background:#f3f6fb;
    flex:0 0 auto;
}

.personal-photo-empty{
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:900;
    color:#334155;
    font-size:18px;
}

.pers-form{
    background:#fff;
    border:1px solid #e9edf4;
    border-radius:14px;
    padding:14px;
    max-width:860px;
    margin:0 auto;
}

.grid4{
    display:grid;
    grid-template-columns:repeat(4,minmax(0,1fr));
    gap:12px;
    align-items:end;
}

.field label{
    display:block;
    font-size:12px;
    font-weight:650;
    margin:0 0 6px;
    color:#111827;
}

.input,.select{
    width:100%;
    box-sizing:border-box;
    padding:10px 12px;
    border:1px solid #d6dee8;
    border-radius:12px;
    outline:none;
    background:#fff;
    font-weight:600;
    color:#111827;
}

.input:focus,.select:focus{
    border-color:rgba(11,110,253,.45);
    box-shadow:0 0 0 4px rgba(11,110,253,.10);
}

.span4{
    grid-column:1/-1;
}

.span2{
    grid-column:span 2;
}

.actions-row{
    display:flex;
    justify-content:flex-end;
    gap:10px;
    margin-top:12px;
}

.btn-primary{
    background:#0b6efd;
    color:#fff;
    border:none;
    padding:10px 14px;
    border-radius:12px;
    cursor:pointer;
    font-weight:750;
    box-shadow:0 2px 10px rgba(15,23,42,.06);
}

.btn-primary:hover{
    filter:brightness(.98);
}

.btn-light{
    background:#eef2f7;
    color:#111827;
    border:1px solid #d6dee8;
    padding:10px 14px;
    border-radius:12px;
    cursor:pointer;
    font-weight:700;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    justify-content:center;
}

.table-card{
    margin-top:14px;
    padding:18px;
}

.table-title{
    font-size:18px;
    font-weight:850;
    margin:0 0 4px;
}

.table-sub{
    margin:0 0 10px;
    color:#6c757d;
    font-size:13px;
    font-weight:600;
}

table th{
    font-weight:700!important;
    font-size:12px;
}

.personal-table-scroll{
    width:100%;
    overflow-x:auto;
}

.personal-table-modern{
    width:100%;
    table-layout:auto;
}

.personal-table-modern thead th{
    text-align:left;
    white-space:normal;
    line-height:1.25;
}

.personal-table-modern th,
.personal-table-modern td{
    padding:13px 12px;
}

.personal-table-modern tbody td{
    vertical-align:middle;
    word-break:break-word;
    overflow-wrap:break-word;
}

.personal-table-modern tbody td:last-child{
    white-space:nowrap;
}

.actions-personal{
    display:inline-flex;
    gap:6px;
    flex-wrap:nowrap;
    margin:0;
    vertical-align:middle;
}

.personal-table-modern .btn-editar{
    vertical-align:middle;
    margin-left:2px;
}

.btn-action{
    border:1px solid #d6dee8;
    background:#fff;
    padding:8px 10px;
    border-radius:10px;
    cursor:pointer;
    font-weight:700;
    font-size:12px;
}

.btn-activar{
    background:#dcfce7;
    border-color:#bbf7d0;
    color:#166534;
}

.btn-suspender{
    background:#fef3c7;
    border-color:#fde68a;
    color:#92400e;
}

.btn-retirar{
    background:#fee2e2;
    border-color:#fecaca;
    color:#991b1b;
}

.btn-editar{
    background:#e0f2fe;
    border-color:#bae6fd;
    color:#075985;
}

.modal-overlay{
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.5);
    display:none;
    align-items:center;
    justify-content:center;
    z-index:9999;
}

.modal-overlay.show{
    display:flex;
}

.modal-box{
    background:#fff;
    border-radius:16px;
    padding:24px;
    max-width:760px;
    width:94%;
    box-shadow:0 10px 40px rgba(0,0,0,.2);
    max-height:92vh;
    overflow-y:auto;
}

.modal-box h3{
    margin:0 0 4px;
    font-size:19px;
}

.modal-sub{
    color:#6b7280;
    font-size:13px;
    margin:0 0 16px;
}

.modal-actions{
    display:flex;
    gap:10px;
    justify-content:flex-end;
    margin-top:18px;
}

.modal-actions .btn-primary{
    background:#800020;
    color:#fff;
    border:0;
    padding:10px 18px;
    border-radius:11px;
    font-weight:800;
    cursor:pointer;
}

.modal-actions .btn-light{
    background:#f1f5f9;
    border:1px solid #d6dee8;
    color:#334155;
    padding:10px 18px;
    border-radius:11px;
    font-weight:700;
    cursor:pointer;
}

.edit-preview{
    width:64px;
    height:64px;
    border-radius:14px;
    object-fit:cover;
    border:1px solid #d6dee8;
    margin-bottom:8px;
}

.status-suspended{
    background:#fef3c7;
    color:#92400e;
}

.status-retired{
    background:#fee2e2;
    color:#991b1b;
}

.pagination{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-top:14px;
    padding-top:14px;
    border-top:1px solid #e5e7eb;
}

.pagination-info{
    color:#6b7280;
    font-size:13px;
    font-weight:900;
}

.pagination-pages{
    display:flex;
    gap:6px;
}

.pagination-pages a,
.pagination-pages span{
    padding:8px 14px;
    border-radius:10px;
    text-decoration:none;
    font-weight:900;
    font-size:13px;
    display:inline-flex;
    align-items:center;
}

.pagination-pages a{
    background:#f1f5f9;
    color:#111;
}

.pagination-pages a:hover{
    background:#e2e8f0;
}

.pagination-pages .current{
    background:#0b6fe6;
    color:#fff;
}

.pagination-pages .disabled{
    opacity:.4;
    pointer-events:none;
}

@media(max-width:980px){
    .pers-form{
        max-width:100%;
    }

    .grid4{
        grid-template-columns:1fr 1fr;
    }

    .span2,.span4{
        grid-column:span 2;
    }
}

@media(max-width:640px){
    .grid4{
        grid-template-columns:1fr;
    }

    .span2,.span4{
        grid-column:span 1;
    }

    .actions-row{
        justify-content:stretch;
    }

    .actions-row .btn-primary,
    .actions-row .btn-light{
        width:100%;
    }

    .personal-table-modern tbody td:last-child{
        white-space:normal;
    }

    .actions-personal{
        flex-wrap:wrap;
    }
}
</style>

<div class="pers-wrap">

    <div class="card pers-card">

        <div class="pers-title">Personal del Plantel</div>

        <p class="pers-sub">
            Registra al personal que aparecerá en Asistencias para marcar entrada/salida.
        </p>

        <?php if ($msg): ?>
            <div class="alert ok">
                <?php echo e($msg); ?>
            </div>
        <?php endif; ?>

        <?php if ($okPersonal !== "" && $okEmpleado): ?>

            <?php
                $okNombre = trim((string)($okEmpleado["nombre"] ?? ""));
                $okFotoArchivo = trim((string)($okEmpleado["foto_archivo"] ?? ""));
                $okFotoUrl = personalFotoSegura($okFotoArchivo);
                $okInicial = strtoupper(substr($okNombre, 0, 1));

                if ($okInicial === "") {
                    $okInicial = "-";
                }

                $okCedula = $okEmpleado["cedula"] ?? "";
                $okCargo = $okEmpleado["cargo"] ?? "-";
                $okTurno = $okEmpleado["turno"] ?? "-";
                $okEstadoEmpleado = $okEmpleado["estado"] ?? "ACTIVO";
                $okCodigoBarra = $okEmpleado["codigo_barra"] ?? "";
            ?>

            <div class="personal-success-card" id="personalSuccessCard">

                <?php if ($okFotoUrl !== ""): ?>

                    <img
                        class="personal-photo"
                        src="<?php echo e($okFotoUrl); ?>"
                        alt="Foto de <?php echo e($okNombre); ?>"
                    >

                <?php else: ?>

                    <div class="personal-photo personal-photo-empty">
                        <?php echo e($okInicial); ?>
                    </div>

                <?php endif; ?>

                <div>
                    <div class="success-title">
                        Información del empleado
                    </div>

                    <div class="success-meta">
                        <strong>
                            <?php echo e($okNombre); ?>
                        </strong>

                        <br>

                        Cédula: <?php echo e($okCedula); ?> |
                        Cargo: <?php echo e($okCargo); ?> |
                        Turno: <?php echo e($okTurno); ?>

                        <br>

                        Código de barras:
                        <strong>
                            <?php echo e($okCodigoBarra ?: "—"); ?>
                        </strong>

                        |
                        Estado: <?php echo e($okEstadoEmpleado); ?>
                    </div>
                </div>
            </div>

        <?php endif; ?>

        <?php if ($err): ?>
            <div class="alert bad">
                <?php echo e($err); ?>
            </div>
        <?php endif; ?>

        <?php if ($puedeCrearPersonal): ?>

            <div class="pers-form">

                <form
                    class="personal-form-modern"
                    method="POST"
                    action="../procesos/personal_guardar.php"
                    id="formPersonal"
                    enctype="multipart/form-data"
                >

                    <?php echo csrfInput(); ?>

                    <div class="grid4">

                        <div class="field">
                            <label for="inputNombres">Nombres</label>

                            <input
                                class="input"
                                type="text"
                                name="nombres"
                                id="inputNombres"
                                required
                                minlength="2"
                                maxlength="80"
                                pattern="[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+( [A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*"
                                autocomplete="given-name"
                                placeholder="Ej: María José"
                                title="Ingrese entre 2 y 80 caracteres, solo letras y espacios"
                            >
                        </div>

                        <div class="field">
                            <label for="inputApellidos">Apellidos</label>

                            <input
                                class="input"
                                type="text"
                                name="apellidos"
                                id="inputApellidos"
                                required
                                minlength="2"
                                maxlength="80"
                                pattern="[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+( [A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*"
                                autocomplete="family-name"
                                placeholder="Ej: García Pérez"
                                title="Ingrese entre 2 y 80 caracteres, solo letras y espacios"
                            >
                        </div>

                        <div class="field">
                            <label for="inputCedula">Cédula</label>

                            <input
                                class="input"
                                type="text"
                                name="cedula"
                                id="inputCedula"
                                required
                                inputmode="numeric"
                                minlength="8"
                                maxlength="8"
                                pattern="[0-9]{8}"
                                autocomplete="off"
                                placeholder="Ej: 12345678"
                                title="La cédula debe contener exactamente 8 números"
                            >
                        </div>

                        <div class="field">
                            <label for="inputCargoId">Cargo</label>

                            <select
                                class="select"
                                name="cargo_id"
                                id="inputCargoId"
                                required
                            >
                                <option value="">Seleccione…</option>

                                <?php foreach ($cargos as $c): ?>
                                    <option value="<?php echo (int)$c["id"]; ?>">
                                        <?php echo e($c["nombre"]); ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="field span2">
                            <label for="inputTurnoId">Turno</label>

                            <select
                                class="select"
                                name="turno_id"
                                id="inputTurnoId"
                                required
                            >
                                <option value="">Seleccione…</option>

                                <?php foreach ($turnos as $t): ?>
                                    <option value="<?php echo (int)$t["id"]; ?>">
                                        <?php echo e($t["nombre"]); ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>

                        <div class="field span2">
                            <label for="inputFoto">Foto del personal</label>

                            <input
                                class="input"
                                type="file"
                                name="foto"
                                id="inputFoto"
                                accept="image/jpeg,image/png,image/webp"
                            >

                            <small style="display:block;color:#6b7280;margin-top:6px">
                                Formatos permitidos: JPG, PNG o WEBP. Máximo 2 MB.
                            </small>
                        </div>

                        <div class="field span4">
                            <label for="inputCodigoBarra">
                                Código de Barras
                            </label>

                            <input
                                class="input"
                                type="text"
                                name="codigo_barra"
                                id="inputCodigoBarra"
                                required
                                minlength="3"
                                maxlength="50"
                                pattern="[A-Za-z0-9][A-Za-z0-9_-]{2,49}"
                                inputmode="text"
                                autocomplete="off"
                                placeholder="Ej: ASIS-12345678"
                                title="El código debe tener entre 3 y 50 caracteres, sin espacios ni símbolos especiales"
                            >

                            <small style="display:block;color:#6b7280;margin-top:6px">
                                Código del carné. Hasta 50 caracteres, sin espacios.
                            </small>
                        </div>

                        <div class="span4">
                            <div class="actions-row">

                                <button class="btn-primary" type="submit">
                                    Registrar Personal
                                </button>

                                <a href="personal.php" class="btn-light">
                                    Limpiar
                                </a>

                            </div>
                        </div>

                    </div>
                </form>
            </div>

        <?php endif; ?>

    </div>

    <?php if (esRolGlobal()): ?>
<details class="card" id="configurar-cargos-turnos"
    <?php echo isset($_GET['catalogos']) ? 'open' : ''; ?>
    style="margin:16px 0;padding:18px">

<summary style="font-weight:700;cursor:pointer;font-size:18px">
    Configurar cargos y turnos
</summary>

<?php
$catalogosMsg = isset($_GET['cat_msg']) && is_string($_GET['cat_msg'])
    ? substr($_GET['cat_msg'], 0, 200) : '';

$catalogosErr = isset($_GET['cat_err']) && is_string($_GET['cat_err'])
    ? substr($_GET['cat_err'], 0, 200) : '';

$cargosConfig = $pdo->query("
    SELECT c.id, c.nombre, c.descripcion, COUNT(e.id) AS empleados
    FROM cargos c
    LEFT JOIN empleados e ON e.cargo_id = c.id
    GROUP BY c.id, c.nombre, c.descripcion
    ORDER BY c.nombre
")->fetchAll(PDO::FETCH_ASSOC);

$turnosConfig = $pdo->query("
    SELECT t.id, t.nombre, t.hora_inicio, t.hora_fin,
           COUNT(e.id) AS empleados
    FROM turnos t
    LEFT JOIN empleados e ON e.turno_id = t.id
    GROUP BY t.id, t.nombre, t.hora_inicio, t.hora_fin
    ORDER BY t.id
")->fetchAll(PDO::FETCH_ASSOC);
?>
<style>
.catalogos-wrap{max-width:1100px;margin:0 auto}
.catalogos-grid{display:grid;grid-template-columns:1fr 1fr;gap:18px;align-items:start}
.catalogos-box{background:white;border:1px solid #e9edf4;border-radius:14px;padding:18px;margin-top:16px}
.catalogos-box h2{margin-bottom:14px;font-size:20px}
.catalogos-form{display:flex;gap:8px;flex-wrap:wrap;align-items:center;padding:10px 0;border-top:1px solid #eee}
.catalogos-form:first-of-type{border-top:0}
.catalogos-form input{min-width:100px;flex:1;padding:9px;border:1px solid #ccd4df;border-radius:8px}
.catalogos-form button{border:0;border-radius:8px;background:#0b6efd;color:white;padding:10px;cursor:pointer}
.catalogos-form button.danger{background:#b91c1c}
.catalogos-hint{color:#566070;font-size:13px;margin:6px 0 12px}
.catalogos-msg{padding:12px;border-radius:9px;margin-top:12px;background:#e8f8ee}
.catalogos-msg.err{background:#ffebeb}
@media(max-width:830px){.catalogos-grid{grid-template-columns:1fr}}
</style>
<div class="catalogos-wrap">

  <p class="catalogos-hint">Administracion exclusiva de Directora y Subdirector. No se modifican ni eliminan catalogos que tengan empleados asignados.</p>
  <?php if ($catalogosMsg !== ''): ?><div class="catalogos-msg"><?php echo e($catalogosMsg); ?></div><?php endif; ?>
  <?php if ($catalogosErr !== ''): ?><div class="catalogos-msg err"><?php echo e($catalogosErr); ?></div><?php endif; ?>
  <div class="catalogos-grid">
    <section class="catalogos-box">
      <h2>Cargos</h2>
      <form class="catalogos-form" method="post" action="<?php echo e(BASE_URL); ?>/procesos/catalogos_guardar.php">
        <?php echo csrfInput(); ?>
        <input type="hidden" name="accion" value="guardar_cargo">
        <input name="nombre" maxlength="80" placeholder="Nuevo cargo" aria-label="Nuevo cargo" required>
        <input name="descripcion" maxlength="200" placeholder="Descripcion (opcional)" aria-label="Descripcion">
        <button type="submit">Crear</button>
      </form>
      <?php foreach ($cargosConfig as $cargo): ?>
        <form class="catalogos-form" method="post" action="<?php echo e(BASE_URL); ?>/procesos/catalogos_guardar.php">
          <?php echo csrfInput(); ?>
          <input type="hidden" name="accion" value="guardar_cargo">
          <input type="hidden" name="id" value="<?php echo (int)$cargo['id']; ?>">
          <input name="nombre" maxlength="80" value="<?php echo e($cargo['nombre']); ?>" required>
          <input name="descripcion" maxlength="200" value="<?php echo e($cargo['descripcion'] ?? ''); ?>" placeholder="Descripcion">
          <button type="submit">Guardar</button>
        </form>
        <p class="catalogos-hint"><?php echo (int)$cargo['empleados']; ?> empleados asignados</p>
        <?php if ((int)$cargo['empleados'] === 0): ?>
          <form class="catalogos-form" method="post" action="<?php echo e(BASE_URL); ?>/procesos/catalogos_guardar.php" onsubmit="return confirm('Eliminar este cargo?');">
            <?php echo csrfInput(); ?>
            <input type="hidden" name="accion" value="eliminar_cargo">
            <input type="hidden" name="id" value="<?php echo (int)$cargo['id']; ?>">
            <button class="danger" type="submit">Eliminar cargo</button>
          </form>
        <?php endif; ?>
      <?php endforeach; ?>
    </section>
    <section class="catalogos-box">
      <h2>Turnos</h2>
      <p class="catalogos-hint">Los turnos MATUTINO y VESPERTINO se utilizan para limitar el acceso de los roles DIURNO y TARDE.</p>
      <form class="catalogos-form" method="post" action="<?php echo e(BASE_URL); ?>/procesos/catalogos_guardar.php">
        <?php echo csrfInput(); ?>
        <input type="hidden" name="accion" value="guardar_turno">
        <input name="nombre" maxlength="50" placeholder="Nuevo turno" required>
        <input type="time" name="hora_inicio" required aria-label="Hora inicio">
        <input type="time" name="hora_fin" required aria-label="Hora fin">
        <button type="submit">Crear</button>
      </form>
      <?php foreach ($turnosConfig as $turno): ?>
        <form class="catalogos-form" method="post" action="<?php echo e(BASE_URL); ?>/procesos/catalogos_guardar.php">
          <?php echo csrfInput(); ?>
          <input type="hidden" name="accion" value="guardar_turno">
          <input type="hidden" name="id" value="<?php echo (int)$turno['id']; ?>">
          <input name="nombre" maxlength="50" value="<?php echo e($turno['nombre']); ?>" required>
          <input type="time" name="hora_inicio" value="<?php echo e(substr((string)$turno['hora_inicio'], 0, 5)); ?>" required>
          <input type="time" name="hora_fin" value="<?php echo e(substr((string)$turno['hora_fin'], 0, 5)); ?>" required>
          <button type="submit">Guardar</button>
        </form>
        <p class="catalogos-hint"><?php echo (int)$turno['empleados']; ?> empleados asignados</p>
        <?php if ((int)$turno['empleados'] === 0 && !in_array(strtoupper($turno['nombre']), ['MATUTINO','VESPERTINO','COMPLETO'], true)): ?>
          <form class="catalogos-form" method="post" action="<?php echo e(BASE_URL); ?>/procesos/catalogos_guardar.php" onsubmit="return confirm('Eliminar este turno?');">
            <?php echo csrfInput(); ?>
            <input type="hidden" name="accion" value="eliminar_turno">
            <input type="hidden" name="id" value="<?php echo (int)$turno['id']; ?>">
            <button class="danger" type="submit">Eliminar turno</button>
          </form>
        <?php endif; ?>
      <?php endforeach; ?>
    </section>
  </div>
</div>

</details>
<?php endif; ?>
<div class="card table-card">

        <div class="table-title">Listado de Personal</div>

        <p class="table-sub">
            <?php if ($filtroEstado === "ACTIVO"): ?>
                Personal activo registrado.
            <?php elseif ($filtroEstado === "SUSPENDIDO"): ?>
                Personal suspendido registrado.
            <?php elseif ($filtroEstado === "RETIRADO"): ?>
                Personal retirado registrado.
            <?php else: ?>
                Listado de personal registrado.
            <?php endif; ?>
        </p>

        <div style="display:flex;gap:8px;margin-bottom:12px;flex-wrap:wrap">

            <a
                href="<?php echo e(personalListadoUrl(1, 'jerarquia', $filtroEstado)); ?>"
                class="btn <?php echo $orden === 'jerarquia' ? 'btn-primary' : 'btn-light'; ?>"
                style="font-size:12px;padding:8px 12px"
            >
                Orden por Cargo
            </a>

            <a
                href="<?php echo e(personalListadoUrl(1, 'alfabetico', $filtroEstado)); ?>"
                class="btn <?php echo $orden === 'alfabetico' ? 'btn-primary' : 'btn-light'; ?>"
                style="font-size:12px;padding:8px 12px"
            >
                Orden Alfabético
            </a>

            <div style="border-left:1px solid #d6dee8;margin:0 4px"></div>

            <a
                href="<?php echo e(personalListadoUrl(1, $orden, 'ACTIVO')); ?>"
                class="btn <?php echo $filtroEstado === 'ACTIVO' ? 'btn-primary' : 'btn-light'; ?>"
                style="font-size:12px;padding:8px 12px"
            >
                Activos
            </a>

            <a
                href="<?php echo e(personalListadoUrl(1, $orden, 'SUSPENDIDO')); ?>"
                class="btn <?php echo $filtroEstado === 'SUSPENDIDO' ? 'btn-primary' : 'btn-light'; ?>"
                style="font-size:12px;padding:8px 12px"
            >
                Suspendidos
            </a>

            <a
                href="<?php echo e(personalListadoUrl(1, $orden, 'RETIRADO')); ?>"
                class="btn <?php echo $filtroEstado === 'RETIRADO' ? 'btn-primary' : 'btn-light'; ?>"
                style="font-size:12px;padding:8px 12px"
            >
                Retirados
            </a>

            <a
                href="<?php echo e(personalListadoUrl(1, '', '')); ?>"
                class="btn btn-light"
                style="font-size:12px;padding:8px 12px"
            >
                Mostrar Todos
            </a>

        </div>

        <div class="personal-table-scroll">

            <table class="personal-table-modern">

                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Cédula</th>
                        <th>Código de Barras</th>
                        <th>Cargo</th>
                        <th>Turno</th>
                        <th>Estado</th>
                        <th>Acción</th>
                    </tr>
                </thead>

                <tbody>

                    <?php if (!$personal): ?>
                        <tr>
                            <td colspan="7">
                                No hay personal registrado.
                            </td>
                        </tr>
                    <?php endif; ?>

                    <?php foreach ($personal as $p): ?>

                        <?php
                            $codigoBarra = $p["codigo_barra"] ?? "";

                            $pillClass = "status-present";

                            if ($p["estado"] === "SUSPENDIDO") {
                                $pillClass = "status-suspended";
                            } elseif ($p["estado"] === "RETIRADO") {
                                $pillClass = "status-retired";
                            }
                        ?>

                        <tr>

                            <td><?php echo e($p["nombre"]); ?></td>

                            <td><?php echo e($p["cedula"]); ?></td>

                            <td>
                                <code style="font-size:13px;font-weight:700;letter-spacing:1px">
                                    <?php echo e(enmascararCodigoBarra($codigoBarra)); ?>
                                </code>
                            </td>

                            <td><?php echo e($p["cargo"] ?: "—"); ?></td>

                            <td><?php echo e($p["turno"] ?: "—"); ?></td>

                            <td>
                                <span class="pill <?php echo $pillClass; ?>">
                                    <?php echo e($p["estado"]); ?>
                                </span>
                            </td>

                            <td>

                                <?php if ($puedeCambiarEstadoPersonal): ?>

                                    <form
                                        method="POST"
                                        action="../procesos/personal_estado.php"
                                        class="actions-personal"
                                    >

                                        <?php echo csrfInput(); ?>

                                        <input
                                            type="hidden"
                                            name="id"
                                            value="<?php echo (int)$p["id"]; ?>"
                                        >

                                        <?php if ($p["estado"] === "ACTIVO"): ?>

                                            <button
                                                type="submit"
                                                name="accion"
                                                value="suspender"
                                                class="btn-action btn-suspender"
                                            >
                                                Suspender
                                            </button>

                                            <button
                                                type="submit"
                                                name="accion"
                                                value="retirar"
                                                class="btn-action btn-retirar"
                                            >
                                                Retirar
                                            </button>

                                        <?php elseif ($p["estado"] === "SUSPENDIDO"): ?>

                                            <button
                                                type="submit"
                                                name="accion"
                                                value="activar"
                                                class="btn-action btn-activar"
                                            >
                                                Activar
                                            </button>

                                            <button
                                                type="submit"
                                                name="accion"
                                                value="retirar"
                                                class="btn-action btn-retirar"
                                            >
                                                Retirar
                                            </button>

                                        <?php else: ?>

                                            <button
                                                type="submit"
                                                name="accion"
                                                value="activar"
                                                class="btn-action btn-activar"
                                            >
                                                Reingresar
                                            </button>

                                        <?php endif; ?>

                                    </form>

                                <?php else: ?>

                                    <span class="scope-note">
                                        Solo lectura
                                    </span>

                                <?php endif; ?>

                                <?php if ($puedeEditarPersonal): ?>

                                    <button
                                        type="button"
                                        class="btn-action btn-editar"
                                        data-id="<?php echo (int)$p["id"]; ?>"
                                        data-nombres="<?php echo e($p["nombres"] ?? ""); ?>"
                                        data-apellidos="<?php echo e($p["apellidos"] ?? ""); ?>"
                                        data-cedula="<?php echo e($p["cedula"] ?? ""); ?>"
                                        data-cargo-id="<?php echo (int)($p["cargo_id"] ?? 0); ?>"
                                        data-turno-id="<?php echo (int)($p["turno_id"] ?? 0); ?>"
                                        data-codigo="<?php echo e($p["codigo_barra"] ?? ""); ?>"
                                        data-foto="<?php echo e(fotoEmpleadoUrl($p["foto_archivo"] ?? "")); ?>"
                                    >
                                        Editar
                                    </button>

                                <?php endif; ?>
                                <a class="btn-action" href="<?php echo e(BASE_URL); ?>/modulos/historial_personal.php?empleado_id=<?php echo (int)$p['id']; ?>">Historial</a>

                            </td>
                        </tr>

                    <?php endforeach; ?>

                </tbody>
            </table>
        </div>

        <?php if ($totalPaginas > 0): ?>

            <div class="pagination">

                <div class="pagination-info">
                    Mostrando
                    <?php echo $mostrandoInicio; ?>-<?php echo $mostrandoFin; ?>
                    de <?php echo $totalPersonal; ?> personal
                </div>

                <div class="pagination-pages">

                    <?php if ($pagina > 1): ?>

                        <a href="<?php echo e(personalListadoUrl($pagina - 1, $orden, $filtroEstado)); ?>">
                            ‹ Anterior
                        </a>

                    <?php else: ?>

                        <span class="disabled">‹ Anterior</span>

                    <?php endif; ?>

                    <?php
                        $inicioPaginas = max(1, $pagina - 3);
                        $finPaginas = min($totalPaginas, $pagina + 3);
                    ?>

                    <?php for ($i = $inicioPaginas; $i <= $finPaginas; $i++): ?>

                        <a
                            href="<?php echo e(personalListadoUrl($i, $orden, $filtroEstado)); ?>"
                            class="<?php echo $i === $pagina ? 'current' : ''; ?>"
                        >
                            <?php echo $i; ?>
                        </a>

                    <?php endfor; ?>

                    <?php if ($pagina < $totalPaginas): ?>

                        <a href="<?php echo e(personalListadoUrl($pagina + 1, $orden, $filtroEstado)); ?>">
                            Siguiente ›
                        </a>

                    <?php else: ?>

                        <span class="disabled">Siguiente ›</span>

                    <?php endif; ?>

                </div>
            </div>

        <?php endif; ?>

    </div>

</div>

<div class="modal-overlay" id="modalEditarPersonal">

    <div
        class="modal-box"
        role="dialog"
        aria-modal="true"
        aria-labelledby="tituloEditarPersonal"
    >

        <h3 id="tituloEditarPersonal">Editar Personal</h3>

        <p class="modal-sub">
            Actualiza los datos del empleado. El código de barras es obligatorio.
        </p>

        <form
            method="POST"
            action="../procesos/personal_actualizar.php"
            id="formEditarPersonal"
            enctype="multipart/form-data"
        >

            <?php echo csrfInput(); ?>

            <input type="hidden" name="id" id="editId">

            <div class="grid4">

                <div class="field">
                    <label for="editNombres">Nombres</label>

                    <input
                        class="input"
                        type="text"
                        name="nombres"
                        id="editNombres"
                        required
                        minlength="2"
                        maxlength="80"
                        pattern="[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+( [A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*"
                    >
                </div>

                <div class="field">
                    <label for="editApellidos">Apellidos</label>

                    <input
                        class="input"
                        type="text"
                        name="apellidos"
                        id="editApellidos"
                        required
                        minlength="2"
                        maxlength="80"
                        pattern="[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+( [A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*"
                    >
                </div>

                <div class="field">
                    <label for="editCedula">Cédula</label>

                    <input
                        class="input"
                        type="text"
                        name="cedula"
                        id="editCedula"
                        required
                        inputmode="numeric"
                        minlength="8"
                        maxlength="8"
                        pattern="[0-9]{8}"
                        autocomplete="off"
                        title="La cédula debe contener exactamente 8 números"
                    >
                </div>

                <div class="field">
                    <label for="editCargoId">Cargo</label>

                    <select
                        class="select"
                        name="cargo_id"
                        id="editCargoId"
                        required
                    >
                        <option value="">Seleccione…</option>

                        <?php foreach ($cargos as $c): ?>
                            <option value="<?php echo (int)$c["id"]; ?>">
                                <?php echo e($c["nombre"]); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="field">
                    <label for="editTurnoId">Turno</label>

                    <select
                        class="select"
                        name="turno_id"
                        id="editTurnoId"
                        required
                    >
                        <option value="">Seleccione…</option>

                        <?php foreach ($turnos as $t): ?>
                            <option value="<?php echo (int)$t["id"]; ?>">
                                <?php echo e($t["nombre"]); ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="field span2">
                    <label for="editCodigoBarra">Código de Barras</label>

                    <input
                        class="input"
                        type="text"
                        name="codigo_barra"
                        id="editCodigoBarra"
                        required
                        minlength="3"
                        maxlength="50"
                        pattern="[A-Za-z0-9][A-Za-z0-9_-]{2,49}"
                        inputmode="text"
                        autocomplete="off"
                        title="El código debe tener entre 3 y 50 caracteres, sin espacios"
                    >

                    <small style="display:block;color:#6b7280;margin-top:6px">
                        Hasta 50 caracteres, sin espacios.
                    </small>
                </div>

                <div class="field span2">

                    <img
                        class="edit-preview"
                        id="editFotoPreview"
                        alt="Foto actual"
                        style="display:none"
                    >

                    <label for="editFoto">Foto (opcional)</label>

                    <input
                        class="input"
                        type="file"
                        name="foto"
                        id="editFoto"
                        accept="image/jpeg,image/png,image/webp"
                    >

                    <small style="display:block;color:#6b7280;margin-top:6px">
                        JPG, PNG o WEBP. Máximo 2 MB.
                    </small>

                </div>

            </div>

            <div class="modal-actions">

                <button
                    type="button"
                    class="btn-light"
                    id="btnCerrarModalEditar"
                >
                    Cancelar
                </button>

                <button type="submit" class="btn-primary">
                    Guardar Cambios
                </button>

            </div>

        </form>

    </div>

</div>

<script>
(function() {
    'use strict';

    const regexNombres =
        /^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+(?: [A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*$/;

    const regexCodigo = /^[A-Z0-9][A-Z0-9_-]{2,49}$/;

    const baseUrl = <?php echo json_encode(
        rtrim(BASE_URL, '/'),
        JSON_HEX_TAG |
        JSON_HEX_AMP |
        JSON_HEX_QUOT |
        JSON_HEX_APOS
    ); ?>;

    const tiposFoto = [
        'image/jpeg',
        'image/png',
        'image/webp'
    ];

    const tamanoMaximo = 2 * 1024 * 1024;

    function validarNombre(input) {

        if (!input) {
            return;
        }

        input.value = input.value.trim().replace(/\s+/g, ' ');

        input.setCustomValidity(
            input.value.length >= 2 &&
            input.value.length <= 80 &&
            regexNombres.test(input.value)
                ? ''
                : 'Escriba entre 2 y 80 caracteres, solo letras y espacios.'
        );
    }

    function validarCedula(input) {

        if (!input) {
            return;
        }

        input.value = input.value
            .replace(/[^0-9]/g, '')
            .slice(0, 8);

        input.setCustomValidity(
            /^[0-9]{8}$/.test(input.value)
                ? ''
                : 'La cédula debe contener exactamente 8 números.'
        );
    }

    function validarCodigo(input) {

        if (!input) {
            return;
        }

        input.value = input.value
            .toUpperCase()
            .replace(/[^A-Z0-9_-]/g, '')
            .slice(0, 50);

        input.setCustomValidity(
            regexCodigo.test(input.value)
                ? ''
                : 'El código debe tener entre 3 y 50 caracteres, sin espacios.'
        );
    }

    function validarFoto(input) {

        if (!input) {
            return;
        }

        const archivo = input.files && input.files[0];

        let error = '';

        if (archivo) {

            if (!tiposFoto.includes(archivo.type)) {

                error = 'Solo se permiten fotografías JPG, PNG o WEBP.';

            } else if (
                archivo.size === 0 ||
                archivo.size > tamanoMaximo
            ) {

                error = 'La fotografía debe pesar más de 0 bytes y máximo 2 MB.';
            }
        }

        input.setCustomValidity(error);
    }

    ['formPersonal', 'formEditarPersonal'].forEach(function(id) {

        const form = document.getElementById(id);

        if (!form) {
            return;
        }

        const nombres = form.elements.namedItem('nombres');
        const apellidos = form.elements.namedItem('apellidos');
        const cedula = form.elements.namedItem('cedula');
        const codigo = form.elements.namedItem('codigo_barra');
        const foto = form.elements.namedItem('foto');

        [nombres, apellidos].forEach(function(input) {

            if (!input) {
                return;
            }

            input.addEventListener('input', function() {

                input.value = input.value
                    .replace(/[^A-Za-zÁÉÍÓÚÜÑáéíóúüñ ]/g, '')
                    .slice(0, 80);

                input.setCustomValidity('');
            });

            input.addEventListener('blur', function() {
                validarNombre(input);
            });
        });

        if (cedula) {

            cedula.addEventListener('input', function() {
                validarCedula(cedula);
            });
        }

        if (codigo) {

            codigo.addEventListener('input', function() {
                validarCodigo(codigo);
            });
        }

        if (foto) {

            foto.addEventListener('change', function() {
                validarFoto(foto);
                foto.reportValidity();
            });
        }

        form.addEventListener('submit', function(ev) {

            validarNombre(nombres);
            validarNombre(apellidos);
            validarCedula(cedula);
            validarCodigo(codigo);
            validarFoto(foto);

            if (!form.checkValidity()) {

                ev.preventDefault();
                form.reportValidity();
            }
        });
    });

    document.querySelectorAll(
        'form.personal-form-modern input[type="file"]'
    ).forEach(function(input) {

        input.classList.add('personal-file-input');

        if (input.parentElement) {
            input.parentElement.classList.add('personal-photo-field');
        }
    });

    document.querySelectorAll('.actions-personal').forEach(
        function(form) {

            form.addEventListener('submit', function(ev) {

                const boton = ev.submitter || document.activeElement;
                const accion = boton && boton.value;

                const mensajes = {
                    suspender: '¿Confirma que desea suspender a este empleado?',
                    retirar: '¿Confirma que desea retirar a este empleado?',
                    activar: '¿Confirma que desea activar o reingresar a este empleado?'
                };

                if (
                    !Object.prototype.hasOwnProperty.call(
                        mensajes,
                        accion
                    ) ||
                    !confirm(mensajes[accion])
                ) {
                    ev.preventDefault();
                }
            });
        }
    );

    const modal = document.getElementById('modalEditarPersonal');
    const cerrar = document.getElementById('btnCerrarModalEditar');

    let botonAnterior = null;

    function cerrarModal() {

        if (!modal) {
            return;
        }

        modal.classList.remove('show');

        document.body.style.overflow = '';

        if (botonAnterior) {
            botonAnterior.focus();
        }
    }

    function abrirModal(boton) {

        if (!modal) {
            return;
        }

        const campos = {
            editId: boton.dataset.id,
            editNombres: boton.dataset.nombres,
            editApellidos: boton.dataset.apellidos,
            editCedula: boton.dataset.cedula,
            editCargoId: boton.dataset.cargoId,
            editTurnoId: boton.dataset.turnoId,
            editCodigoBarra: boton.dataset.codigo
        };

        Object.entries(campos).forEach(function(entrada) {

            const input = document.getElementById(entrada[0]);

            if (input) {

                input.value = entrada[1] || '';

                if (typeof input.setCustomValidity === 'function') {
                    input.setCustomValidity('');
                }
            }
        });

        const foto = document.getElementById('editFoto');

        if (foto) {

            foto.value = '';
            foto.setCustomValidity('');
        }

        const preview = document.getElementById('editFotoPreview');

        if (preview) {

            const ruta = boton.dataset.foto || '';

            const segura = ruta.startsWith(baseUrl + '/procesos/foto_empleado.php?archivo=') &&
                !ruta.includes('..');

            preview.src = segura ? ruta : '';

            preview.style.display = segura ? 'block' : 'none';
        }

        botonAnterior = boton;

        modal.classList.add('show');

        document.body.style.overflow = 'hidden';

        const primero = document.getElementById('editNombres');

        if (primero) {
            primero.focus();
        }
    }

    document.querySelectorAll('.btn-editar').forEach(function(boton) {

        boton.addEventListener('click', function() {
            abrirModal(boton);
        });
    });

    if (cerrar) {

        cerrar.addEventListener('click', cerrarModal);
    }

    if (modal) {

        modal.addEventListener('click', function(ev) {

            if (ev.target === modal) {
                cerrarModal();
            }
        });
    }

    document.addEventListener('keydown', function(ev) {

        if (
            ev.key === 'Escape' &&
            modal &&
            modal.classList.contains('show')
        ) {
            cerrarModal();
        }
    });

})();
</script>

<?php require_once __DIR__ . "/../includes/footer.php"; ?>
