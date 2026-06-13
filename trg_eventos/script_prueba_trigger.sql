-- Actualizar el estado de un evento
UPDATE evento SET estado = 'Cancelado' WHERE id_evento = 1;
COMMIT;

-- Ver la auditoría
SELECT * FROM auditoria_evento;

-- Prueba de inserción (debería insertar si no hay cruce)
INSERT INTO evento (id_cliente, id_empleado, id_categoria, id_salon, nombre_evento, fecha_hora_inicio, fecha_hora_fin, estado)
VALUES (1, 1, 1, 1, 'Evento prueba', SYSDATE + 10, SYSDATE + 10 + 3/24, 'Pendiente');

-- Prueba de cruce (debería fallar)
INSERT INTO evento (id_cliente, id_empleado, id_categoria, id_salon, nombre_evento, fecha_hora_inicio, fecha_hora_fin, estado)
VALUES (2, 2, 2, 1, 'Evento conflicto', SYSDATE + 10, SYSDATE + 10 + 3/24, 'Pendiente');