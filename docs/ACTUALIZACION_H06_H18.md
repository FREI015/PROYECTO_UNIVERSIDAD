# Cambios H-06 a H-18 (versión revisada)

**Antes de poner en producción:** comprobar que `git status` está limpio y que no hay cambios de otra persona sin integrar. No se ejecutó SQL sobre la base actual.

## Migración obligatoria para H-14 y H-18
Ejecutar `sql/05_auditoria_e_historial.sql` una única vez en una base de prueba y verificar las nuevas tablas `auditoria_acciones` y `empleados_historial_estado`. Después instalar en la base real. El código exige esas tablas para registrar cambios administrativos y preservar el historial; sin ellas, esas operaciones mostrarán errores controlados. No crea usuarios ni sobrescribe asistencia.

## H-06: justificativos
En Reposos se puede adjuntar PDF/JPG/PNG (hasta 5 MB). Los archivos se guardan en `uploads/justificativos/` con acceso web directo denegado por `.htaccess`. La descarga usa sesión y permisos por turno. Probar con sesión autorizada, sin sesión y con usuario de otro turno. **Importante:** comprobar HTTP 403 con la URL directa al archivo; depende de Apache/AllowOverride.

## H-07: cargos y turnos
<!-- H07_CATALOGOS_INTEGRIDAD_V2 -->

La administracion de cargos y turnos permanece integrada en Personal y restringida a Directora y Subdirector.

- Los cargos institucionales DOCENTE, ADMINISTRATIVO, OBRERO y DIRECTIVO permanecen protegidos.
- Los cargos no pueden modificarse ni eliminarse mientras tengan empleados asignados.
- MATUTINO (07:00-12:00), VESPERTINO (13:00-17:00) y COMPLETO (07:00-17:00) son institucionales y permanecen protegidos.
- Los turnos adicionales requieren soporte del motor de ventanas de asistencia.
- Los turnos adicionales no pueden modificarse ni eliminarse cuando tengan empleados o asistencias asociadas.
- Las asistencias conservan turno, hora inicial y hora final del momento del marcaje.
- La FK impide eliminar turnos que tengan referencias historicas.
- Los registros antiguos sin turno identificado no se completan artificialmente.
- MariaDB aplica restricciones CHECK y triggers para impedir modificaciones directas incompatibles.
- Los nombres de cargos y turnos son unicos.
- La auditoria conserva los valores anteriores y nuevos de cada operacion administrativa.
- La interfaz y el servidor aplican las mismas restricciones de negocio.

La migracion estructural se encuentra en `sql/08_integridad_catalogos.sql`.
El instalador aplica cada cambio de forma condicional y verifica el resultado.
- MariaDB mantiene nueve triggers H-07: seis protecciones existentes y tres controles adicionales para impedir inserciones no canonicas y conversiones de turnos a nombres o identificadores institucionales reservados.

## H-12: reportes
Las fechas futuras y días no laborables ya no se cuentan como ausencias automáticas. Por defecto son laborables lunes-viernes. Para instituciones que abren fines de semana o tienen feriados, configurar en `includes/config.php` antes de `session_start()`:

```php
define('REPORTE_DIAS_LABORABLES', [1,2,3,4,5]); // 1=lunes, 7=domingo
define('REPORTE_FECHAS_NO_LABORABLES', ['2026-12-25']);
define('REPORTE_FECHAS_LABORABLES_EXTRA', []);
```

Las asistencias registradas y reposos/permisos existentes prevalecen sobre la clasificación de día no laborable. Validar con un reporte de fin de semana y otro que incluya fechas futuras.

## H-14: auditoría
Panel desplegable de historial dentro de `modulos/usuarios.php`; registra acciones de altas/bajas/ediciones de personal, catálogos, reposos y administración de usuarios. Los datos sensibles no se guardan en los metadatos. La bitácora no modifica el historial previo. Por ahora los marcajes manuales ordinarios siguen su trazabilidad existente mediante `registrado_por`.

## H-16: fotos
Las fotos ya no se entregan como archivos estáticos públicos. La ruta `procesos/foto_empleado.php` valida sesión, permisos y alcance por turno. El kiosco usa un token de sesión de 90 segundos tras un marcaje exitoso. Verificar que el `.htaccess` de `uploads/empleados` produzca 403 en Apache.

## H-17: códigos de barras
El esquema de instalaciones nuevas exige código no nulo. Las validaciones PHP para creación/edición ya exigen código. Para bases existentes, consultar `sql/06_validar_codigos_barra_existentes.sql` y **no ejecutar ALTER TABLE** sin corregir primero los registros vacíos. El script deja comentada la sentencia de endurecimiento. No se generan códigos artificiales.

## H-18: historial
`modulos/historial_personal.php?empleado_id=...` permite consultar transiciones de estado según rol y turno. Solo se registran nuevas transiciones a partir de la migración: no se pueden reconstruir retroactivamente movimientos históricos que nunca fueron almacenados.

## Pruebas pendientes antes de desplegar
- Lint PHP de todos los archivos y `git diff --check`.
- Probar marcaje de entrada/salida y concurrencia del lector.
- Probar upload/descarga segura, foto por sesión, permisos de roles y reportes PDF.
- Verificar migración SQL (MySQL/MariaDB) y los cambios reales de estado de personal.
- Comparar el diff con los cambios de cualquier colaborador antes de subir a GitHub.

## Ajustes definitivos de consistencia
- El lector de codigo de barras y la marcacion manual utilizan las horas de inicio y fin del turno guardadas en `turnos`, con 5 minutos de antelacion para la entrada y una hora de margen para las salidas; se conserva el calculo de retardos.
- El reporte PDF exige fechas validas, ordenadas y maximo 100 dias; usa el historial de estado laboral y tambien incluye personal retirado durante los periodos en los que estaba vinculado.
- La retirada del empleado conserva permisos/reposos historicos como `CERRADO` y anula solo los futuros; los historicos previamente anulados no pueden reconstruirse automaticamente.
- El acceso administrativo a fotos revalida cuenta, rol y version de sesion. El token local temporal del kiosco se conserva.
- Permisos y reposos no admiten rangos activos superpuestos y las inserciones se serializan mediante bloqueo de empleado.
- Verificar en MySQL que el campo `codigo_barra` sea NOT NULL y unico, y ejecutar pruebas funcionales en XAMPP antes de publicar.
