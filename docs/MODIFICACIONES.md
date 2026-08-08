# MODIFICACIONES DEL SISTEMA

## Control de Asistencia — E.B.N. Dr. Enrique Delgado Palacios

---

## 1. Módulo de Código de Barras

### 1.1 Base de datos
**Archivo:** `sql/migracion_codigo_barra.sql`

Columna `codigo_barra VARCHAR(50) UNIQUE` agregada a `empleados` (después de `telefono`).
Formato del código: `EMP` + ID de 5 dígitos (ej: `EMP00001`, `EMP00042`).

### 1.2 Funciones auxiliares
**Archivo:** `includes/funciones.php`

- `empleadoPorCodigoBarra(PDO $pdo, string $codigo): ?array` — Busca empleado por código de barras.
- `generarCodigoBarra(int $empleadoId): string` — Genera código `EMP` + ID padded a 5 dígitos.

### 1.3 Generación automática al registrar personal
**Archivo:** `procesos/personal_guardar.php`

Al crear un nuevo empleado, se genera automáticamente su código de barras después del INSERT.

### 1.4 Visualización en el módulo Personal
**Archivo:** `modulos/personal.php`

- Columna `e.codigo_barra` incluida en las consultas SQL.
- Columna "Código de Barras" en la tabla de listado (entre Cédula y Cargo).
- Código mostrado en la tarjeta de éxito al registrar un empleado.

### 1.5 Procesador de código de barras
**Archivo (NUEVO):** `procesos/asistencia_barcode.php`

Endpoint POST unificado para procesar escaneo de código de barras:
- Acepta `redirect_to` para funcionar desde el panel admin o desde el kiosko.
- Detecta automáticamente entrada o salida según el estado actual de la asistencia.
- Calcula retardos con tolerancia configurable.
- Soporta turnos nocturnos (cruzan medianoche).
- Modo emergencia: omite restricciones de reposo/permiso si está activo.
- CSRF solo para el panel admin; el kiosko omite CSRF.

### 1.6 Terminal público de asistencia
**Archivo (NUEVO):** `login_empleado.php`

Página standalone para que empleados registren asistencia por código de barras sin iniciar sesión:
- Logo institucional + campo de escaneo.
- Auto-detección de Enter para enviar el formulario.
- Feedback visual con mensajes de éxito/error.
- Tabla con últimos 10 registros del día.
- Botón "Volver al inicio" con diseño beige/borde.

---

## 2. Landing Page en index.php

**Archivo:** `index.php`

Se agregó una landing page institucional **antes** de `requireLogin()`:
- **No logueado:** Muestra dos botones: "Acceso Administrativo" → `login.php` y "Registrar Asistencia" → `login_empleado.php`.
- **Logueado:** El dashboard administrativo existente se mantiene intacto.

---

## 3. Logo institucional

**Archivo:** `assets/img/insignia.png` (copiado)

Se actualizó la referencia en 4 archivos:
- `login.php`
- `includes/header.php`
- `index.php`
- `login_empleado.php`

---

## 4. Botón "Volver al inicio" en login.php

**Archivo:** `login.php`

Se agregó un enlace con diseño beige/borde debajo del formulario de login que redirige a `index.php`.

---

## Archivos creados

| Archivo | Descripción |
|---|---|
| `login_empleado.php` | Terminal público de asistencia por código de barras |
| `procesos/asistencia_barcode.php` | Procesador unificado de código de barras |
| `sql/migracion_codigo_barra.sql` | Migración para columna `codigo_barra` |
| `docs/MODIFICACIONES.md` | Este documento |

## Archivos modificados

| Archivo | Cambios |
|---|---|
| `index.php` | Landing page agregada antes de `requireLogin()` |
| `login.php` | Logo actualizado a `insignia.png` + botón "Volver al inicio" |
| `includes/header.php` | Logo actualizado a `insignia.png` |
| `includes/funciones.php` | Funciones `empleadoPorCodigoBarra()` y `generarCodigoBarra()` |
| `modulos/personal.php` | Columna "Código de Barras" en tabla y tarjeta de éxito |
| `procesos/personal_guardar.php` | Generación automática de código de barras |

## Funcionalidades ya presentes (sin cambios)

| Funcionalidad | Archivo |
|---|---|
| Modo emergencia (procesador) | `procesos/modo_emergencia.php` |
| Modo emergencia (UI en asistencias) | `modulos/asistencias.php` |
| Modo emergencia (bypass en entrada) | `procesos/asistencia_entrada.php` |
| Funciones de seguridad para contraseñas | `includes/funciones.php` |
| Login simplificado (password_verify) | `procesos/login_procesar.php` |

## Base de datos

| Cambio | SQL |
|---|---|
| `empleados.codigo_barra` | `ALTER TABLE empleados ADD codigo_barra VARCHAR(50) UNIQUE AFTER telefono;` |

---

# NOTA DE SOLUCIONES — 2026-08-07

Correcciones aplicadas el día de hoy, verificadas contra la BD real y una base de datos limpia de prueba.

## 5.1. Reportes PDF no se generaban (error fatal de SQL)

**Síntoma:** al pulsar "Generar PDF" en el módulo de reportes, el script moría sin entregar el PDF.

**Causa:** la tabla `asistencias` de la base de datos real tenía desactualizado el esquema y le faltaban columnas que el sistema usa desde hace tiempo:
`salida_estado`, `minutos_salida_tardia` y `observacion_sistema`. La consulta de `procesos/reporte_pdf.php` (y el registro de salida en `procesos/asistencia_salida.php`) las referencia, por lo que se lanzaba:

```
Uncaught PDOException: SQLSTATE[42S22]: Column not found: 1054
Unknown column 'salida_estado' in 'field list'  (reporte_pdf.php:373)
```

**Solución:**
- Creado `sql/migracion_salida_asistencias.sql` que agrega las tres columnas faltantes a `asistencias`.
- Aplicada la migración en la BD real.
- Verificado: el PDF se genera correctamente (≈280 KB) tanto para el reporte general como individual.

## 5.2. Errores al cargar la base de datos en otro equipo

**Síntoma:** al importar los scripts SQL desde `sql/` en una instalación nueva (otra máquina), MySQL reportaba errores.

**Causas detectadas:**
- `bd.sql` no definía la columna `codigo_barra` en `empleados`, aunque el código la requiere.
- `migracion_salida_asistencias.sql` y `migracion_codigo_barra.sql` no eran idempotentes: al ejecutarse tras `bd.sql` lanzaban `ERROR 1060 Duplicate column` y no traían `USE`, fallando con `No database selected`.
- El hash del usuario `admin` en `bd.sql` y en `01_saneamiento_profesional_bd.sql` no era válido: `password_verify('admin', hash)` daba `false`, por lo que era imposible iniciar sesión con la clave `admin`.

**Soluciones:**
- `sql/bd.sql`:
  - Agregada la columna `codigo_barra` y su índice único `uq_empleados_codigo_barra`.
  - Agregados cargos iniciales (DOCENTE, ADMINISTRATIVO, OBRERO, DIRECTIVO).
  - Agregado el usuario administrador inicial `admin` (rol `SUPER`) con hash de contraseña válido (clave: `admin`).
  - Regeneración de códigos de barra iniciales (`EMP` + id con 5 dígitos) para empleados existentes.
- `sql/migracion_salida_asistencias.sql`: reescrita como **idempotente** (agrega columnas solo si faltan) y con `CREATE DATABASE` + `USE`.
- `sql/migracion_codigo_barra.sql`: ídem (columna e índice solo si faltan).
- `sql/01_saneamiento_profesional_bd.sql`: corregido el hash del usuario `admin` por uno que sí verifica con la clave `admin`.

## 5.3. Orden de carga recomendado en instalaciones nuevas

1. `bd.sql`
2. `migracion_codigo_barra.sql`
3. `migracion_salida_asistencias.sql`
4. `01_saneamiento_profesional_bd.sql`

Los cuatro scripts se importaron en una base de datos limpia y finalizaron sin errores (EXIT 0).

## 5.4. Archivos involucrados

| Archivo | Cambio |
|---|---|
| `sql/migracion_salida_asistencias.sql` | Creado; agrega columnas de salida a `asistencias` (idempotente). |
| `sql/migracion_codigo_barra.sql` | Reescrito idempotente (columna + índice `codigo_barra`). |
| `sql/bd.sql` | Columna `codigo_barra`, cargos, usuario admin válido y códigos iniciales. |
| `sql/01_saneamiento_profesional_bd.sql` | Hash de usuario `admin` corregido. |
| BD real `control_asistencia` | Columnas de salida agregadas a `asistencias`. |

---

## 6. Exportación portable de la base de datos (volcado completo)

**Motivo:** el MySQL del equipo local contiene datos que solo responden a ese equipo
(empleados, usuarios, asistencias, permisos y reposos). Si se importaba solo el esquema
(`bd.sql`) o solo la tabla `asistencias` en otro equipo, las referencias a empleados/usuarios
no existían y el sistema no funcionaba.

**Solución:** se creó el volcado autocontenido:

| Archivo | Descripción |
|---|---|
| `sql/control_asistencia_completa.sql` | Volcado completo de la BD real (todas las tablas + datos) con `CREATE DATABASE`, índices, claves foráneas y AUTO_INCREMENT. Se importa en cualquier equipo y deja el sistema operativo completo. |

Verificado:
- Importado en una base de datos vacía `control_t2` → 73 empleados, 3.015 asistencias, 5 usuarios, permisos y reposos correctos.
- Usuario `admin` (`SUPER`) con contraseña `admin` verifica con `password_verify`.
- Ninguna asistencia huérfana (FK hacia `empleados` sin registros inválidos).
- `bd.sql` (esquema limpio) también importa sin errores: 1 usuario admin válido, columnas `codigo_barra`, `condicion_baja`, `fecha_baja` presentes.

**Uso en otro equipo:** importar el archivo `sql/control_asistencia_completa.sql` (p. ej. en phpMyAdmin, sección "Importar"). Después solo copiar `conexion.example.php` → `includes/conexion.php` y ajustar credenciales.

**También corregido en la BD real / `bd.sql`:** se agregaron las columnas `empleados.condicion_baja` y `empleados.fecha_baja` (las usa `procesos/personal_estado.php`) que faltaban en la BD local.

| Archivo | Cambio |
|---|---|
| `sql/control_asistencia_completa.sql` | (Nuevo) volcado completo portable de la BD real. |
| `sql/bd.sql` | `jerarquia` default 5 (igual que BD real). |
| BD real `control_asistencia` | Columnas `condicion_baja` y `fecha_baja` agregadas a `empleados`. |

---

## 7. Limpieza de datos de prueba y formato de código de barras

**Problema:** la BD local contenía 12 empleados de prueba (ids 1588–1599,
cedula `PRUEBA000001…`, barras `PBA-EMP00001…`) generados por `pruebas_generacion.php`,
con 3.005 asistencias, 4 permisos y 3 reposos asociados. Además, el formato del
código de barras era inconsistente: los empleados reales tenían `EMP-<UUID>` (12 chars
hex) generado por el trigger, mientras que la app y los scripts usaban `EMP00001`.

**Cambios (2026-08-07):**

1. Se eliminaron los datos de prueba en la BD real (asistencias, permisos, reposos y
   empleados con `codigo_barra LIKE 'PBA-%'` o `cedula LIKE 'PRUEBA%'`). Quedan solo los
   61 empleados reales (ids 1–61) y sus asistencias reales.
2. Formato de código de barras uniforme: **`EMP` + id a 5 dígitos** (`EMP00001`…`EMP00061`).
3. Trigger `trg_empleados_codigo_barra_bi` actualizado para generar el código secuencial
   `MAX(id)+1` (antes generaba UUID `EMP-…`). Se recreó en la BD real y en los scripts SQL.
4. `01_saneamiento_profesional_bd.sql`: normaliza barras viejas `EMP-` a `EMP00001`.
5. `sql/migracion_codigo_barra.sql`: normalización + trigger secuencial idempotentes.
6. `sql/control_asistencia_completa.sql` regenerado con la BD limpia y el formato nuevo:
   61 empleados, 0 `PBA-*`, 0 duplicados de barra, `admin`/`admin` (SUPER) OK.

Verificado importando el dump en una BD limpia: 61 empleados, 10 asistencias reales,
0 duplicados, barra `EMP00001`, trigger presente.

| Archivo/BD | Cambio |
|---|---|
| BD real `control_asistencia` | Datos de prueba eliminados; barras — `EMP` + id (5 dígitos); trigger secuencial. |
| `sql/01_saneamiento_profesional_bd.sql` | Normalización `EMP-`→`EMP`+id; trigger secuencial. |
| `sql/migracion_codigo_barra.sql` | Normalización `EMP-`→`EMP`+id; trigger secuencial. |
| `sql/control_asistencia_completa.sql` | Regenerado (BD limpia, formato `EMP`+id). |

---

## 8. Corrección de tildes en los datos (UTF-8)

**Síntoma:** en pantalla los datos de los usuarios se veían con `?` en lugar de
tildes (`Mar??a`, `Garc??a`).

**Diagnóstico (2026-08-07):**
1. El sistema **sí soporta UTF-8**: la conexión es `charset=utf8mb4`
   (`includes/conexion.php`) y las páginas declaran `<meta charset="UTF-8">`.
   Un `INSERT` con `María` vía PDO se guardó correctamente (bytes `C3 AD`).
2. El problema era el **dato ya almacenado**: las filas existentes tenían la
   tilde literalmente reemplazada por `?` (hex `4D 61 72 3F 3F 61` = `Mar??a`),
   corrupción producida al re-importar un volcado con una codificación de
   cliente distinta de la del archivo.

**Solución aplicada:**
- Se recuperaron los acentos correctos desde el volcado `control_asistencia_completa.sql`
  (que conservaba la información de las tildes como mojibake reversible `├│`).
- El dump fue convertido byte a byte a UTF-8 real (revertir CP850 → UTF-8), se
  quitó el BOM UTF-8 inicial (que rompía la importación con `source`) y se
  re-importó en la BD `control_asistencia`.
- Verificado: 61 empleados, `María García` (hex `4D6172C3AD61`), 28 filas con
  acentos correctos, `Directivos de la institución`, 0 filas con `?`, admin OK,
  trigger presente.
- El dump portable `sql/control_asistencia_completa.sql` quedó actualizado **sin
  BOM** y con las tildes correctas; se validó su importación desde cero en BD limpia.

| Archivo/BD | Cambio |
|---|---|
| BD real `control_asistencia` | Tildes recuperadas (UTF-8 real). |
| `sql/control_asistencia_completa.sql` | Reescribido sin BOM, tildes correctas. |

**Nota para el futuro:** si al importar con phpMyAdmin/`source` se ven `?`, verificar
que la conexión/cliente use `utf8mb4` y que el archivo `.sql` no contenga BOM.
