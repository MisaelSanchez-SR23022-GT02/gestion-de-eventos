SELECT 
    e.fecha_hora_inicio AS "Fecha",
    e.nombre_evento AS "Evento",
    cat.nombre_categoria AS "Categoría",
    s.nombre_salon AS "Salón",
    em.nombre_empleado || ' ' || em.apellido_empleado AS "Responsable"
FROM evento e
INNER JOIN salon s ON e.id_salon = s.id_salon
INNER JOIN empleado em ON e.id_empleado = em.id_empleado
INNER JOIN categoria cat ON e.id_categoria = cat.id_categoria
WHERE e.fecha_hora_inicio BETWEEN TO_DATE('2026-01-01', 'YYYY-MM-DD') 
                              AND TO_DATE('2026-06-30', 'YYYY-MM-DD')
ORDER BY e.fecha_hora_inicio ASC;