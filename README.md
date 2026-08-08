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
3. Importar la base de datos desde la carpeta sql/:
   - **Instalación con datos (recomendada):** importar `control_asistencia_completa.sql`. Es un volcado autocontenido que crea la BD y restaura todos los datos (empleados, asistencias, permisos, reposos y usuarios).
   - **Instalación limpia (solo esquema):** importar `bd.sql` y luego, opcionalmente, `01_saneamiento_profesional_bd.sql`.
4. Copiar conexion.example.php como includes/conexion.php.
5. Ajustar credenciales locales en includes/conexion.php.
6. Iniciar Apache y MySQL.
7. Abrir http://localhost/control_asistencia/login.php.

> Nota: `01_saneamiento_profesional_bd.sql` usa `DELIMITER` y crea procedimientos/trigger, por lo que debe ejecutarse en MySQL/MariaDB (no en SQLite) y con privilegios de base de datos. El volcado `control_asistencia_completa.sql` no depende de esos procedimientos.

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
