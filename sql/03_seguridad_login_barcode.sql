-- ============================================================
-- 03 - SEGURIDAD LOGIN Y CODIGOS DE BARRAS
-- ============================================================

CREATE DATABASE IF NOT EXISTS control_asistencia
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE control_asistencia;

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

DROP TRIGGER IF EXISTS
  trg_empleados_codigo_barra_bi;

-- Los barcodes existentes deben rotarse mediante PHP usando
-- random_bytes(); no se generan a partir del ID del empleado.