# Cambios realizados

**Fecha:** 06/11/2026  
**Proyecto:** Sistema de Control de Asistencia  
**Alcance:** turno COMPLETO, registro por código de barras, kiosco, sesión/CSRF, cédula y reportes PDF.

---

## Resumen

Se implementaron y validaron las siguientes actualizaciones:

- Soporte para el turno COMPLETO.
- Registro de asistencia por código de barras con AJAX y compatibilidad con el flujo tradicional.
- Eliminación del ingreso manual visible en el kiosco.
- Receptor oculto compatible con Barcode to PC.
- Rediseño visual del kiosco.
- Cola secuencial, idempotencia, deduplicación y recuperación de CSRF.
- Sesión independiente y de larga duración para el kiosco.
- Cédula de empleados con 7 u 8 números.
- Usuario y rol que genera cada reporte PDF.

No se modificó el esquema de la base de datos.

---

## Archivos modificados y creados

| Archivo | Tipo | Cambio principal |
|---|---|---|
| `includes/config.php` | Modificado | Sesión de kiosco, constantes de turno COMPLETO y límites de barcode. |
| `includes/funciones.php` | Modificado | Soporte para turno COMPLETO. |
| `procesos/asistencia_barcode.php` | Modificado | AJAX, CSRF, normalización, idempotencia, deduplicación y rate limit. |
| `procesos/kiosk_token.php` | Nuevo | Endpoint para refrescar el token CSRF del kiosco. |
| `login_empleado.php` | Modificado | Nuevo kiosco visual, receptor oculto y cola AJAX. |
| `modulos/personal.php` | Modificado | Cédula de 7 u 8 números en creación y edición. |
| `procesos/personal_guardar.php` | Modificado | Validación de cédula en servidor. |
| `procesos/personal_actualizar.php` | Modificado | Validación de cédula en servidor. |
| `procesos/reporte_pdf.php` | Modificado | Usuario y rol que genera el reporte. |
| `docs/Prompt_Actualizacion_Version_Actual.md` | Nuevo | Prompt para aplicar estos cambios a la versión actual. |

---

## 1. Turno COMPLETO

### `includes/config.php`

Se agregaron:

```php
TURNO_COMPLETO_ID = 3
TURNO_COMPLETO_NOMBRE = "COMPLETO"
BARCODE_RATE_LIMIT_POR_MINUTO = 120
BARCODE_DUPLICADO_SEGUNDOS = 5
```

El turno COMPLETO reutiliza:

- Entrada del PRIMER turno: `06:55:00` a `08:00:00`.
- Salida del SEGUNDO turno: `17:00:00` a `18:00:00`.

No se duplicaron horarios. Cualquier ajuste en las ventanas del PRIMER o SEGUNDO turno se refleja automáticamente en COMPLETO.

### `includes/funciones.php`

Se agregó:

- `esTurnoCompleto()`.
- Retorno `"COMPLETO"` en `tipoTurnoVentanas()`.
- Configuración de ventana COMPLETO en `configuracionVentanaTurno()`.

Reglas resultantes:

- Puntual hasta las `07:05`.
- Retardo desde las `07:06` hasta las `08:00`.
- Salida permitida de `17:00` a `18:00`.
- Después de las `18:01` no se permite salida.

---

## 2. Registro por código de barras

### `procesos/asistencia_barcode.php`

Se conservó el flujo tradicional y se agregó el flujo AJAX.

Cambios principales:

- Detección de AJAX mediante `X-Requested-With` y `Accept`.
- Identificador único `request_id` por lectura.
- Normalización del código:
  - mayúsculas;
  - ceros iniciales conservados;
  - eliminación de BOM, espacios y comillas externas;
  - máximo 50 caracteres;
  - rechazo de espacios, comillas internas y caracteres de control.
- Respuesta JSON con:
  - `ok`;
  - `type`;
  - `message`;
  - `accion`;
  - `empleado`;
  - `empleado_id`;
  - `hora`;
  - `estado`;
  - `minutos_tarde`;
  - `salida_estado`;
  - `minutos_salida_tardia`;
  - `duplicate`;
  - `request_id`.
- Idempotencia en sesión mediante `kiosk_barcode_respuestas`, con máximo 50 respuestas.
- Los errores CSRF no se guardan en la caché de idempotencia.
- Deduplicación física de 5 segundos mediante `kiosk_barcode_ultimo`.
- Rate limit configurable de 120 lecturas por minuto.
- Nombre del empleado incluido en la respuesta para mostrarlo sin recargar.
- Validación CSRF con `hash_equals` para AJAX.
- Respuesta `type: "csrf"` para que el cliente refresque el token y reintente.
- Restricción de localhost conservada.

La lógica existente de entrada, salida, retardos, salidas tardías, transacciones y turnos no fue reemplazada; solo se integró con el nuevo flujo.

---

## 3. Sesión del kiosco y CSRF

### `includes/config.php`

Se agregó detección de rutas del kiosco:

- `/login_empleado.php`
- `/procesos/asistencia_barcode.php`
- `/procesos/kiosk_token.php`

Cuando la ruta es del kiosco:

- Se usa la cookie `KIOSKSESSID`.
- La duración de sesión es de 8 horas.
- No se aplica el cierre por inactividad de 30 minutos.

El panel administrativo conserva:

- Cookie `PHPSESSID`.
- Cierre de sesión después de 30 minutos de inactividad.

### `procesos/kiosk_token.php`

Archivo nuevo que:

- Solo responde desde `127.0.0.1` o `::1`.
- Devuelve JSON con `ok` y `csrf_token`.
- Envía `Cache-Control: no-store`.
- Envía `X-Content-Type-Options: nosniff`.

---

## 4. Kiosco sin ingreso manual visible

### `login_empleado.php`

Cambios visuales:

- Título: `CONTROL DE ASISTENCIA`.
- Subtítulo: `Registro de entrada y salida del personal`.
- Mensaje central: `ESCANEE SU CARNET PARA REGISTRAR SU ASISTENCIA`.
- Texto de ayuda: `Acerque el carnet al lector; el registro es automático.`
- Nuevo fondo institucional azul.
- Tarjeta blanca con acento superior.
- Panel de escaneo con icono SVG de carnet y código de barras.
- Haz de escaneo animado.
- Indicador `Procesando lectura...` con spinner.
- Tarjeta de éxito con foto o inicial, nombre, acción, hora y estado.
- Mensajes de éxito, error, advertencia e información.

Cambios funcionales:

- Se eliminó el input de texto visible.
- Se eliminó el botón de envío visible.
- Se mantiene un formulario receptor oculto de 1×1, recortado y con `opacity: 0`.
- El input no usa `disabled` ni `readonly`.
- El input usa `inputmode="none"`, `tabindex="-1"` y `autofocus`.
- Se conserva la recepción de texto y Enter de Barcode to PC.
- No se bloquea globalmente el teclado físico.

JavaScript:

- Cola secuencial de códigos.
- `request_id` con `crypto.randomUUID()` o fallback.
- Envío con `fetch` y `FormData`.
- Timeout de 10 segundos con `AbortController`.
- Reintento por error de red.
- Reintento por error CSRF después de refrescar el token.
- Token refrescado cada 10 minutos y al volver a la pestaña.
- Foco recuperado al cargar, al perder el foco y al volver a la pestaña.
- Limpieza del input después de cada lectura.
- Sonidos de éxito, advertencia y error con Web Audio API.
- Limpieza de parámetros del resultado en la URL.
- Sin recarga de página después de un escaneo AJAX.

Diseño responsive:

- Probado en escritorio.
- Probado en viewport móvil de `390×844`.
- Respeta `prefers-reduced-motion`.

---

## 5. Cédula de 7 u 8 números

### `modulos/personal.php`

Formularios de creación y edición:

```html
minlength="7"
maxlength="8"
pattern="[0-9]{7,8}"
placeholder="Ej: 1234567 o 12345678"
title="La cédula debe contener 7 u 8 números"
```

`validarCedula()` ahora:

- Elimina caracteres no numéricos.
- Permite máximo 8 dígitos.
- Acepta entre 7 y 8 dígitos.
- Muestra: `La cédula debe contener 7 u 8 números.`

### `procesos/personal_guardar.php` y `procesos/personal_actualizar.php`

Se agregó validación en servidor:

```php
if (!preg_match('/^[0-9]{7,8}$/', $cedula)) {
  header("Location: " . BASE_URL . "/modulos/personal.php?err=" . urlencode("La cédula debe contener 7 u 8 números."));
  exit;
}
```

La columna `empleados.cedula` es `VARCHAR(15)`, por lo que no requiere migración.

---

## 6. Administrador en reportes PDF

### `procesos/reporte_pdf.php`

Se obtiene el usuario desde la sesión:

- `usuarioActual()`.
- Fallback a `$_SESSION["usuario"]` y `$_SESSION["rol"]`.

Se agrega al bloque de metadatos del PDF:

```text
Generado por: usuario (rol)
```

Ejemplos:

- `Generado por: directora (Directora)`
- `Generado por: subdirector (Subdirector)`
- `Generado por: diurno (Diurno / Matutino)`

Aparece tanto en el reporte general como en el reporte individual.

---

## 7. Verificación realizada

- `php -l` en 67 archivos PHP: 0 errores durante la implementación.
- `php -l` en los últimos 4 archivos modificados: 0 errores.
- Sintaxis JavaScript validada.
- Flujo de código de barras: 9/9 pruebas superadas.
- Pruebas de turnos PRIMER/SEGUNDO/COMPLETO: superadas.
- Prueba de CSRF inválido: respuesta JSON correcta.
- Prueba de recuperación CSRF: sin recarga y con reintento.
- Dos códigos rápidos: dos POST secuenciales.
- Foco del receptor: recuperado al cargar, al perder foco y al volver a la pestaña.
- Input limpio después de cada lectura.
- Indicador de procesamiento visible con respuesta retardada.
- Interfaz móvil `390×844` verificada.
- Auditoría de accesibilidad: 0 violaciones.
- Regex de cédula:
  - 7 dígitos: aceptada.
  - 8 dígitos: aceptada.
  - 6 dígitos: rechazada.
  - 9 dígitos: rechazada.
  - Caracteres no numéricos: rechazados.

---

## 8. Consideraciones para aplicar en la versión actual

1. Crear un respaldo de los archivos antes de reemplazarlos.
2. Copiar los archivos modificados y el nuevo `procesos/kiosk_token.php`.
3. Conservar las credenciales, `BASE_URL`, rutas y configuración local de la versión actual.
4. No copiar datos de prueba, CSV de prueba ni credenciales de la copia de prueba.
5. Verificar que `session_name("KIOSKSESSID")` se ejecute antes de `session_start()`.
6. Verificar que `csrfToken()`, `csrfInput()` y `verifyCsrfOrRedirect()` existan en la versión actual.
7. Probar el flujo tradicional y el AJAX.
8. Probar los reportes PDF con un usuario de cada rol.
9. No se requiere migración de base de datos para estos cambios.

---

## 9. Estado

- Servidor de pruebas detenido.
- Navegador de pruebas cerrado.
- No se realizó commit.
- No se realizó push.
- No se modificó GitHub.
