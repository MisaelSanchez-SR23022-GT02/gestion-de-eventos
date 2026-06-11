SELECT 
    e.fecha_hora_inicio AS "Fecha",
    e.nombre_evento AS "Evento",
    c.nombre_cliente || ' ' || c.apellido_cliente AS "Cliente",
    s.nombre_salon AS "Salón",
    em.nombre_empleado || ' ' || em.apellido_empleado AS "Responsable",
    e.estado AS "Estado"
FROM evento e
INNER JOIN cliente c ON e.id_cliente = c.id_cliente
INNER JOIN empleado em ON e.id_empleado = em.id_empleado
INNER JOIN salon s ON e.id_salon = s.id_salon
WHERE e.estado IN ('Cancelado', 'Finalizado')
  AND e.fecha_hora_inicio >= (SYSDATE - 60)
ORDER BY e.fecha_hora_inicio DESC;