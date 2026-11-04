<?php
/**
 * H-12: política de días laborables para reportes.
 * Por defecto de lunes a viernes; se puede ajustar en config.php.
 * Los marcajes, permisos y reposos explícitos prevalecen sobre esta clasificación.
 */
function estadoBaseReporte(string $fecha, string $hoy): array {
  if ($fecha > $hoy) {
    return ['estado' => 'PENDIENTE', 'detalle' => 'Fecha futura', 'minutos_tarde' => 0];
  }
  $laborables = defined('REPORTE_DIAS_LABORABLES')
    ? (array)constant('REPORTE_DIAS_LABORABLES') : [1, 2, 3, 4, 5];
  $excepciones = defined('REPORTE_FECHAS_NO_LABORABLES')
    ? (array)constant('REPORTE_FECHAS_NO_LABORABLES') : [];
  $incluir = defined('REPORTE_FECHAS_LABORABLES_EXTRA')
    ? (array)constant('REPORTE_FECHAS_LABORABLES_EXTRA') : [];
  $diaSemana = (int)(new DateTimeImmutable($fecha))->format('N');
  if ((in_array($fecha, $excepciones, true) || !in_array($diaSemana, $laborables, true))
      && !in_array($fecha, $incluir, true)) {
    return ['estado' => 'NO_LABORABLE', 'detalle' => 'Día sin jornada programada', 'minutos_tarde' => 0];
  }
  return ['estado' => 'AUSENTE', 'detalle' => 'Sin justificación', 'minutos_tarde' => 0];
}
