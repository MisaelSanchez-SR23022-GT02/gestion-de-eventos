SELECT nombre_evento, fecha_hora_inicio  AS FECHA
FROM evento
WHERE id_evento IN (
    SELECT id_evento
    FROM control_asistencia
);