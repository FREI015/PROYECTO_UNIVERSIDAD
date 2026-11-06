-- H-07: integridad de cargos, turnos e historial.
-- Aplicacion administrada por el instalador PHP.
-- No ejecutar manualmente despues de instalar.

ALTER TABLE turnos
ADD CONSTRAINT chk_turnos_catalogo_integridad CHECK (
    hora_inicio < hora_fin
);

ALTER TABLE asistencias
ADD KEY idx_asistencias_turno_marcaje (turno_id_marcaje),
ADD CONSTRAINT chk_asistencias_snapshot_turno CHECK (
    (turno_id_marcaje IS NULL AND hora_inicio_marcaje IS NULL AND hora_fin_marcaje IS NULL)
    OR
    (turno_id_marcaje IS NOT NULL AND hora_inicio_marcaje IS NOT NULL
     AND hora_fin_marcaje IS NOT NULL
     AND hora_inicio_marcaje < hora_fin_marcaje)
),
ADD CONSTRAINT fk_asistencia_turno_marcaje
FOREIGN KEY (turno_id_marcaje)
REFERENCES turnos(id)
ON DELETE RESTRICT ON UPDATE CASCADE;

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
