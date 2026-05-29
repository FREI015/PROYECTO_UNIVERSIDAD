# Sistema de Control de Asistencia

Sistema web para la gestion de asistencia, personal, permisos, reposos, usuarios, roles y reportes PDF.

## Caracteristicas principales

- Registro de entrada y salida del personal.
- Gestion de personal activo, suspendido y retirado.
- Control de permisos y reposos.
- Administracion de usuarios, roles y estados.
- Restriccion de acceso por permisos y roles.
- Reportes PDF con TCPDF.
- Proteccion de sesiones.
- Validacion CSRF en formularios sensibles.
- Contrasenas protegidas con password_hash y password_verify.

## Estructura del proyecto

- assets/: recursos visuales y estilos.
- includes/: configuracion, conexion local, funciones, header y footer.
- libs/tcpdf/: libreria TCPDF local para PDF.
- modulos/: pantallas principales del sistema.
- procesos/: procesos POST y acciones del sistema.
- sql/: estructura y datos de base de datos.
- conexion.example.php: ejemplo de conexion local.
- index.php: panel principal.
- login.php: pantalla de acceso.

## Requisitos

- PHP 8 o superior recomendado.
- MySQL/MariaDB.
- XAMPP, WAMP, Laragon o servidor local equivalente.
- Git.

## Instalacion local

1. Clonar el repositorio.
2. Colocar el proyecto en el directorio web local, por ejemplo C:\xampp\htdocs\control_asistencia.
3. Crear la base de datos control_asistencia.
4. Importar los archivos SQL desde la carpeta sql/.
5. Copiar conexion.example.php como includes/conexion.php.
6. Ajustar credenciales locales en includes/conexion.php.
7. Iniciar Apache y MySQL.
8. Abrir http://localhost/control_asistencia/login.php.

## Configuracion local

El archivo includes/conexion.php contiene credenciales locales y no debe subirse a Git.

El archivo versionado para referencia es conexion.example.php.

## Seguridad

- No subir credenciales reales al repositorio.
- Mantener includes/conexion.php fuera de Git.
- Usar contrasenas hasheadas.
- Validar formularios sensibles con CSRF.
- Mantener permisos por rol.

## Roles principales

- SUPER
- DIRECTORA
- DIURNO
- TARDE

## Reportes PDF

El sistema usa TCPDF local desde libs/tcpdf/.

## Version estable

La version estable recuperada con roles y permisos quedo marcada con el tag:

version-roles-permisos-20260525_131634

## Estado del proyecto

El proyecto fue saneado para mantener solo archivos necesarios del sistema, sin respaldos, reportes temporales, copias antiguas ni archivos internos de trabajo.
