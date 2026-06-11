SELECT 
    e.nombre_evento AS "Evento",
    c.nombre_cliente || ' ' || c.apellido_cliente AS "Cliente",
    s.nombre_salon AS "Salón",
    e.fecha_hora_inicio AS "Inicio",
    e.estado AS "Estado"
FROM evento e
INNER JOIN cliente c ON e.id_cliente = c.id_cliente
INNER JOIN salon s ON e.id_salon = s.id_salon
INNER JOIN categoria cat ON e.id_categoria = cat.id_categoria
WHERE e.estado = 'Confirmado'
  AND EXTRACT(YEAR FROM e.fecha_hora_inicio) = 2026
ORDER BY e.fecha_hora_inicio ASC;