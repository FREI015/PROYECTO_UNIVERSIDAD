# Instalacion y restauracion local del sistema

## Objetivo
Instalar el sistema de control de asistencia en otra computadora
compatible con Apache, PHP y MySQL/MariaDB.

## Instalacion nueva
1. Instalar XAMPP compatible con la version de PHP del proyecto.
2. Copiar la carpeta completa del proyecto al directorio web.
3. Iniciar Apache y MySQL/MariaDB.
4. Crear la base de datos control_asistencia, usando utf8mb4.
5. Importar sql/bd.sql para crear el esquema inicial.
6. Configurar includes/conexion.php con las credenciales locales.
7. Revisar las migraciones necesarias antes de ejecutarlas.
8. Abrir el sistema desde http://localhost/RUTA_DEL_PROYECTO/.
9. Cambiar las contrasenas iniciales antes de utilizarlo.
10. Verificar inicio de sesion, permisos, lector, reportes y archivos.

## Restauracion desde un respaldo existente
1. Identificar el archivo SQL que se desea restaurar.
2. Comprobar que pertenece a la instalacion correcta.
3. Detener el uso del sistema durante la restauracion.
4. Utilizar una base de datos de prueba para verificar el respaldo.
5. Importar el SQL mediante phpMyAdmin o el cliente MySQL.
6. Restaurar tambien los archivos subidos si el respaldo los incluye.
7. Verificar cantidad de empleados, usuarios y asistencias.
8. Comprobar la integridad de las relaciones entre tablas.
9. Probar permisos, reportes y marcaje antes de ponerlo en servicio.

## Precauciones
- No ejecutar scripts de datos iniciales sobre una base en produccion
  sin comprobar previamente sus efectos.
- No asumir que un respaldo SQL contiene fotografias o documentos.
- No sobrescribir datos existentes sin verificar el respaldo elegido.
- Los cambios de esquema requieren verificar las migraciones aplicadas.
- El kiosco esta destinado a funcionar desde localhost.
- No utilizar rutas absolutas de la computadora de desarrollo.

## Validacion
- Comprobar que Apache y MySQL se inician correctamente.
- Ejecutar validaciones de sintaxis PHP.
- Revisar permisos administrativos por rol.
- Comprobar un registro controlado de entrada y salida.
- Generar reportes PDF y verificar sus totales.
- Verificar que los documentos privados no sean publicos.