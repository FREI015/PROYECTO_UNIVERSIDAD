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
- Codigo de barras manual obligatorio al registrar o editar personal.
- Edicion de personal desde el listado (modal con datos precargados).
- Filtros de consulta en Permisos y Reposos (empleado, estado, fechas).
- Campos obligatorios con asterisco y mensaje.
- Reportes PDF con escala uniforme.
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
- Barcodes validados (unicos, sin espacios ni comillas, maximo 50 caracteres).
- Codigo de barras enmascarado en el listado de Personal.

## Codigo de barras

Desde la version v1.1.0 el codigo se registra manualmente al dar de
alta o editar un empleado. No se genera automaticamente.

Reglas:

- obligatorio;
- mayusculas;
- maximo 50 caracteres;
- sin espacios ni comillas;
- unico entre empleados.

En el listado de Personal se muestra enmascarado
("****" + ultimos 4 caracteres).

## Instalacion limpia

1. Clonar el repositorio.
2. Colocarlo en el servidor local.
3. Importar `sql/bd.sql`.
4. Opcional: `sql/00_usuarios_iniciales.sql` crea los 4 usuarios base.
5. Copiar `conexion.example.php` como
   `includes/conexion.php`.
6. Configurar las credenciales locales.
7. Iniciar Apache y MariaDB/MySQL.
8. Abrir la aplicacion.

## Datos reales

Nunca deben versionarse volcados que contengan datos reales
de empleados, usuarios, hashes, barcodes o asistencias.

`includes/conexion.php` es local y esta ignorado por Git.