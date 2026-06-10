SELECT 
    cl.nombre_cliente || ' ' || cl.apellido_cliente AS cliente,
    SUM(rp.monto_pagado) AS gasto_total
FROM cliente cl
JOIN evento e ON e.id_cliente = cl.id_cliente
JOIN registro_pago rp ON rp.id_evento = e.id_evento
GROUP BY cl.id_cliente, cl.nombre_cliente, cl.apellido_cliente
ORDER BY gasto_total DESC
FETCH FIRST 5 ROWS ONLY;