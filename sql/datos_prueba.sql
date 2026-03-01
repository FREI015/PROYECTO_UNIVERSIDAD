USE control_asistencia;

INSERT INTO turnos (nombre, hora_inicio, hora_fin) VALUES
('MATUTINO','07:00:00','12:00:00'),
('VESPERTINO','13:00:00','17:00:00'),
('COMPLETO','07:00:00','17:00:00')
ON DUPLICATE KEY UPDATE hora_inicio=VALUES(hora_inicio), hora_fin=VALUES(hora_fin);

INSERT INTO cargos (nombre, descripcion) VALUES
('Docente','Personal docente'),
('Administrativo','Personal administrativo'),
('Obrero','Personal obrero'),
('Directivo','Directivos de la institución')
ON DUPLICATE KEY UPDATE descripcion=VALUES(descripcion);

-- Empleados demo
INSERT INTO empleados (cedula,nombres,apellidos,telefono,cargo_id,tipo_contrato,turno_id,estado)
SELECT '12345679','María','García','04121234567',
       (SELECT id FROM cargos WHERE nombre='Docente' LIMIT 1),
       'TURNO',
       (SELECT id FROM turnos WHERE nombre='MATUTINO' LIMIT 1),
       'ACTIVO'
WHERE NOT EXISTS (SELECT 1 FROM empleados WHERE cedula='12345679');

