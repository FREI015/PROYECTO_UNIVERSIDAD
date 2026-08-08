-- Migración: garantizar la columna `codigo_barra` en la tabla `empleados`
-- Idempotente: solo agrega la columna/índice si no existen; no falla
-- cuando el esquema ya los contiene (ej: importado desde bd.sql).
-- Usado por: modulos/personal.php y procesos/asistencia_barcode.php

CREATE DATABASE IF NOT EXISTS control_asistencia
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE control_asistencia;

SET @p_sql := (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE empleados ADD COLUMN codigo_barra VARCHAR(50) NULL AFTER telefono',
  'SELECT 1 AS noop')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleados' AND COLUMN_NAME = 'codigo_barra');
PREPARE stmt FROM @p_sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @p_sql := (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE empleados ADD UNIQUE KEY uq_empleados_codigo_barra (codigo_barra)',
  'SELECT 1 AS noop')
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'empleados' AND INDEX_NAME = 'uq_empleados_codigo_barra');
PREPARE stmt FROM @p_sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

UPDATE empleados
SET codigo_barra = CONCAT('EMP', LPAD(id, 5, '0'))
WHERE codigo_barra IS NULL
   OR TRIM(codigo_barra) = ''
   OR codigo_barra REGEXP '^EMP-';

DROP TRIGGER IF EXISTS trg_empleados_codigo_barra_bi;

DELIMITER |
CREATE TRIGGER trg_empleados_codigo_barra_bi
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
  IF NEW.codigo_barra IS NULL OR TRIM(NEW.codigo_barra) = '' THEN
    SET NEW.codigo_barra = CONCAT('EMP', LPAD(COALESCE((SELECT MAX(id) + 1 FROM empleados), 1), 5, '0'));
  END IF;
END|
DELIMITER ;