SELECT  
    s.id_salon,
    s.nombre_salon,
    s.capacidad_max,
    COUNT(e.id_evento) AS total_eventos_programados
FROM salon s
LEFT JOIN evento e ON s.id_salon = e.id_salon
GROUP BY s.id_salon, s.nombre_salon, s.capacidad_max
ORDER BY total_eventos_programados DESC;
