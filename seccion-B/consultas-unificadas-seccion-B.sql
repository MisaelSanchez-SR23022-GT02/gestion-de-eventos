--Consulta 1 (Salones más utilizados)
SELECT
    s.id_salon,
    s.nombre_salon,
    s.capacidad_max,
    COUNT(e.id_evento) AS total_eventos_programados
FROM salon s
LEFT JOIN evento e ON s.id_salon = e.id_salon
GROUP BY s.id_salon, s.nombre_salon, s.capacidad_max
ORDER BY total_eventos_programados DESC;

--Consulta 2 (Coordinadores con eventos asignados)
SELECT
    emp.id_empleado,
    emp.nombre_empleado || ' ' || emp.apellido_empleado AS coordinador,
    emp.email_empleado,
    COUNT(e.id_evento) AS eventos_bajo_cargo
FROM empleado emp
LEFT JOIN evento e ON emp.id_empleado = e.id_empleado
GROUP BY emp.id_empleado, emp.nombre_empleado, emp.apellido_empleado, emp.email_empleado
ORDER BY eventos_bajo_cargo DESC;

--Consulta 3 (Categorías más solicitadas)
SELECT
    cat.id_categoria,
    cat.nombre_categoria,
    cat.precio_categoria AS precio_base,
    COUNT(e.id_evento) AS cantidad_solicitada
FROM categoria cat
LEFT JOIN evento e ON cat.id_categoria = e.id_categoria
GROUP BY cat.id_categoria, cat.nombre_categoria, cat.precio_categoria
ORDER BY cantidad_solicitada DESC;

--Consulta 4 (Tipos de eventos en cada salón)
SELECT
    s.nombre_salon,
    cat.nombre_categoria AS tipo_de_evento_alojado,
    COUNT(e.id_evento) AS total_veces_realizado
FROM salon s
LEFT JOIN evento e ON s.id_salon = e.id_salon
LEFT JOIN categoria cat ON e.id_categoria = cat.id_categoria
GROUP BY s.nombre_salon, cat.nombre_categoria
ORDER BY s.nombre_salon ASC, total_veces_realizado DESC;

--Consulta 5 (Eventos cancelados y pagos registrados)
SELECT
    e.id_evento,
    e.nombre_evento,
    e.estado,
    NVL(p.monto_pagado, 0) AS monto_retenido_abonado
FROM registro_pago p
RIGHT JOIN evento e ON p.id_evento = e.id_evento
WHERE e.estado = 'Cancelado'
ORDER BY monto_retenido_abonado DESC;

--Consulta 6 (Eventos y pagos)
SELECT
    e.id_evento,
    e.nombre_evento,
    e.estado AS estado_evento,
    p.id_pago,
    NVL(p.monto_pagado, 0) AS abono_realizado
FROM registro_pago p
RIGHT JOIN evento e ON p.id_evento = e.id_evento
ORDER BY abono_realizado ASC;
