# Sistema de Control de Asistencia

Sistema web para gestionar asistencia, personal, permisos,
reposos, usuarios, roles y reportes.

## Funciones principales

- Entrada y salida manual.
- Entrada y salida mediante codigo de barras.
- Fotografia del empleado durante la asistencia.
- Control automatico de SIN_SALIDA.
- Restriccion de turnos por rol.
- Gestion de personal, permisos y reposos.
- Reportes PDF.
- Restablecimiento administrativo limitado.
- Recuperacion con codigos de un solo uso.
- Mi perfil y cambio de la propia clave.
- Invalidacion de sesiones mediante version_sesion.
- Rate limit persistente del login administrativo.

## Roles

- DIRECTORA
- SUBDIRECTOR
- DIURNO
- TARDE

DIURNO y TARDE se limitan a su turno.
DIRECTORA y SUBDIRECTOR tienen alcance global.

El restablecimiento administrativo de clave solo puede
aplicarse a usuarios operativos DIURNO/TARDE.

## Seguridad

- password_hash() / password_verify().
- CSRF en procesos sensibles.
- Session ID regenerado al autenticar.
- Cookies HttpOnly y SameSite.
- version_sesion para invalidar sesiones antiguas.
- Recuperacion con codigos almacenados como hash.
- Rate limit de recuperacion.
- Rate limit persistente de login.
- SQL preparado.
- Directorios internos bloqueados.
- Uploads sin ejecucion PHP.
- Barcodes aleatorios generados con random_bytes().

## Codigo de barras

Formato actual:

ASIS- + 32 caracteres hexadecimales aleatorios.

La parte aleatoria proviene de random_bytes(16).

El codigo no depende del ID del empleado y no es secuencial.

## Instalacion limpia

1. Clonar el repositorio.
2. Colocarlo en el servidor local.
3. Importar `sql/bd.sql`.
4. Copiar `conexion.example.php` como
   `includes/conexion.php`.
5. Configurar las credenciales locales.
6. Iniciar Apache y MariaDB/MySQL.
7. Abrir la aplicacion.

## Datos reales

Nunca deben versionarse volcados que contengan datos reales
de empleados, usuarios, hashes, barcodes o asistencias.

`includes/conexion.php` es local y esta ignorado por Git.