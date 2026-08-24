
# Actualización lector de código de barras

## Objetivo

Actualizar los modelos UML y MER para reflejar
la integración del lector de código de barras.

## Base de datos

Entidad modificada:

empleados


Nuevo atributo:

codigo_barra


Tipo:

VARCHAR(50)


Restricción:

UNIQUE


## Relación

Empleado 1:N Asistencias


## Flujo

Empleado presenta código

↓

Sistema captura código

↓

Busca empleado

↓

Registra asistencia



