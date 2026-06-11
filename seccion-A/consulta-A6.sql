SELECT 
    s.nombre_salon AS "Salón",
    COUNT(e.id_evento) AS "Total Eventos Programados",
    ROUND(AVG((e.fecha_hora_fin - e.fecha_hora_inicio) * 24), 2) AS "Horas Promedio por Evento",
    COUNT(DISTINCT e.id_cliente) AS "Clientes Únicos Atendidos"
FROM salon s
INNER JOIN evento e ON s.id_salon = e.id_salon
INNER JOIN categoria cat ON e.id_categoria = cat.id_categoria
GROUP BY s.nombre_salon
ORDER BY "Total Eventos Programados" DESC;