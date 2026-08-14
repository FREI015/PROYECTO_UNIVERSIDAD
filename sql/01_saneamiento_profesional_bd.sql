/*
  SANEAMIENTO PROFESIONAL DE BASE DE DATOS
  Proyecto: Control de Asistencia
  Motor: MySQL/MariaDB

  Este script NO borra datos.
  Corrige inconsistencias reales detectadas:
  - empleados.codigo_barra faltante en bd.sql.
  - migracion de codigo_barra integrada.
  - cargos base iniciales.
  - indices para consultas frecuentes.
  - relaciones protegidas para no borrar historial.
  - eliminacion del generador secuencial heredado de codigo de barras.
*/

CREATE DATABASE IF NOT EXISTS control_asistencia
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE control_asistencia;

SET NAMES utf8mb4;
SET time_zone = '-04:00';

INSERT IGNORE INTO turnos (id, nombre, hora_inicio, hora_fin) VALUES
(1, 'MATUTINO', '07:00:00', '12:00:00'),
(2, 'VESPERTINO', '13:00:00', '17:00:00'),
(3, 'COMPLETO', '07:00:00', '17:00:00');

INSERT IGNORE INTO cargos (nombre, descripcion) VALUES
('DOCENTE', 'Personal docente'),
('ADMINISTRATIVO', 'Personal administrativo'),
('OBRERO', 'Personal obrero'),
('DIRECTIVO', 'Personal directivo');


DELIMITER $$

DROP PROCEDURE IF EXISTS add_column_if_missing$$
CREATE PROCEDURE add_column_if_missing(
  IN p_table VARCHAR(64),
  IN p_column VARCHAR(64),
  IN p_sql TEXT
)
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = p_table
      AND COLUMN_NAME = p_column
  ) THEN
    SET @sql_to_run = p_sql;
    PREPARE stmt FROM @sql_to_run;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END$$

DROP PROCEDURE IF EXISTS add_index_if_missing$$
CREATE PROCEDURE add_index_if_missing(
  IN p_table VARCHAR(64),
  IN p_index VARCHAR(64),
  IN p_sql TEXT
)
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = p_table
      AND INDEX_NAME = p_index
  ) THEN
    SET @sql_to_run = p_sql;
    PREPARE stmt FROM @sql_to_run;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END$$

DROP PROCEDURE IF EXISTS add_unique_single_column_if_missing$$
CREATE PROCEDURE add_unique_single_column_if_missing(
  IN p_table VARCHAR(64),
  IN p_column VARCHAR(64),
  IN p_index VARCHAR(64),
  IN p_sql TEXT
)
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = p_table
      AND COLUMN_NAME = p_column
      AND NON_UNIQUE = 0
  ) THEN
    SET @sql_to_run = p_sql;
    PREPARE stmt FROM @sql_to_run;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END$$

DROP PROCEDURE IF EXISTS drop_fk_if_exists$$
CREATE PROCEDURE drop_fk_if_exists(
  IN p_table VARCHAR(64),
  IN p_fk VARCHAR(64)
)
BEGIN
  IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = p_table
      AND CONSTRAINT_NAME = p_fk
      AND CONSTRAINT_TYPE = 'FOREIGN KEY'
  ) THEN
    SET @sql_to_run = CONCAT('ALTER TABLE `', p_table, '` DROP FOREIGN KEY `', p_fk, '`');
    PREPARE stmt FROM @sql_to_run;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END$$

DROP PROCEDURE IF EXISTS add_fk_if_missing$$
CREATE PROCEDURE add_fk_if_missing(
  IN p_table VARCHAR(64),
  IN p_fk VARCHAR(64),
  IN p_sql TEXT
)
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = p_table
      AND CONSTRAINT_NAME = p_fk
      AND CONSTRAINT_TYPE = 'FOREIGN KEY'
  ) THEN
    SET @sql_to_run = p_sql;
    PREPARE stmt FROM @sql_to_run;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END$$

DELIMITER ;

CALL add_column_if_missing(
  'empleados',
  'codigo_barra',
  'ALTER TABLE empleados ADD COLUMN codigo_barra VARCHAR(50) NULL AFTER telefono'
);

UPDATE empleados
SET turno_id = (SELECT id FROM turnos WHERE nombre = 'COMPLETO' LIMIT 1)
WHERE turno_id IS NULL;

ALTER TABLE empleados MODIFY turno_id INT NOT NULL;

UPDATE empleados
SET codigo_barra = NULL
WHERE codigo_barra IS NOT NULL
  AND TRIM(codigo_barra) = '';

-- No generar barcodes predecibles desde SQL.
UPDATE empleados
SET codigo_barra = NULL
WHERE codigo_barra IS NOT NULL
  AND TRIM(codigo_barra) = '';

-- Los duplicados deben corregirse mediante una migracion controlada en PHP
-- para producir valores aleatorios unicos con random_bytes().

CALL add_unique_single_column_if_missing(
  'empleados',
  'codigo_barra',
  'uq_empleados_codigo_barra',
  'ALTER TABLE empleados ADD UNIQUE KEY uq_empleados_codigo_barra (codigo_barra)'
);

CALL add_index_if_missing('empleados', 'idx_empleados_estado_turno', 'ALTER TABLE empleados ADD INDEX idx_empleados_estado_turno (estado, turno_id)');
CALL add_index_if_missing('empleados', 'idx_empleados_cargo', 'ALTER TABLE empleados ADD INDEX idx_empleados_cargo (cargo_id)');
CALL add_index_if_missing('empleados', 'idx_empleados_turno', 'ALTER TABLE empleados ADD INDEX idx_empleados_turno (turno_id)');

CALL add_index_if_missing('asistencias', 'idx_asistencias_fecha', 'ALTER TABLE asistencias ADD INDEX idx_asistencias_fecha (fecha)');
CALL add_index_if_missing('asistencias', 'idx_asistencias_estado_fecha', 'ALTER TABLE asistencias ADD INDEX idx_asistencias_estado_fecha (estado, fecha)');
CALL add_index_if_missing('asistencias', 'idx_asistencias_registrado_por', 'ALTER TABLE asistencias ADD INDEX idx_asistencias_registrado_por (registrado_por)');

CALL add_index_if_missing('permisos', 'idx_permisos_empleado_estado_fechas', 'ALTER TABLE permisos ADD INDEX idx_permisos_empleado_estado_fechas (empleado_id, estado, fecha_inicio, fecha_fin)');
CALL add_index_if_missing('permisos', 'idx_permisos_estado_fechas', 'ALTER TABLE permisos ADD INDEX idx_permisos_estado_fechas (estado, fecha_inicio, fecha_fin)');
CALL add_index_if_missing('permisos', 'idx_permisos_creado_por', 'ALTER TABLE permisos ADD INDEX idx_permisos_creado_por (creado_por)');

CALL add_index_if_missing('reposos', 'idx_reposos_empleado_estado_fechas', 'ALTER TABLE reposos ADD INDEX idx_reposos_empleado_estado_fechas (empleado_id, estado, fecha_inicio, fecha_fin)');
CALL add_index_if_missing('reposos', 'idx_reposos_estado_fechas', 'ALTER TABLE reposos ADD INDEX idx_reposos_estado_fechas (estado, fecha_inicio, fecha_fin)');
CALL add_index_if_missing('reposos', 'idx_reposos_creado_por', 'ALTER TABLE reposos ADD INDEX idx_reposos_creado_por (creado_por)');

CALL add_index_if_missing('usuarios', 'idx_usuarios_rol_estado', 'ALTER TABLE usuarios ADD INDEX idx_usuarios_rol_estado (rol, estado)');

CALL drop_fk_if_exists('empleados', 'fk_empleado_cargo');
CALL drop_fk_if_exists('empleados', 'fk_empleado_turno');
CALL drop_fk_if_exists('empleados', 'empleados_ibfk_1');
CALL drop_fk_if_exists('empleados', 'empleados_ibfk_2');
CALL drop_fk_if_exists('asistencias', 'fk_asistencia_empleado');
CALL drop_fk_if_exists('asistencias', 'fk_asistencia_usuario');
CALL drop_fk_if_exists('permisos', 'fk_permiso_empleado');
CALL drop_fk_if_exists('permisos', 'fk_permiso_usuario');
CALL drop_fk_if_exists('reposos', 'fk_reposo_empleado');
CALL drop_fk_if_exists('reposos', 'fk_reposo_usuario');

CALL add_fk_if_missing(
  'empleados',
  'fk_empleado_cargo',
  'ALTER TABLE empleados ADD CONSTRAINT fk_empleado_cargo FOREIGN KEY (cargo_id) REFERENCES cargos(id) ON DELETE RESTRICT ON UPDATE CASCADE'
);

CALL add_fk_if_missing(
  'empleados',
  'fk_empleado_turno',
  'ALTER TABLE empleados ADD CONSTRAINT fk_empleado_turno FOREIGN KEY (turno_id) REFERENCES turnos(id) ON DELETE RESTRICT ON UPDATE CASCADE'
);

CALL add_fk_if_missing(
  'asistencias',
  'fk_asistencia_empleado',
  'ALTER TABLE asistencias ADD CONSTRAINT fk_asistencia_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE RESTRICT ON UPDATE CASCADE'
);

CALL add_fk_if_missing(
  'asistencias',
  'fk_asistencia_usuario',
  'ALTER TABLE asistencias ADD CONSTRAINT fk_asistencia_usuario FOREIGN KEY (registrado_por) REFERENCES usuarios(id) ON DELETE SET NULL ON UPDATE CASCADE'
);

CALL add_fk_if_missing(
  'permisos',
  'fk_permiso_empleado',
  'ALTER TABLE permisos ADD CONSTRAINT fk_permiso_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE RESTRICT ON UPDATE CASCADE'
);

CALL add_fk_if_missing(
  'permisos',
  'fk_permiso_usuario',
  'ALTER TABLE permisos ADD CONSTRAINT fk_permiso_usuario FOREIGN KEY (creado_por) REFERENCES usuarios(id) ON DELETE SET NULL ON UPDATE CASCADE'
);

CALL add_fk_if_missing(
  'reposos',
  'fk_reposo_empleado',
  'ALTER TABLE reposos ADD CONSTRAINT fk_reposo_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE RESTRICT ON UPDATE CASCADE'
);

CALL add_fk_if_missing(
  'reposos',
  'fk_reposo_usuario',
  'ALTER TABLE reposos ADD CONSTRAINT fk_reposo_usuario FOREIGN KEY (creado_por) REFERENCES usuarios(id) ON DELETE SET NULL ON UPDATE CASCADE'
);

DROP TRIGGER IF EXISTS trg_empleados_codigo_barra_bi;

DROP PROCEDURE IF EXISTS add_column_if_missing;
DROP PROCEDURE IF EXISTS add_index_if_missing;
DROP PROCEDURE IF EXISTS add_unique_single_column_if_missing;
DROP PROCEDURE IF EXISTS drop_fk_if_exists;
DROP PROCEDURE IF EXISTS add_fk_if_missing;

SELECT 'OK - SANEAMIENTO PROFESIONAL EJECUTADO' AS resultado;

SELECT TABLE_NAME AS tabla
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME IN ('cargos','turnos','empleados','usuarios','asistencias','permisos','reposos')
ORDER BY TABLE_NAME;

SELECT COLUMN_NAME AS columna_empleados
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'empleados'
  AND COLUMN_NAME IN ('codigo_barra','turno_id','cargo_id')
ORDER BY COLUMN_NAME;

SELECT id, usuario, rol, estado
FROM usuarios
ORDER BY id;

