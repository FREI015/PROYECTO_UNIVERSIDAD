<?php

require_once __DIR__ . "/../includes/config.php";
require_once __DIR__ . "/../includes/conexion.php";
require_once __DIR__ . "/../includes/funciones.php";

noCache();

requireLogin();

go(
    BASE_URL . "/codigos_recuperacion.php?deshabilitada=1"
);