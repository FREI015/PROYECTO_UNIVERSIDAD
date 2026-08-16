-- Usuarios iniciales con hash bcrypt (password_hash).
USE control_asistencia;

-- directora (DIRECTORA) hash: OK
INSERT INTO usuarios (usuario, clave, rol, estado, debe_cambiar_clave, version_sesion)
VALUES ('directora', '$2y$10$H5Kpn19nfjxyX6yGwcocHuKKroupGflGRioEt/0XhLOoy0xFsiCXW', 'DIRECTORA', 'ACTIVO', 0, 1)
ON DUPLICATE KEY UPDATE clave = VALUES(clave), rol = VALUES(rol), estado = 'ACTIVO', debe_cambiar_clave = 0, version_sesion = 1;

-- subdirector (SUBDIRECTOR) hash: OK
INSERT INTO usuarios (usuario, clave, rol, estado, debe_cambiar_clave, version_sesion)
VALUES ('subdirector', '$2y$10$jIKQpgaYyVgd8LG7sWbYRu0xNbwecrpPNrZrxeLJ4rsusO9T4jrr.', 'SUBDIRECTOR', 'ACTIVO', 0, 1)
ON DUPLICATE KEY UPDATE clave = VALUES(clave), rol = VALUES(rol), estado = 'ACTIVO', debe_cambiar_clave = 0, version_sesion = 1;

-- diurno (DIURNO) hash: OK
INSERT INTO usuarios (usuario, clave, rol, estado, debe_cambiar_clave, version_sesion)
VALUES ('diurno', '$2y$10$qoRm/8BbOJWEklGzocO1CeB4rlXCOyeQxSqb4AJPan6uRsK5pGyiS', 'DIURNO', 'ACTIVO', 0, 1)
ON DUPLICATE KEY UPDATE clave = VALUES(clave), rol = VALUES(rol), estado = 'ACTIVO', debe_cambiar_clave = 0, version_sesion = 1;

-- tarde (TARDE) hash: OK
INSERT INTO usuarios (usuario, clave, rol, estado, debe_cambiar_clave, version_sesion)
VALUES ('tarde', '$2y$10$OSazC1devIDzotwxZb2Pve.1Cuu9OIcvIvlTDtvsp6BQ0goKdCL5O', 'TARDE', 'ACTIVO', 0, 1)
ON DUPLICATE KEY UPDATE clave = VALUES(clave), rol = VALUES(rol), estado = 'ACTIVO', debe_cambiar_clave = 0, version_sesion = 1;
