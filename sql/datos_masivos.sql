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


-- 1. INSERTANDO EMPLEADOS
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('28349518', 'Teresa', 'Vega', '0424-8495128', 3, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('14586348', 'Claudia', 'Arias', '0416-5565719', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('18517845', 'Ana', 'Ortiz', '0424-1454899', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('28729965', 'Francisco', 'Gómez', '0414-9786472', 1, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('31784222', 'Isabel', 'Pacheco', '0412-7211182', 1, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('30771087', 'Luis', 'Mendoza', '0412-7080858', 1, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('19638241', 'Verónica', 'Rivera', '0416-7633859', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('15582262', 'Diego', 'Ortiz', '0412-7779689', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('17377976', 'Lucía', 'Rojas', '0414-2948365', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('21268891', 'Luis', 'Vargas', '0414-8387655', 3, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('17969383', 'Manuel', 'Torres', '0414-5892203', 2, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('27576132', 'Isabel', 'Ortiz', '0414-6163401', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('11914547', 'Roberto', 'Martínez', '0426-2169476', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('15352111', 'Patricia', 'Vega', '0412-1200544', 2, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('28447882', 'Mónica', 'Vega', '0424-1550139', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('30616527', 'Pedro', 'Jiménez', '0412-3771776', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('27319128', 'Teresa', 'Álvarez', '0414-2788801', 1, 'TURNO', 3, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('17466734', 'Luis', 'Arias', '0426-3511670', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('13151660', 'Patricia', 'Álvarez', '0416-6988668', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('31962231', 'Jorge', 'Contreras', '0416-3973986', 4, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('10044506', 'Alejandro', 'García', '0424-8172766', 1, 'TURNO', 3, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('31564349', 'Alejandro', 'Moreno', '0424-1160024', 3, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('27230142', 'Gabriela', 'Flores', '0424-8486357', 1, 'TURNO', 3, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('29807557', 'Ricardo', 'Flores', '0426-5816558', 3, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('11357289', 'Sofía', 'Castro', '0416-7354824', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('10100483', 'Fernando', 'Silva', '0416-3122713', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('21325998', 'Raúl', 'Jiménez', '0414-3100753', 4, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('11088945', 'Miguel', 'Salazar', '0412-9943576', 2, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('24070907', 'Claudia', 'Pérez', '0414-7610119', 1, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('31168256', 'Lucía', 'Ruiz', '0412-6717630', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('10657082', 'Lucía', 'Guerrero', '0412-4165832', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('21463781', 'Beatriz', 'Arias', '0412-4063427', 1, 'TURNO', 3, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('21179131', 'Verónica', 'Vásquez', '0424-4723410', 4, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('13332209', 'Roberto', 'Álvarez', '0424-4491609', 3, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('21999226', 'María', 'Ramos', '0426-2605943', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('27570001', 'Javier', 'Castillo', '0416-6774572', 2, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('31834997', 'Fernando', 'Salazar', '0424-8191618', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('21045336', 'David', 'Salazar', '0416-1957210', 3, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('15284357', 'Ana', 'Arias', '0412-7085529', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('18880093', 'Daniel', 'Vásquez', '0426-8016355', 1, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('31195513', 'Francisco', 'Rojas', '0424-4630449', 4, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('27593948', 'Elena', 'Moreno', '0426-9349401', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('18673997', 'Raúl', 'Gómez', '0412-7675313', 1, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('11790010', 'Isabel', 'Ortiz', '0412-9566986', 2, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('26438973', 'Mónica', 'Torres', '0426-7199000', 1, 'TURNO', 3, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('31051160', 'Carmen', 'Pérez', '0414-5393884', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('17767733', 'Silvia', 'Gómez', '0414-7595349', 3, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('16945698', 'Beatriz', 'Mendoza', '0416-4378341', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('28865289', 'Miguel', 'Vargas', '0412-8990275', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('14742831', 'Gabriela', 'Romero', '0424-7534015', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('15334684', 'Javier', 'Rojas', '0424-9973091', 2, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('24467853', 'David', 'Ramos', '0424-1989912', 2, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('25457068', 'Gabriela', 'Salazar', '0424-5799665', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('12925897', 'Andrés', 'Rodríguez', '0414-9802639', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('10299602', 'Miguel', 'Salazar', '0424-1425396', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('16401484', 'Ricardo', 'Mendoza', '0426-1153969', 2, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('18632802', 'Carolina', 'Díaz', '0412-1644845', 1, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('16319189', 'Luis', 'Gutiérrez', '0424-9181505', 1, 'TURNO', 1, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('29279333', 'María', 'Pacheco', '0416-5587218', 4, 'TURNO', 2, 'ACTIVO');
INSERT INTO empleados (cedula, nombres, apellidos, telefono, cargo_id, tipo_contrato, turno_id, estado) VALUES ('23941733', 'Diego', 'Rodríguez', '0416-7892614', 1, 'TURNO', 2, 'ACTIVO');

-- 2. GENERANDO HISTORIAL (ASISTENCIAS, PERMISOS, REPOSOS)
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-03', '06:53:00', '11:57:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-03', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-03', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-03', '06:46:00', '11:57:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-03', '06:53:00', '11:56:00', 0, 5.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-03', '06:56:00', '12:13:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-03', '12:59:00', '17:04:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-03', '12:53:00', '17:00:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-03', '12:52:00', '17:03:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-03', '06:48:00', '11:57:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-03', '06:59:00', '11:58:00', 0, 4.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-03', '13:32:00', '17:03:00', 32, 3.52, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-03', '12:54:00', '17:14:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-03', '12:50:00', '17:04:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-03', '12:58:00', '17:11:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-03', '13:18:00', '17:03:00', 18, 3.75, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-03', '06:51:00', '17:10:00', 0, 10.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-03', '12:57:00', '17:00:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-03', '12:47:00', '17:03:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-03', '06:49:00', '12:14:00', 0, 5.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-03', '06:58:00', '17:02:00', 0, 10.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-03', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-03', '06:51:00', '17:02:00', 0, 10.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-03', '06:48:00', '11:58:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-03', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-03', '12:56:00', '17:11:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-03', '06:51:00', '12:07:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-03', '13:13:00', '16:59:00', 13, 3.77, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-03', '06:52:00', '12:09:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-03', '12:55:00', '16:56:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-03', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-03', '06:50:00', '17:00:00', 0, 10.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-03', '12:58:00', '16:57:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-03', '06:47:00', '12:10:00', 0, 5.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-03', '12:52:00', '16:57:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-03', '06:55:00', '12:12:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-03', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-03', '06:54:00', '11:57:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-03', '13:40:00', '17:15:00', 40, 3.58, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-03', '06:52:00', '12:07:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-03', '12:52:00', '17:10:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-03', '12:52:00', '16:59:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-03', '07:28:00', '12:09:00', 28, 4.68, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-03', '06:55:00', '11:56:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-03', '06:50:00', '17:00:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-03', '13:11:00', '17:09:00', 11, 3.97, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-03', '13:00:00', '17:07:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-03', '12:49:00', '17:10:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-03', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-03', '12:57:00', '17:12:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-03', '06:46:00', '12:15:00', 0, 5.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-03', '12:55:00', '16:59:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-03', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-03', '12:56:00', '17:03:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-03', '12:59:00', '16:55:00', 0, 3.93, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-03', '13:00:00', '16:58:00', 0, 3.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (57, '2025-11-03', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-03', '06:59:00', '12:04:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-03', '12:55:00', '17:14:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-03', '12:58:00', '17:08:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-04', '06:46:00', '12:15:00', 0, 5.48, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (2, '2025-11-04', '2025-11-04', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-04', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-04', '06:51:00', '12:03:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-04', '06:54:00', '12:09:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-04', '06:46:00', '12:12:00', 0, 5.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-04', '13:41:00', '17:01:00', 41, 3.33, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-04', '12:45:00', '17:10:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-04', '12:47:00', '17:12:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-04', '06:51:00', '12:05:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-04', '06:50:00', '12:14:00', 0, 5.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-04', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-04', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-04', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-04', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-04', '12:56:00', '17:03:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-04', '06:48:00', '17:11:00', 0, 10.38, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (18, '2025-11-04', '2025-11-08', 'Médico', 'Intervención dental', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-04', '12:55:00', '17:15:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-04', '06:57:00', '12:15:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-04', '06:56:00', '17:00:00', 0, 10.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-04', '12:45:00', '17:11:00', 0, 4.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-04', '06:56:00', '17:01:00', 0, 10.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-04', '06:53:00', '11:55:00', 0, 5.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-04', '12:58:00', '17:06:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-04', '12:58:00', '16:55:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-04', '06:46:00', '12:04:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-04', '13:00:00', '16:56:00', 0, 3.93, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-04', '06:51:00', '12:13:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-04', '12:55:00', '17:00:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-04', '13:26:00', '17:01:00', 26, 3.58, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-04', '06:57:00', '17:10:00', 0, 10.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (33, '2025-11-04', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-04', '06:57:00', '12:12:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-04', '13:45:00', '17:08:00', 45, 3.38, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-04', '06:56:00', '12:11:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-04', '12:45:00', '17:06:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-04', '06:52:00', '12:04:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-04', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-04', '06:50:00', '12:13:00', 0, 5.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-04', '12:53:00', '17:11:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-04', '12:50:00', '16:59:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (43, '2025-11-04', '2025-11-04', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-04', '06:53:00', '11:58:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-04', '06:50:00', '17:05:00', 0, 10.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-04', '12:57:00', '17:07:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-04', '13:30:00', '17:04:00', 30, 3.57, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-04', '12:46:00', '17:09:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-04', '12:55:00', '17:15:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-04', '12:56:00', '17:10:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-04', '06:55:00', '12:15:00', 0, 5.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-04', '12:54:00', '16:57:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (53, '2025-11-04', '2025-11-04', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-04', '13:42:00', '17:06:00', 42, 3.4, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (55, '2025-11-04', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-04', '12:46:00', '17:14:00', 0, 4.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-04', '13:16:00', '17:15:00', 16, 3.98, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-04', '06:59:00', '11:56:00', 0, 4.95, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-04', '12:49:00', '17:05:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-04', '13:42:00', '16:59:00', 42, 3.28, 'RETARDO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2025-11-05', '2025-11-10', 'Médico', 'Esguince de tobillo', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-05', '12:53:00', '17:15:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-05', '13:42:00', '17:15:00', 42, 3.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-05', '06:53:00', '12:14:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-05', '06:47:00', '12:06:00', 0, 5.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-05', '06:54:00', '12:02:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (7, '2025-11-05', '2025-11-05', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-05', '12:51:00', '16:57:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-05', '13:21:00', '16:59:00', 21, 3.63, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-05', '06:58:00', '12:04:00', 0, 5.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-05', '06:48:00', '11:55:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-05', '12:57:00', '17:00:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-05', '12:54:00', '17:10:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-05', '12:50:00', '17:04:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-05', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-05', '12:54:00', '16:56:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (17, '2025-11-05', '2025-11-08', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-05', '12:50:00', '17:07:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-05', '12:55:00', '17:05:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-05', '06:56:00', '12:05:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-05', '06:54:00', '17:03:00', 0, 10.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-05', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-05', '06:59:00', '16:55:00', 0, 9.93, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-05', '06:59:00', '12:06:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-05', '12:57:00', '17:00:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-05', '12:48:00', '17:07:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-05', '06:47:00', '11:56:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-05', '12:59:00', '17:07:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-05', '06:48:00', '12:05:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-05', '12:49:00', '17:07:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-05', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-05', '06:58:00', '17:13:00', 0, 10.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-05', '12:55:00', '17:11:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-05', '06:47:00', '12:15:00', 0, 5.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-05', '12:55:00', '17:02:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-05', '06:55:00', '11:59:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-05', '13:31:00', '16:57:00', 31, 3.43, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (38, '2025-11-05', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-05', '12:59:00', '16:57:00', 0, 3.97, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-05', '06:52:00', '11:55:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-05', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-05', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-05', '06:57:00', '12:14:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-05', '07:48:00', '11:55:00', 48, 4.12, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-05', '06:55:00', '17:01:00', 0, 10.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-05', '13:35:00', '16:57:00', 35, 3.37, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-05', '12:56:00', '17:09:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-05', '12:48:00', '17:00:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-05', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-05', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-05', '07:23:00', '12:10:00', 23, 4.78, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-05', '12:49:00', '17:10:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-05', '12:53:00', '17:02:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-05', '12:46:00', '16:58:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-05', '12:51:00', '17:12:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-05', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-05', '12:56:00', '17:13:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-05', '07:22:00', '12:09:00', 22, 4.78, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-05', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-05', '12:52:00', '17:09:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-06', '07:15:00', '12:05:00', 15, 4.83, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-06', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-06', '12:45:00', '17:00:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-06', '07:19:00', '12:05:00', 19, 4.77, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-06', '06:53:00', '12:02:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-06', '06:48:00', '12:11:00', 0, 5.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-06', '12:59:00', '16:59:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-06', '12:49:00', '17:03:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-06', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-06', '06:52:00', '12:15:00', 0, 5.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-06', '07:27:00', '12:12:00', 27, 4.75, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-06', '12:51:00', '17:02:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-06', '12:51:00', '17:12:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (14, '2025-11-06', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-06', '12:51:00', '17:09:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-06', '12:59:00', '17:15:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-06', '06:51:00', '17:00:00', 0, 10.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-06', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-06', '12:46:00', '17:09:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-06', '06:47:00', '12:00:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-06', '06:57:00', '16:58:00', 0, 10.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-06', '12:57:00', '16:58:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-06', '07:39:00', '17:13:00', 39, 9.57, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-06', '06:48:00', '11:55:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-06', '12:52:00', '17:09:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-06', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-06', '06:49:00', '12:00:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-06', '13:46:00', '16:57:00', 46, 3.18, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-06', '07:23:00', '12:01:00', 23, 4.63, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-06', '12:51:00', '17:01:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-06', '13:18:00', '16:58:00', 18, 3.67, 'RETARDO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (32, '2025-11-06', '2025-11-09', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-06', '13:18:00', '17:08:00', 18, 3.83, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-06', '06:53:00', '11:57:00', 0, 5.07, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (35, '2025-11-06', '2025-11-06', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (36, '2025-11-06', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-06', '12:45:00', '17:02:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-06', '06:53:00', '12:09:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-06', '13:00:00', '17:03:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-06', '06:58:00', '12:11:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-06', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-06', '12:59:00', '17:01:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-06', '06:45:00', '12:07:00', 0, 5.37, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (44, '2025-11-06', '2025-11-06', 'Eventualidad', 'Cita médica control', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-06', '06:52:00', '16:55:00', 0, 10.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-06', '12:46:00', '17:10:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-06', '12:47:00', '17:12:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-06', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-06', '12:57:00', '16:59:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-06', '12:53:00', '17:02:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-06', '06:54:00', '12:09:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-06', '12:45:00', '17:14:00', 0, 4.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-06', '12:46:00', '17:10:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-06', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-06', '12:45:00', '17:10:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-06', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-06', '12:47:00', '17:07:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-06', '07:19:00', '12:03:00', 19, 4.73, 'RETARDO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (59, '2025-11-06', '2025-11-06', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-06', '12:52:00', '17:14:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-07', '07:14:00', '12:09:00', 14, 4.92, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-07', '12:53:00', '17:06:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-07', '12:51:00', '16:59:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-07', '06:54:00', '12:05:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-07', '06:52:00', '12:07:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (6, '2025-11-07', '2025-11-07', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-07', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-07', '12:51:00', '17:03:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (9, '2025-11-07', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-07', '07:32:00', '12:09:00', 32, 4.62, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-07', '06:51:00', '12:00:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-07', '12:47:00', '16:58:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (13, '2025-11-07', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-07', '13:27:00', '17:11:00', 27, 3.73, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-07', '12:53:00', '17:11:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-07', '12:57:00', '17:00:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-07', '07:34:00', '17:12:00', 34, 9.63, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-07', '13:32:00', '17:08:00', 32, 3.6, 'RETARDO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (19, '2025-11-07', '2025-11-07', 'Eventualidad', 'Cita médica control', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-07', '07:39:00', '11:57:00', 39, 4.3, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-07', '06:50:00', '16:57:00', 0, 10.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-07', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-07', '06:55:00', '17:11:00', 0, 10.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-07', '06:49:00', '11:58:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-07', '13:46:00', '16:55:00', 46, 3.15, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (26, '2025-11-07', 'FALTA', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (27, '2025-11-07', '2025-11-12', 'Médico', 'Intervención dental', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-07', '12:56:00', '17:05:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (29, '2025-11-07', '2025-11-07', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-07', '13:13:00', '17:01:00', 13, 3.8, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-07', '12:48:00', '17:11:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-07', '06:48:00', '17:12:00', 0, 10.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-07', '13:46:00', '17:07:00', 46, 3.35, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-07', '06:52:00', '12:05:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (35, '2025-11-07', '2025-11-07', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-07', '06:57:00', '11:57:00', 0, 5.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-07', '12:47:00', '17:06:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-07', '06:52:00', '12:05:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-07', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-07', '06:48:00', '12:14:00', 0, 5.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-07', '12:56:00', '17:01:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-07', '12:57:00', '17:12:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-07', '07:41:00', '12:04:00', 41, 4.38, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-07', '06:51:00', '11:59:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-07', '06:58:00', '16:56:00', 0, 9.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-07', '13:13:00', '17:05:00', 13, 3.87, 'RETARDO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (47, '2025-11-07', '2025-11-07', 'Eventualidad', 'Trámite bancario', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-07', '12:50:00', '17:02:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-07', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-07', '12:54:00', '17:09:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-07', '06:51:00', '12:07:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-07', '13:00:00', '17:04:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (53, '2025-11-07', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-07', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (55, '2025-11-07', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-07', '12:49:00', '17:08:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-07', '12:48:00', '17:02:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-07', '06:45:00', '12:10:00', 0, 5.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-07', '12:48:00', '17:12:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (60, '2025-11-07', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-10', '06:52:00', '12:13:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-10', '12:51:00', '17:01:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-10', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-10', '06:51:00', '12:04:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-10', '06:49:00', '12:06:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (6, '2025-11-10', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-10', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (8, '2025-11-10', '2025-11-10', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-10', '13:27:00', '17:05:00', 27, 3.63, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-10', '06:48:00', '12:13:00', 0, 5.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-10', '07:36:00', '11:55:00', 36, 4.32, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-10', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-10', '13:49:00', '16:57:00', 49, 3.13, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-10', '12:45:00', '17:03:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-10', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (16, '2025-11-10', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-10', '06:46:00', '17:13:00', 0, 10.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-10', '12:47:00', '17:04:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-10', '13:45:00', '17:02:00', 45, 3.28, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (20, '2025-11-10', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-10', '06:50:00', '17:02:00', 0, 10.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-10', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-10', '06:55:00', '17:04:00', 0, 10.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-10', '06:53:00', '11:56:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-10', '12:50:00', '16:56:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-10', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-10', '06:59:00', '11:57:00', 0, 4.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-10', '12:52:00', '17:09:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (29, '2025-11-10', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-10', '13:00:00', '16:55:00', 0, 3.92, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-10', '13:28:00', '16:59:00', 28, 3.52, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-10', '06:59:00', '16:56:00', 0, 9.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-10', '12:59:00', '17:12:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-10', '06:51:00', '12:05:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-10', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-10', '06:49:00', '12:08:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-10', '12:55:00', '17:03:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (38, '2025-11-10', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-10', '12:49:00', '16:57:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (40, '2025-11-10', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-10', '12:48:00', '17:07:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-10', '12:52:00', '17:10:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-10', '06:46:00', '12:10:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (44, '2025-11-10', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-10', '06:46:00', '17:13:00', 0, 10.45, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-10', '12:47:00', '17:02:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-10', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-10', '12:48:00', '16:56:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-10', '12:57:00', '17:06:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-10', '12:57:00', '16:57:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-10', '06:47:00', '12:04:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-10', '12:56:00', '16:59:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-10', '12:46:00', '17:05:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-10', '12:46:00', '17:01:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-10', '12:45:00', '16:55:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-10', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-10', '13:16:00', '17:08:00', 16, 3.87, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-10', '07:18:00', '11:57:00', 18, 4.65, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-10', '13:16:00', '16:57:00', 16, 3.68, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-10', '12:54:00', '17:12:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-11', '06:52:00', '12:02:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-11', '12:47:00', '16:58:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-11', '12:45:00', '17:03:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-11', '06:49:00', '11:56:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (5, '2025-11-11', '2025-11-11', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-11', '07:00:00', '12:07:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-11', '12:50:00', '16:58:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-11', '12:51:00', '17:08:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-11', '12:52:00', '17:06:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-11', '06:47:00', '12:15:00', 0, 5.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-11', '06:49:00', '12:00:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (12, '2025-11-11', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-11', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-11', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (15, '2025-11-11', '2025-11-11', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-11', '12:52:00', '16:56:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-11', '06:51:00', '17:12:00', 0, 10.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-11', '12:53:00', '17:11:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-11', '12:52:00', '16:57:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-11', '06:50:00', '12:12:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-11', '06:53:00', '17:06:00', 0, 10.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-11', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-11', '06:45:00', '16:55:00', 0, 10.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-11', '06:48:00', '12:09:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (25, '2025-11-11', '2025-11-11', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-11', '13:45:00', '17:02:00', 45, 3.28, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-11', '06:47:00', '12:02:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-11', '12:55:00', '17:00:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-11', '06:46:00', '12:14:00', 0, 5.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-11', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-11', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-11', '06:54:00', '17:06:00', 0, 10.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-11', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-11', '06:46:00', '12:05:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-11', '12:50:00', '17:02:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-11', '07:11:00', '12:15:00', 11, 5.07, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-11', '12:46:00', '16:58:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-11', '06:53:00', '12:00:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-11', '12:47:00', '16:57:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-11', '06:52:00', '12:04:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-11', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-11', '12:52:00', '17:00:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-11', '06:57:00', '11:56:00', 0, 4.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-11', '06:45:00', '12:11:00', 0, 5.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-11', '06:55:00', '16:58:00', 0, 10.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-11', '12:54:00', '17:12:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-11', '12:59:00', '16:58:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-11', '12:56:00', '17:13:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-11', '12:57:00', '17:07:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-11', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-11', '06:50:00', '12:07:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (52, '2025-11-11', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-11', '12:49:00', '17:08:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-11', '12:51:00', '17:04:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-11', '12:47:00', '17:00:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-11', '13:00:00', '16:55:00', 0, 3.92, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-11', '12:58:00', '17:15:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-11', '06:45:00', '12:14:00', 0, 5.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-11', '13:18:00', '17:08:00', 18, 3.83, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-11', '13:13:00', '17:14:00', 13, 4.02, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-12', '06:52:00', '12:14:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-12', '12:54:00', '17:06:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-12', '12:50:00', '17:00:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (4, '2025-11-12', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-12', '06:46:00', '11:58:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-12', '07:10:00', '12:05:00', 10, 4.92, 'RETARDO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (7, '2025-11-12', '2025-11-12', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-12', '12:47:00', '16:58:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-12', '12:57:00', '16:58:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-12', '06:52:00', '12:00:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-12', '06:59:00', '12:15:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (12, '2025-11-12', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-12', '12:57:00', '16:57:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-12', '13:23:00', '16:57:00', 23, 3.57, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-12', '12:52:00', '17:07:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-12', '12:55:00', '16:58:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-12', '07:29:00', '17:12:00', 29, 9.72, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-12', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-12', '12:57:00', '17:09:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-12', '06:54:00', '12:01:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-12', '06:58:00', '17:03:00', 0, 10.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-12', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-12', '06:47:00', '17:14:00', 0, 10.45, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-12', '06:52:00', '12:07:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-12', '12:57:00', '17:14:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-12', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-12', '06:45:00', '12:06:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-12', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-12', '07:00:00', '11:55:00', 0, 4.92, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-12', '12:53:00', '17:00:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-12', '12:48:00', '17:06:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-12', '06:55:00', '16:55:00', 0, 10.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-12', '12:55:00', '17:15:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-12', '06:53:00', '11:55:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-12', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-12', '07:17:00', '12:02:00', 17, 4.75, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-12', '12:56:00', '16:57:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-12', '07:23:00', '12:03:00', 23, 4.67, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-12', '13:48:00', '16:59:00', 48, 3.18, 'RETARDO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (40, '2025-11-12', '2025-11-12', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-12', '12:47:00', '17:14:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-12', '12:59:00', '16:59:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-12', '06:54:00', '12:08:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-12', '07:32:00', '12:01:00', 32, 4.48, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-12', '06:46:00', '17:04:00', 0, 10.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-12', '12:52:00', '17:04:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-12', '13:00:00', '17:01:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-12', '12:48:00', '17:08:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-12', '13:25:00', '17:13:00', 25, 3.8, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-12', '12:55:00', '17:12:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-12', '06:50:00', '12:07:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-12', '12:53:00', '17:15:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-12', '13:21:00', '17:14:00', 21, 3.88, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-12', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-12', '12:52:00', '17:13:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (56, '2025-11-12', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-12', '13:23:00', '16:57:00', 23, 3.57, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-12', '06:48:00', '11:58:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-12', '13:27:00', '17:15:00', 27, 3.8, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (60, '2025-11-12', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-13', '06:50:00', '12:08:00', 0, 5.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-13', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-13', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-13', '06:47:00', '12:12:00', 0, 5.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-13', '06:47:00', '12:11:00', 0, 5.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-13', '07:00:00', '12:09:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-13', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (8, '2025-11-13', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-13', '12:46:00', '17:15:00', 0, 4.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-13', '07:47:00', '12:01:00', 47, 4.23, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-13', '06:53:00', '12:04:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-13', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-13', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-13', '12:49:00', '17:10:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-13', '12:55:00', '17:00:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-13', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-13', '07:10:00', '17:08:00', 10, 9.97, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-13', '12:49:00', '17:05:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-13', '12:52:00', '16:57:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-13', '07:38:00', '11:57:00', 38, 4.32, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-13', '07:00:00', '16:59:00', 0, 9.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-13', '12:51:00', '16:55:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-13', '06:48:00', '17:13:00', 0, 10.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (24, '2025-11-13', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-13', '12:54:00', '17:09:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-13', '12:45:00', '17:11:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-13', '07:50:00', '11:57:00', 50, 4.12, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-13', '12:46:00', '16:56:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-13', '06:53:00', '11:59:00', 0, 5.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-13', '12:50:00', '17:04:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-13', '12:49:00', '17:00:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-13', '06:54:00', '17:11:00', 0, 10.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-13', '12:45:00', '17:09:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-13', '06:47:00', '11:59:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-13', '12:51:00', '17:12:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-13', '07:41:00', '11:57:00', 41, 4.27, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-13', '12:48:00', '17:12:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (38, '2025-11-13', '2025-11-13', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-13', '12:52:00', '17:14:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-13', '06:51:00', '12:00:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-13', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-13', '12:57:00', '17:00:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-13', '06:54:00', '11:56:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-13', '07:00:00', '12:10:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-13', '06:46:00', '17:12:00', 0, 10.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-13', '12:53:00', '16:55:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (47, '2025-11-13', '2025-11-18', 'Médico', 'Migraña severa', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-13', '12:53:00', '16:57:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-13', '12:49:00', '17:07:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-13', '12:49:00', '17:07:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-13', '06:52:00', '11:59:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-13', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-13', '13:41:00', '16:59:00', 41, 3.3, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-13', '12:52:00', '17:10:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-13', '12:56:00', '16:55:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (56, '2025-11-13', '2025-11-13', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (57, '2025-11-13', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-13', '06:51:00', '12:15:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-13', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-13', '13:36:00', '17:10:00', 36, 3.57, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-14', '06:45:00', '11:57:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (2, '2025-11-14', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-14', '13:36:00', '17:10:00', 36, 3.57, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-14', '06:54:00', '11:57:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (5, '2025-11-14', '2025-11-14', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-14', '06:54:00', '12:06:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-14', '13:00:00', '16:58:00', 0, 3.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-14', '13:39:00', '17:11:00', 39, 3.53, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-14', '13:18:00', '16:56:00', 18, 3.63, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-14', '06:51:00', '12:14:00', 0, 5.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-14', '06:46:00', '11:56:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-14', '12:53:00', '16:57:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-14', '12:48:00', '17:08:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-14', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-14', '12:50:00', '17:03:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (16, '2025-11-14', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-14', '06:48:00', '17:06:00', 0, 10.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-14', '12:48:00', '17:06:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (19, '2025-11-14', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-14', '06:49:00', '12:01:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-14', '06:53:00', '17:15:00', 0, 10.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-14', '12:45:00', '17:15:00', 0, 4.5, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (23, '2025-11-14', '2025-11-14', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-14', '07:34:00', '12:07:00', 34, 4.55, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-14', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-14', '13:00:00', '17:08:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-14', '06:57:00', '12:08:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-14', '13:29:00', '17:01:00', 29, 3.53, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-14', '06:54:00', '12:15:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-14', '13:37:00', '17:14:00', 37, 3.62, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-14', '12:45:00', '17:14:00', 0, 4.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-14', '06:49:00', '17:08:00', 0, 10.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-14', '13:15:00', '17:10:00', 15, 3.92, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-14', '06:53:00', '12:03:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (35, '2025-11-14', '2025-11-14', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-14', '06:56:00', '12:08:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-14', '12:51:00', '16:57:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-14', '06:57:00', '12:06:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-14', '12:55:00', '17:11:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-14', '06:47:00', '12:01:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-14', '12:59:00', '16:58:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-14', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-14', '06:48:00', '11:57:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-14', '06:51:00', '12:08:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-14', '07:45:00', '17:07:00', 45, 9.37, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-14', '12:47:00', '17:12:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-14', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-14', '12:55:00', '16:59:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-14', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-14', '12:55:00', '17:15:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-14', '06:57:00', '11:56:00', 0, 4.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-14', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-14', '12:49:00', '16:55:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-14', '12:54:00', '17:05:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-14', '12:49:00', '16:57:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-14', '13:17:00', '17:08:00', 17, 3.85, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-14', '12:53:00', '17:03:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (58, '2025-11-14', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-14', '12:46:00', '17:07:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-14', '12:55:00', '16:56:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-17', '06:45:00', '12:10:00', 0, 5.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-17', '12:56:00', '17:02:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-17', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-17', '07:00:00', '11:57:00', 0, 4.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-17', '06:59:00', '12:04:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-17', '06:46:00', '11:55:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-17', '12:47:00', '16:56:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-17', '12:56:00', '16:55:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-17', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-17', '06:56:00', '12:10:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-17', '06:47:00', '12:02:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-17', '13:45:00', '17:12:00', 45, 3.45, 'RETARDO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (13, '2025-11-17', '2025-11-17', 'Eventualidad', 'Trámite bancario', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-17', '12:52:00', '17:02:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-17', '12:46:00', '17:01:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-17', '13:30:00', '16:55:00', 30, 3.42, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-17', '07:13:00', '17:13:00', 13, 10.0, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-17', '12:58:00', '16:57:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-17', '13:00:00', '17:01:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-17', '06:51:00', '12:07:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (21, '2025-11-17', '2025-11-17', 'Eventualidad', 'Cita médica control', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-17', '12:45:00', '17:11:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-17', '06:55:00', '17:03:00', 0, 10.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (24, '2025-11-17', 'FALTA', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (25, '2025-11-17', '2025-11-17', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-17', '12:52:00', '17:06:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-17', '06:50:00', '12:11:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (28, '2025-11-17', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-17', '06:53:00', '11:58:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-17', '13:20:00', '17:12:00', 20, 3.87, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-17', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-17', '06:55:00', '17:13:00', 0, 10.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-17', '12:47:00', '17:07:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-17', '06:57:00', '11:56:00', 0, 4.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-17', '12:47:00', '16:57:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-17', '06:49:00', '12:05:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-17', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-17', '06:55:00', '12:07:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (39, '2025-11-17', '2025-11-17', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-17', '06:57:00', '11:57:00', 0, 5.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-17', '12:55:00', '16:55:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (42, '2025-11-17', '2025-11-17', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-17', '06:58:00', '12:12:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (44, '2025-11-17', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-17', '06:45:00', '17:06:00', 0, 10.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-17', '12:54:00', '16:55:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-17', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-17', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-17', '12:51:00', '16:56:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-17', '13:50:00', '17:11:00', 50, 3.35, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-17', '06:55:00', '12:11:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-17', '13:50:00', '16:57:00', 50, 3.12, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-17', '12:56:00', '17:12:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-17', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-17', '13:23:00', '17:01:00', 23, 3.63, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-17', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-17', '12:48:00', '16:59:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-17', '06:56:00', '12:03:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-17', '13:41:00', '17:03:00', 41, 3.37, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-17', '12:59:00', '16:55:00', 0, 3.93, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2025-11-18', '2025-11-18', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-18', '12:54:00', '16:56:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-18', '12:48:00', '17:08:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-18', '06:57:00', '12:10:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-18', '06:54:00', '11:59:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-18', '06:59:00', '12:03:00', 0, 5.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-18', '13:26:00', '17:01:00', 26, 3.58, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-18', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-18', '12:51:00', '16:58:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-18', '06:59:00', '12:01:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (11, '2025-11-18', '2025-11-22', 'Médico', 'Intervención dental', 'ACTIVO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (12, '2025-11-18', '2025-11-21', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-18', '12:52:00', '17:10:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-18', '12:58:00', '16:57:00', 0, 3.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-18', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-18', '12:48:00', '16:56:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-18', '06:54:00', '16:57:00', 0, 10.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-18', '12:45:00', '17:06:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-18', '12:59:00', '17:14:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-18', '06:54:00', '12:15:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-18', '07:13:00', '17:03:00', 13, 9.83, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-18', '12:45:00', '16:57:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-18', '07:00:00', '17:10:00', 0, 10.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-18', '07:47:00', '11:57:00', 47, 4.17, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-18', '12:58:00', '17:12:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-18', '13:30:00', '17:11:00', 30, 3.68, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-18', '06:59:00', '11:56:00', 0, 4.95, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-18', '13:46:00', '17:14:00', 46, 3.47, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-18', '07:41:00', '11:57:00', 41, 4.27, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-18', '12:52:00', '17:09:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-18', '12:56:00', '17:15:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (32, '2025-11-18', '2025-11-18', 'Eventualidad', 'Trámite bancario', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-18', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-18', '06:56:00', '12:12:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-18', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-18', '06:49:00', '12:08:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-18', '12:58:00', '17:09:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-18', '06:48:00', '12:01:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-18', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (40, '2025-11-18', '2025-11-18', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-18', '13:30:00', '17:14:00', 30, 3.73, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-18', '13:32:00', '17:00:00', 32, 3.47, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-18', '06:58:00', '11:58:00', 0, 5.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-18', '07:00:00', '12:07:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-18', '06:53:00', '17:08:00', 0, 10.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-18', '12:57:00', '16:56:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-18', '13:39:00', '17:06:00', 39, 3.45, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-18', '12:50:00', '17:13:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-18', '12:50:00', '16:57:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-18', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-18', '06:55:00', '12:10:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-18', '12:59:00', '17:14:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-18', '12:48:00', '17:09:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-18', '12:45:00', '17:11:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (55, '2025-11-18', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-18', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-18', '12:45:00', '17:04:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-18', '06:50:00', '12:04:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-18', '12:46:00', '16:59:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-18', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-19', '07:28:00', '11:58:00', 28, 4.5, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-19', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-19', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-19', '06:50:00', '12:06:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (5, '2025-11-19', '2025-11-19', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-19', '06:51:00', '12:15:00', 0, 5.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-19', '12:50:00', '17:10:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-19', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-19', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-19', '06:53:00', '11:58:00', 0, 5.08, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (11, '2025-11-19', '2025-11-19', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-19', '12:57:00', '17:09:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-19', '13:16:00', '17:13:00', 16, 3.95, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-19', '12:45:00', '17:09:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-19', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-19', '12:55:00', '17:05:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-19', '07:00:00', '17:13:00', 0, 10.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-19', '12:52:00', '16:56:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-19', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-19', '06:54:00', '11:55:00', 0, 5.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-19', '06:48:00', '16:57:00', 0, 10.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (22, '2025-11-19', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-19', '06:51:00', '16:59:00', 0, 10.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-19', '06:59:00', '12:10:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-19', '12:46:00', '17:15:00', 0, 4.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-19', '12:45:00', '17:15:00', 0, 4.5, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-19', '07:23:00', '11:57:00', 23, 4.57, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-19', '12:51:00', '17:09:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-19', '06:50:00', '12:02:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-19', '12:55:00', '17:14:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-19', '12:54:00', '16:57:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-19', '06:57:00', '16:55:00', 0, 9.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-19', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-19', '06:46:00', '12:07:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-19', '13:00:00', '17:13:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (36, '2025-11-19', '2025-11-23', 'Médico', 'Infección estomacal', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-19', '13:00:00', '17:04:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-19', '07:13:00', '11:55:00', 13, 4.7, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-19', '12:56:00', '17:05:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-19', '07:00:00', '11:59:00', 0, 4.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-19', '13:48:00', '17:15:00', 48, 3.45, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-19', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-19', '06:55:00', '12:15:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-19', '06:50:00', '12:14:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-19', '06:56:00', '17:07:00', 0, 10.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-19', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-19', '12:57:00', '17:14:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (48, '2025-11-19', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-19', '12:46:00', '17:05:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-19', '12:49:00', '17:13:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-19', '07:32:00', '12:10:00', 32, 4.63, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-19', '12:54:00', '17:01:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-19', '13:47:00', '17:01:00', 47, 3.23, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-19', '12:57:00', '17:12:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-19', '12:45:00', '16:57:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-19', '12:52:00', '17:02:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-19', '13:36:00', '17:04:00', 36, 3.47, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-19', '06:49:00', '11:56:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-19', '12:47:00', '17:06:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-19', '12:56:00', '17:00:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-20', '06:57:00', '12:06:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-20', '12:46:00', '17:13:00', 0, 4.45, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-20', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-20', '07:26:00', '12:13:00', 26, 4.78, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-20', '07:16:00', '12:06:00', 16, 4.83, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-20', '06:48:00', '11:56:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-20', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-20', '12:46:00', '17:00:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-20', '12:47:00', '16:56:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-20', '07:16:00', '12:06:00', 16, 4.83, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-20', '06:58:00', '11:59:00', 0, 5.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-20', '12:52:00', '17:12:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-20', '12:49:00', '17:05:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-20', '12:50:00', '17:13:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-20', '12:46:00', '17:07:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (16, '2025-11-20', '2025-11-22', 'Médico', 'Infección estomacal', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-20', '06:58:00', '17:14:00', 0, 10.27, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (18, '2025-11-20', '2025-11-22', 'Médico', 'Migraña severa', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-20', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-20', '06:53:00', '12:09:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-20', '06:51:00', '17:15:00', 0, 10.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-20', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-20', '07:49:00', '17:01:00', 49, 9.2, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-20', '06:52:00', '12:03:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-20', '12:58:00', '17:00:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-20', '13:21:00', '17:10:00', 21, 3.82, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-20', '06:47:00', '12:07:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-20', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-20', '06:48:00', '12:05:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-20', '12:49:00', '17:01:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-20', '13:31:00', '17:05:00', 31, 3.57, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-20', '06:55:00', '17:03:00', 0, 10.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-20', '12:54:00', '16:56:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-20', '06:52:00', '11:55:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-20', '13:45:00', '17:13:00', 45, 3.47, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-20', '06:53:00', '12:06:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-20', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-20', '07:16:00', '12:09:00', 16, 4.88, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-20', '12:59:00', '16:59:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-20', '06:52:00', '11:55:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-20', '13:48:00', '16:56:00', 48, 3.13, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-20', '12:50:00', '16:58:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-20', '06:46:00', '12:03:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-20', '06:59:00', '11:56:00', 0, 4.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-20', '06:46:00', '16:58:00', 0, 10.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-20', '12:55:00', '17:02:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-20', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-20', '12:55:00', '17:00:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-20', '13:26:00', '17:08:00', 26, 3.7, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-20', '12:58:00', '17:15:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-20', '07:40:00', '11:55:00', 40, 4.25, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-20', '13:18:00', '17:06:00', 18, 3.8, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-20', '12:49:00', '16:55:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-20', '12:58:00', '17:13:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-20', '13:45:00', '17:15:00', 45, 3.5, 'RETARDO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (56, '2025-11-20', '2025-11-20', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-20', '13:26:00', '17:15:00', 26, 3.82, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-20', '06:50:00', '12:08:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-20', '13:12:00', '17:13:00', 12, 4.02, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-20', '13:33:00', '17:06:00', 33, 3.55, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-21', '06:46:00', '12:12:00', 0, 5.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-21', '12:59:00', '17:00:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-21', '12:48:00', '17:08:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-21', '06:55:00', '11:56:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-21', '06:48:00', '12:09:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-21', '06:54:00', '11:55:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-21', '12:51:00', '17:10:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-21', '12:57:00', '16:58:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-21', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-21', '06:48:00', '11:59:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-21', '06:57:00', '12:12:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-21', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-21', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (14, '2025-11-21', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-21', '13:00:00', '16:58:00', 0, 3.97, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-21', '12:55:00', '16:55:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-21', '06:48:00', '17:04:00', 0, 10.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (18, '2025-11-21', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-21', '12:57:00', '17:00:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-21', '06:51:00', '12:04:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-21', '07:10:00', '17:14:00', 10, 10.07, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-21', '12:45:00', '16:55:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-21', '06:45:00', '17:13:00', 0, 10.47, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-21', '07:00:00', '12:10:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-21', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-21', '12:46:00', '17:06:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-21', '06:54:00', '11:58:00', 0, 5.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-21', '12:45:00', '17:03:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-21', '06:59:00', '12:10:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-21', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-21', '12:47:00', '17:07:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-21', '06:45:00', '16:55:00', 0, 10.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-21', '12:49:00', '16:58:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-21', '06:53:00', '12:05:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-21', '12:56:00', '17:11:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-21', '06:59:00', '12:05:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-21', '12:52:00', '17:04:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-21', '07:22:00', '11:56:00', 22, 4.57, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-21', '12:46:00', '17:12:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-21', '06:46:00', '12:14:00', 0, 5.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-21', '12:53:00', '17:00:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-21', '12:52:00', '17:04:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-21', '06:59:00', '12:00:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-21', '06:49:00', '12:09:00', 0, 5.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-21', '06:58:00', '17:10:00', 0, 10.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-21', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-21', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-21', '12:58:00', '17:06:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-21', '12:45:00', '17:14:00', 0, 4.48, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-21', '12:45:00', '17:09:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-21', '06:48:00', '12:10:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-21', '12:54:00', '17:02:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-21', '12:55:00', '17:03:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-21', '12:46:00', '17:14:00', 0, 4.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-21', '12:52:00', '17:15:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-21', '12:47:00', '17:09:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-21', '12:58:00', '17:09:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (58, '2025-11-21', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-21', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-21', '12:58:00', '16:57:00', 0, 3.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (1, '2025-11-24', 'FALTA', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (2, '2025-11-24', '2025-11-24', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-24', '12:56:00', '17:06:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-24', '07:36:00', '12:06:00', 36, 4.5, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-24', '06:46:00', '12:10:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-24', '06:55:00', '12:09:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-24', '12:58:00', '16:55:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-24', '12:55:00', '17:08:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-24', '13:00:00', '17:01:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-24', '06:45:00', '12:08:00', 0, 5.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-24', '06:56:00', '12:08:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-24', '12:54:00', '17:07:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-24', '13:10:00', '17:02:00', 10, 3.87, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-24', '12:54:00', '17:06:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-24', '12:51:00', '16:58:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-24', '12:50:00', '17:08:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (17, '2025-11-24', '2025-11-24', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (18, '2025-11-24', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (19, '2025-11-24', 'FALTA', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (20, '2025-11-24', '2025-11-24', 'Eventualidad', 'Cita médica control', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-24', '06:48:00', '17:14:00', 0, 10.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-24', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-24', '07:23:00', '17:14:00', 23, 9.85, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-24', '06:50:00', '11:56:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-24', '12:46:00', '17:08:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-24', '12:47:00', '17:13:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-24', '06:48:00', '11:58:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-24', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-24', '06:53:00', '11:55:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-24', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-24', '12:55:00', '17:01:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-24', '06:47:00', '17:07:00', 0, 10.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-24', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-24', '07:49:00', '12:10:00', 49, 4.35, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-24', '12:54:00', '16:55:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (36, '2025-11-24', '2025-11-24', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-24', '12:48:00', '17:04:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-24', '07:12:00', '12:04:00', 12, 4.87, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-24', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-24', '07:12:00', '11:57:00', 12, 4.75, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-24', '13:49:00', '16:59:00', 49, 3.17, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-24', '12:56:00', '17:10:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (43, '2025-11-24', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-24', '06:59:00', '12:04:00', 0, 5.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-24', '06:59:00', '16:56:00', 0, 9.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-24', '12:54:00', '17:09:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-24', '13:48:00', '17:03:00', 48, 3.25, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-24', '12:53:00', '17:11:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-24', '12:56:00', '17:04:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-24', '12:57:00', '17:09:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-24', '06:54:00', '12:10:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-24', '12:50:00', '17:02:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-24', '12:59:00', '17:00:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-24', '12:55:00', '17:10:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-24', '12:54:00', '17:14:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-24', '12:58:00', '16:59:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-24', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-24', '06:51:00', '12:10:00', 0, 5.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-24', '13:22:00', '17:14:00', 22, 3.87, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-24', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-25', '07:46:00', '12:07:00', 46, 4.35, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-25', '12:51:00', '17:00:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-25', '12:55:00', '17:05:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (4, '2025-11-25', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-25', '07:35:00', '12:01:00', 35, 4.43, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-25', '06:50:00', '12:12:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-25', '12:46:00', '17:12:00', 0, 4.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-25', '12:46:00', '17:03:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-25', '12:51:00', '17:03:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-25', '06:46:00', '11:56:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-25', '06:49:00', '12:00:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-25', '13:30:00', '16:55:00', 30, 3.42, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-25', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-25', '12:55:00', '17:12:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (15, '2025-11-25', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-25', '12:47:00', '17:02:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-25', '06:49:00', '17:03:00', 0, 10.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-25', '12:52:00', '17:05:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-25', '13:35:00', '16:55:00', 35, 3.33, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-25', '06:51:00', '12:08:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-25', '07:24:00', '17:14:00', 24, 9.83, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-25', '13:00:00', '16:57:00', 0, 3.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-25', '06:56:00', '16:57:00', 0, 10.02, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (24, '2025-11-25', '2025-11-28', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-25', '12:50:00', '17:00:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-25', '12:48:00', '17:10:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-25', '06:48:00', '12:04:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-25', '13:33:00', '17:08:00', 33, 3.58, 'RETARDO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (29, '2025-11-25', '2025-11-29', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-25', '12:51:00', '16:55:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-25', '13:00:00', '17:05:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-25', '06:50:00', '16:59:00', 0, 10.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-25', '12:58:00', '17:10:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-25', '06:49:00', '12:08:00', 0, 5.32, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (35, '2025-11-25', '2025-11-27', 'Médico', 'Intervención dental', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-25', '07:23:00', '11:58:00', 23, 4.58, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-25', '12:47:00', '17:13:00', 0, 4.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-25', '06:56:00', '12:05:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-25', '12:56:00', '17:01:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-25', '06:51:00', '12:07:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (41, '2025-11-25', '2025-11-25', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (42, '2025-11-25', '2025-11-28', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-25', '06:52:00', '12:00:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-25', '06:46:00', '12:14:00', 0, 5.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-25', '06:49:00', '17:09:00', 0, 10.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-25', '12:53:00', '17:14:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-25', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-25', '13:17:00', '17:06:00', 17, 3.82, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-25', '12:54:00', '17:07:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (50, '2025-11-25', '2025-11-25', 'Eventualidad', 'Cita médica control', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-25', '06:58:00', '12:08:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-25', '12:51:00', '17:13:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-25', '13:00:00', '17:06:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-25', '12:49:00', '16:58:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-25', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-25', '12:48:00', '17:09:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-25', '12:58:00', '16:57:00', 0, 3.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-25', '07:49:00', '11:58:00', 49, 4.15, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-25', '12:54:00', '17:11:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-25', '13:00:00', '16:55:00', 0, 3.92, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-26', '06:59:00', '12:15:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-26', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-26', '13:24:00', '17:13:00', 24, 3.82, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (4, '2025-11-26', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-26', '06:58:00', '12:00:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-26', '06:52:00', '11:59:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-26', '12:47:00', '17:14:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-26', '12:54:00', '17:14:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-26', '12:49:00', '17:13:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-26', '07:20:00', '12:11:00', 20, 4.85, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-26', '06:49:00', '11:58:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-26', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-26', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-26', '13:41:00', '17:01:00', 41, 3.33, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-26', '12:56:00', '17:01:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-26', '12:54:00', '17:01:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-26', '07:17:00', '17:12:00', 17, 9.92, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-26', '12:47:00', '17:04:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-26', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-26', '07:44:00', '12:13:00', 44, 4.48, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-26', '06:58:00', '17:05:00', 0, 10.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-26', '12:57:00', '17:09:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (23, '2025-11-26', '2025-11-26', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-26', '06:57:00', '12:10:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-26', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (26, '2025-11-26', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-26', '06:48:00', '12:05:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-26', '12:54:00', '16:55:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-26', '07:23:00', '12:02:00', 23, 4.65, 'RETARDO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (30, '2025-11-26', '2025-12-01', 'Médico', 'Covid-19', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-26', '12:59:00', '17:07:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-26', '06:45:00', '17:10:00', 0, 10.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-26', '12:46:00', '17:00:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-26', '07:14:00', '11:59:00', 14, 4.75, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-26', '12:53:00', '17:07:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (36, '2025-11-26', '2025-11-28', 'Médico', 'Covid-19', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (37, '2025-11-26', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-26', '07:20:00', '12:10:00', 20, 4.83, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-26', '13:31:00', '17:11:00', 31, 3.67, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-26', '06:56:00', '11:58:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-26', '12:47:00', '17:11:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-26', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-26', '06:47:00', '12:12:00', 0, 5.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-26', '06:56:00', '12:11:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-26', '06:53:00', '17:06:00', 0, 10.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-26', '13:30:00', '16:57:00', 30, 3.45, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-26', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-26', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-26', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-26', '12:46:00', '17:01:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-26', '06:53:00', '12:07:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-26', '12:56:00', '16:57:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-26', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-26', '13:41:00', '17:14:00', 41, 3.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-26', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-26', '12:48:00', '17:02:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (57, '2025-11-26', '2025-11-29', 'Médico', 'Esguince de tobillo', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-26', '06:58:00', '12:11:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-26', '12:54:00', '17:04:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-26', '12:51:00', '17:11:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-27', '06:58:00', '12:02:00', 0, 5.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-27', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (3, '2025-11-27', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-27', '06:48:00', '12:00:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-27', '06:48:00', '12:00:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-27', '06:45:00', '12:00:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-27', '12:48:00', '17:13:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-27', '12:59:00', '16:59:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-27', '13:32:00', '16:58:00', 32, 3.43, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-27', '06:56:00', '12:14:00', 0, 5.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-27', '06:53:00', '12:14:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-27', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-27', '12:50:00', '17:09:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-27', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-27', '13:39:00', '16:58:00', 39, 3.32, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-27', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-27', '06:59:00', '16:58:00', 0, 9.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-27', '12:55:00', '17:01:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-27', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-27', '06:52:00', '12:10:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-27', '07:00:00', '17:03:00', 0, 10.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-27', '12:50:00', '17:00:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-27', '07:00:00', '16:55:00', 0, 9.92, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-27', '06:58:00', '12:05:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-27', '12:52:00', '17:15:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (26, '2025-11-27', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-27', '06:52:00', '12:00:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (28, '2025-11-27', '2025-11-27', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-27', '06:46:00', '12:11:00', 0, 5.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-27', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-27', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-27', '06:52:00', '17:04:00', 0, 10.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-27', '12:54:00', '17:04:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-27', '06:52:00', '11:58:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-11-27', '12:56:00', '16:58:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-27', '06:45:00', '11:55:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-27', '12:47:00', '17:10:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-11-27', '06:57:00', '12:01:00', 0, 5.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (39, '2025-11-27', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-27', '06:55:00', '12:11:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-27', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-27', '12:51:00', '17:03:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-27', '06:45:00', '12:14:00', 0, 5.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-27', '07:00:00', '12:11:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-11-27', '06:54:00', '16:59:00', 0, 10.08, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (46, '2025-11-27', '2025-12-01', 'Médico', 'Intervención dental', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-27', '12:58:00', '17:14:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-27', '12:47:00', '17:03:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-27', '12:53:00', '17:03:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-27', '12:48:00', '17:11:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-27', '07:45:00', '12:10:00', 45, 4.42, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-27', '12:57:00', '17:09:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-27', '13:44:00', '17:01:00', 44, 3.28, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-27', '12:46:00', '17:02:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-27', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-27', '12:52:00', '17:02:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-27', '12:54:00', '17:06:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-27', '06:52:00', '11:56:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-11-27', '12:51:00', '16:58:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-27', '12:58:00', '17:03:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-11-28', '06:50:00', '12:01:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-11-28', '12:58:00', '17:13:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-11-28', '12:55:00', '16:56:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-11-28', '06:46:00', '12:10:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-11-28', '06:54:00', '12:03:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-11-28', '06:57:00', '12:07:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-11-28', '12:45:00', '16:57:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-11-28', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-11-28', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-11-28', '06:45:00', '11:59:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-11-28', '06:58:00', '12:06:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-11-28', '12:52:00', '16:59:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-11-28', '12:48:00', '17:04:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-11-28', '12:56:00', '16:59:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-11-28', '12:55:00', '16:59:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-11-28', '13:48:00', '17:05:00', 48, 3.28, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-11-28', '06:59:00', '17:00:00', 0, 10.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-11-28', '12:47:00', '16:58:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-11-28', '12:46:00', '17:01:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-11-28', '06:48:00', '12:02:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-11-28', '06:45:00', '16:57:00', 0, 10.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-11-28', '13:17:00', '17:09:00', 17, 3.87, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-11-28', '07:00:00', '17:15:00', 0, 10.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-11-28', '06:58:00', '12:00:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-11-28', '13:35:00', '17:08:00', 35, 3.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-11-28', '13:35:00', '17:06:00', 35, 3.52, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-11-28', '06:49:00', '12:06:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-11-28', '12:53:00', '17:07:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-11-28', '07:19:00', '12:13:00', 19, 4.9, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-11-28', '13:41:00', '16:58:00', 41, 3.28, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-11-28', '13:44:00', '16:56:00', 44, 3.2, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-11-28', '06:53:00', '17:08:00', 0, 10.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-11-28', '12:53:00', '17:13:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-11-28', '07:12:00', '12:02:00', 12, 4.83, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (35, '2025-11-28', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-11-28', '07:00:00', '12:15:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-11-28', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (38, '2025-11-28', '2025-11-28', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-11-28', '13:43:00', '17:10:00', 43, 3.45, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-11-28', '06:56:00', '11:55:00', 0, 4.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-11-28', '12:48:00', '17:02:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-11-28', '13:10:00', '17:11:00', 10, 4.02, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-11-28', '06:47:00', '12:08:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-11-28', '06:48:00', '12:03:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (45, '2025-11-28', '2025-11-28', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-11-28', '12:50:00', '17:11:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-11-28', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-11-28', '12:52:00', '17:14:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-11-28', '12:54:00', '17:12:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-11-28', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-11-28', '06:56:00', '12:03:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-11-28', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-11-28', '12:55:00', '17:15:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-11-28', '12:58:00', '16:59:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-11-28', '12:55:00', '17:10:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-11-28', '12:45:00', '17:09:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-11-28', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-11-28', '06:58:00', '12:13:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (59, '2025-11-28', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-11-28', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-01', '06:53:00', '12:03:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-01', '13:15:00', '17:06:00', 15, 3.85, 'RETARDO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (3, '2025-12-01', '2025-12-01', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-01', '06:47:00', '12:11:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-01', '06:52:00', '12:14:00', 0, 5.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-01', '06:53:00', '12:08:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-01', '12:52:00', '16:59:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-01', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-01', '12:52:00', '17:11:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-01', '07:15:00', '11:58:00', 15, 4.72, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-01', '06:54:00', '12:00:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-01', '13:44:00', '17:02:00', 44, 3.3, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-01', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-01', '12:53:00', '17:06:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-01', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-01', '12:59:00', '17:02:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-01', '06:53:00', '17:05:00', 0, 10.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-01', '12:57:00', '16:55:00', 0, 3.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-01', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-01', '06:59:00', '12:11:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-01', '07:37:00', '17:11:00', 37, 9.57, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-01', '12:58:00', '17:10:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-01', '06:54:00', '17:09:00', 0, 10.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-01', '06:53:00', '11:56:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-01', '13:13:00', '17:03:00', 13, 3.83, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-01', '13:10:00', '17:06:00', 10, 3.93, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-01', '06:52:00', '12:01:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-01', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-01', '07:16:00', '12:04:00', 16, 4.8, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-01', '13:34:00', '16:58:00', 34, 3.4, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-01', '12:52:00', '17:00:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-01', '07:00:00', '17:08:00', 0, 10.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-01', '12:48:00', '17:06:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-01', '06:51:00', '12:01:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-01', '13:00:00', '17:04:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-01', '06:53:00', '12:14:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (37, '2025-12-01', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-01', '07:42:00', '12:09:00', 42, 4.45, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-01', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (40, '2025-12-01', '2025-12-01', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-01', '12:49:00', '17:08:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-01', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-01', '06:49:00', '12:05:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-01', '07:11:00', '12:05:00', 11, 4.9, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-01', '07:30:00', '16:55:00', 30, 9.42, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-01', '12:55:00', '16:56:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (47, '2025-12-01', '2025-12-01', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-01', '12:47:00', '16:58:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-01', '13:43:00', '17:15:00', 43, 3.53, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-01', '13:00:00', '17:12:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-01', '07:14:00', '12:11:00', 14, 4.95, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-01', '12:45:00', '17:00:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (53, '2025-12-01', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-01', '12:52:00', '16:57:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-01', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (56, '2025-12-01', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-01', '12:45:00', '16:56:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-01', '06:45:00', '12:04:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-01', '12:48:00', '17:09:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-01', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2025-12-02', '2025-12-02', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-02', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-02', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-02', '06:46:00', '12:02:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-02', '06:49:00', '12:10:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-02', '06:55:00', '12:11:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-02', '12:48:00', '17:04:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (8, '2025-12-02', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-02', '12:58:00', '17:08:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-02', '06:53:00', '12:02:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-02', '06:49:00', '11:56:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (12, '2025-12-02', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-02', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-02', '12:59:00', '17:08:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-02', '13:49:00', '17:01:00', 49, 3.2, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-02', '12:52:00', '17:15:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-02', '06:58:00', '17:02:00', 0, 10.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-02', '12:47:00', '17:06:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-02', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-02', '06:55:00', '12:08:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-02', '06:53:00', '17:05:00', 0, 10.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-02', '12:57:00', '17:09:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (23, '2025-12-02', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-02', '07:17:00', '12:13:00', 17, 4.93, 'RETARDO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (25, '2025-12-02', '2025-12-02', 'Eventualidad', 'Trámite bancario', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-02', '12:50:00', '17:15:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-02', '06:53:00', '11:56:00', 0, 5.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-02', '12:50:00', '17:10:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-02', '07:47:00', '12:00:00', 47, 4.22, 'RETARDO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (30, '2025-12-02', '2025-12-07', 'Médico', 'Migraña severa', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-02', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-02', '06:52:00', '17:07:00', 0, 10.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-02', '12:51:00', '16:58:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-02', '06:51:00', '12:07:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (35, '2025-12-02', '2025-12-02', 'Eventualidad', 'Cita médica control', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-02', '07:00:00', '12:13:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-02', '12:48:00', '17:04:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-02', '06:50:00', '12:06:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-02', '12:45:00', '17:15:00', 0, 4.5, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-02', '06:54:00', '12:03:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-02', '12:47:00', '17:05:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-02', '13:00:00', '16:55:00', 0, 3.92, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-02', '06:46:00', '11:58:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-02', '06:46:00', '12:01:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (45, '2025-12-02', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-02', '12:48:00', '16:55:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-02', '12:53:00', '17:03:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-02', '12:45:00', '17:01:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-02', '12:50:00', '17:13:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-02', '12:56:00', '17:15:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-02', '06:49:00', '12:06:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-02', '13:13:00', '17:03:00', 13, 3.83, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (53, '2025-12-02', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-02', '12:46:00', '17:10:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-02', '13:22:00', '17:14:00', 22, 3.87, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-02', '12:58:00', '17:10:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-02', '12:55:00', '17:12:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-02', '06:48:00', '12:05:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (59, '2025-12-02', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-02', '13:00:00', '17:03:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-03', '06:58:00', '12:01:00', 0, 5.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-03', '13:47:00', '16:57:00', 47, 3.17, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-03', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-03', '06:54:00', '12:02:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (5, '2025-12-03', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-03', '06:56:00', '12:11:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-03', '12:58:00', '17:08:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-03', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (9, '2025-12-03', 'FALTA', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (10, '2025-12-03', '2025-12-03', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-03', '06:55:00', '12:02:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-03', '12:45:00', '16:59:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-03', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-03', '12:58:00', '17:11:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-03', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-03', '12:49:00', '17:07:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-03', '06:52:00', '17:02:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (18, '2025-12-03', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-03', '13:14:00', '17:11:00', 14, 3.95, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-03', '07:41:00', '12:08:00', 41, 4.45, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-03', '07:43:00', '16:57:00', 43, 9.23, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-03', '13:12:00', '17:03:00', 12, 3.85, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-03', '07:00:00', '17:02:00', 0, 10.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-03', '06:57:00', '12:08:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-03', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-03', '12:48:00', '17:05:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-03', '06:47:00', '12:10:00', 0, 5.38, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (28, '2025-12-03', '2025-12-03', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-03', '06:55:00', '12:14:00', 0, 5.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-03', '13:29:00', '17:02:00', 29, 3.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-03', '12:47:00', '17:14:00', 0, 4.45, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-03', '06:58:00', '17:05:00', 0, 10.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-03', '12:49:00', '17:01:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-03', '06:59:00', '12:15:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-03', '13:00:00', '17:07:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-03', '06:50:00', '11:58:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-03', '12:57:00', '17:14:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-03', '06:51:00', '12:09:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-03', '12:45:00', '17:11:00', 0, 4.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-03', '07:00:00', '12:14:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-03', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-03', '12:57:00', '17:02:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-03', '07:15:00', '12:11:00', 15, 4.93, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-03', '06:55:00', '12:13:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-03', '06:52:00', '16:58:00', 0, 10.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-03', '12:58:00', '17:01:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (47, '2025-12-03', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-03', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-03', '12:45:00', '17:05:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-03', '12:54:00', '17:09:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-03', '06:58:00', '12:11:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-03', '12:48:00', '17:13:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-03', '13:42:00', '17:13:00', 42, 3.52, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-03', '13:00:00', '17:04:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-03', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-03', '12:57:00', '17:06:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-03', '12:49:00', '16:55:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-03', '06:45:00', '12:08:00', 0, 5.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-03', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-03', '13:27:00', '17:06:00', 27, 3.65, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-04', '07:13:00', '12:11:00', 13, 4.97, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-04', '13:25:00', '17:04:00', 25, 3.65, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-04', '13:40:00', '17:02:00', 40, 3.37, 'RETARDO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (4, '2025-12-04', '2025-12-08', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-04', '06:54:00', '12:08:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-04', '06:58:00', '11:56:00', 0, 4.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-04', '12:54:00', '17:07:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-04', '12:49:00', '17:08:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-04', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (10, '2025-12-04', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-04', '06:54:00', '11:58:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-04', '12:57:00', '17:07:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-04', '13:39:00', '17:10:00', 39, 3.52, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-04', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-04', '13:11:00', '17:12:00', 11, 4.02, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-04', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-04', '06:47:00', '17:02:00', 0, 10.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-04', '12:47:00', '17:06:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-04', '12:47:00', '17:06:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-04', '06:47:00', '11:56:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-04', '06:56:00', '16:59:00', 0, 10.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-04', '12:52:00', '16:59:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-04', '06:45:00', '17:09:00', 0, 10.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-04', '06:49:00', '12:12:00', 0, 5.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (25, '2025-12-04', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-04', '12:50:00', '17:10:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-04', '06:53:00', '11:59:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-04', '12:53:00', '17:03:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-04', '06:58:00', '12:03:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-04', '12:58:00', '17:00:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-04', '12:48:00', '17:15:00', 0, 4.45, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-04', '06:47:00', '16:57:00', 0, 10.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-04', '12:49:00', '17:15:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-04', '06:57:00', '12:01:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-04', '12:47:00', '16:56:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-04', '06:57:00', '12:03:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-04', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-04', '06:53:00', '11:59:00', 0, 5.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-04', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-04', '07:00:00', '12:00:00', 0, 5.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-04', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-04', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-04', '06:49:00', '11:56:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-04', '06:51:00', '12:11:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-04', '06:56:00', '16:59:00', 0, 10.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-04', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-04', '13:22:00', '17:05:00', 22, 3.72, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-04', '13:14:00', '17:08:00', 14, 3.9, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-04', '12:58:00', '17:02:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-04', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-04', '07:00:00', '12:15:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-04', '12:45:00', '17:04:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (53, '2025-12-04', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-04', '12:56:00', '17:11:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-04', '12:56:00', '17:00:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-04', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-04', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-04', '06:58:00', '12:00:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-04', '13:48:00', '16:56:00', 48, 3.13, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-04', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-05', '06:48:00', '12:07:00', 0, 5.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-05', '12:49:00', '17:09:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-05', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-05', '07:00:00', '11:56:00', 0, 4.93, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-05', '06:59:00', '12:01:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-05', '07:41:00', '12:07:00', 41, 4.43, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-05', '12:55:00', '17:08:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-05', '12:55:00', '16:58:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-05', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-05', '06:46:00', '12:14:00', 0, 5.47, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (11, '2025-12-05', '2025-12-07', 'Médico', 'Esguince de tobillo', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-05', '13:37:00', '17:11:00', 37, 3.57, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-05', '12:51:00', '17:13:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-05', '12:58:00', '17:07:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-05', '12:58:00', '16:59:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-05', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-05', '06:59:00', '17:01:00', 0, 10.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-05', '13:00:00', '17:05:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-05', '12:51:00', '16:56:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-05', '06:57:00', '12:00:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-05', '06:46:00', '17:15:00', 0, 10.48, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-05', '12:58:00', '17:01:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-05', '06:52:00', '17:02:00', 0, 10.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-05', '06:55:00', '11:55:00', 0, 5.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-05', '13:00:00', '16:58:00', 0, 3.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-05', '12:52:00', '17:12:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-05', '06:45:00', '11:59:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-05', '12:54:00', '17:10:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-05', '06:53:00', '11:57:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-05', '12:45:00', '17:02:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-05', '12:46:00', '17:09:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-05', '06:48:00', '17:03:00', 0, 10.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-05', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-05', '06:50:00', '12:01:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-05', '13:19:00', '17:08:00', 19, 3.82, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-05', '06:51:00', '12:10:00', 0, 5.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-05', '12:51:00', '16:55:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-05', '07:49:00', '12:12:00', 49, 4.38, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-05', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-05', '06:50:00', '12:08:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-05', '13:00:00', '16:57:00', 0, 3.95, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-05', '12:48:00', '17:15:00', 0, 4.45, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-05', '06:52:00', '11:57:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-05', '07:35:00', '12:14:00', 35, 4.65, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-05', '06:54:00', '17:00:00', 0, 10.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-05', '12:49:00', '16:58:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-05', '12:48:00', '17:10:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-05', '12:45:00', '17:12:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-05', '12:59:00', '17:05:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-05', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-05', '06:50:00', '12:07:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (52, '2025-12-05', '2025-12-05', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-05', '13:00:00', '17:04:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-05', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-05', '13:24:00', '16:57:00', 24, 3.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-05', '12:50:00', '17:13:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-05', '12:56:00', '17:10:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-05', '06:52:00', '12:06:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-05', '13:44:00', '17:05:00', 44, 3.35, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-05', '12:58:00', '17:10:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-08', '06:58:00', '11:57:00', 0, 4.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-08', '13:47:00', '17:01:00', 47, 3.23, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-08', '12:56:00', '16:59:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-08', '07:50:00', '12:03:00', 50, 4.22, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-08', '06:47:00', '12:05:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-08', '06:47:00', '12:09:00', 0, 5.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-08', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-08', '12:52:00', '17:11:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-08', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-08', '06:52:00', '11:57:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-08', '06:47:00', '11:59:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-08', '12:56:00', '17:06:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-08', '13:11:00', '17:14:00', 11, 4.05, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-08', '12:51:00', '17:04:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-08', '12:46:00', '17:03:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-08', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-08', '06:50:00', '17:07:00', 0, 10.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-08', '12:55:00', '17:00:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-08', '12:48:00', '17:08:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (20, '2025-12-08', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-08', '06:48:00', '17:09:00', 0, 10.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-08', '12:48:00', '17:10:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-08', '06:54:00', '17:10:00', 0, 10.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-08', '07:00:00', '12:06:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-08', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-08', '13:14:00', '16:58:00', 14, 3.73, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-08', '06:57:00', '12:15:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-08', '13:00:00', '17:02:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-08', '06:56:00', '12:04:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-08', '12:55:00', '17:01:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-08', '12:56:00', '17:05:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-08', '06:58:00', '16:59:00', 0, 10.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-08', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-08', '06:55:00', '12:12:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-08', '12:47:00', '17:11:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-08', '06:45:00', '12:02:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-08', '12:50:00', '17:10:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-08', '07:41:00', '12:06:00', 41, 4.42, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-08', '12:53:00', '16:57:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-08', '06:48:00', '11:58:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-08', '12:57:00', '17:11:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-08', '12:52:00', '17:07:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-08', '06:59:00', '12:08:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (44, '2025-12-08', '2025-12-10', 'Médico', 'Esguince de tobillo', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (45, '2025-12-08', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-08', '12:56:00', '17:06:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-08', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-08', '12:49:00', '16:57:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-08', '12:47:00', '17:09:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-08', '12:59:00', '17:06:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-08', '06:46:00', '11:57:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-08', '12:52:00', '17:05:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-08', '12:45:00', '17:15:00', 0, 4.5, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-08', '12:55:00', '17:09:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-08', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-08', '13:17:00', '17:08:00', 17, 3.85, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-08', '13:24:00', '16:55:00', 24, 3.52, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-08', '07:10:00', '12:08:00', 10, 4.97, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-08', '12:48:00', '17:10:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-08', '12:50:00', '16:56:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-09', '07:27:00', '12:02:00', 27, 4.58, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-09', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-09', '12:56:00', '17:03:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-09', '07:00:00', '12:04:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-09', '06:49:00', '12:06:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-09', '06:51:00', '12:00:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-09', '12:52:00', '17:05:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-09', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (9, '2025-12-09', '2025-12-09', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-09', '07:20:00', '12:01:00', 20, 4.68, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-09', '06:46:00', '11:56:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-09', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-09', '13:00:00', '17:13:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-09', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-09', '12:54:00', '17:03:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-09', '13:44:00', '17:15:00', 44, 3.52, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-09', '06:59:00', '17:12:00', 0, 10.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-09', '12:58:00', '17:05:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-09', '12:47:00', '17:10:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-09', '06:57:00', '11:59:00', 0, 5.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-09', '06:55:00', '16:55:00', 0, 10.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-09', '12:47:00', '17:02:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-09', '06:49:00', '16:55:00', 0, 10.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-09', '06:49:00', '12:04:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-09', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (26, '2025-12-09', '2025-12-09', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-09', '07:44:00', '12:15:00', 44, 4.52, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-09', '12:51:00', '17:01:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-09', '06:57:00', '12:14:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-09', '13:11:00', '17:10:00', 11, 3.98, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-09', '12:45:00', '16:55:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (32, '2025-12-09', '2025-12-13', 'Médico', 'Infección estomacal', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-09', '12:50:00', '17:15:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-09', '07:00:00', '12:01:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-09', '12:58:00', '17:05:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-09', '06:52:00', '12:10:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-09', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-09', '06:56:00', '12:00:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-09', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-09', '06:55:00', '12:15:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-09', '12:54:00', '17:09:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-09', '12:58:00', '16:57:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-09', '07:33:00', '12:04:00', 33, 4.52, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-09', '06:56:00', '11:59:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-09', '07:00:00', '17:09:00', 0, 10.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-09', '12:59:00', '16:59:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (47, '2025-12-09', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-09', '12:53:00', '17:10:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-09', '12:59:00', '16:58:00', 0, 3.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-09', '12:53:00', '17:00:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (51, '2025-12-09', '2025-12-14', 'Médico', 'Migraña severa', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-09', '12:59:00', '17:06:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-09', '13:42:00', '16:58:00', 42, 3.27, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-09', '12:59:00', '17:07:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-09', '12:52:00', '17:14:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (56, '2025-12-09', '2025-12-14', 'Médico', 'Intervención dental', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-09', '12:45:00', '16:55:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-09', '06:55:00', '12:04:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-09', '12:54:00', '16:59:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-09', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-10', '06:52:00', '12:12:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-10', '12:58:00', '17:13:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-10', '12:49:00', '17:02:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-10', '06:48:00', '11:59:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-10', '06:58:00', '12:13:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-10', '06:55:00', '12:09:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-10', '12:46:00', '17:15:00', 0, 4.48, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-10', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-10', '13:29:00', '17:10:00', 29, 3.68, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-10', '06:47:00', '12:11:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-10', '06:58:00', '12:15:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-10', '12:45:00', '17:03:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-10', '13:40:00', '17:12:00', 40, 3.53, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-10', '13:29:00', '16:58:00', 29, 3.48, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-10', '12:59:00', '17:10:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (16, '2025-12-10', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-10', '06:56:00', '17:05:00', 0, 10.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-10', '12:57:00', '16:56:00', 0, 3.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-10', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-10', '06:55:00', '12:06:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-10', '07:20:00', '17:07:00', 20, 9.78, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-10', '12:54:00', '16:56:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-10', '07:46:00', '17:04:00', 46, 9.3, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-10', '06:56:00', '12:03:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-10', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-10', '13:44:00', '17:11:00', 44, 3.45, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-10', '07:22:00', '12:06:00', 22, 4.73, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-10', '12:55:00', '16:58:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-10', '06:51:00', '12:10:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-10', '12:55:00', '16:59:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-10', '12:56:00', '16:59:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (32, '2025-12-10', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-10', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-10', '06:53:00', '12:09:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-10', '13:43:00', '17:15:00', 43, 3.53, 'RETARDO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (36, '2025-12-10', '2025-12-10', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (37, '2025-12-10', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-10', '06:47:00', '12:15:00', 0, 5.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (39, '2025-12-10', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-10', '06:46:00', '12:07:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-10', '13:46:00', '17:00:00', 46, 3.23, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-10', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-10', '06:45:00', '12:10:00', 0, 5.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-10', '06:47:00', '12:03:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-10', '07:25:00', '17:13:00', 25, 9.8, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-10', '12:57:00', '16:57:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-10', '13:00:00', '17:08:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-10', '12:55:00', '17:10:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-10', '12:45:00', '17:04:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-10', '12:59:00', '17:08:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-10', '06:59:00', '12:12:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (52, '2025-12-10', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-10', '13:17:00', '16:58:00', 17, 3.68, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-10', '12:55:00', '16:58:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-10', '12:53:00', '17:10:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-10', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-10', '12:47:00', '17:15:00', 0, 4.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-10', '06:58:00', '12:12:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-10', '13:00:00', '17:02:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-10', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-11', '06:51:00', '12:15:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-11', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-11', '12:46:00', '17:13:00', 0, 4.45, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-11', '06:56:00', '12:01:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-11', '06:52:00', '12:15:00', 0, 5.38, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (6, '2025-12-11', '2025-12-11', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-11', '13:28:00', '17:15:00', 28, 3.78, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (8, '2025-12-11', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-11', '13:18:00', '17:09:00', 18, 3.85, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-11', '06:47:00', '12:05:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-11', '07:30:00', '12:11:00', 30, 4.68, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-11', '12:45:00', '17:00:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-11', '12:45:00', '17:14:00', 0, 4.48, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-11', '12:57:00', '17:09:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-11', '12:48:00', '16:57:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-11', '13:00:00', '17:04:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-11', '06:57:00', '17:10:00', 0, 10.22, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (18, '2025-12-11', '2025-12-11', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-11', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (20, '2025-12-11', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-11', '06:52:00', '16:57:00', 0, 10.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-11', '12:48:00', '17:03:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-11', '06:45:00', '17:08:00', 0, 10.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-11', '06:45:00', '12:05:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-11', '13:44:00', '16:55:00', 44, 3.18, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-11', '12:54:00', '16:56:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-11', '06:51:00', '12:03:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-11', '12:54:00', '16:55:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-11', '07:00:00', '12:13:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-11', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-11', '12:47:00', '17:02:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-11', '06:54:00', '17:06:00', 0, 10.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-11', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-11', '06:58:00', '11:58:00', 0, 5.0, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (35, '2025-12-11', '2025-12-16', 'Médico', 'Migraña severa', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-11', '06:56:00', '11:57:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-11', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-11', '06:46:00', '12:07:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (39, '2025-12-11', '2025-12-14', 'Médico', 'Covid-19', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (40, '2025-12-11', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-11', '13:20:00', '17:01:00', 20, 3.68, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-11', '13:18:00', '17:02:00', 18, 3.73, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-11', '06:50:00', '12:06:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-11', '06:56:00', '12:06:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-11', '06:55:00', '17:09:00', 0, 10.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-11', '12:45:00', '17:12:00', 0, 4.45, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-11', '12:46:00', '17:02:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-11', '12:56:00', '17:11:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-11', '13:29:00', '17:15:00', 29, 3.77, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-11', '12:56:00', '17:11:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-11', '06:47:00', '12:07:00', 0, 5.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-11', '12:50:00', '17:10:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-11', '12:46:00', '17:05:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-11', '12:56:00', '17:03:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-11', '12:54:00', '17:11:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-11', '13:36:00', '17:13:00', 36, 3.62, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-11', '13:11:00', '17:11:00', 11, 4.0, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-11', '06:47:00', '12:10:00', 0, 5.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-11', '12:48:00', '16:56:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-11', '13:00:00', '17:05:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-12', '06:53:00', '12:01:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-12', '12:50:00', '16:55:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-12', '12:50:00', '17:00:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-12', '06:49:00', '11:57:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-12', '06:50:00', '12:01:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (6, '2025-12-12', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-12', '13:00:00', '16:57:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-12', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-12', '13:35:00', '17:10:00', 35, 3.58, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-12', '06:51:00', '11:58:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-12', '07:21:00', '12:06:00', 21, 4.75, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-12', '13:21:00', '17:06:00', 21, 3.75, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-12', '12:50:00', '17:13:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-12', '12:54:00', '17:07:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-12', '12:52:00', '16:56:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-12', '12:51:00', '16:57:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-12', '06:56:00', '16:57:00', 0, 10.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-12', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-12', '12:51:00', '16:59:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-12', '07:34:00', '12:06:00', 34, 4.53, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-12', '06:59:00', '17:08:00', 0, 10.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (22, '2025-12-12', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-12', '06:56:00', '17:15:00', 0, 10.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-12', '06:59:00', '12:15:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-12', '12:48:00', '17:08:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-12', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-12', '06:52:00', '12:05:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-12', '12:53:00', '17:12:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-12', '06:54:00', '12:03:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (30, '2025-12-12', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-12', '12:46:00', '17:06:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-12', '07:34:00', '17:12:00', 34, 9.63, 'RETARDO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (33, '2025-12-12', '2025-12-12', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-12', '06:57:00', '12:00:00', 0, 5.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-12', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-12', '06:59:00', '12:05:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-12', '12:48:00', '16:56:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-12', '07:15:00', '12:06:00', 15, 4.85, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-12', '13:14:00', '17:09:00', 14, 3.92, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-12', '06:54:00', '12:06:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-12', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-12', '12:57:00', '16:56:00', 0, 3.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-12', '06:51:00', '12:01:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-12', '07:00:00', '12:05:00', 0, 5.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-12', '06:47:00', '17:05:00', 0, 10.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-12', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-12', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-12', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-12', '12:58:00', '17:11:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (50, '2025-12-12', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-12', '06:48:00', '11:58:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-12', '12:50:00', '16:56:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-12', '12:49:00', '17:01:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-12', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-12', '13:35:00', '17:08:00', 35, 3.55, 'RETARDO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (56, '2025-12-12', '2025-12-12', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-12', '12:50:00', '17:08:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-12', '07:46:00', '12:02:00', 46, 4.27, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-12', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-12', '12:57:00', '17:13:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-15', '06:47:00', '11:57:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-15', '13:38:00', '16:58:00', 38, 3.33, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-15', '12:57:00', '16:59:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-15', '07:24:00', '12:06:00', 24, 4.7, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-15', '07:11:00', '12:11:00', 11, 5.0, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-15', '07:16:00', '12:07:00', 16, 4.85, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-15', '12:49:00', '17:09:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-15', '12:50:00', '17:08:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-15', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-15', '06:47:00', '12:09:00', 0, 5.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-15', '06:46:00', '12:12:00', 0, 5.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-15', '12:48:00', '16:56:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-15', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (14, '2025-12-15', '2025-12-15', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-15', '12:53:00', '17:10:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-15', '12:47:00', '17:00:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-15', '06:49:00', '17:15:00', 0, 10.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-15', '12:47:00', '17:07:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (19, '2025-12-15', '2025-12-17', 'Médico', 'Migraña severa', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-15', '06:52:00', '12:05:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-15', '06:51:00', '17:11:00', 0, 10.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-15', '12:50:00', '17:03:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-15', '06:55:00', '17:02:00', 0, 10.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-15', '07:32:00', '12:15:00', 32, 4.72, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-15', '12:51:00', '17:10:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-15', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-15', '06:54:00', '12:04:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-15', '13:47:00', '17:13:00', 47, 3.43, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-15', '06:50:00', '12:14:00', 0, 5.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-15', '12:56:00', '17:04:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-15', '12:51:00', '17:02:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-15', '06:55:00', '16:55:00', 0, 10.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-15', '13:12:00', '17:02:00', 12, 3.83, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-15', '06:53:00', '12:05:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-15', '13:13:00', '16:55:00', 13, 3.7, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-15', '06:50:00', '12:15:00', 0, 5.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-15', '12:45:00', '17:11:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-15', '06:54:00', '12:05:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-15', '13:12:00', '17:13:00', 12, 4.02, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-15', '06:45:00', '12:15:00', 0, 5.5, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-15', '12:52:00', '17:12:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-15', '12:47:00', '17:11:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-15', '06:52:00', '12:02:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-15', '06:59:00', '12:03:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-15', '06:56:00', '17:12:00', 0, 10.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-15', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-15', '12:57:00', '17:14:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-15', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-15', '12:50:00', '17:11:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-15', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-15', '06:56:00', '12:03:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-15', '12:55:00', '17:02:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-15', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-15', '12:58:00', '17:10:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (55, '2025-12-15', '2025-12-20', 'Médico', 'Esguince de tobillo', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-15', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-15', '12:48:00', '17:00:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-15', '06:56:00', '12:13:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-15', '12:49:00', '17:02:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-15', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-16', '06:48:00', '12:02:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-16', '12:58:00', '16:59:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-16', '12:56:00', '17:12:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-16', '06:56:00', '12:14:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-16', '07:45:00', '12:08:00', 45, 4.38, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-16', '06:47:00', '12:05:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-16', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-16', '12:45:00', '17:01:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-16', '12:51:00', '16:58:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-16', '07:00:00', '12:13:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-16', '06:57:00', '12:14:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-16', '13:17:00', '16:56:00', 17, 3.65, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-16', '13:33:00', '17:00:00', 33, 3.45, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-16', '12:47:00', '16:57:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-16', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-16', '13:10:00', '17:05:00', 10, 3.92, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-16', '06:48:00', '17:06:00', 0, 10.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-16', '12:52:00', '17:11:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-16', '12:53:00', '17:00:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-16', '07:00:00', '12:06:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-16', '06:56:00', '16:56:00', 0, 10.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-16', '12:54:00', '17:07:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-16', '06:58:00', '17:00:00', 0, 10.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-16', '06:53:00', '12:14:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-16', '13:00:00', '16:59:00', 0, 3.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-16', '12:45:00', '17:10:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-16', '06:59:00', '12:06:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-16', '12:50:00', '16:59:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-16', '06:47:00', '12:12:00', 0, 5.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-16', '12:45:00', '16:59:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-16', '12:54:00', '17:13:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-16', '06:47:00', '17:06:00', 0, 10.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-16', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-16', '06:55:00', '12:12:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-16', '12:51:00', '17:03:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-16', '06:45:00', '12:04:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-16', '13:16:00', '17:05:00', 16, 3.82, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-16', '06:58:00', '12:09:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-16', '12:54:00', '17:12:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-16', '07:00:00', '12:06:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-16', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-16', '12:50:00', '16:55:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-16', '06:55:00', '11:56:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-16', '06:54:00', '12:04:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-16', '06:52:00', '17:09:00', 0, 10.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-16', '13:43:00', '16:58:00', 43, 3.25, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-16', '13:24:00', '16:56:00', 24, 3.53, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (48, '2025-12-16', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-16', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-16', '12:58:00', '17:12:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-16', '06:54:00', '11:55:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-16', '12:50:00', '16:59:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-16', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-16', '12:51:00', '16:57:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-16', '12:59:00', '17:04:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-16', '13:35:00', '17:08:00', 35, 3.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-16', '12:53:00', '16:57:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-16', '06:55:00', '12:02:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-16', '12:54:00', '17:02:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-16', '12:49:00', '17:01:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-17', '06:45:00', '12:04:00', 0, 5.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-17', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-17', '12:48:00', '17:11:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-17', '06:54:00', '11:59:00', 0, 5.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-17', '06:47:00', '11:55:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-17', '06:46:00', '12:13:00', 0, 5.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-17', '12:51:00', '17:09:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (8, '2025-12-17', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-17', '13:48:00', '17:06:00', 48, 3.3, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-17', '07:00:00', '12:12:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-17', '06:58:00', '12:00:00', 0, 5.03, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (12, '2025-12-17', '2025-12-17', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-17', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-17', '12:52:00', '17:08:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (15, '2025-12-17', '2025-12-17', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-17', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (17, '2025-12-17', '2025-12-17', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-17', '12:50:00', '17:15:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-17', '12:50:00', '16:58:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-17', '07:10:00', '11:58:00', 10, 4.8, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-17', '07:12:00', '17:11:00', 12, 9.98, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-17', '12:57:00', '17:07:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-17', '06:50:00', '17:00:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-17', '06:57:00', '12:00:00', 0, 5.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-17', '12:57:00', '17:06:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-17', '13:44:00', '17:12:00', 44, 3.47, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-17', '07:25:00', '12:06:00', 25, 4.68, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-17', '12:57:00', '17:11:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-17', '06:45:00', '12:00:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-17', '12:48:00', '16:56:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-17', '13:00:00', '17:10:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-17', '06:55:00', '17:02:00', 0, 10.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-17', '12:46:00', '17:08:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-17', '06:52:00', '12:08:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-17', '12:54:00', '17:02:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-17', '06:53:00', '12:14:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-17', '12:45:00', '16:59:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-17', '06:52:00', '12:12:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (39, '2025-12-17', '2025-12-17', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-17', '06:46:00', '12:02:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-17', '12:53:00', '17:15:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-17', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-17', '07:10:00', '12:14:00', 10, 5.07, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-17', '06:55:00', '12:04:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-17', '06:53:00', '16:57:00', 0, 10.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-17', '12:52:00', '17:05:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-17', '12:59:00', '17:11:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-17', '12:59:00', '17:12:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-17', '12:46:00', '17:15:00', 0, 4.48, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-17', '12:45:00', '16:59:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-17', '07:12:00', '12:11:00', 12, 4.98, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-17', '12:51:00', '17:13:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-17', '13:39:00', '17:05:00', 39, 3.43, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-17', '12:47:00', '16:58:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-17', '12:48:00', '17:05:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (56, '2025-12-17', '2025-12-19', 'Médico', 'Infección estomacal', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-17', '12:58:00', '17:08:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-17', '07:00:00', '12:07:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (59, '2025-12-17', '2025-12-17', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-17', '12:54:00', '17:13:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-18', '06:49:00', '11:59:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-18', '12:56:00', '17:06:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (3, '2025-12-18', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-18', '06:51:00', '12:13:00', 0, 5.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-18', '07:45:00', '12:14:00', 45, 4.48, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-18', '06:58:00', '11:59:00', 0, 5.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-18', '13:00:00', '17:06:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-18', '13:19:00', '17:05:00', 19, 3.77, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-18', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (10, '2025-12-18', '2025-12-21', 'Médico', 'Intervención dental', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-18', '06:48:00', '12:11:00', 0, 5.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-18', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-18', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-18', '13:47:00', '17:02:00', 47, 3.25, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-18', '12:56:00', '17:13:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-18', '12:55:00', '17:02:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-18', '06:57:00', '17:07:00', 0, 10.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-18', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-18', '12:53:00', '17:15:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-18', '06:46:00', '12:12:00', 0, 5.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-18', '06:57:00', '17:13:00', 0, 10.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (22, '2025-12-18', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-18', '07:00:00', '17:02:00', 0, 10.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-18', '06:48:00', '12:09:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-18', '13:00:00', '16:58:00', 0, 3.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-18', '12:47:00', '16:56:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-18', '06:48:00', '11:56:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-18', '12:53:00', '17:14:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-18', '07:42:00', '12:12:00', 42, 4.5, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-18', '13:32:00', '16:57:00', 32, 3.42, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-18', '12:56:00', '17:03:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-18', '06:50:00', '17:08:00', 0, 10.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-18', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-18', '07:00:00', '11:55:00', 0, 4.92, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-18', '12:49:00', '16:57:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-18', '06:55:00', '12:06:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-18', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-18', '06:45:00', '11:59:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-18', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-18', '07:38:00', '12:15:00', 38, 4.62, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-18', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-18', '12:49:00', '16:59:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-18', '06:56:00', '12:04:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-18', '07:34:00', '12:13:00', 34, 4.65, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-18', '06:55:00', '17:03:00', 0, 10.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-18', '12:54:00', '17:04:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-18', '12:52:00', '17:11:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-18', '13:45:00', '16:56:00', 45, 3.18, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-18', '13:47:00', '17:08:00', 47, 3.35, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-18', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-18', '06:45:00', '12:03:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-18', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-18', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-18', '13:00:00', '16:57:00', 0, 3.95, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-18', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-18', '12:52:00', '17:13:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-18', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-18', '06:56:00', '12:14:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-18', '13:10:00', '16:58:00', 10, 3.8, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-18', '12:55:00', '17:11:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-19', '06:54:00', '11:57:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-19', '12:59:00', '17:01:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-19', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-19', '06:57:00', '12:05:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-19', '06:47:00', '12:02:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-19', '06:53:00', '12:10:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-19', '13:36:00', '17:13:00', 36, 3.62, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-19', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-19', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-19', '06:56:00', '12:07:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-19', '06:49:00', '11:55:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-19', '12:45:00', '17:11:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-19', '12:54:00', '17:03:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-19', '13:33:00', '17:15:00', 33, 3.7, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-19', '12:50:00', '17:10:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-19', '12:59:00', '17:08:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-19', '06:50:00', '17:09:00', 0, 10.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-19', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (19, '2025-12-19', '2025-12-19', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-19', '06:50:00', '12:15:00', 0, 5.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-19', '06:50:00', '17:00:00', 0, 10.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-19', '12:53:00', '17:07:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-19', '06:50:00', '16:55:00', 0, 10.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-19', '07:14:00', '11:59:00', 14, 4.75, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-19', '13:16:00', '17:09:00', 16, 3.88, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (26, '2025-12-19', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-19', '06:57:00', '12:09:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-19', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-19', '06:46:00', '11:57:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-19', '12:56:00', '16:55:00', 0, 3.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-19', '12:57:00', '16:59:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (32, '2025-12-19', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-19', '12:54:00', '17:03:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (34, '2025-12-19', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-19', '12:48:00', '17:11:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-19', '06:55:00', '11:57:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-19', '12:50:00', '17:07:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-19', '06:49:00', '12:09:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-19', '12:54:00', '17:11:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-19', '07:20:00', '12:14:00', 20, 4.9, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-19', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-19', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-19', '06:56:00', '12:09:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-19', '06:49:00', '12:07:00', 0, 5.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-19', '07:50:00', '16:55:00', 50, 9.08, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-19', '12:53:00', '17:09:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-19', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-19', '13:24:00', '17:10:00', 24, 3.77, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-19', '12:47:00', '17:00:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-19', '12:51:00', '17:04:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-19', '06:52:00', '12:06:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (52, '2025-12-19', '2025-12-19', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-19', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-19', '13:21:00', '17:14:00', 21, 3.88, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-19', '12:48:00', '17:12:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-19', '12:57:00', '17:11:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-19', '12:45:00', '17:05:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (58, '2025-12-19', '2025-12-21', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (59, '2025-12-19', '2025-12-19', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-19', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-22', '06:57:00', '12:06:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-22', '12:45:00', '17:06:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-22', '12:48:00', '17:05:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-22', '06:52:00', '12:09:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-22', '06:53:00', '12:09:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-22', '06:59:00', '12:12:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-22', '12:56:00', '16:57:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-22', '12:57:00', '16:58:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (9, '2025-12-22', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-22', '06:47:00', '11:59:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-22', '06:59:00', '12:08:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-22', '12:49:00', '17:10:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-22', '12:48:00', '17:12:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-22', '12:59:00', '17:01:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-22', '12:45:00', '17:06:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-22', '12:49:00', '17:05:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-22', '06:50:00', '17:11:00', 0, 10.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (18, '2025-12-22', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-22', '12:45:00', '17:09:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-22', '06:59:00', '11:55:00', 0, 4.93, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (21, '2025-12-22', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-22', '13:38:00', '16:58:00', 38, 3.33, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-22', '06:48:00', '17:00:00', 0, 10.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-22', '06:48:00', '11:56:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-22', '12:53:00', '16:57:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-22', '12:59:00', '16:57:00', 0, 3.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-22', '06:55:00', '12:14:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-22', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-22', '06:57:00', '12:00:00', 0, 5.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-22', '12:53:00', '17:01:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-22', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-22', '07:20:00', '17:12:00', 20, 9.87, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-22', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-22', '07:17:00', '11:58:00', 17, 4.68, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-22', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-22', '06:56:00', '11:58:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-22', '12:49:00', '16:59:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-22', '06:50:00', '11:58:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-22', '12:57:00', '17:13:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-22', '06:59:00', '11:57:00', 0, 4.97, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-22', '12:52:00', '17:06:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-22', '12:57:00', '17:15:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-22', '07:33:00', '11:57:00', 33, 4.4, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-22', '06:49:00', '12:05:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-22', '06:46:00', '17:07:00', 0, 10.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-22', '12:52:00', '17:05:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-22', '13:19:00', '17:12:00', 19, 3.88, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-22', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-22', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-22', '12:53:00', '17:02:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (51, '2025-12-22', '2025-12-22', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-22', '12:50:00', '16:55:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-22', '12:57:00', '17:06:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-22', '12:55:00', '16:59:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-22', '12:56:00', '17:01:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-22', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-22', '13:25:00', '17:14:00', 25, 3.82, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-22', '07:30:00', '12:04:00', 30, 4.57, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-22', '12:56:00', '17:12:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-22', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-23', '07:00:00', '12:06:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-23', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-23', '12:52:00', '17:03:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-23', '06:47:00', '12:13:00', 0, 5.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-23', '06:50:00', '11:55:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-23', '07:30:00', '12:04:00', 30, 4.57, 'RETARDO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (7, '2025-12-23', '2025-12-23', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (8, '2025-12-23', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-23', '13:28:00', '17:11:00', 28, 3.72, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-23', '06:58:00', '12:00:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-23', '06:52:00', '12:09:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-23', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-23', '13:25:00', '17:10:00', 25, 3.75, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-23', '12:59:00', '17:08:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-23', '12:49:00', '16:58:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-23', '13:00:00', '17:08:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-23', '06:54:00', '17:03:00', 0, 10.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-23', '13:28:00', '17:07:00', 28, 3.65, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-23', '13:00:00', '17:08:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-23', '06:55:00', '11:58:00', 0, 5.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-23', '06:53:00', '17:05:00', 0, 10.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-23', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (23, '2025-12-23', '2025-12-23', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (24, '2025-12-23', '2025-12-23', 'Eventualidad', 'Trámite bancario', 'CERRADO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (25, '2025-12-23', '2025-12-25', 'Médico', 'Covid-19', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-23', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-23', '06:55:00', '12:12:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-23', '13:40:00', '17:09:00', 40, 3.48, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-23', '06:53:00', '12:12:00', 0, 5.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-23', '13:41:00', '17:09:00', 41, 3.47, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-23', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-23', '06:57:00', '17:09:00', 0, 10.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (33, '2025-12-23', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-23', '06:48:00', '12:08:00', 0, 5.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-23', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-23', '06:57:00', '12:01:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-23', '12:54:00', '17:04:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-23', '06:51:00', '12:06:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-23', '12:50:00', '17:06:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-23', '06:59:00', '12:05:00', 0, 5.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-23', '12:58:00', '17:05:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-23', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (43, '2025-12-23', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-23', '07:36:00', '12:12:00', 36, 4.6, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-23', '06:57:00', '17:02:00', 0, 10.08, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (46, '2025-12-23', '2025-12-27', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-23', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-23', '12:48:00', '16:56:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-23', '12:58:00', '17:07:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-23', '12:55:00', '17:12:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-23', '06:51:00', '12:11:00', 0, 5.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-23', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-23', '12:50:00', '17:04:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-23', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-23', '12:46:00', '17:01:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-23', '13:24:00', '16:59:00', 24, 3.58, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-23', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-23', '06:47:00', '12:05:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-23', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-23', '12:56:00', '17:09:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-24', '06:57:00', '12:01:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-24', '12:56:00', '17:15:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-24', '12:46:00', '17:08:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-24', '06:47:00', '12:12:00', 0, 5.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-24', '07:13:00', '12:09:00', 13, 4.93, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-24', '06:47:00', '11:59:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-24', '12:45:00', '16:55:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-24', '13:11:00', '17:15:00', 11, 4.07, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-24', '12:51:00', '16:57:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-24', '06:51:00', '12:02:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (11, '2025-12-24', '2025-12-26', 'Médico', 'Infección estomacal', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-24', '12:51:00', '17:02:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-24', '12:45:00', '17:05:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-24', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-24', '12:56:00', '17:02:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-24', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-24', '06:48:00', '16:56:00', 0, 10.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-24', '13:00:00', '17:12:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-24', '12:49:00', '17:15:00', 0, 4.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-24', '07:11:00', '12:06:00', 11, 4.92, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-24', '06:46:00', '17:14:00', 0, 10.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-24', '12:59:00', '17:11:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-24', '06:45:00', '17:12:00', 0, 10.45, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-24', '06:56:00', '12:09:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-24', '13:34:00', '17:15:00', 34, 3.68, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-24', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-24', '06:46:00', '12:04:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-24', '12:50:00', '17:12:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-24', '07:11:00', '12:08:00', 11, 4.95, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-24', '13:17:00', '16:55:00', 17, 3.63, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-24', '13:49:00', '16:58:00', 49, 3.15, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-24', '06:48:00', '17:01:00', 0, 10.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-24', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-24', '06:56:00', '12:07:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-24', '12:46:00', '17:06:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-24', '06:47:00', '12:13:00', 0, 5.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-24', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (38, '2025-12-24', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-24', '12:49:00', '17:15:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-24', '06:49:00', '12:08:00', 0, 5.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (41, '2025-12-24', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-24', '12:47:00', '17:05:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-24', '06:49:00', '11:58:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-24', '06:49:00', '12:01:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-24', '06:57:00', '17:15:00', 0, 10.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-24', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-24', '12:46:00', '17:10:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-24', '13:45:00', '16:59:00', 45, 3.23, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-24', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-24', '12:57:00', '17:15:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-24', '07:47:00', '12:05:00', 47, 4.3, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-24', '13:13:00', '17:10:00', 13, 3.95, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-24', '12:59:00', '17:05:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-24', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-24', '12:49:00', '17:07:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-24', '12:59:00', '17:11:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-24', '12:48:00', '17:03:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-24', '06:57:00', '11:58:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-24', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-24', '12:48:00', '17:00:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2025-12-25', '2025-12-29', 'Médico', 'Infección estomacal', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-25', '12:46:00', '17:07:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-25', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-25', '06:45:00', '12:14:00', 0, 5.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-25', '06:57:00', '11:59:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-25', '06:55:00', '11:56:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (7, '2025-12-25', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (8, '2025-12-25', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-25', '12:59:00', '16:57:00', 0, 3.97, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (10, '2025-12-25', '2025-12-28', 'Médico', 'Esguince de tobillo', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-25', '06:53:00', '12:01:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-25', '12:54:00', '17:09:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-25', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-25', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-25', '12:52:00', '16:56:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (16, '2025-12-25', '2025-12-25', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-25', '06:48:00', '17:12:00', 0, 10.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-25', '12:58:00', '17:08:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-25', '12:59:00', '17:06:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-25', '06:51:00', '11:58:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (21, '2025-12-25', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-25', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (23, '2025-12-25', '2025-12-27', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-25', '06:58:00', '12:08:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-25', '12:54:00', '17:13:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-25', '12:53:00', '16:57:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-25', '06:49:00', '11:55:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-25', '12:49:00', '16:58:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-25', '07:24:00', '11:57:00', 24, 4.55, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-25', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-25', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-25', '06:56:00', '17:11:00', 0, 10.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (33, '2025-12-25', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-25', '07:41:00', '12:08:00', 41, 4.45, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-25', '12:51:00', '16:59:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-25', '06:57:00', '11:56:00', 0, 4.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-25', '12:54:00', '17:14:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-25', '06:54:00', '11:55:00', 0, 5.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-25', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-25', '06:59:00', '12:00:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-25', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-25', '12:55:00', '17:08:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-25', '06:48:00', '12:01:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-25', '06:51:00', '12:09:00', 0, 5.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-25', '06:46:00', '17:00:00', 0, 10.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-25', '12:58:00', '17:08:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-25', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-25', '12:53:00', '17:15:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-25', '12:54:00', '17:06:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-25', '12:51:00', '17:03:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-25', '07:19:00', '12:08:00', 19, 4.82, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-25', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-25', '12:50:00', '17:06:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-25', '12:50:00', '17:08:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-25', '12:52:00', '17:10:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-25', '12:47:00', '16:56:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-25', '13:48:00', '17:14:00', 48, 3.43, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-25', '06:59:00', '11:57:00', 0, 4.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-25', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (60, '2025-12-25', '2025-12-25', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-26', '06:50:00', '12:00:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-26', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (3, '2025-12-26', '2025-12-28', 'Médico', 'Migraña severa', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-26', '06:57:00', '11:57:00', 0, 5.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-26', '06:57:00', '12:07:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-26', '06:52:00', '12:08:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (7, '2025-12-26', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-26', '12:49:00', '16:57:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (9, '2025-12-26', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-26', '06:55:00', '12:07:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-26', '06:52:00', '12:12:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-26', '12:55:00', '17:03:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (13, '2025-12-26', '2025-12-26', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-26', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-26', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (16, '2025-12-26', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-26', '06:46:00', '17:02:00', 0, 10.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-26', '12:47:00', '17:15:00', 0, 4.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-26', '12:57:00', '16:59:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-26', '06:56:00', '12:03:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-26', '06:49:00', '16:57:00', 0, 10.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (22, '2025-12-26', 'FALTA', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (23, '2025-12-26', '2025-12-26', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-26', '06:53:00', '11:59:00', 0, 5.1, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (25, '2025-12-26', '2025-12-28', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-26', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-26', '07:21:00', '12:09:00', 21, 4.8, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-26', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-26', '07:29:00', '12:07:00', 29, 4.63, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-26', '12:58:00', '16:56:00', 0, 3.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-26', '12:55:00', '17:01:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-26', '06:50:00', '17:05:00', 0, 10.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-26', '12:49:00', '17:00:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-26', '07:18:00', '12:06:00', 18, 4.8, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-26', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-26', '07:17:00', '12:10:00', 17, 4.88, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-26', '12:45:00', '17:03:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-26', '07:26:00', '11:56:00', 26, 4.5, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-26', '13:50:00', '17:03:00', 50, 3.22, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-26', '06:47:00', '12:12:00', 0, 5.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-26', '12:55:00', '17:02:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-26', '13:29:00', '16:55:00', 29, 3.43, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-26', '07:10:00', '11:57:00', 10, 4.78, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-26', '07:00:00', '12:04:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-26', '06:54:00', '17:04:00', 0, 10.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-26', '12:47:00', '17:13:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-26', '13:00:00', '17:10:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-26', '13:21:00', '17:00:00', 21, 3.65, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-26', '13:15:00', '17:14:00', 15, 3.98, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-26', '12:45:00', '16:55:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-26', '07:27:00', '11:55:00', 27, 4.47, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-26', '12:46:00', '17:10:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-26', '12:50:00', '17:03:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (54, '2025-12-26', 'FALTA', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (55, '2025-12-26', '2025-12-31', 'Médico', 'Intervención dental', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-26', '13:27:00', '17:14:00', 27, 3.78, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-26', '13:26:00', '17:03:00', 26, 3.62, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-26', '06:55:00', '12:11:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-26', '12:56:00', '17:02:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-26', '12:47:00', '17:14:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-29', '06:58:00', '11:56:00', 0, 4.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-29', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-29', '12:45:00', '17:14:00', 0, 4.48, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-29', '06:48:00', '12:15:00', 0, 5.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-29', '06:51:00', '11:59:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-29', '06:59:00', '12:00:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-29', '12:45:00', '16:59:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-29', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-29', '12:59:00', '17:12:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-29', '07:28:00', '11:56:00', 28, 4.47, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-29', '06:53:00', '12:06:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (12, '2025-12-29', 'FALTA', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (13, '2025-12-29', '2025-12-29', 'Eventualidad', 'Cita médica control', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-29', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-29', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-29', '13:14:00', '17:05:00', 14, 3.85, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-29', '06:46:00', '17:15:00', 0, 10.48, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-29', '12:56:00', '17:02:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (19, '2025-12-29', '2025-12-29', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-29', '06:54:00', '12:11:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (21, '2025-12-29', '2025-12-29', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-29', '13:43:00', '17:11:00', 43, 3.47, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-29', '06:53:00', '17:05:00', 0, 10.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-29', '06:57:00', '12:01:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (25, '2025-12-29', '2026-01-02', 'Médico', 'Covid-19', 'ACTIVO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (26, '2025-12-29', '2026-01-03', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-29', '06:52:00', '12:01:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-29', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-29', '06:55:00', '12:05:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-29', '12:51:00', '17:11:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (31, '2025-12-29', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-29', '07:00:00', '17:09:00', 0, 10.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-29', '13:00:00', '16:57:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-29', '06:51:00', '12:01:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-29', '12:47:00', '17:10:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-29', '06:55:00', '12:06:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-29', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-29', '06:52:00', '12:01:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-29', '12:48:00', '16:57:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (40, '2025-12-29', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-29', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-29', '12:57:00', '16:57:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-29', '06:55:00', '12:14:00', 0, 5.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-29', '06:50:00', '12:03:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-29', '06:46:00', '17:08:00', 0, 10.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-29', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-29', '12:51:00', '16:55:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-29', '12:54:00', '17:09:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-29', '12:51:00', '17:04:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-29', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-29', '06:50:00', '12:02:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-29', '12:45:00', '17:07:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-29', '13:48:00', '17:04:00', 48, 3.27, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-29', '12:56:00', '17:05:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-29', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-29', '12:46:00', '17:06:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-29', '13:34:00', '17:07:00', 34, 3.55, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-29', '06:45:00', '11:57:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-29', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (60, '2025-12-29', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-30', '07:11:00', '12:14:00', 11, 5.05, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-30', '12:46:00', '17:06:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-30', '12:50:00', '17:15:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-30', '06:58:00', '11:57:00', 0, 4.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-30', '06:53:00', '12:02:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-30', '06:59:00', '12:09:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-30', '12:46:00', '17:09:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (8, '2025-12-30', '2026-01-01', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2025-12-30', '12:53:00', '17:09:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-30', '06:55:00', '12:01:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-30', '07:43:00', '12:02:00', 43, 4.32, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-30', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (13, '2025-12-30', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-30', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-30', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-30', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-30', '07:49:00', '17:04:00', 49, 9.25, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-30', '12:48:00', '17:15:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (19, '2025-12-30', '2025-12-30', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-30', '06:49:00', '12:04:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2025-12-30', '06:54:00', '17:03:00', 0, 10.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-30', '12:51:00', '17:12:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-30', '06:55:00', '17:01:00', 0, 10.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-30', '06:46:00', '12:01:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-30', '13:00:00', '17:12:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-30', '12:56:00', '17:02:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-30', '06:58:00', '11:58:00', 0, 5.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-30', '12:47:00', '17:14:00', 0, 4.45, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2025-12-30', '06:57:00', '11:57:00', 0, 5.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2025-12-30', '12:50:00', '17:00:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-30', '12:52:00', '16:56:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-30', '06:48:00', '16:58:00', 0, 10.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-30', '12:51:00', '17:11:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-30', '07:16:00', '11:55:00', 16, 4.65, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-30', '12:55:00', '16:56:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2025-12-30', '07:00:00', '12:13:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (37, '2025-12-30', '2026-01-02', 'Médico', 'Esguince de tobillo', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2025-12-30', '06:56:00', '11:56:00', 0, 5.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (39, '2025-12-30', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-30', '06:46:00', '11:58:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-30', '13:43:00', '17:00:00', 43, 3.28, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-30', '12:47:00', '17:11:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (43, '2025-12-30', '2025-12-30', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-30', '06:54:00', '12:04:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (45, '2025-12-30', '2025-12-30', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-30', '12:50:00', '17:12:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-30', '13:23:00', '17:06:00', 23, 3.72, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-30', '12:47:00', '17:14:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (49, '2025-12-30', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-30', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-30', '06:59:00', '12:13:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-30', '12:51:00', '17:03:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-30', '13:43:00', '16:59:00', 43, 3.27, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-30', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-30', '12:56:00', '16:57:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2025-12-30', '13:40:00', '17:10:00', 40, 3.5, 'RETARDO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (57, '2025-12-30', '2025-12-30', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-30', '07:45:00', '12:13:00', 45, 4.47, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-30', '12:50:00', '17:04:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-30', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2025-12-31', '06:56:00', '11:57:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2025-12-31', '12:49:00', '16:55:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2025-12-31', '12:52:00', '17:06:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2025-12-31', '06:48:00', '12:08:00', 0, 5.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2025-12-31', '06:49:00', '12:10:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2025-12-31', '06:58:00', '12:10:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2025-12-31', '12:51:00', '17:14:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2025-12-31', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (9, '2025-12-31', '2025-12-31', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2025-12-31', '06:56:00', '12:05:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2025-12-31', '06:55:00', '12:07:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2025-12-31', '12:47:00', '17:02:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2025-12-31', '12:49:00', '17:04:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2025-12-31', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2025-12-31', '12:52:00', '17:13:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2025-12-31', '12:52:00', '17:07:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2025-12-31', '06:46:00', '17:09:00', 0, 10.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2025-12-31', '12:56:00', '17:05:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2025-12-31', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2025-12-31', '07:31:00', '12:00:00', 31, 4.48, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (21, '2025-12-31', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2025-12-31', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2025-12-31', '06:50:00', '17:06:00', 0, 10.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2025-12-31', '06:56:00', '12:05:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2025-12-31', '12:46:00', '17:07:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2025-12-31', '12:58:00', '17:07:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2025-12-31', '06:50:00', '11:58:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2025-12-31', '12:49:00', '17:10:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (29, '2025-12-31', '2026-01-05', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (30, '2025-12-31', '2026-01-05', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2025-12-31', '12:50:00', '17:08:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2025-12-31', '06:49:00', '17:11:00', 0, 10.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2025-12-31', '12:58:00', '16:59:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2025-12-31', '06:59:00', '12:00:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2025-12-31', '12:56:00', '17:11:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (36, '2025-12-31', '2025-12-31', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2025-12-31', '13:25:00', '17:11:00', 25, 3.77, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (38, '2025-12-31', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2025-12-31', '12:59:00', '17:00:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2025-12-31', '06:48:00', '12:07:00', 0, 5.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2025-12-31', '12:56:00', '17:06:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2025-12-31', '12:58:00', '17:03:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2025-12-31', '07:00:00', '12:02:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2025-12-31', '06:45:00', '12:11:00', 0, 5.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2025-12-31', '07:27:00', '17:13:00', 27, 9.77, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2025-12-31', '12:56:00', '17:09:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2025-12-31', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2025-12-31', '12:55:00', '17:03:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2025-12-31', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2025-12-31', '13:24:00', '16:58:00', 24, 3.57, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2025-12-31', '06:50:00', '12:03:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2025-12-31', '13:21:00', '16:57:00', 21, 3.6, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2025-12-31', '12:54:00', '17:06:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2025-12-31', '12:58:00', '17:02:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2025-12-31', '12:54:00', '17:02:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (56, '2025-12-31', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2025-12-31', '12:47:00', '17:13:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2025-12-31', '06:50:00', '12:03:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2025-12-31', '12:56:00', '16:58:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2025-12-31', '12:48:00', '17:03:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-01', '06:52:00', '12:03:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-01', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-01', '12:54:00', '16:57:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-01', '06:58:00', '12:09:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-01', '06:54:00', '12:10:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (6, '2026-01-01', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-01', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-01', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-01', '13:18:00', '17:12:00', 18, 3.9, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-01', '07:15:00', '12:10:00', 15, 4.92, 'RETARDO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (11, '2026-01-01', '2026-01-01', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-01', '12:56:00', '16:59:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-01', '12:51:00', '17:02:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (14, '2026-01-01', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-01', '12:49:00', '17:04:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-01', '12:58:00', '16:55:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (17, '2026-01-01', 'FALTA', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (18, '2026-01-01', '2026-01-01', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (19, '2026-01-01', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-01', '06:57:00', '11:57:00', 0, 5.0, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (21, '2026-01-01', '2026-01-05', 'Médico', 'Covid-19', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-01', '12:56:00', '16:55:00', 0, 3.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-01', '06:58:00', '16:57:00', 0, 9.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-01', '07:26:00', '12:13:00', 26, 4.78, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-01', '12:50:00', '17:02:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (26, '2026-01-01', '2026-01-01', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-01', '06:47:00', '12:07:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-01', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-01', '06:58:00', '12:07:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-01', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-01', '12:52:00', '17:03:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-01', '06:51:00', '17:12:00', 0, 10.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-01', '12:55:00', '17:05:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-01', '06:53:00', '12:13:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-01', '12:54:00', '17:05:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-01', '06:52:00', '12:03:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-01', '13:27:00', '17:00:00', 27, 3.55, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-01', '06:59:00', '12:05:00', 0, 5.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-01', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-01', '06:50:00', '12:12:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-01', '12:51:00', '17:02:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-01', '12:47:00', '17:02:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-01', '07:30:00', '12:02:00', 30, 4.53, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-01', '07:00:00', '11:55:00', 0, 4.92, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-01', '06:53:00', '17:00:00', 0, 10.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (46, '2026-01-01', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-01', '12:51:00', '16:56:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (48, '2026-01-01', '2026-01-01', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-01', '12:56:00', '17:04:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-01', '12:58:00', '17:02:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-01', '06:45:00', '12:04:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-01', '12:54:00', '17:14:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-01', '13:23:00', '16:57:00', 23, 3.57, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-01', '12:47:00', '17:10:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-01', '12:52:00', '17:00:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-01', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-01', '12:55:00', '17:02:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (58, '2026-01-01', '2026-01-01', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-01', '12:57:00', '17:12:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-01', '12:49:00', '17:15:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-02', '07:22:00', '12:08:00', 22, 4.77, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-02', '12:59:00', '17:15:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-02', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (4, '2026-01-02', '2026-01-07', 'Médico', 'Infección estomacal', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (5, '2026-01-02', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-02', '07:13:00', '12:07:00', 13, 4.9, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-02', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-02', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-02', '12:51:00', '17:06:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (10, '2026-01-02', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-02', '06:54:00', '12:02:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-02', '13:27:00', '17:11:00', 27, 3.73, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (13, '2026-01-02', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-02', '13:28:00', '16:57:00', 28, 3.48, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-02', '12:47:00', '17:11:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-02', '12:46:00', '16:56:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-02', '06:46:00', '17:02:00', 0, 10.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-02', '12:54:00', '17:02:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-02', '12:45:00', '17:00:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-02', '06:54:00', '11:58:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-02', '06:49:00', '17:15:00', 0, 10.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-02', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-02', '07:49:00', '16:55:00', 49, 9.1, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-02', '06:58:00', '12:02:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-02', '13:00:00', '16:58:00', 0, 3.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-02', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-02', '06:50:00', '12:06:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-02', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-02', '06:51:00', '12:15:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-02', '12:45:00', '17:03:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-02', '12:49:00', '16:57:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-02', '07:44:00', '17:10:00', 44, 9.43, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-02', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-02', '06:45:00', '11:57:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-02', '13:00:00', '17:05:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-02', '06:58:00', '12:11:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-02', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-02', '07:00:00', '11:55:00', 0, 4.92, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-02', '12:45:00', '16:59:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-02', '06:59:00', '12:05:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-02', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-02', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-02', '06:47:00', '12:01:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-02', '06:50:00', '12:02:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-02', '06:53:00', '16:57:00', 0, 10.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-02', '13:00:00', '17:02:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-02', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-02', '12:58:00', '17:06:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-02', '13:28:00', '16:56:00', 28, 3.47, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-02', '12:53:00', '17:01:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-02', '06:48:00', '12:11:00', 0, 5.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (52, '2026-01-02', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-02', '12:48:00', '17:04:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-02', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-02', '12:56:00', '17:04:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (56, '2026-01-02', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-02', '13:21:00', '16:58:00', 21, 3.62, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-02', '07:28:00', '12:14:00', 28, 4.77, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-02', '12:55:00', '17:00:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-02', '12:51:00', '17:00:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-05', '06:58:00', '12:15:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-05', '12:45:00', '17:04:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-05', '12:48:00', '17:10:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-05', '06:51:00', '12:09:00', 0, 5.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-05', '06:47:00', '12:13:00', 0, 5.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-05', '06:50:00', '12:14:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-05', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-05', '12:53:00', '16:57:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-05', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-05', '06:57:00', '11:55:00', 0, 4.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-05', '06:50:00', '12:01:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-05', '12:50:00', '17:02:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-05', '12:56:00', '17:00:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-05', '12:58:00', '17:09:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-05', '13:00:00', '17:07:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-05', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (17, '2026-01-05', '2026-01-05', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-05', '13:32:00', '17:04:00', 32, 3.53, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-05', '12:59:00', '17:14:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-05', '06:53:00', '12:11:00', 0, 5.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (21, '2026-01-05', 'FALTA', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (22, '2026-01-05', '2026-01-08', 'Médico', 'Infección estomacal', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-05', '06:57:00', '17:07:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-05', '06:57:00', '12:10:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-05', '13:31:00', '17:13:00', 31, 3.7, 'RETARDO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (26, '2026-01-05', '2026-01-08', 'Médico', 'Infección estomacal', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-05', '06:57:00', '12:07:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-05', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-05', '06:45:00', '12:07:00', 0, 5.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-05', '12:47:00', '17:01:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-05', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-05', '07:00:00', '17:07:00', 0, 10.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-05', '12:54:00', '17:05:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-05', '06:51:00', '11:56:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-05', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-05', '07:00:00', '12:13:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (37, '2026-01-05', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-05', '07:15:00', '11:59:00', 15, 4.73, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-05', '13:37:00', '17:01:00', 37, 3.4, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-05', '06:48:00', '12:06:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (41, '2026-01-05', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-05', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-05', '06:50:00', '12:11:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-05', '06:48:00', '12:03:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-05', '06:45:00', '17:13:00', 0, 10.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-05', '12:46:00', '16:58:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-05', '12:51:00', '17:09:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-05', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-05', '13:14:00', '17:13:00', 14, 3.98, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-05', '12:57:00', '17:02:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-05', '06:54:00', '12:10:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-05', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-05', '12:58:00', '17:02:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-05', '12:56:00', '17:02:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-05', '12:45:00', '16:58:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-05', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-05', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-05', '06:47:00', '12:08:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-05', '12:58:00', '17:11:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-05', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-06', '06:54:00', '12:15:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-06', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (3, '2026-01-06', '2026-01-10', 'Médico', 'Intervención dental', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-06', '06:56:00', '11:56:00', 0, 5.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-06', '06:48:00', '12:00:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-06', '06:50:00', '12:01:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-06', '13:33:00', '17:01:00', 33, 3.47, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-06', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-06', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-06', '06:59:00', '12:11:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-06', '06:51:00', '12:15:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-06', '12:45:00', '17:15:00', 0, 4.5, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-06', '13:36:00', '17:05:00', 36, 3.48, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-06', '12:51:00', '17:12:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (15, '2026-01-06', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-06', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-06', '06:48:00', '17:10:00', 0, 10.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-06', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-06', '13:44:00', '17:06:00', 44, 3.37, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-06', '06:48:00', '12:04:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-06', '06:46:00', '17:07:00', 0, 10.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-06', '12:59:00', '17:01:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-06', '06:58:00', '17:09:00', 0, 10.18, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (24, '2026-01-06', '2026-01-11', 'Médico', 'Migraña severa', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-06', '12:54:00', '17:10:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-06', '12:52:00', '17:06:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-06', '06:55:00', '12:05:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-06', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-06', '06:47:00', '12:13:00', 0, 5.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-06', '12:57:00', '17:06:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-06', '12:59:00', '17:05:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-06', '06:50:00', '17:12:00', 0, 10.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-06', '12:56:00', '17:09:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (34, '2026-01-06', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-06', '12:50:00', '16:55:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-06', '07:28:00', '12:15:00', 28, 4.78, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-06', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-06', '07:34:00', '12:01:00', 34, 4.45, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-06', '12:58:00', '17:14:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-06', '06:47:00', '11:59:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (41, '2026-01-06', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-06', '12:49:00', '16:55:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-06', '06:54:00', '12:09:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-06', '07:19:00', '11:59:00', 19, 4.67, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-06', '06:51:00', '16:55:00', 0, 10.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-06', '12:54:00', '17:06:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (47, '2026-01-06', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-06', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-06', '12:52:00', '17:11:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (50, '2026-01-06', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-06', '06:57:00', '12:06:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-06', '13:25:00', '17:09:00', 25, 3.73, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-06', '12:45:00', '17:05:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-06', '13:25:00', '17:07:00', 25, 3.7, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-06', '12:55:00', '17:10:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-06', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-06', '12:47:00', '17:05:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-06', '06:59:00', '12:13:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-06', '13:00:00', '17:13:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-06', '12:57:00', '17:04:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-07', '06:56:00', '12:05:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-07', '12:48:00', '17:05:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (3, '2026-01-07', '2026-01-11', 'Médico', 'Covid-19', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-07', '06:51:00', '12:11:00', 0, 5.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-07', '06:58:00', '12:15:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-07', '06:58:00', '11:57:00', 0, 4.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-07', '12:53:00', '17:02:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-07', '12:50:00', '17:12:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-07', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-07', '06:49:00', '11:59:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-07', '06:57:00', '12:09:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-07', '12:57:00', '17:12:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-07', '12:58:00', '17:11:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-07', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (15, '2026-01-07', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-07', '12:56:00', '17:10:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-07', '06:57:00', '17:15:00', 0, 10.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-07', '13:00:00', '16:58:00', 0, 3.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-07', '13:00:00', '16:56:00', 0, 3.93, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-07', '07:35:00', '12:10:00', 35, 4.58, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-07', '07:43:00', '16:57:00', 43, 9.23, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-07', '13:47:00', '17:02:00', 47, 3.25, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (23, '2026-01-07', 'FALTA', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (24, '2026-01-07', '2026-01-07', 'Eventualidad', 'Cita médica control', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-07', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-07', '13:00:00', '17:03:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-07', '06:46:00', '12:04:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-07', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-07', '07:22:00', '11:55:00', 22, 4.55, 'RETARDO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (30, '2026-01-07', '2026-01-09', 'Médico', 'Infección estomacal', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-07', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-07', '06:46:00', '17:12:00', 0, 10.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-07', '12:45:00', '17:05:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-07', '06:55:00', '11:56:00', 0, 5.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-07', '12:58:00', '17:02:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-07', '06:45:00', '12:09:00', 0, 5.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-07', '12:59:00', '17:12:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-07', '06:58:00', '12:07:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (39, '2026-01-07', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-07', '06:50:00', '12:04:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (41, '2026-01-07', '2026-01-07', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (42, '2026-01-07', '2026-01-12', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-07', '07:13:00', '12:00:00', 13, 4.78, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-07', '06:58:00', '12:00:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-07', '06:52:00', '16:56:00', 0, 10.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-07', '12:47:00', '17:04:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-07', '12:59:00', '17:11:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (48, '2026-01-07', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (49, '2026-01-07', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-07', '13:38:00', '17:06:00', 38, 3.47, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-07', '07:50:00', '12:00:00', 50, 4.17, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-07', '12:45:00', '17:13:00', 0, 4.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-07', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-07', '12:59:00', '17:10:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-07', '12:53:00', '17:12:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-07', '12:55:00', '17:14:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-07', '12:55:00', '17:01:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-07', '06:45:00', '11:58:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-07', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-07', '12:58:00', '17:05:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-08', '06:56:00', '12:05:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-08', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-08', '12:49:00', '16:58:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-08', '06:59:00', '12:10:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (5, '2026-01-08', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-08', '06:55:00', '12:03:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-08', '12:56:00', '17:12:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-08', '12:46:00', '17:00:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-08', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-08', '06:52:00', '12:03:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-08', '07:29:00', '11:55:00', 29, 4.43, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-08', '12:45:00', '17:03:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (13, '2026-01-08', '2026-01-08', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-08', '12:50:00', '17:11:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-08', '12:53:00', '17:09:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-08', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-08', '06:49:00', '17:11:00', 0, 10.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (18, '2026-01-08', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-08', '12:51:00', '17:01:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-08', '06:46:00', '12:02:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-08', '07:29:00', '17:07:00', 29, 9.63, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-08', '12:51:00', '17:10:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-08', '06:51:00', '17:05:00', 0, 10.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-08', '06:46:00', '12:04:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-08', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-08', '12:45:00', '17:14:00', 0, 4.48, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (27, '2026-01-08', '2026-01-08', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-08', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-08', '06:47:00', '12:03:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-08', '12:45:00', '17:07:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-08', '12:57:00', '16:59:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-08', '06:50:00', '17:08:00', 0, 10.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-08', '12:51:00', '17:12:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-08', '06:54:00', '11:57:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-08', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-08', '06:54:00', '12:12:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (37, '2026-01-08', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-08', '06:54:00', '12:04:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-08', '12:57:00', '17:13:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (40, '2026-01-08', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-08', '12:47:00', '17:11:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-08', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-08', '06:52:00', '12:14:00', 0, 5.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-08', '06:48:00', '12:00:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-08', '06:58:00', '16:58:00', 0, 10.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-08', '13:16:00', '17:03:00', 16, 3.78, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-08', '12:51:00', '17:10:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-08', '12:57:00', '17:07:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-08', '12:45:00', '17:13:00', 0, 4.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-08', '12:58:00', '16:59:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-08', '07:00:00', '11:55:00', 0, 4.92, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-08', '13:42:00', '17:08:00', 42, 3.43, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-08', '12:48:00', '17:04:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-08', '12:56:00', '17:05:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-08', '13:42:00', '17:01:00', 42, 3.32, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-08', '12:59:00', '17:04:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-08', '12:50:00', '16:55:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-08', '06:51:00', '12:12:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-08', '12:45:00', '17:07:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-08', '13:00:00', '17:15:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2026-01-09', '2026-01-09', 'Eventualidad', 'Trámite bancario', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-09', '13:22:00', '17:04:00', 22, 3.7, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-09', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (4, '2026-01-09', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-09', '07:00:00', '12:02:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-09', '06:57:00', '12:04:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-09', '13:00:00', '17:15:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-09', '12:53:00', '17:07:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-09', '13:32:00', '17:03:00', 32, 3.52, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-09', '07:28:00', '12:03:00', 28, 4.58, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-09', '06:59:00', '12:13:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-09', '12:49:00', '17:10:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-09', '12:48:00', '17:00:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-09', '12:56:00', '17:01:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (15, '2026-01-09', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-09', '12:47:00', '17:06:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (17, '2026-01-09', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-09', '13:19:00', '16:57:00', 19, 3.63, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-09', '12:54:00', '17:13:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-09', '06:54:00', '12:10:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-09', '07:22:00', '17:08:00', 22, 9.77, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-09', '13:18:00', '17:14:00', 18, 3.93, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-09', '06:58:00', '17:11:00', 0, 10.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-09', '06:53:00', '12:05:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-09', '12:48:00', '17:11:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-09', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-09', '06:53:00', '12:04:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-09', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-09', '06:57:00', '12:07:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-09', '12:55:00', '17:05:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-09', '12:50:00', '16:56:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-09', '06:59:00', '17:13:00', 0, 10.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-09', '12:57:00', '17:01:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-09', '06:46:00', '12:11:00', 0, 5.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-09', '12:59:00', '16:59:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (36, '2026-01-09', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-09', '12:54:00', '17:11:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-09', '06:47:00', '12:01:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-09', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-09', '06:59:00', '12:13:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-09', '12:46:00', '16:56:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-09', '12:48:00', '17:09:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-09', '07:00:00', '12:00:00', 0, 5.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-09', '06:49:00', '11:59:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-09', '06:51:00', '16:57:00', 0, 10.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-09', '13:50:00', '17:13:00', 50, 3.38, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-09', '13:00:00', '17:10:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-09', '12:59:00', '17:14:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (49, '2026-01-09', '2026-01-09', 'Eventualidad', 'Trámite bancario', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-09', '12:45:00', '17:04:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-09', '06:55:00', '12:07:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-09', '13:23:00', '16:55:00', 23, 3.53, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-09', '12:52:00', '17:14:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-09', '13:43:00', '17:15:00', 43, 3.53, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-09', '13:00:00', '17:02:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-09', '12:47:00', '17:01:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-09', '12:50:00', '17:15:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (58, '2026-01-09', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-09', '12:55:00', '16:55:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-09', '13:26:00', '17:04:00', 26, 3.63, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-12', '06:50:00', '11:56:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-12', '12:47:00', '17:01:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-12', '13:33:00', '17:12:00', 33, 3.65, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-12', '06:56:00', '12:04:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-12', '06:46:00', '12:01:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-12', '06:55:00', '12:10:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (7, '2026-01-12', '2026-01-16', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-12', '13:20:00', '17:14:00', 20, 3.9, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-12', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-12', '07:26:00', '12:10:00', 26, 4.73, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-12', '06:50:00', '11:59:00', 0, 5.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-12', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-12', '12:46:00', '17:13:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-12', '12:51:00', '17:00:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-12', '13:18:00', '17:03:00', 18, 3.75, 'RETARDO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (16, '2026-01-12', '2026-01-17', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-12', '06:56:00', '17:11:00', 0, 10.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-12', '12:47:00', '17:03:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-12', '12:52:00', '17:07:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-12', '06:45:00', '12:12:00', 0, 5.45, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-12', '06:49:00', '17:05:00', 0, 10.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-12', '12:50:00', '17:12:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-12', '06:53:00', '17:07:00', 0, 10.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-12', '07:39:00', '12:08:00', 39, 4.48, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (25, '2026-01-12', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-12', '13:00:00', '17:12:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-12', '06:55:00', '11:56:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-12', '12:50:00', '17:06:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-12', '06:56:00', '12:13:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-12', '12:53:00', '17:07:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-12', '12:59:00', '16:58:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-12', '06:47:00', '17:12:00', 0, 10.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-12', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-12', '07:24:00', '12:11:00', 24, 4.78, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-12', '12:57:00', '17:13:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-12', '07:24:00', '12:06:00', 24, 4.7, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-12', '12:55:00', '16:55:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (38, '2026-01-12', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-12', '12:52:00', '17:12:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-12', '07:21:00', '12:04:00', 21, 4.72, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-12', '12:46:00', '17:00:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-12', '12:50:00', '16:58:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-12', '07:18:00', '12:13:00', 18, 4.92, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (44, '2026-01-12', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-12', '06:51:00', '17:01:00', 0, 10.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-12', '12:46:00', '17:07:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-12', '12:59:00', '17:07:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-12', '13:20:00', '17:15:00', 20, 3.92, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-12', '12:46:00', '17:00:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (50, '2026-01-12', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-12', '06:49:00', '11:59:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-12', '13:00:00', '17:12:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-12', '12:56:00', '17:00:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-12', '12:59:00', '17:05:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-12', '12:57:00', '17:13:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-12', '12:50:00', '16:56:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-12', '12:50:00', '17:06:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-12', '06:53:00', '11:58:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-12', '12:54:00', '17:05:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-12', '13:00:00', '17:07:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-13', '06:51:00', '12:01:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-13', '12:49:00', '17:05:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-13', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (4, '2026-01-13', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-13', '06:45:00', '12:01:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-13', '06:46:00', '12:12:00', 0, 5.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-13', '12:46:00', '17:13:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-13', '12:55:00', '17:10:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-13', '12:46:00', '16:56:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-13', '06:52:00', '11:58:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-13', '06:54:00', '11:57:00', 0, 5.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-13', '12:45:00', '16:58:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-13', '13:48:00', '16:59:00', 48, 3.18, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-13', '12:45:00', '17:02:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-13', '12:54:00', '17:01:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-13', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-13', '06:59:00', '17:06:00', 0, 10.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (18, '2026-01-13', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-13', '13:00:00', '16:56:00', 0, 3.93, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-13', '06:50:00', '12:06:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-13', '06:55:00', '17:08:00', 0, 10.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (22, '2026-01-13', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-13', '06:46:00', '16:56:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-13', '06:46:00', '12:12:00', 0, 5.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-13', '12:57:00', '17:00:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-13', '12:54:00', '17:03:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-13', '07:47:00', '11:57:00', 47, 4.17, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-13', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-13', '06:54:00', '11:57:00', 0, 5.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-13', '12:57:00', '16:57:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (31, '2026-01-13', 'FALTA', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (32, '2026-01-13', '2026-01-16', 'Médico', 'Infección estomacal', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-13', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-13', '06:52:00', '12:09:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-13', '12:59:00', '17:01:00', 0, 4.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (36, '2026-01-13', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-13', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-13', '07:38:00', '11:57:00', 38, 4.32, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-13', '12:57:00', '17:14:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-13', '06:51:00', '12:15:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-13', '12:58:00', '17:13:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-13', '12:57:00', '16:56:00', 0, 3.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-13', '06:58:00', '12:14:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-13', '06:50:00', '12:01:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-13', '07:46:00', '17:10:00', 46, 9.4, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-13', '12:45:00', '17:10:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-13', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-13', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-13', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-13', '12:51:00', '17:08:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-13', '06:49:00', '12:05:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-13', '12:57:00', '17:14:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-13', '12:57:00', '17:05:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-13', '12:50:00', '17:09:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-13', '12:45:00', '16:58:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-13', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-13', '12:53:00', '17:09:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-13', '06:57:00', '12:06:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-13', '12:55:00', '17:11:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-13', '12:47:00', '17:11:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-14', '06:58:00', '12:05:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-14', '12:59:00', '17:06:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-14', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-14', '06:48:00', '12:07:00', 0, 5.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-14', '07:30:00', '11:59:00', 30, 4.48, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-14', '06:58:00', '11:55:00', 0, 4.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-14', '13:27:00', '17:08:00', 27, 3.68, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-14', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-14', '12:45:00', '17:14:00', 0, 4.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-14', '06:58:00', '12:07:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-14', '06:52:00', '12:09:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (12, '2026-01-14', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-14', '12:57:00', '17:14:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-14', '13:30:00', '16:58:00', 30, 3.47, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-14', '12:50:00', '16:56:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-14', '12:47:00', '17:03:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (17, '2026-01-14', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-14', '12:57:00', '17:02:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-14', '12:55:00', '17:11:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-14', '06:48:00', '12:05:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-14', '07:00:00', '17:13:00', 0, 10.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-14', '12:51:00', '17:09:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-14', '06:51:00', '16:58:00', 0, 10.12, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (24, '2026-01-14', '2026-01-14', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (25, '2026-01-14', '2026-01-18', 'Médico', 'Infección estomacal', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-14', '12:53:00', '17:09:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-14', '06:55:00', '12:09:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-14', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-14', '06:53:00', '12:00:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-14', '12:56:00', '17:02:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-14', '12:50:00', '16:57:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-14', '06:47:00', '17:00:00', 0, 10.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-14', '13:30:00', '16:56:00', 30, 3.43, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (34, '2026-01-14', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-14', '12:47:00', '16:57:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-14', '06:53:00', '12:00:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-14', '12:58:00', '17:00:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-14', '06:59:00', '12:01:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-14', '13:13:00', '16:59:00', 13, 3.77, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-14', '06:59:00', '12:02:00', 0, 5.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-14', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-14', '12:54:00', '16:56:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-14', '06:48:00', '12:15:00', 0, 5.45, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-14', '06:54:00', '12:02:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-14', '06:50:00', '17:07:00', 0, 10.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-14', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (47, '2026-01-14', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-14', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-14', '12:58:00', '17:01:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-14', '12:54:00', '17:11:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-14', '06:45:00', '11:59:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-14', '13:44:00', '17:00:00', 44, 3.27, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-14', '12:58:00', '17:15:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-14', '12:52:00', '17:00:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-14', '12:55:00', '17:06:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (56, '2026-01-14', '2026-01-18', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-14', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-14', '07:47:00', '11:58:00', 47, 4.18, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-14', '13:00:00', '17:07:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-14', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2026-01-15', '2026-01-15', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-15', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-15', '12:46:00', '17:01:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (4, '2026-01-15', '2026-01-15', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-15', '06:45:00', '12:06:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-15', '06:48:00', '12:11:00', 0, 5.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-15', '12:49:00', '17:05:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-15', '12:58:00', '17:01:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-15', '12:55:00', '16:58:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (10, '2026-01-15', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-15', '07:47:00', '12:02:00', 47, 4.25, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-15', '12:55:00', '17:03:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-15', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-15', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-15', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-15', '12:56:00', '17:03:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-15', '06:52:00', '17:11:00', 0, 10.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-15', '13:10:00', '16:59:00', 10, 3.82, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-15', '12:49:00', '17:02:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-15', '06:51:00', '12:14:00', 0, 5.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-15', '06:46:00', '17:01:00', 0, 10.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-15', '12:56:00', '17:05:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-15', '06:51:00', '17:14:00', 0, 10.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-15', '06:54:00', '11:56:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-15', '12:47:00', '17:09:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-15', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-15', '06:55:00', '12:11:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-15', '12:45:00', '17:06:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-15', '06:45:00', '11:56:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-15', '12:45:00', '17:00:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-15', '12:48:00', '17:12:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (32, '2026-01-15', '2026-01-15', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-15', '12:54:00', '17:11:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-15', '06:52:00', '12:10:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (35, '2026-01-15', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-15', '06:47:00', '12:09:00', 0, 5.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-15', '12:56:00', '17:05:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (38, '2026-01-15', '2026-01-15', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-15', '12:52:00', '17:08:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-15', '06:46:00', '11:55:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-15', '12:54:00', '17:01:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (42, '2026-01-15', '2026-01-15', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-15', '06:47:00', '12:08:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-15', '06:54:00', '12:04:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-15', '07:50:00', '17:11:00', 50, 9.35, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (46, '2026-01-15', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-15', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-15', '12:56:00', '17:00:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-15', '12:45:00', '17:10:00', 0, 4.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-15', '12:57:00', '16:55:00', 0, 3.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-15', '06:59:00', '12:06:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-15', '13:45:00', '17:14:00', 45, 3.48, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-15', '13:00:00', '17:05:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-15', '13:00:00', '17:03:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-15', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-15', '12:57:00', '16:57:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (57, '2026-01-15', '2026-01-15', 'Eventualidad', 'Trámite bancario', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-15', '06:47:00', '12:06:00', 0, 5.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-15', '12:56:00', '17:02:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-15', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-16', '07:25:00', '12:12:00', 25, 4.78, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-16', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-16', '12:59:00', '17:11:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-16', '06:56:00', '11:55:00', 0, 4.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (5, '2026-01-16', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-16', '06:45:00', '11:56:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-16', '12:59:00', '17:00:00', 0, 4.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-16', '12:56:00', '17:11:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-16', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-16', '06:55:00', '11:57:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-16', '06:49:00', '12:06:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-16', '12:45:00', '17:14:00', 0, 4.48, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-16', '12:59:00', '16:55:00', 0, 3.93, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-16', '12:57:00', '17:11:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-16', '13:46:00', '17:14:00', 46, 3.47, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-16', '12:51:00', '17:10:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-16', '06:58:00', '17:15:00', 0, 10.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-16', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-16', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-16', '06:53:00', '12:01:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-16', '06:51:00', '17:09:00', 0, 10.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-16', '12:46:00', '17:09:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-16', '06:48:00', '16:56:00', 0, 10.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-16', '06:54:00', '12:07:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-16', '13:34:00', '17:03:00', 34, 3.48, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-16', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-16', '06:59:00', '11:56:00', 0, 4.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-16', '12:58:00', '17:02:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-16', '06:58:00', '11:55:00', 0, 4.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-16', '12:48:00', '17:11:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-16', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-16', '06:58:00', '17:02:00', 0, 10.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-16', '13:18:00', '17:12:00', 18, 3.9, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-16', '06:52:00', '12:11:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-16', '12:59:00', '17:11:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (36, '2026-01-16', '2026-01-21', 'Médico', 'Intervención dental', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-16', '12:52:00', '17:00:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (38, '2026-01-16', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-16', '12:47:00', '17:02:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-16', '06:47:00', '12:14:00', 0, 5.45, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-16', '12:55:00', '17:11:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-16', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-16', '07:31:00', '12:13:00', 31, 4.7, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-16', '06:55:00', '11:57:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-16', '06:47:00', '17:02:00', 0, 10.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-16', '13:37:00', '16:59:00', 37, 3.37, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-16', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-16', '12:59:00', '16:57:00', 0, 3.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-16', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-16', '12:50:00', '17:02:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-16', '07:00:00', '12:07:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-16', '12:58:00', '17:09:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-16', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-16', '12:59:00', '16:56:00', 0, 3.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-16', '12:54:00', '16:57:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-16', '12:50:00', '16:55:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-16', '12:57:00', '16:58:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-16', '07:00:00', '11:59:00', 0, 4.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-16', '13:39:00', '17:05:00', 39, 3.43, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-16', '12:45:00', '16:58:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-19', '06:54:00', '12:09:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (2, '2026-01-19', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-19', '12:49:00', '16:59:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-19', '06:55:00', '11:58:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-19', '06:55:00', '12:00:00', 0, 5.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-19', '07:19:00', '12:02:00', 19, 4.72, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-19', '12:52:00', '17:14:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-19', '13:43:00', '16:55:00', 43, 3.2, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-19', '12:59:00', '16:58:00', 0, 3.98, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-19', '06:46:00', '12:00:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-19', '06:48:00', '11:55:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (12, '2026-01-19', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-19', '13:36:00', '17:02:00', 36, 3.43, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (14, '2026-01-19', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-19', '13:21:00', '17:07:00', 21, 3.77, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (16, '2026-01-19', 'FALTA', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (17, '2026-01-19', '2026-01-19', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-19', '12:49:00', '17:02:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-19', '12:52:00', '17:11:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-19', '06:56:00', '11:55:00', 0, 4.98, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-19', '06:55:00', '17:05:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-19', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-19', '06:54:00', '17:02:00', 0, 10.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-19', '07:31:00', '12:02:00', 31, 4.52, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-19', '12:59:00', '16:57:00', 0, 3.97, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-19', '12:55:00', '17:08:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-19', '06:48:00', '11:55:00', 0, 5.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-19', '12:53:00', '17:11:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-19', '06:55:00', '11:55:00', 0, 5.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-19', '13:43:00', '17:13:00', 43, 3.5, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-19', '12:57:00', '17:06:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-19', '06:49:00', '17:09:00', 0, 10.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-19', '13:48:00', '17:04:00', 48, 3.27, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-19', '07:42:00', '12:00:00', 42, 4.3, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-19', '12:48:00', '16:55:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-19', '06:59:00', '12:14:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-19', '12:59:00', '16:59:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-19', '06:56:00', '12:05:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-19', '13:00:00', '16:55:00', 0, 3.92, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-19', '06:58:00', '12:15:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (41, '2026-01-19', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-19', '12:49:00', '17:01:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-19', '06:50:00', '12:08:00', 0, 5.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-19', '06:53:00', '12:01:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-19', '06:59:00', '17:09:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-19', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-19', '13:21:00', '17:03:00', 21, 3.7, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-19', '12:55:00', '17:01:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-19', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-19', '12:48:00', '17:13:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-19', '06:51:00', '12:06:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-19', '12:48:00', '17:08:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-19', '12:45:00', '17:09:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-19', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-19', '13:44:00', '17:08:00', 44, 3.4, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-19', '13:00:00', '17:13:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-19', '12:53:00', '17:00:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-19', '07:00:00', '12:01:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-19', '12:46:00', '17:14:00', 0, 4.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-19', '13:29:00', '17:12:00', 29, 3.72, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-20', '06:58:00', '11:58:00', 0, 5.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-20', '12:48:00', '17:05:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-20', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-20', '06:56:00', '12:10:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-20', '06:48:00', '12:07:00', 0, 5.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-20', '06:46:00', '12:10:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-20', '12:59:00', '16:58:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-20', '12:50:00', '17:15:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-20', '12:54:00', '17:03:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-20', '06:59:00', '12:14:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-20', '06:47:00', '12:11:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-20', '12:50:00', '16:59:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-20', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (14, '2026-01-20', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (15, '2026-01-20', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-20', '12:57:00', '16:56:00', 0, 3.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-20', '06:53:00', '17:14:00', 0, 10.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-20', '12:54:00', '17:06:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-20', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-20', '07:00:00', '12:08:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-20', '07:00:00', '17:01:00', 0, 10.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-20', '12:46:00', '17:00:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-20', '06:54:00', '17:14:00', 0, 10.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-20', '06:51:00', '12:05:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-20', '12:48:00', '16:57:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-20', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (27, '2026-01-20', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-20', '12:48:00', '17:07:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-20', '06:47:00', '12:11:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-20', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-20', '12:53:00', '17:08:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-20', '07:29:00', '16:57:00', 29, 9.47, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-20', '12:54:00', '17:13:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-20', '06:58:00', '12:10:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-20', '12:50:00', '17:05:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-20', '07:00:00', '12:10:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-20', '13:40:00', '17:09:00', 40, 3.48, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-20', '06:59:00', '12:00:00', 0, 5.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-20', '13:45:00', '16:55:00', 45, 3.17, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-20', '06:59:00', '12:04:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-20', '12:55:00', '17:08:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-20', '12:49:00', '17:13:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-20', '06:58:00', '12:08:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-20', '06:59:00', '12:12:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-20', '06:57:00', '17:08:00', 0, 10.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-20', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-20', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-20', '12:56:00', '17:09:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-20', '13:00:00', '17:10:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-20', '13:19:00', '16:58:00', 19, 3.65, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-20', '06:59:00', '12:01:00', 0, 5.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-20', '13:35:00', '16:56:00', 35, 3.35, 'RETARDO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (53, '2026-01-20', '2026-01-20', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-20', '12:54:00', '17:03:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-20', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-20', '12:49:00', '17:07:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-20', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-20', '06:53:00', '12:11:00', 0, 5.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-20', '12:47:00', '17:12:00', 0, 4.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-20', '12:57:00', '16:57:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2026-01-21', '2026-01-26', 'Médico', 'Intervención dental', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-21', '13:44:00', '17:10:00', 44, 3.43, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-21', '12:55:00', '17:02:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-21', '06:53:00', '12:05:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-21', '07:00:00', '12:13:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-21', '06:50:00', '12:13:00', 0, 5.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-21', '12:49:00', '17:10:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-21', '12:58:00', '17:06:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-21', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (10, '2026-01-21', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-21', '06:55:00', '12:13:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-21', '13:38:00', '17:02:00', 38, 3.4, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-21', '12:49:00', '17:15:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (14, '2026-01-21', '2026-01-21', 'Eventualidad', 'Cita médica control', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-21', '12:55:00', '17:03:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-21', '12:50:00', '17:13:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-21', '06:55:00', '17:14:00', 0, 10.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-21', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-21', '12:51:00', '17:04:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-21', '07:19:00', '12:04:00', 19, 4.75, 'RETARDO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (21, '2026-01-21', '2026-01-24', 'Médico', 'Migraña severa', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-21', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-21', '07:38:00', '17:02:00', 38, 9.4, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-21', '06:52:00', '12:13:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-21', '12:55:00', '17:09:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-21', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-21', '06:45:00', '11:58:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (28, '2026-01-21', '2026-01-26', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-21', '06:57:00', '11:58:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (30, '2026-01-21', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-21', '12:47:00', '17:07:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-21', '06:47:00', '17:09:00', 0, 10.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-21', '12:58:00', '16:56:00', 0, 3.97, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-21', '06:50:00', '12:02:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-21', '12:48:00', '17:06:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-21', '06:56:00', '11:57:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-21', '12:58:00', '17:15:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-21', '06:54:00', '12:06:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-21', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-21', '06:57:00', '12:13:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-21', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-21', '12:51:00', '16:56:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-21', '06:51:00', '11:58:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-21', '07:00:00', '12:06:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-21', '06:49:00', '17:01:00', 0, 10.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-21', '12:52:00', '17:08:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-21', '13:13:00', '17:00:00', 13, 3.78, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-21', '12:52:00', '17:15:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-21', '12:45:00', '17:01:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-21', '12:53:00', '17:14:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-21', '07:20:00', '12:09:00', 20, 4.82, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-21', '13:32:00', '17:06:00', 32, 3.57, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-21', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-21', '12:50:00', '17:07:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-21', '12:47:00', '17:14:00', 0, 4.45, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-21', '12:50:00', '17:08:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-21', '12:47:00', '16:57:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-21', '06:45:00', '11:55:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-21', '12:59:00', '17:08:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (60, '2026-01-21', '2026-01-21', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2026-01-22', '2026-01-22', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-22', '12:52:00', '17:07:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-22', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-22', '06:55:00', '12:05:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-22', '07:23:00', '12:04:00', 23, 4.68, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-22', '06:51:00', '12:13:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-22', '12:49:00', '17:10:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-22', '12:51:00', '17:09:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-22', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (10, '2026-01-22', '2026-01-24', 'Médico', 'Esguince de tobillo', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-22', '06:53:00', '11:55:00', 0, 5.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-22', '12:50:00', '16:56:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-22', '12:59:00', '17:06:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-22', '12:51:00', '17:09:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-22', '12:52:00', '16:57:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-22', '13:00:00', '16:55:00', 0, 3.92, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-22', '07:42:00', '17:00:00', 42, 9.3, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-22', '12:53:00', '17:14:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-22', '12:52:00', '17:00:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-22', '06:55:00', '11:55:00', 0, 5.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-22', '07:13:00', '17:02:00', 13, 9.82, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-22', '12:47:00', '16:56:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-22', '06:51:00', '17:05:00', 0, 10.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-22', '06:52:00', '11:56:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-22', '12:59:00', '17:08:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-22', '12:58:00', '17:05:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-22', '06:58:00', '12:08:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-22', '12:54:00', '17:11:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-22', '06:55:00', '12:03:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-22', '12:47:00', '17:09:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-22', '12:54:00', '17:02:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-22', '06:45:00', '17:06:00', 0, 10.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-22', '12:47:00', '17:01:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-22', '06:59:00', '12:10:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-22', '12:53:00', '17:01:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-22', '07:23:00', '12:08:00', 23, 4.75, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-22', '12:57:00', '16:55:00', 0, 3.97, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-22', '06:54:00', '12:10:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-22', '12:47:00', '17:01:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-22', '07:00:00', '12:10:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-22', '12:45:00', '16:56:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-22', '12:50:00', '17:11:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-22', '07:10:00', '11:59:00', 10, 4.82, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-22', '06:54:00', '11:59:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-22', '06:51:00', '17:06:00', 0, 10.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-22', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-22', '12:47:00', '17:00:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (48, '2026-01-22', '2026-01-22', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-22', '13:33:00', '16:58:00', 33, 3.42, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-22', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-22', '07:15:00', '12:00:00', 15, 4.75, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-22', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-22', '12:58:00', '17:14:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-22', '12:57:00', '16:57:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-22', '12:58:00', '17:13:00', 0, 4.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-22', '12:55:00', '17:04:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (57, '2026-01-22', '2026-01-22', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-22', '07:21:00', '12:00:00', 21, 4.65, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-22', '12:51:00', '16:55:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-22', '12:52:00', '17:09:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-23', '06:58:00', '12:02:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-23', '13:16:00', '17:07:00', 16, 3.85, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-23', '12:53:00', '17:14:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-23', '07:00:00', '12:12:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-23', '07:50:00', '12:10:00', 50, 4.33, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-23', '07:18:00', '11:59:00', 18, 4.68, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-23', '13:00:00', '16:58:00', 0, 3.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-23', '12:49:00', '17:00:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-23', '13:35:00', '16:59:00', 35, 3.4, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-23', '06:54:00', '12:08:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-23', '07:17:00', '12:07:00', 17, 4.83, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-23', '12:55:00', '17:12:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-23', '12:54:00', '17:03:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-23', '12:48:00', '17:05:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-23', '12:51:00', '17:11:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-23', '12:47:00', '16:57:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-23', '06:49:00', '16:59:00', 0, 10.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-23', '13:26:00', '17:09:00', 26, 3.72, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-23', '13:18:00', '17:00:00', 18, 3.7, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (20, '2026-01-23', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (21, '2026-01-23', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-23', '12:57:00', '17:14:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-23', '06:49:00', '17:12:00', 0, 10.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-23', '06:59:00', '12:11:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (25, '2026-01-23', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-23', '12:50:00', '17:02:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-23', '07:36:00', '12:13:00', 36, 4.62, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-23', '12:56:00', '17:07:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-23', '06:50:00', '12:10:00', 0, 5.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-23', '12:49:00', '17:01:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-23', '13:50:00', '17:00:00', 50, 3.17, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-23', '06:45:00', '17:05:00', 0, 10.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-23', '12:58:00', '17:05:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-23', '06:49:00', '12:09:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-23', '13:00:00', '17:10:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-23', '06:55:00', '11:55:00', 0, 5.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-23', '12:53:00', '16:55:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-23', '06:58:00', '12:00:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-23', '13:40:00', '16:58:00', 40, 3.3, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-23', '06:56:00', '11:58:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-23', '12:48:00', '16:59:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-23', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-23', '06:48:00', '12:04:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-23', '06:50:00', '12:03:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-23', '06:56:00', '17:13:00', 0, 10.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-23', '12:49:00', '16:58:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-23', '13:45:00', '16:58:00', 45, 3.22, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-23', '12:46:00', '17:14:00', 0, 4.47, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-23', '12:48:00', '17:11:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-23', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-23', '07:46:00', '12:06:00', 46, 4.33, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-23', '13:00:00', '17:07:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-23', '12:55:00', '17:08:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-23', '12:49:00', '17:15:00', 0, 4.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-23', '12:48:00', '17:06:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-23', '12:46:00', '17:08:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-23', '12:45:00', '17:02:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-23', '06:54:00', '12:09:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-23', '12:48:00', '16:59:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-23', '12:45:00', '17:01:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (1, '2026-01-26', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-26', '12:55:00', '17:13:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-26', '12:59:00', '17:04:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-26', '06:59:00', '12:07:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-26', '06:51:00', '12:06:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-26', '06:52:00', '12:10:00', 0, 5.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-26', '12:51:00', '17:11:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-26', '12:56:00', '17:11:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (9, '2026-01-26', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-26', '07:21:00', '12:09:00', 21, 4.8, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-26', '06:53:00', '12:10:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (12, '2026-01-26', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-26', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-26', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-26', '12:47:00', '16:58:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-26', '12:59:00', '17:05:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-26', '06:59:00', '17:09:00', 0, 10.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-26', '13:41:00', '17:06:00', 41, 3.42, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-26', '12:56:00', '17:04:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-26', '06:53:00', '12:01:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-26', '06:57:00', '16:56:00', 0, 9.98, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-26', '13:00:00', '17:05:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-26', '07:27:00', '17:02:00', 27, 9.58, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-26', '07:44:00', '11:57:00', 44, 4.22, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-26', '13:41:00', '17:01:00', 41, 3.33, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-26', '12:58:00', '16:56:00', 0, 3.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-26', '06:51:00', '12:08:00', 0, 5.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-26', '12:46:00', '17:06:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-26', '06:54:00', '11:55:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-26', '12:56:00', '17:10:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (31, '2026-01-26', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (32, '2026-01-26', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-26', '12:46:00', '17:11:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-26', '06:55:00', '11:56:00', 0, 5.02, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-26', '12:53:00', '17:09:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-26', '07:23:00', '12:10:00', 23, 4.78, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-26', '13:30:00', '17:11:00', 30, 3.68, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-26', '06:58:00', '12:13:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-26', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-26', '06:48:00', '12:00:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-26', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-26', '13:00:00', '17:12:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-26', '07:37:00', '12:07:00', 37, 4.5, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-26', '07:00:00', '12:10:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-26', '06:54:00', '17:09:00', 0, 10.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-26', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-26', '12:48:00', '16:56:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-26', '13:17:00', '17:04:00', 17, 3.78, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-26', '12:57:00', '17:07:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-26', '12:57:00', '17:02:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-26', '06:54:00', '12:07:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-26', '13:10:00', '17:08:00', 10, 3.97, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-26', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-26', '13:37:00', '17:07:00', 37, 3.5, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-26', '12:50:00', '17:00:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-26', '12:52:00', '17:04:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-26', '12:59:00', '17:11:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-26', '06:49:00', '12:15:00', 0, 5.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-26', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-26', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-27', '06:50:00', '12:04:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (2, '2026-01-27', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-27', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-27', '06:59:00', '12:05:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-27', '06:45:00', '12:14:00', 0, 5.48, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-27', '06:51:00', '12:13:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-27', '12:46:00', '17:12:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-27', '12:45:00', '17:04:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (9, '2026-01-27', '2026-01-27', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-27', '06:48:00', '12:01:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-27', '06:49:00', '12:10:00', 0, 5.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-27', '12:48:00', '17:07:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-27', '12:52:00', '17:15:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-27', '13:00:00', '17:08:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-27', '12:45:00', '16:56:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-27', '12:58:00', '17:09:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-27', '07:00:00', '17:11:00', 0, 10.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-27', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-27', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-27', '06:48:00', '12:12:00', 0, 5.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-27', '07:45:00', '17:08:00', 45, 9.38, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-27', '12:53:00', '17:06:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-27', '06:57:00', '17:15:00', 0, 10.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-27', '06:53:00', '11:59:00', 0, 5.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-27', '12:51:00', '17:12:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-27', '12:46:00', '17:00:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-27', '06:47:00', '12:14:00', 0, 5.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-27', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-27', '07:00:00', '12:02:00', 0, 5.03, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-27', '12:46:00', '17:13:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-27', '12:50:00', '16:59:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-27', '06:46:00', '17:09:00', 0, 10.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (33, '2026-01-27', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-27', '06:48:00', '11:59:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-27', '12:49:00', '17:02:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-27', '06:52:00', '12:08:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-27', '12:48:00', '17:01:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-27', '07:20:00', '12:06:00', 20, 4.77, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-27', '12:45:00', '16:59:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-27', '06:51:00', '11:57:00', 0, 5.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-27', '13:21:00', '17:02:00', 21, 3.68, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-27', '12:53:00', '16:59:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (43, '2026-01-27', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-27', '06:52:00', '12:12:00', 0, 5.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-27', '06:50:00', '17:11:00', 0, 10.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-27', '12:49:00', '17:15:00', 0, 4.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-27', '12:54:00', '17:00:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (48, '2026-01-27', 'FALTA', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (49, '2026-01-27', '2026-02-01', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-27', '12:58:00', '17:15:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-27', '06:45:00', '12:01:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-27', '12:51:00', '16:58:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-27', '12:55:00', '17:12:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-27', '12:46:00', '17:14:00', 0, 4.47, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-27', '12:48:00', '17:12:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-27', '13:00:00', '16:57:00', 0, 3.95, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-27', '12:48:00', '17:04:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-27', '06:49:00', '12:06:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-27', '12:50:00', '16:57:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-27', '12:55:00', '16:55:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-28', '06:59:00', '12:08:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-28', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-28', '12:56:00', '16:58:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-28', '06:48:00', '11:59:00', 0, 5.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-28', '06:49:00', '11:59:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-28', '07:30:00', '12:02:00', 30, 4.53, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-28', '12:51:00', '17:01:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-28', '12:55:00', '17:10:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-28', '12:54:00', '17:10:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-28', '06:53:00', '11:57:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-28', '07:00:00', '12:05:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-28', '12:56:00', '17:03:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-28', '13:20:00', '17:05:00', 20, 3.75, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-28', '13:22:00', '17:10:00', 22, 3.8, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-28', '12:56:00', '16:58:00', 0, 4.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-28', '12:54:00', '16:58:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-28', '06:57:00', '17:06:00', 0, 10.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-28', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-28', '12:45:00', '17:07:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-28', '06:46:00', '12:01:00', 0, 5.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-28', '06:56:00', '17:00:00', 0, 10.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-28', '12:55:00', '16:59:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-28', '06:46:00', '17:03:00', 0, 10.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-28', '07:23:00', '12:07:00', 23, 4.73, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-28', '12:49:00', '16:59:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-28', '12:49:00', '17:06:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-28', '06:59:00', '11:56:00', 0, 4.95, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-28', '12:57:00', '17:00:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-28', '06:59:00', '11:57:00', 0, 4.97, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-28', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-28', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-28', '06:57:00', '17:15:00', 0, 10.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-28', '12:47:00', '17:00:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-28', '06:59:00', '12:14:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-28', '12:47:00', '17:09:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-28', '07:24:00', '12:07:00', 24, 4.72, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-28', '12:48:00', '16:57:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-28', '06:54:00', '12:06:00', 0, 5.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-28', '12:51:00', '16:56:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-28', '06:46:00', '12:15:00', 0, 5.48, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-28', '13:39:00', '16:56:00', 39, 3.28, 'RETARDO', 3);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (42, '2026-01-28', '2026-01-30', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-28', '06:51:00', '12:07:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-28', '06:58:00', '12:09:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-28', '06:45:00', '17:11:00', 0, 10.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-28', '12:58:00', '17:02:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-28', '12:51:00', '17:00:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-28', '12:51:00', '16:57:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-28', '13:23:00', '16:58:00', 23, 3.58, 'RETARDO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (50, '2026-01-28', '2026-01-28', 'Eventualidad', 'Cita médica control', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-28', '07:32:00', '12:02:00', 32, 4.5, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-28', '12:52:00', '16:59:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-28', '12:55:00', '17:05:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-28', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-28', '12:52:00', '17:01:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-28', '12:55:00', '17:05:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-28', '13:17:00', '17:15:00', 17, 3.97, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-28', '06:46:00', '11:56:00', 0, 5.17, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (59, '2026-01-28', '2026-01-28', 'Eventualidad', 'Trámite bancario', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-28', '12:52:00', '17:11:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-29', '06:48:00', '12:07:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-29', '12:45:00', '17:03:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-29', '12:54:00', '16:59:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-29', '06:45:00', '12:09:00', 0, 5.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-29', '07:44:00', '12:04:00', 44, 4.33, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-01-29', '06:54:00', '12:03:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-29', '13:00:00', '17:07:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-29', '12:53:00', '17:07:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-29', '12:56:00', '17:06:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-29', '06:54:00', '11:56:00', 0, 5.03, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-01-29', '06:47:00', '12:14:00', 0, 5.45, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (12, '2026-01-29', '2026-01-29', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-29', '13:48:00', '17:15:00', 48, 3.45, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-29', '12:51:00', '17:07:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (15, '2026-01-29', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-29', '12:56:00', '17:15:00', 0, 4.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-29', '06:59:00', '17:15:00', 0, 10.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-29', '13:42:00', '17:04:00', 42, 3.37, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-29', '13:00:00', '17:14:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-29', '06:54:00', '12:02:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-29', '07:00:00', '17:07:00', 0, 10.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-29', '12:53:00', '17:13:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (23, '2026-01-29', '2026-01-29', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-29', '07:24:00', '12:14:00', 24, 4.83, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-29', '12:58:00', '17:14:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-01-29', '12:48:00', '17:02:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-29', '06:58:00', '12:04:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-29', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (29, '2026-01-29', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-29', '12:49:00', '17:03:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-29', '13:12:00', '16:59:00', 12, 3.78, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-29', '06:49:00', '16:59:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-29', '12:52:00', '17:02:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-29', '06:54:00', '12:14:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-01-29', '12:47:00', '17:01:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-29', '06:53:00', '11:59:00', 0, 5.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-29', '13:14:00', '17:15:00', 14, 4.02, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-29', '06:57:00', '12:05:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-29', '12:45:00', '17:00:00', 0, 4.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-29', '06:58:00', '12:08:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-29', '12:58:00', '17:10:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-29', '13:13:00', '17:06:00', 13, 3.88, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-29', '06:49:00', '11:56:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-29', '06:46:00', '12:08:00', 0, 5.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-29', '07:11:00', '17:05:00', 11, 9.9, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-29', '12:59:00', '17:13:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-29', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-29', '12:54:00', '16:59:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-01-29', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-29', '12:46:00', '17:13:00', 0, 4.45, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-29', '06:53:00', '11:58:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-29', '13:41:00', '17:14:00', 41, 3.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (53, '2026-01-29', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-29', '12:57:00', '17:04:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-29', '12:54:00', '17:01:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-29', '12:58:00', '17:05:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (57, '2026-01-29', '2026-01-29', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-29', '07:32:00', '12:03:00', 32, 4.52, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-29', '12:51:00', '17:04:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-29', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-01-30', '06:52:00', '12:06:00', 0, 5.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-01-30', '12:57:00', '17:05:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-01-30', '12:50:00', '17:07:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-01-30', '06:48:00', '12:10:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-01-30', '06:57:00', '11:57:00', 0, 5.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (6, '2026-01-30', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-01-30', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-01-30', '12:45:00', '17:13:00', 0, 4.47, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-01-30', '13:21:00', '16:57:00', 21, 3.6, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-01-30', '06:45:00', '12:07:00', 0, 5.37, 'ASISTIO', 2);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (11, '2026-01-30', '2026-02-03', 'Médico', 'Infección estomacal', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-01-30', '13:00:00', '17:02:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-01-30', '12:55:00', '17:07:00', 0, 4.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-01-30', '12:55:00', '17:03:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-01-30', '12:48:00', '17:14:00', 0, 4.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-01-30', '13:00:00', '17:02:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-01-30', '06:46:00', '16:56:00', 0, 10.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-01-30', '12:57:00', '17:04:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-01-30', '12:50:00', '16:57:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-01-30', '07:00:00', '11:57:00', 0, 4.95, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-01-30', '06:55:00', '16:57:00', 0, 10.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-01-30', '12:54:00', '17:03:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-01-30', '07:14:00', '17:09:00', 14, 9.92, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-01-30', '06:53:00', '12:13:00', 0, 5.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-01-30', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (26, '2026-01-30', '2026-01-30', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-01-30', '06:55:00', '11:58:00', 0, 5.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-01-30', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-01-30', '06:52:00', '12:09:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-01-30', '12:46:00', '17:04:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-01-30', '12:52:00', '17:11:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-01-30', '07:00:00', '17:13:00', 0, 10.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-01-30', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-01-30', '06:50:00', '11:56:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (35, '2026-01-30', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-01-30', '06:50:00', '11:57:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-01-30', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-01-30', '06:47:00', '12:04:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-01-30', '13:16:00', '17:14:00', 16, 3.97, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-01-30', '07:25:00', '12:03:00', 25, 4.63, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-01-30', '12:46:00', '16:56:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-01-30', '12:56:00', '17:06:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-01-30', '06:49:00', '12:04:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-01-30', '07:32:00', '12:09:00', 32, 4.62, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-01-30', '06:59:00', '17:00:00', 0, 10.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-01-30', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-01-30', '12:56:00', '17:04:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-01-30', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (49, '2026-01-30', '2026-02-03', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-01-30', '12:45:00', '17:08:00', 0, 4.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-01-30', '06:46:00', '12:14:00', 0, 5.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-01-30', '13:22:00', '17:14:00', 22, 3.87, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-01-30', '12:59:00', '16:55:00', 0, 3.93, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-01-30', '12:45:00', '17:13:00', 0, 4.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-01-30', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-01-30', '13:46:00', '16:57:00', 46, 3.18, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-01-30', '12:47:00', '17:15:00', 0, 4.47, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-01-30', '07:37:00', '12:10:00', 37, 4.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-01-30', '12:50:00', '16:58:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-01-30', '12:49:00', '17:09:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (1, '2026-02-02', '2026-02-02', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-02-02', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-02-02', '13:16:00', '17:11:00', 16, 3.92, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-02-02', '06:57:00', '12:10:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-02-02', '07:34:00', '12:12:00', 34, 4.63, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-02-02', '06:47:00', '11:58:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-02-02', '12:57:00', '17:03:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (8, '2026-02-02', '2026-02-06', 'Médico', 'Infección estomacal', 'ACTIVO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-02-02', '12:56:00', '17:14:00', 0, 4.3, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-02-02', '06:47:00', '11:55:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-02-02', '06:56:00', '12:10:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-02-02', '13:44:00', '16:55:00', 44, 3.18, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-02-02', '13:00:00', '17:12:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-02-02', '12:51:00', '17:05:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-02-02', '12:50:00', '17:02:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-02-02', '13:42:00', '17:11:00', 42, 3.48, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-02-02', '06:45:00', '17:13:00', 0, 10.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-02-02', '12:50:00', '17:14:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-02-02', '13:10:00', '17:00:00', 10, 3.83, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-02-02', '06:58:00', '12:00:00', 0, 5.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-02-02', '06:47:00', '17:07:00', 0, 10.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-02-02', '12:53:00', '17:01:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-02-02', '06:46:00', '16:58:00', 0, 10.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-02-02', '07:23:00', '12:11:00', 23, 4.8, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-02-02', '12:52:00', '16:57:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-02-02', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-02-02', '06:56:00', '12:03:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-02-02', '13:21:00', '17:00:00', 21, 3.65, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-02-02', '06:46:00', '11:56:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (30, '2026-02-02', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-02-02', '13:26:00', '17:15:00', 26, 3.82, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-02-02', '07:41:00', '17:07:00', 41, 9.43, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-02-02', '12:58:00', '17:04:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-02-02', '06:50:00', '12:03:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-02-02', '13:27:00', '16:57:00', 27, 3.5, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-02-02', '06:47:00', '12:04:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-02-02', '12:49:00', '16:55:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-02-02', '06:54:00', '12:02:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-02-02', '12:51:00', '16:59:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-02-02', '06:48:00', '12:09:00', 0, 5.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-02-02', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-02-02', '13:31:00', '16:57:00', 31, 3.43, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-02-02', '06:48:00', '11:57:00', 0, 5.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-02-02', '06:52:00', '12:14:00', 0, 5.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-02-02', '06:46:00', '17:06:00', 0, 10.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (46, '2026-02-02', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-02-02', '12:50:00', '17:07:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-02-02', '13:34:00', '17:07:00', 34, 3.55, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-02-02', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-02-02', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-02-02', '06:56:00', '12:10:00', 0, 5.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-02-02', '13:49:00', '17:10:00', 49, 3.35, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-02-02', '12:51:00', '17:15:00', 0, 4.4, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (54, '2026-02-02', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-02-02', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-02-02', '13:00:00', '17:01:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-02-02', '13:30:00', '16:58:00', 30, 3.47, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-02-02', '06:53:00', '12:06:00', 0, 5.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-02-02', '12:48:00', '17:12:00', 0, 4.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-02-02', '12:53:00', '17:05:00', 0, 4.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-02-03', '06:56:00', '12:04:00', 0, 5.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-02-03', '12:59:00', '17:09:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-02-03', '12:50:00', '17:13:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-02-03', '06:59:00', '12:15:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-02-03', '06:51:00', '12:00:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (6, '2026-02-03', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-02-03', '12:45:00', '17:00:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-02-03', '12:48:00', '17:07:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-02-03', '12:59:00', '17:03:00', 0, 4.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-02-03', '06:54:00', '12:12:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-02-03', '06:58:00', '12:15:00', 0, 5.28, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-02-03', '13:32:00', '17:01:00', 32, 3.48, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-02-03', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-02-03', '12:48:00', '16:58:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-02-03', '12:45:00', '16:55:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-02-03', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-02-03', '06:46:00', '17:11:00', 0, 10.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-02-03', '12:56:00', '17:12:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-02-03', '13:26:00', '17:02:00', 26, 3.6, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-02-03', '06:45:00', '12:01:00', 0, 5.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-02-03', '06:46:00', '17:02:00', 0, 10.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-02-03', '13:44:00', '16:58:00', 44, 3.23, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-02-03', '06:46:00', '17:01:00', 0, 10.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-02-03', '06:58:00', '12:05:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-02-03', '12:45:00', '17:01:00', 0, 4.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-02-03', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (27, '2026-02-03', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-02-03', '13:00:00', '17:06:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-02-03', '06:48:00', '12:11:00', 0, 5.38, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-02-03', '13:21:00', '16:59:00', 21, 3.63, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-02-03', '12:52:00', '16:58:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-02-03', '06:52:00', '17:09:00', 0, 10.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-02-03', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (34, '2026-02-03', '2026-02-03', 'Eventualidad', 'Lluvia fuerte e inundación', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-02-03', '13:15:00', '17:13:00', 15, 3.97, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-02-03', '06:53:00', '12:09:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (37, '2026-02-03', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-02-03', '06:49:00', '12:13:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-02-03', '12:58:00', '17:08:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-02-03', '07:17:00', '12:04:00', 17, 4.78, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-02-03', '12:52:00', '17:06:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-02-03', '12:55:00', '17:08:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-02-03', '06:54:00', '12:07:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-02-03', '06:49:00', '12:07:00', 0, 5.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-02-03', '06:59:00', '17:12:00', 0, 10.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-02-03', '12:45:00', '16:55:00', 0, 4.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-02-03', '13:46:00', '17:12:00', 46, 3.43, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-02-03', '12:52:00', '17:06:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (49, '2026-02-03', '2026-02-08', 'Médico', 'Reposo por hipertensión', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-02-03', '13:00:00', '17:09:00', 0, 4.15, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-02-03', '06:55:00', '12:01:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-02-03', '12:48:00', '17:07:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-02-03', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-02-03', '13:00:00', '17:08:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-02-03', '13:00:00', '16:57:00', 0, 3.95, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-02-03', '12:46:00', '16:59:00', 0, 4.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-02-03', '12:50:00', '16:56:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (58, '2026-02-03', '2026-02-03', 'Eventualidad', 'Trámite bancario', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-02-03', '12:56:00', '17:08:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-02-03', '12:50:00', '17:12:00', 0, 4.37, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-02-04', '06:55:00', '12:01:00', 0, 5.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-02-04', '13:26:00', '16:55:00', 26, 3.48, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-02-04', '13:00:00', '17:00:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-02-04', '06:55:00', '12:00:00', 0, 5.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-02-04', '06:46:00', '12:05:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-02-04', '06:56:00', '12:11:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-02-04', '12:45:00', '17:04:00', 0, 4.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-02-04', '12:58:00', '17:05:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-02-04', '13:00:00', '17:04:00', 0, 4.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-02-04', '06:45:00', '12:06:00', 0, 5.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-02-04', '06:46:00', '12:10:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-02-04', '12:55:00', '17:03:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-02-04', '12:56:00', '17:15:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-02-04', '13:32:00', '17:03:00', 32, 3.52, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-02-04', '12:45:00', '17:15:00', 0, 4.5, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-02-04', '13:46:00', '17:00:00', 46, 3.23, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-02-04', '06:45:00', '16:56:00', 0, 10.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-02-04', '13:45:00', '17:12:00', 45, 3.45, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-02-04', '12:51:00', '17:10:00', 0, 4.32, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-02-04', '06:52:00', '12:07:00', 0, 5.25, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-02-04', '06:57:00', '16:57:00', 0, 10.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-02-04', '13:42:00', '17:14:00', 42, 3.53, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-02-04', '06:53:00', '16:59:00', 0, 10.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-02-04', '07:45:00', '12:10:00', 45, 4.42, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-02-04', '12:58:00', '16:58:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-02-04', '12:53:00', '17:14:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-02-04', '07:31:00', '12:15:00', 31, 4.73, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-02-04', '12:49:00', '17:05:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-02-04', '06:47:00', '11:57:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-02-04', '12:58:00', '17:09:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-02-04', '12:48:00', '16:57:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-02-04', '06:51:00', '16:59:00', 0, 10.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-02-04', '12:49:00', '17:12:00', 0, 4.38, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-02-04', '06:48:00', '12:05:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-02-04', '12:53:00', '17:11:00', 0, 4.3, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-02-04', '06:55:00', '11:56:00', 0, 5.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-02-04', '13:29:00', '17:02:00', 29, 3.55, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-02-04', '07:29:00', '12:04:00', 29, 4.58, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-02-04', '12:55:00', '16:55:00', 0, 4.0, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (40, '2026-02-04', '2026-02-04', 'Eventualidad', 'Problemas de transporte público', 'CERRADO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-02-04', '12:52:00', '17:12:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-02-04', '13:47:00', '16:56:00', 47, 3.15, 'RETARDO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (43, '2026-02-04', '2026-02-04', 'Eventualidad', 'Cita médica control', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-02-04', '06:59:00', '12:09:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-02-04', '06:49:00', '17:03:00', 0, 10.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-02-04', '12:59:00', '17:15:00', 0, 4.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-02-04', '12:55:00', '17:02:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-02-04', '13:46:00', '17:15:00', 46, 3.48, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (49, '2026-02-04', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-02-04', '12:52:00', '17:13:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-02-04', '06:45:00', '12:13:00', 0, 5.47, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-02-04', '12:56:00', '16:59:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-02-04', '12:54:00', '17:06:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-02-04', '12:45:00', '17:05:00', 0, 4.33, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-02-04', '12:57:00', '17:13:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-02-04', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-02-04', '12:53:00', '17:00:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-02-04', '06:58:00', '12:06:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-02-04', '13:21:00', '16:55:00', 21, 3.57, 'RETARDO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (60, '2026-02-04', '2026-02-04', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (1, '2026-02-05', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-02-05', '12:56:00', '17:04:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-02-05', '13:30:00', '17:10:00', 30, 3.67, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-02-05', '06:48:00', '12:12:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (5, '2026-02-05', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-02-05', '06:48:00', '12:04:00', 0, 5.27, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-02-05', '12:49:00', '16:56:00', 0, 4.12, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-02-05', '13:24:00', '17:00:00', 24, 3.6, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-02-05', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-02-05', '06:49:00', '12:02:00', 0, 5.22, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-02-05', '06:58:00', '12:12:00', 0, 5.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (12, '2026-02-05', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-02-05', '12:48:00', '16:55:00', 0, 4.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-02-05', '13:31:00', '16:59:00', 31, 3.47, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-02-05', '12:59:00', '17:02:00', 0, 4.05, 'ASISTIO', 3);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (16, '2026-02-05', '2026-02-05', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-02-05', '06:45:00', '17:04:00', 0, 10.32, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-02-05', '13:49:00', '17:11:00', 49, 3.37, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-02-05', '13:00:00', '17:06:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-02-05', '06:53:00', '12:09:00', 0, 5.27, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-02-05', '06:54:00', '17:11:00', 0, 10.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-02-05', '13:12:00', '17:05:00', 12, 3.88, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-02-05', '07:35:00', '17:00:00', 35, 9.42, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-02-05', '06:53:00', '12:04:00', 0, 5.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-02-05', '12:50:00', '17:11:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-02-05', '12:52:00', '16:55:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-02-05', '07:20:00', '11:59:00', 20, 4.65, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-02-05', '12:49:00', '17:11:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-02-05', '06:59:00', '12:03:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-02-05', '12:52:00', '17:13:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-02-05', '12:53:00', '17:04:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-02-05', '06:47:00', '16:59:00', 0, 10.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-02-05', '12:57:00', '17:07:00', 0, 4.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-02-05', '06:45:00', '12:04:00', 0, 5.32, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-02-05', '12:58:00', '17:01:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-02-05', '07:27:00', '12:12:00', 27, 4.75, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-02-05', '12:59:00', '17:08:00', 0, 4.15, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-02-05', '06:46:00', '11:56:00', 0, 5.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-02-05', '13:11:00', '16:56:00', 11, 3.75, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-02-05', '06:54:00', '12:14:00', 0, 5.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-02-05', '13:00:00', '17:06:00', 0, 4.1, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (42, '2026-02-05', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-02-05', '06:51:00', '11:55:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (44, '2026-02-05', '2026-02-05', 'Eventualidad', 'Asunto familiar grave', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-02-05', '06:52:00', '17:00:00', 0, 10.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-02-05', '12:49:00', '17:00:00', 0, 4.18, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-02-05', '12:51:00', '17:04:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-02-05', '13:13:00', '17:14:00', 13, 4.02, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-02-05', '12:54:00', '17:05:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-02-05', '12:54:00', '16:57:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-02-05', '06:47:00', '12:02:00', 0, 5.25, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-02-05', '12:50:00', '17:11:00', 0, 4.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (53, '2026-02-05', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-02-05', '12:50:00', '17:06:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-02-05', '12:58:00', '17:01:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO reposos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (56, '2026-02-05', '2026-02-07', 'Médico', 'Gripe viral fuerte', 'ACTIVO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-02-05', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-02-05', '06:56:00', '12:09:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-02-05', '12:58:00', '17:07:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-02-05', '13:15:00', '16:56:00', 15, 3.68, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-02-06', '07:00:00', '12:12:00', 0, 5.2, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-02-06', '12:48:00', '17:12:00', 0, 4.4, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-02-06', '13:26:00', '17:01:00', 26, 3.58, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-02-06', '06:58:00', '12:09:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-02-06', '06:47:00', '12:13:00', 0, 5.43, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-02-06', '06:54:00', '12:11:00', 0, 5.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-02-06', '12:47:00', '16:55:00', 0, 4.13, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (8, '2026-02-06', '2026-02-06', 'Eventualidad', 'Diligencia personal urgente', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-02-06', '12:52:00', '17:08:00', 0, 4.27, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (10, '2026-02-06', '06:59:00', '12:11:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-02-06', '06:49:00', '12:14:00', 0, 5.42, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-02-06', '13:48:00', '17:07:00', 48, 3.32, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (13, '2026-02-06', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-02-06', '12:49:00', '17:09:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-02-06', '12:51:00', '17:08:00', 0, 4.28, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-02-06', '13:24:00', '17:09:00', 24, 3.75, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-02-06', '07:43:00', '17:06:00', 43, 9.38, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-02-06', '12:55:00', '17:08:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-02-06', '12:47:00', '17:07:00', 0, 4.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-02-06', '06:48:00', '12:14:00', 0, 5.43, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-02-06', '06:52:00', '17:12:00', 0, 10.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-02-06', '12:53:00', '16:55:00', 0, 4.03, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-02-06', '06:48:00', '16:57:00', 0, 10.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-02-06', '07:00:00', '12:04:00', 0, 5.07, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-02-06', '12:48:00', '16:55:00', 0, 4.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (26, '2026-02-06', 'FALTA', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (27, '2026-02-06', '06:50:00', '11:59:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-02-06', '12:50:00', '17:01:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-02-06', '07:00:00', '12:08:00', 0, 5.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-02-06', '12:47:00', '17:08:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-02-06', '12:57:00', '17:10:00', 0, 4.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-02-06', '06:56:00', '17:02:00', 0, 10.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (33, '2026-02-06', '12:56:00', '16:59:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-02-06', '06:50:00', '12:03:00', 0, 5.22, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-02-06', '12:51:00', '16:59:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-02-06', '06:46:00', '12:09:00', 0, 5.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-02-06', '12:53:00', '16:58:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-02-06', '07:20:00', '11:59:00', 20, 4.65, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-02-06', '12:52:00', '17:06:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-02-06', '06:59:00', '12:08:00', 0, 5.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-02-06', '12:54:00', '17:08:00', 0, 4.23, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-02-06', '12:58:00', '17:01:00', 0, 4.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-02-06', '06:45:00', '12:11:00', 0, 5.43, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-02-06', '06:57:00', '12:04:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-02-06', '06:57:00', '16:55:00', 0, 9.97, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-02-06', '13:00:00', '17:08:00', 0, 4.13, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-02-06', '12:54:00', '17:15:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-02-06', '12:56:00', '17:01:00', 0, 4.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (49, '2026-02-06', 'FALTA', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-02-06', '13:21:00', '17:01:00', 21, 3.67, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-02-06', '07:45:00', '12:15:00', 45, 4.5, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (52, '2026-02-06', '12:47:00', '17:15:00', 0, 4.47, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-02-06', '13:31:00', '17:02:00', 31, 3.52, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-02-06', '12:51:00', '17:00:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-02-06', '12:52:00', '16:58:00', 0, 4.1, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-02-06', '13:00:00', '17:11:00', 0, 4.18, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (57, '2026-02-06', '12:49:00', '17:14:00', 0, 4.42, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (58, '2026-02-06', '06:47:00', '11:59:00', 0, 5.2, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-02-06', '13:44:00', '17:02:00', 44, 3.3, 'RETARDO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (60, '2026-02-06', '2026-02-06', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (1, '2026-02-09', '06:53:00', '12:03:00', 0, 5.17, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (2, '2026-02-09', '12:54:00', '17:02:00', 0, 4.13, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (3, '2026-02-09', '13:28:00', '17:09:00', 28, 3.68, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (4, '2026-02-09', '06:47:00', '12:12:00', 0, 5.42, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (5, '2026-02-09', '06:59:00', '11:59:00', 0, 5.0, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (6, '2026-02-09', '06:46:00', '12:10:00', 0, 5.4, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (7, '2026-02-09', '13:28:00', '17:03:00', 28, 3.58, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (8, '2026-02-09', '13:43:00', '17:12:00', 43, 3.48, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (9, '2026-02-09', '12:46:00', '17:13:00', 0, 4.45, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (10, '2026-02-09', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (11, '2026-02-09', '06:51:00', '11:58:00', 0, 5.12, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (12, '2026-02-09', '12:56:00', '16:56:00', 0, 4.0, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (13, '2026-02-09', '12:46:00', '16:57:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (14, '2026-02-09', '12:57:00', '17:08:00', 0, 4.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (15, '2026-02-09', '12:55:00', '16:56:00', 0, 4.02, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (16, '2026-02-09', '12:48:00', '17:11:00', 0, 4.38, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (17, '2026-02-09', '06:59:00', '17:04:00', 0, 10.08, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (18, '2026-02-09', '12:57:00', '17:07:00', 0, 4.17, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (19, '2026-02-09', '12:45:00', '17:06:00', 0, 4.35, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (20, '2026-02-09', '07:22:00', '12:04:00', 22, 4.7, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (21, '2026-02-09', '06:47:00', '17:07:00', 0, 10.33, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (22, '2026-02-09', '12:53:00', '16:56:00', 0, 4.05, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (23, '2026-02-09', '06:56:00', '16:59:00', 0, 10.05, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (24, '2026-02-09', '06:50:00', '11:55:00', 0, 5.08, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (25, '2026-02-09', '13:48:00', '16:58:00', 48, 3.17, 'RETARDO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (26, '2026-02-09', '12:54:00', '17:11:00', 0, 4.28, 'ASISTIO', 2);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (27, '2026-02-09', '2026-02-09', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (28, '2026-02-09', '13:30:00', '17:04:00', 30, 3.57, 'RETARDO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (29, '2026-02-09', '06:56:00', '12:00:00', 0, 5.07, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (30, '2026-02-09', '12:51:00', '17:04:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (31, '2026-02-09', '13:00:00', '17:01:00', 0, 4.02, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (32, '2026-02-09', '06:59:00', '17:09:00', 0, 10.17, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (33, '2026-02-09', 'FALTA', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (34, '2026-02-09', '06:56:00', '11:59:00', 0, 5.05, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (35, '2026-02-09', '12:46:00', '17:15:00', 0, 4.48, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (36, '2026-02-09', '06:54:00', '12:02:00', 0, 5.13, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (37, '2026-02-09', '12:56:00', '17:13:00', 0, 4.28, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (38, '2026-02-09', '07:00:00', '12:04:00', 0, 5.07, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (39, '2026-02-09', '12:52:00', '17:14:00', 0, 4.37, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (40, '2026-02-09', '06:56:00', '12:03:00', 0, 5.12, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (41, '2026-02-09', '12:51:00', '16:57:00', 0, 4.1, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (42, '2026-02-09', '13:11:00', '17:07:00', 11, 3.93, 'RETARDO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (43, '2026-02-09', '06:49:00', '12:00:00', 0, 5.18, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (44, '2026-02-09', '06:58:00', '11:58:00', 0, 5.0, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (45, '2026-02-09', '06:46:00', '17:07:00', 0, 10.35, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (46, '2026-02-09', '12:51:00', '17:12:00', 0, 4.35, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (47, '2026-02-09', '12:59:00', '17:14:00', 0, 4.25, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (48, '2026-02-09', '12:50:00', '17:08:00', 0, 4.3, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (49, '2026-02-09', '12:53:00', '17:06:00', 0, 4.22, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (50, '2026-02-09', '12:46:00', '17:08:00', 0, 4.37, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (51, '2026-02-09', '07:45:00', '12:06:00', 45, 4.35, 'RETARDO', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (52, '2026-02-09', '2026-02-09', 'Eventualidad', 'Cita médica control', 'CERRADO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (53, '2026-02-09', '12:46:00', '17:00:00', 0, 4.23, 'ASISTIO', 2);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (54, '2026-02-09', '12:47:00', '16:59:00', 0, 4.2, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (55, '2026-02-09', '12:53:00', '17:13:00', 0, 4.33, 'ASISTIO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (56, '2026-02-09', '12:46:00', '16:55:00', 0, 4.15, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, estado, registrado_por) VALUES (57, '2026-02-09', 'FALTA', 1);
INSERT INTO permisos (empleado_id, fecha_inicio, fecha_fin, tipo, motivo, estado, creado_por) VALUES (58, '2026-02-09', '2026-02-09', 'Eventualidad', 'Vehículo averiado', 'CERRADO', 3);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (59, '2026-02-09', '12:55:00', '17:00:00', 0, 4.08, 'ASISTIO', 1);
INSERT INTO asistencias (empleado_id, fecha, hora_entrada, hora_salida, minutos_tarde, horas_trabajadas, estado, registrado_por) 
                          VALUES (60, '2026-02-09', '12:57:00', '16:59:00', 0, 4.03, 'ASISTIO', 3);
SET FOREIGN_KEY_CHECKS = 1;
