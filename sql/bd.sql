
CREATE DATABASE IF NOT EXISTS control_asistencia
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE control_asistencia;

CREATE TABLE IF NOT EXISTS cargos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL UNIQUE,
  descripcion VARCHAR(200) NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS turnos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  CONSTRAINT chk_turnos_catalogo_integridad CHECK (
    hora_inicio < hora_fin
  )
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS empleados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cedula VARCHAR(15) NOT NULL UNIQUE,
  nombres VARCHAR(80) NOT NULL,
  apellidos VARCHAR(80) NOT NULL,
  telefono VARCHAR(20) NULL,
  codigo_barra VARCHAR(50) NOT NULL,
  cargo_id INT NOT NULL,
  tipo_contrato ENUM('HORA','TURNO') NOT NULL DEFAULT 'TURNO',
  turno_id INT NULL,
  jerarquia INT NOT NULL DEFAULT 5,
  foto_archivo VARCHAR(255) NULL,
  estado ENUM('ACTIVO','SUSPENDIDO','RETIRADO') NOT NULL DEFAULT 'ACTIVO',
  condicion_baja VARCHAR(120) NULL,
  fecha_baja DATE NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_empleados_codigo_barra (codigo_barra),
  CONSTRAINT fk_empleado_cargo FOREIGN KEY (cargo_id) REFERENCES cargos(id),
  CONSTRAINT fk_empleado_turno FOREIGN KEY (turno_id) REFERENCES turnos(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(50) NOT NULL UNIQUE,
  clave VARCHAR(255) NOT NULL,
  rol ENUM('DIURNO','TARDE','DIRECTORA','SUBDIRECTOR') NOT NULL DEFAULT 'DIURNO',
  estado ENUM('ACTIVO','INACTIVO') NOT NULL DEFAULT 'ACTIVO',
  debe_cambiar_clave TINYINT(1) NOT NULL DEFAULT 0,
  version_sesion INT UNSIGNED NOT NULL DEFAULT 1,
  clave_actualizada_en DATETIME NULL DEFAULT NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS usuario_codigos_recuperacion (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  selector CHAR(12) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  codigo_hash VARCHAR(255) NOT NULL,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  usado_en DATETIME NULL DEFAULT NULL,
  revocado_en DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_ucr_selector (selector),
  KEY idx_ucr_usuario_estado (usuario_id, usado_en, revocado_en),
  CONSTRAINT fk_ucr_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS recuperacion_intentos (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(50) NOT NULL,
  ip VARCHAR(45) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  exitoso TINYINT(1) NOT NULL DEFAULT 0,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_ri_usuario_fallo_fecha (usuario, exitoso, creado_en),
  KEY idx_ri_ip_fallo_fecha (ip, exitoso, creado_en),
  KEY idx_ri_creado_en (creado_en)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS login_intentos (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(50) NOT NULL,
  ip VARCHAR(45)
    CHARACTER SET ascii
    COLLATE ascii_bin
    NOT NULL,
  exitoso TINYINT(1) NOT NULL DEFAULT 0,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (id),

  KEY idx_li_usuario_ip_fallo_fecha (
    usuario,
    ip,
    exitoso,
    creado_en
  ),

  KEY idx_li_ip_fallo_fecha (
    ip,
    exitoso,
    creado_en
  ),

  KEY idx_li_creado_en (
    creado_en
  )
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS asistencias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT NOT NULL,
  fecha DATE NOT NULL,
  hora_entrada TIME NULL,
  hora_salida TIME NULL,
  turno_id_marcaje INT NULL,
  hora_inicio_marcaje TIME NULL,
  hora_fin_marcaje TIME NULL,
  minutos_tarde INT NOT NULL DEFAULT 0,
  horas_trabajadas DECIMAL(5,2) NULL,
  salida_estado VARCHAR(30) NULL DEFAULT NULL,
  minutos_salida_tardia INT NOT NULL DEFAULT 0,
  estado ENUM('ASISTIO','RETARDO','FALTA') NOT NULL DEFAULT 'ASISTIO',
  registrado_por INT NULL,
  observacion_sistema VARCHAR(255) NULL DEFAULT NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_asistencia_dia (empleado_id, fecha),
  CONSTRAINT chk_asistencias_snapshot_turno CHECK ((turno_id_marcaje IS NULL AND hora_inicio_marcaje IS NULL AND hora_fin_marcaje IS NULL) OR (turno_id_marcaje IS NOT NULL AND hora_inicio_marcaje IS NOT NULL AND hora_fin_marcaje IS NOT NULL AND hora_inicio_marcaje < hora_fin_marcaje)),
  KEY idx_asistencias_turno_marcaje (turno_id_marcaje),
  CONSTRAINT fk_asistencia_turno_marcaje FOREIGN KEY (turno_id_marcaje) REFERENCES turnos(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_asistencia_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE RESTRICT,
  CONSTRAINT fk_asistencia_usuario FOREIGN KEY (registrado_por) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS permisos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  tipo VARCHAR(60) NOT NULL,
  motivo VARCHAR(255) NULL,
  observaciones VARCHAR(255) NULL,
  estado ENUM('ACTIVO','CERRADO','ANULADO') NOT NULL DEFAULT 'ACTIVO',
  creado_por INT NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_permiso_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE RESTRICT,
  CONSTRAINT fk_permiso_usuario FOREIGN KEY (creado_por) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS reposos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  tipo VARCHAR(60) NOT NULL,
  motivo VARCHAR(255) NULL,
  observaciones VARCHAR(255) NULL,
  justificativo_archivo VARCHAR(255) NULL,
  estado ENUM('ACTIVO','CERRADO','ANULADO') NOT NULL DEFAULT 'ACTIVO',
  creado_por INT NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_reposo_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE RESTRICT,
  CONSTRAINT fk_reposo_usuario FOREIGN KEY (creado_por) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB;

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

INSERT IGNORE INTO turnos (id, nombre, hora_inicio, hora_fin) VALUES
(1, 'MATUTINO', '07:00:00', '12:00:00'),
(2, 'VESPERTINO', '13:00:00', '17:00:00'),
(3, 'COMPLETO', '07:00:00', '17:00:00');

INSERT IGNORE INTO cargos (nombre, descripcion) VALUES
('DOCENTE', 'Personal docente'),
('ADMINISTRATIVO', 'Personal administrativo'),
('OBRERO', 'Personal obrero'),
('DIRECTIVO', 'Personal directivo');

-- Los codigos de barras se generan en la aplicacion con random_bytes().


-- H-07: proteccion de catalogos.
DELIMITER $$
DROP TRIGGER IF EXISTS `trg_turnos_proteger_institucional_bu`$$

CREATE TRIGGER trg_turnos_proteger_institucional_bu
BEFORE UPDATE ON turnos
FOR EACH ROW
BEGIN
    IF OLD.id IN (1,2,3) AND (
        NEW.id <> OLD.id
        OR (OLD.id = 1 AND (
            UPPER(TRIM(NEW.nombre)) <> 'MATUTINO'
            OR NEW.hora_inicio <> '07:00:00'
            OR NEW.hora_fin <> '12:00:00'
        ))
        OR (OLD.id = 2 AND (
            UPPER(TRIM(NEW.nombre)) <> 'VESPERTINO'
            OR NEW.hora_inicio <> '13:00:00'
            OR NEW.hora_fin <> '17:00:00'
        ))
        OR (OLD.id = 3 AND (
            UPPER(TRIM(NEW.nombre)) <> 'COMPLETO'
            OR NEW.hora_inicio <> '07:00:00'
            OR NEW.hora_fin <> '17:00:00'
        ))
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_LOCK_INSTITUCIONAL_UPDATE';
    END IF;
END$$
DROP TRIGGER IF EXISTS `trg_turnos_proteger_institucional_bd`$$

CREATE TRIGGER trg_turnos_proteger_institucional_bd
BEFORE DELETE ON turnos
FOR EACH ROW
BEGIN
    IF OLD.id IN (1,2,3) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_LOCK_INSTITUCIONAL_DELETE';
    END IF;
END$$
DROP TRIGGER IF EXISTS `trg_turnos_proteger_dependencias_bu`$$

CREATE TRIGGER trg_turnos_proteger_dependencias_bu
BEFORE UPDATE ON turnos
FOR EACH ROW
BEGIN
    IF OLD.id NOT IN (1,2,3)
       AND (
           NEW.id <> OLD.id
           OR NOT (BINARY NEW.nombre <=> BINARY OLD.nombre)
           OR NOT (NEW.hora_inicio <=> OLD.hora_inicio)
           OR NOT (NEW.hora_fin <=> OLD.hora_fin)
       )
       AND (
           EXISTS (
               SELECT 1 FROM empleados
               WHERE turno_id = OLD.id
           )
           OR EXISTS (
               SELECT 1 FROM asistencias
               WHERE turno_id_marcaje = OLD.id
           )
           OR EXISTS (
               SELECT 1 FROM asistencias
               WHERE turno_id_marcaje IS NULL
           )
       )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_LOCK_TURNO_DEPENDENCIAS_UPDATE';
    END IF;
END$$
DROP TRIGGER IF EXISTS `trg_turnos_proteger_dependencias_bd`$$

CREATE TRIGGER trg_turnos_proteger_dependencias_bd
BEFORE DELETE ON turnos
FOR EACH ROW
BEGIN
    IF OLD.id NOT IN (1,2,3)
       AND (
           EXISTS (
               SELECT 1 FROM empleados
               WHERE turno_id = OLD.id
           )
           OR EXISTS (
               SELECT 1 FROM asistencias
               WHERE turno_id_marcaje = OLD.id
           )
           OR EXISTS (
               SELECT 1 FROM asistencias
               WHERE turno_id_marcaje IS NULL
           )
       )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_LOCK_TURNO_DEPENDENCIAS_DELETE';
    END IF;
END$$
DROP TRIGGER IF EXISTS `trg_cargos_proteger_asignados_bu`$$

CREATE TRIGGER trg_cargos_proteger_asignados_bu
BEFORE UPDATE ON cargos
FOR EACH ROW
BEGIN
    IF (
        UPPER(TRIM(OLD.nombre)) IN ('DOCENTE','ADMINISTRATIVO','OBRERO','DIRECTIVO')
        AND (
            NEW.id <> OLD.id
            OR BINARY NEW.nombre <> BINARY OLD.nombre
            OR NOT (NEW.descripcion <=> OLD.descripcion)
        )
    ) OR (
        UPPER(TRIM(NEW.nombre)) IN ('DOCENTE','ADMINISTRATIVO','OBRERO','DIRECTIVO')
        AND UPPER(TRIM(NEW.nombre)) <> UPPER(TRIM(OLD.nombre))
    ) OR (
        EXISTS (SELECT 1 FROM empleados WHERE cargo_id = OLD.id)
        AND (
            NEW.id <> OLD.id
            OR BINARY NEW.nombre <> BINARY OLD.nombre
            OR NOT (NEW.descripcion <=> OLD.descripcion)
        )
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_LOCK_CARGO_ASIGNADO_UPDATE';
    END IF;
END$$
DROP TRIGGER IF EXISTS `trg_cargos_proteger_asignados_bd`$$

CREATE TRIGGER trg_cargos_proteger_asignados_bd
BEFORE DELETE ON cargos
FOR EACH ROW
BEGIN
    IF UPPER(TRIM(OLD.nombre)) IN ('DOCENTE','ADMINISTRATIVO','OBRERO','DIRECTIVO')
       OR EXISTS (
           SELECT 1 FROM empleados
           WHERE cargo_id = OLD.id
       )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_LOCK_CARGO_ASIGNADO_DELETE';
    END IF;
END$$

DROP TRIGGER IF EXISTS `trg_cargos_proteger_reservados_bi`$$
CREATE TRIGGER trg_cargos_proteger_reservados_bi
BEFORE INSERT ON cargos
FOR EACH ROW
BEGIN
    IF UPPER(TRIM(NEW.nombre)) IN ('DOCENTE','ADMINISTRATIVO','OBRERO','DIRECTIVO')
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_RESERVED_CARGO_INSERT';
    END IF;
END$$
DROP TRIGGER IF EXISTS `trg_turnos_proteger_reservados_bi`$$
CREATE TRIGGER trg_turnos_proteger_reservados_bi
BEFORE INSERT ON turnos
FOR EACH ROW
BEGIN
    IF (
        NEW.id IN (1,2,3)
        OR UPPER(TRIM(NEW.nombre)) IN ('MATUTINO','VESPERTINO','COMPLETO')
    )
    AND NOT (
        (NEW.id = 1 AND BINARY NEW.nombre = BINARY 'MATUTINO' AND NEW.hora_inicio = '07:00:00' AND NEW.hora_fin = '12:00:00')
        OR
        (NEW.id = 2 AND BINARY NEW.nombre = BINARY 'VESPERTINO' AND NEW.hora_inicio = '13:00:00' AND NEW.hora_fin = '17:00:00')
        OR
        (NEW.id = 3 AND BINARY NEW.nombre = BINARY 'COMPLETO' AND NEW.hora_inicio = '07:00:00' AND NEW.hora_fin = '17:00:00')
    )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_RESERVED_TURNO_INSERT';
    END IF;
END$$
DROP TRIGGER IF EXISTS `trg_turnos_proteger_reservados_bu`$$
CREATE TRIGGER trg_turnos_proteger_reservados_bu
BEFORE UPDATE ON turnos
FOR EACH ROW
BEGIN
    IF OLD.id NOT IN (1,2,3)
       AND (
           NEW.id IN (1,2,3)
           OR UPPER(TRIM(NEW.nombre)) IN ('MATUTINO','VESPERTINO','COMPLETO')
       )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'H07_RESERVED_TURNO_UPDATE';
    END IF;
END$$
DELIMITER ;
