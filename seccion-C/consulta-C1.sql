SELECT 
    c.nombre_categoria,
    COUNT(e.id_evento) AS cantidad_eventos,
    SUM(rp.monto_pagado) AS total_ingresos
FROM categoria c
JOIN evento e ON e.id_categoria = c.id_categoria
JOIN registro_pago rp ON rp.id_evento = e.id_evento
GROUP BY c.nombre_categoria
ORDER BY total_ingresos DESC;