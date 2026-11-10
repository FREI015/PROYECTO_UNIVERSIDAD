<?php

require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/funciones.php";

noCache();

go(
    BASE_URL . "/recuperar_clave.php?deshabilitada=1"
);