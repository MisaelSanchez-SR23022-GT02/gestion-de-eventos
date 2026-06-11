SELECT id_categoria, ROUND(AVG(monto_pagado), 2) AS promedio_pago
FROM (
    SELECT e.id_categoria, r.monto_pagado
    FROM evento e
    JOIN registro_pago r ON e.id_evento = r.id_evento
) pagos_categoria
GROUP BY id_categoria;