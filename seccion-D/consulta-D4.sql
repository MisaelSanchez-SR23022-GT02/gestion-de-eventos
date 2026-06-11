SELECT e.nombre_evento,
       (SELECT COUNT(*)
        FROM control_asistencia ca
        WHERE ca.id_evento = e.id_evento) AS total_asistentes
FROM evento e;