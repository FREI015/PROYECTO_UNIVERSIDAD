-- Ejecutar UNA VEZ en phpMyAdmin, sobre control_asistencia.
-- No modifica datos historicos ni rellena turnos de forma inventada.
ALTER TABLE asistencias
  ADD COLUMN IF NOT EXISTS turno_id_marcaje INT NULL,
  ADD COLUMN IF NOT EXISTS hora_inicio_marcaje TIME NULL,
  ADD COLUMN IF NOT EXISTS hora_fin_marcaje TIME NULL;
