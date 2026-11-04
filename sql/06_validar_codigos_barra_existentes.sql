-- H-17 - DIAGNOSTICO, NO MODIFICA DATOS POR SI MISMO.
-- En phpMyAdmin selecciona primero la base control_asistencia.
SELECT id, cedula, nombres, apellidos
FROM empleados
WHERE codigo_barra IS NULL OR TRIM(codigo_barra) = ''
ORDER BY id;

SELECT codigo_barra, COUNT(*) AS cantidad
FROM empleados
WHERE codigo_barra IS NOT NULL
GROUP BY codigo_barra
HAVING COUNT(*) > 1;

-- SOLO CUANDO LAS CONSULTAS ANTERIORES NO RETORNEN FILAS,
-- aplica manualmente (descomentando la instruccion):
-- ALTER TABLE empleados MODIFY codigo_barra VARCHAR(50) NOT NULL;
-- Se evita modificar o inventar codigos para empleados existentes.
