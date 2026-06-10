--Totales agrupados por categoría principal del negocio

SELECT 
    c.nombre_categoria,
    COUNT(e.id_evento) AS cantidad_eventos,
    SUM(rp.monto_pagado) AS total_ingresos
FROM categoria c
JOIN evento e ON e.id_categoria = c.id_categoria
JOIN registro_pago rp ON rp.id_evento = e.id_evento
GROUP BY c.nombre_categoria
ORDER BY total_ingresos DESC;

-- Promedio y monto máximo pagado por cliente, cuyo promedio supere los 500 unidades monetarias

SELECT 
    cl.nombre_cliente || ' ' || cl.apellido_cliente AS cliente,
    ROUND(AVG(rp.monto_pagado), 2) AS promedio_pagado,
    MAX(rp.monto_pagado) AS maximo_pagado
FROM cliente cl
JOIN evento e ON e.id_cliente = cl.id_cliente
JOIN registro_pago rp ON rp.id_evento = e.id_evento
GROUP BY cl.id_cliente, cl.nombre_cliente, cl.apellido_cliente
HAVING AVG(rp.monto_pagado) > 500
ORDER BY promedio_pagado DESC;

-- Cantidad de eventos realizados por mes (año y mes)
SELECT 
    EXTRACT(YEAR FROM e.fecha_hora_inicio) AS anio,
    EXTRACT(MONTH FROM e.fecha_hora_inicio) AS mes,
    COUNT(*) AS total_eventos
FROM evento e
GROUP BY EXTRACT(YEAR FROM e.fecha_hora_inicio), EXTRACT(MONTH FROM e.fecha_hora_inicio)
ORDER BY anio, mes;

--Los 5 clientes con mayor gasto total acumulado.

SELECT 
    cl.nombre_cliente || ' ' || cl.apellido_cliente AS cliente,
    SUM(rp.monto_pagado) AS gasto_total
FROM cliente cl
JOIN evento e ON e.id_cliente = cl.id_cliente
JOIN registro_pago rp ON rp.id_evento = e.id_evento
GROUP BY cl.id_cliente, cl.nombre_cliente, cl.apellido_cliente
ORDER BY gasto_total DESC
FETCH FIRST 5 ROWS ONLY;

-- Categorías cuyo ingreso total es mayor que el ingreso promedio de todas las categorías
SELECT 
    c.nombre_categoria,
    SUM(rp.monto_pagado) AS ingreso_categoria
FROM categoria c
JOIN evento e ON e.id_categoria = c.id_categoria
JOIN registro_pago rp ON rp.id_evento = e.id_evento
GROUP BY c.id_categoria, c.nombre_categoria
HAVING SUM(rp.monto_pagado) > (
    SELECT AVG(ingreso_categoria)
    FROM (
        SELECT SUM(rp2.monto_pagado) AS ingreso_categoria
        FROM categoria c2
        JOIN evento e2 ON e2.id_categoria = c2.id_categoria
        JOIN registro_pago rp2 ON rp2.id_evento = e2.id_evento
        GROUP BY c2.id_categoria
    )
)
ORDER BY ingreso_categoria DESC;

-- Por cada salón y por cada mes (fecha de pago), se mostraran los ingresos totales, cantidad de eventos realizados y promedio de asistentes por evento

SELECT 
    s.nombre_salon,
    TO_CHAR(rp.fecha_pago, 'YYYY-MM') AS mes_pago,
    SUM(rp.monto_pagado) AS ingresos_totales,
    COUNT(DISTINCT e.id_evento) AS cantidad_eventos,
    AVG(asistentes_por_evento.cantidad) AS promedio_asistentes
FROM salon s
JOIN evento e ON e.id_salon = s.id_salon
JOIN registro_pago rp ON rp.id_evento = e.id_evento
LEFT JOIN (
    SELECT id_evento, COUNT(*) AS cantidad
    FROM control_asistencia
    GROUP BY id_evento
) asistentes_por_evento ON asistentes_por_evento.id_evento = e.id_evento
GROUP BY s.nombre_salon, TO_CHAR(rp.fecha_pago, 'YYYY-MM')
ORDER BY s.nombre_salon, mes_pago;