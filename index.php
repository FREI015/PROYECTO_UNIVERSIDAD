<?php
require_once __DIR__ . "/includes/funciones.php";
noCache();

/*
  Punto único de entrada al sistema.
  - Si está logueado → asistencias
  - Si NO → login
*/

if (isLogged()) {
  go("modulos/asistencias.php");
}

go("login.php");
