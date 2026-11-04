<?php
/** H-14: escribir eventos sin contraseñas, claves, documentos médicos ni datos biométricos. */
function registrarAuditoria(PDO $pdo, string $accion, string $entidad, ?int $id, array $detalle = []): void {
  $actor = (int)($_SESSION['user']['id'] ?? $_SESSION['usuario_id'] ?? 0);
  $ip = (string)($_SERVER['REMOTE_ADDR'] ?? '');
  $ip = strlen($ip) <= 45 ? $ip : '';
  $json = json_encode($detalle, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR);
  if (strlen($json) > 2000) {
    throw new RuntimeException('Evento de auditoria demasiado largo.');
  }
  $stmt = $pdo->prepare('INSERT INTO auditoria_acciones (actor_id, accion, entidad, entidad_id, detalle, ip) VALUES (?, ?, ?, ?, ?, ?)');
  $stmt->execute([$actor > 0 ? $actor : null, $accion, $entidad, $id, $json, $ip]);
}
