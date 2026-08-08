-- Migración: garantizar columnas de salida en la tabla `asistencias`
-- Idempotente: solo agrega la columna si no existe, así no falla
-- cuando el esquema ya las contiene (ej: importado desde bd.sql).
-- Usado por: procesos/reporte_pdf.php y procesos/asistencia_salida.php

CREATE DATABASE IF NOT EXISTS control_asistencia
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE control_asistencia;

SET @p_sql := (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE asistencias ADD COLUMN salida_estado VARCHAR(30) NULL DEFAULT NULL AFTER horas_trabajadas',
  'SELECT 1 AS noop')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'asistencias' AND COLUMN_NAME = 'salida_estado');
PREPARE stmt FROM @p_sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @p_sql := (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE asistencias ADD COLUMN minutos_salida_tardia INT NOT NULL DEFAULT 0 AFTER salida_estado',
  'SELECT 1 AS noop')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'asistencias' AND COLUMN_NAME = 'minutos_salida_tardia');
PREPARE stmt FROM @p_sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @p_sql := (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE asistencias ADD COLUMN observacion_sistema VARCHAR(255) NULL DEFAULT NULL AFTER registrado_por',
  'SELECT 1 AS noop')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'asistencias' AND COLUMN_NAME = 'observacion_sistema');
PREPARE stmt FROM @p_sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;