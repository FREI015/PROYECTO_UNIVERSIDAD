
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
  hora_fin TIME NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS empleados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cedula VARCHAR(15) NOT NULL UNIQUE,
  nombres VARCHAR(80) NOT NULL,
  apellidos VARCHAR(80) NOT NULL,
  telefono VARCHAR(20) NULL,
  cargo_id INT NOT NULL,
  tipo_contrato ENUM('HORA','TURNO') NOT NULL DEFAULT 'TURNO',
  turno_id INT NULL,
  estado ENUM('ACTIVO','SUSPENDIDO','RETIRADO') NOT NULL DEFAULT 'ACTIVO',
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_empleado_cargo FOREIGN KEY (cargo_id) REFERENCES cargos(id),
  CONSTRAINT fk_empleado_turno FOREIGN KEY (turno_id) REFERENCES turnos(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario VARCHAR(50) NOT NULL UNIQUE,
  clave VARCHAR(255) NOT NULL,
  rol ENUM('DIURNO','TARDE','DIRECTORA','SUPER') NOT NULL DEFAULT 'DIURNO',
  estado ENUM('ACTIVO','INACTIVO') NOT NULL DEFAULT 'ACTIVO',
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS asistencias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT NOT NULL,
  fecha DATE NOT NULL,
  hora_entrada TIME NULL,
  hora_salida TIME NULL,
  minutos_tarde INT NOT NULL DEFAULT 0,
  horas_trabajadas DECIMAL(5,2) NULL,
  estado ENUM('ASISTIO','RETARDO','FALTA') NOT NULL DEFAULT 'ASISTIO',
  registrado_por INT NULL,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_asistencia_dia (empleado_id, fecha),
  CONSTRAINT fk_asistencia_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE,
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
  CONSTRAINT fk_permiso_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE,
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
  CONSTRAINT fk_reposo_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE,
  CONSTRAINT fk_reposo_usuario FOREIGN KEY (creado_por) REFERENCES usuarios(id) ON DELETE SET NULL
) ENGINE=InnoDB;
