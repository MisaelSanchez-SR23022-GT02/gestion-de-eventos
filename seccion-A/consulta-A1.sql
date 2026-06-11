SELECT 
    e.nombre_evento AS "Nombre del Evento",
    c.nombre_cliente || ' ' || c.apellido_cliente AS "Cliente",
    em.nombre_empleado || ' ' || em.apellido_empleado AS "Responsable",
    s.nombre_salon AS "Salón",
    e.fecha_hora_inicio AS "Inicio",
    e.fecha_hora_fin AS "Fin"
FROM evento e
INNER JOIN cliente c ON e.id_cliente = c.id_cliente
INNER JOIN empleado em ON e.id_empleado = em.id_empleado
INNER JOIN salon s ON e.id_salon = s.id_salon;
