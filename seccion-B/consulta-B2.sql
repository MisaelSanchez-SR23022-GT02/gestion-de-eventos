SELECT 
    emp.id_empleado,
    emp.nombre_empleado || ' ' || emp.apellido_empleado AS coordinador,
    emp.email_empleado,
    COUNT(e.id_evento) AS eventos_bajo_cargo
FROM empleado emp
LEFT JOIN evento e ON emp.id_empleado = e.id_empleado
GROUP BY emp.id_empleado, emp.nombre_empleado, emp.apellido_empleado, emp.email_empleado
ORDER BY eventos_bajo_cargo DESC;