/*
  VENTANAS HORARIAS DEL SEGUNDO TURNO
  Proyecto: Control de Asistencia
  Motor: MySQL/MariaDB

  El segundo turno inicia a la 1:00 PM para que el calculo de
  retardos (hora_inicio + tolerancia) coincida con la ventana:
  - Entrada permitida: 12:55 PM a 3:00 PM.
  - Salida permitida: 5:00 PM a 6:00 PM.

  No borra asistencias ni modifica registros historicos.
*/

USE control_asistencia;

SET NAMES utf8mb4;
SET time_zone = '-04:00';

UPDATE turnos
SET hora_inicio = '13:00:00',
    hora_fin = '17:00:00'
WHERE id = 2
   OR UPPER(nombre) = 'VESPERTINO';
