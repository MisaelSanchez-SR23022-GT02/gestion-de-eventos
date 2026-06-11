SELECT 
    e.nombre_evento AS "Nombre del Evento",
    cat.nombre_categoria AS "Tipo de Celebración",
    c.nombre_cliente || ' ' || c.apellido_cliente AS "Cliente Responsable",
    s.nombre_salon AS "Salón Asignado",
    TO_CHAR(e.fecha_hora_inicio, 'DD "de" Month "de" YYYY') AS "Fecha de Realización"
FROM evento e
INNER JOIN categoria cat ON e.id_categoria = cat.id_categoria
INNER JOIN cliente c ON e.id_cliente = c.id_cliente
INNER JOIN salon s ON e.id_salon = s.id_salon
WHERE e.estado = 'Confirmado'
ORDER BY e.fecha_hora_inicio ASC;