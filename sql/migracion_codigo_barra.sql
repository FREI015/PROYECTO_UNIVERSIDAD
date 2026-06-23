ALTER TABLE empleados ADD COLUMN codigo_barra VARCHAR(50) UNIQUE DEFAULT NULL AFTER telefono;
UPDATE empleados SET codigo_barra = CONCAT('EMP', LPAD(id, 5, '0')) WHERE codigo_barra IS NULL;
