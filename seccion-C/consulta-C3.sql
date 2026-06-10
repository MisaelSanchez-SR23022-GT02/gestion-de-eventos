SELECT 
    EXTRACT(YEAR FROM e.fecha_hora_inicio) AS anio,
    EXTRACT(MONTH FROM e.fecha_hora_inicio) AS mes,
    COUNT(*) AS total_eventos
FROM evento e
GROUP BY EXTRACT(YEAR FROM e.fecha_hora_inicio), EXTRACT(MONTH FROM e.fecha_hora_inicio)
ORDER BY anio, mes;