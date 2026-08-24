# Estado consolidado del sistema

## Asistencia

El sistema mantiene entrada y salida manual junto con
entrada y salida por codigo de barras.

La salida manual y barcode comparten el mismo nucleo de calculo.

## Modo de emergencia

El modo de emergencia fue eliminado por completo (v1.1.0):

- No existe barra, boton, modal ni CSS de emergencia.
- procesos/modo_emergencia.php fue borrado.
- Las restricciones de reposo o permiso activo se aplican siempre
  tanto en la entrada manual como en la de codigo de barras.

## SIN_SALIDA

Las asistencias vencidas sin salida se gestionan mediante
la regla automatica definida por el sistema.

## Fotografias

La fotografia del empleado se almacena y presenta mediante
el flujo seguro implementado para asistencia.

La carga se valida en alta y edicion:

- imagen real y no corrupta;
- MIME permitido real (JPG, PNG, WEBP);
- dimensiones entre 40px y 12000px por lado;
- maximo 2 MB.

## Roles

Roles actuales:

- DIRECTORA
- SUBDIRECTOR
- DIURNO
- TARDE

No existe el rol SUPER.

DIURNO y TARDE se limitan a su turno.
DIRECTORA y SUBDIRECTOR tienen alcance global.

Permiso nuevo en v1.1.0:

- editar_personal: solo DIRECTORA y SUBDIRECTOR.

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

Desde v1.1.0 el codigo de barras se registra manualmente
al dar de alta o editar un empleado:

- obligatorio;
- mayusculas;
- maximo 50 caracteres;
- sin espacios ni comillas;
- unico entre empleados.

Se elimino la funcion generarCodigoBarra().

En el listado de Personal el codigo se muestra enmascarado
("****" + ultimos 4 caracteres) mediante enmascararCodigoBarra().
El codigo completo solo se carga en el modal de edicion.

## Personal

Listado con filtros de estado (Activos, Suspendidos, Retirados,
Mostrar Todos), orden jerarquico/alfabetico y acciones en una
sola linea por fila (Suspender/Retirar o Activar/Reingresar + Editar).

La edicion usa un modal con datos precargados; el codigo de barras
es obligatorio y la foto reemplazada elimina el archivo anterior.

## Permisos y Reposos

Ambos listados cuentan con filtros de consulta por empleado,
estado y rango de fechas, aplicados directamente en SQL y
respetando el alcance de turno por rol.

## Reportes PDF

Reporte general en orientacion horizontal (A4 apaisado) y reporte
individual en vertical, con fuentes y celdas uniformes.

## Campos obligatorios

Los campos con required muestran un asterisco rojo en su etiqueta
y el mensaje "Este campo es obligatorio." al intentar enviar vacio,
mediante assets/js/field-required.js.

## Usuarios

El listado ordena primero los usuarios ACTIVO y despues los INACTIVO,
conservando la jerarquia por rol y el orden alfabetico.

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

El detalle por archivo de cada cambio esta en CAMBIOS.md.




## Actualización lector de código de barras

Fecha:
2026-08-24


Cambios documentados:

- Actualización MER.
- Actualización diagrama de clases.
- Integración atributo codigo_barra.
- Relación empleados/asistencias.
- Flujo de registro mediante lector barcode.


