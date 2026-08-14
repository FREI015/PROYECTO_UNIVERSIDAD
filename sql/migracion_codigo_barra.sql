-- ============================================================
-- MIGRACION CODIGO DE BARRAS
--
-- La base garantiza la columna e indice unico.
-- La aplicacion genera los codigos mediante random_bytes().
-- ============================================================

CREATE DATABASE IF NOT EXISTS control_asistencia
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE control_asistencia;

SET @p_sql := (
  SELECT IF(
    COUNT(*) = 0,
    'ALTER TABLE empleados ADD COLUMN codigo_barra VARCHAR(50) NULL AFTER telefono',
    'SELECT 1 AS noop'
  )
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE
    TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'empleados'
    AND COLUMN_NAME = 'codigo_barra'
);

PREPARE stmt FROM @p_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @p_sql := (
  SELECT IF(
    COUNT(*) = 0,
    'ALTER TABLE empleados ADD UNIQUE KEY uq_empleados_codigo_barra (codigo_barra)',
    'SELECT 1 AS noop'
  )
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE
    TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'empleados'
    AND INDEX_NAME = 'uq_empleados_codigo_barra'
);

PREPARE stmt FROM @p_sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE empleados
SET codigo_barra = NULL
WHERE
  codigo_barra IS NOT NULL
  AND TRIM(codigo_barra) = '';

DROP TRIGGER IF EXISTS
  trg_empleados_codigo_barra_bi;