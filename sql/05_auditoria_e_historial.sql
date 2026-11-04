-- Ejecutar una sola vez tras comprobar el esquema en base local.
CREATE DATABASE IF NOT EXISTS control_asistencia CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE control_asistencia;

-- H-14: auditoria administrativa sin datos secretos.
CREATE TABLE IF NOT EXISTS auditoria_acciones (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  actor_id INT NULL,
  accion VARCHAR(70) NOT NULL,
  entidad VARCHAR(60) NOT NULL,
  entidad_id BIGINT NULL,
  detalle TEXT NULL,
  ip VARCHAR(45) NULL,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_auditoria_fecha (creado_en),
  KEY idx_auditoria_entidad (entidad, entidad_id),
  CONSTRAINT fk_auditoria_actor FOREIGN KEY (actor_id) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- H-18: conservacion de transiciones de estado laboral.
CREATE TABLE IF NOT EXISTS empleados_historial_estado (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT NOT NULL,
  estado_anterior ENUM('ACTIVO','SUSPENDIDO','RETIRADO') NOT NULL,
  estado_nuevo ENUM('ACTIVO','SUSPENDIDO','RETIRADO') NOT NULL,
  condicion_baja VARCHAR(120) NULL,
  actor_id INT NULL,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_historial_empleado_fecha (empleado_id, creado_en),
  CONSTRAINT fk_historial_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE RESTRICT,
  CONSTRAINT fk_historial_actor FOREIGN KEY (actor_id) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB;
