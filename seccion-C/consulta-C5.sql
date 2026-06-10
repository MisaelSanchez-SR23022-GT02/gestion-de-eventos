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