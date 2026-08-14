# Estado consolidado del sistema

## Asistencia

El sistema mantiene entrada y salida manual junto con
entrada y salida por codigo de barras.

La salida manual y barcode comparten el mismo nucleo de calculo.

## SIN_SALIDA

Las asistencias vencidas sin salida se gestionan mediante
la regla automatica definida por el sistema.

## Fotografias

La fotografia del empleado se almacena y presenta mediante
el flujo seguro implementado para asistencia.

## Roles

Roles actuales:

- DIRECTORA
- SUBDIRECTOR
- DIURNO
- TARDE

No existe el rol SUPER.

DIURNO y TARDE se limitan a su turno.
DIRECTORA y SUBDIRECTOR tienen alcance global.

## Seguridad de cuenta

El sistema dispone de:

- password_hash() y password_verify();
- cambio obligatorio de clave temporal;
- restablecimiento administrativo limitado;
- Mi perfil;
- cambio de la propia clave;
- version_sesion;
- codigos de recuperacion de un solo uso;
- rate limit de recuperacion;
- rate limit persistente del login administrativo.

## Codigo de barras

Los codigos actuales se generan mediante random_bytes(16).

Formato:

ASIS-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

No se construyen desde el ID del empleado.

No debe existir un trigger que genere EMP + ID.

## Kiosco

El kiosco publico permite registrar asistencia.

No publica un listado general de los ultimos empleados
ni sus horarios.

## Repositorio

No deben versionarse:

- credenciales reales;
- conexion local;
- volcados con datos reales;
- uploads de usuarios;
- backups locales.