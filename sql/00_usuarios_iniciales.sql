-- Usuarios iniciales con hash bcrypt (password_hash).
USE control_asistencia;

-- directora (DIRECTORA) hash: OK
INSERT INTO usuarios (usuario, clave, rol, estado, debe_cambiar_clave, version_sesion)
VALUES ('directora', '$2y$10$H5Kpn19nfjxyX6yGwcocHuKKroupGflGRioEt/0XhLOoy0xFsiCXW', 'DIRECTORA', 'ACTIVO', 1, 1)
ON DUPLICATE KEY UPDATE usuario = usuario;

-- subdirector (SUBDIRECTOR) hash: OK
INSERT INTO usuarios (usuario, clave, rol, estado, debe_cambiar_clave, version_sesion)
VALUES ('subdirector', '$2y$10$jIKQpgaYyVgd8LG7sWbYRu0xNbwecrpPNrZrxeLJ4rsusO9T4jrr.', 'SUBDIRECTOR', 'ACTIVO', 1, 1)
ON DUPLICATE KEY UPDATE usuario = usuario;

-- diurno (DIURNO) hash: OK
INSERT INTO usuarios (usuario, clave, rol, estado, debe_cambiar_clave, version_sesion)
VALUES ('diurno', '$2y$10$qoRm/8BbOJWEklGzocO1CeB4rlXCOyeQxSqb4AJPan6uRsK5pGyiS', 'DIURNO', 'ACTIVO', 1, 1)
ON DUPLICATE KEY UPDATE usuario = usuario;

-- tarde (TARDE) hash: OK
INSERT INTO usuarios (usuario, clave, rol, estado, debe_cambiar_clave, version_sesion)
VALUES ('tarde', '$2y$10$OSazC1devIDzotwxZb2Pve.1Cuu9OIcvIvlTDtvsp6BQ0goKdCL5O', 'TARDE', 'ACTIVO', 1, 1)
ON DUPLICATE KEY UPDATE usuario = usuario;
