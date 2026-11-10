-- ==========================================
-- 09 - DESACTIVAR CODIGOS DE RECUPERACION
-- ==========================================

-- Conserva el historial.
-- Revoca solamente los codigos pendientes.

START TRANSACTION;

UPDATE usuario_codigos_recuperacion
SET revocado_en = NOW()
WHERE
    usado_en IS NULL
    AND revocado_en IS NULL;

SELECT ROW_COUNT() AS codigos_revocados;

COMMIT;