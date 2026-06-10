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