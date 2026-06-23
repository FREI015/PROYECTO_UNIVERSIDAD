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
