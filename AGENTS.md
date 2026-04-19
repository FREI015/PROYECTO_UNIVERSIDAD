# AGENTS.md - Universidad Attendance System

## Project Overview
Plain PHP + MySQL attendance control system for a university. No frameworks, no build tools.

## Running the App
- **Requirement**: XAMPP (or any Apache/MySQL stack)
- **Web root**: Project folder must be accessible via `http://localhost/control_asistencia/` or similar
- **Start**: Run Apache + MySQL in XAMPP control panel, then open browser

## Database Setup
1. Create database: `control_asistencia` (utf8mb4)
2. Run migrations: `sql/bd.sql`
3. Load test data: `sql/datos_prueba.sql` (optional)
4. Credentials in `includes/conexion.php`: `root` / `""` (empty password)

## Entry Points
- `index.php` → Main router (checks session, redirects to login or asistencia)
- `login.php` → Login page
- `modulos/asistencias.php` → Default authenticated page

## Key Conventions
- **Timezone**: `America/Caracas` (UTC-4) - set in `includes/config.php`
- **Session**: Auto-started in `includes/config.php`
- **Auth check**: Use `requireLogin()` on protected pages
- **DB**: Both `mysqli` ($conexion) and `PDO` ($pdo) available in `includes/conexion.php`
- **Routing**: Use `go($url)` for redirects, `BASE_URL` for hrefs

## Modules
- `modulos/asistencias.php` - Attendance management
- `modulos/permisos.php` - Permissions/leaves
- `modulos/reposos.php` - Rest periods
- `modulos/personal.php` - Staff management
- `modulos/reportes.php` - Reports (uses TCPDF in `libs/tcpdf/`)

## Important Files
- `includes/config.php` - Base config, BASE_URL, BASE_PATH definitions
- `includes/funciones.php` - Utilities: `isLogged()`, `go()`, `requireLogin()`, `e()`, `safeNext()`
- `includes/header.php` - Common header/navigation
- `conexion.example.php` - Template for DB connection (not used, actual config in `includes/conexion.php`)