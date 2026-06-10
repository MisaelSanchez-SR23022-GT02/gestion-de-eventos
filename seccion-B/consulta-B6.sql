SELECT 
    e.id_evento,
    e.nombre_evento,
    e.estado AS estado_evento,
    p.id_pago,
    NVL(p.monto_pagado, 0) AS abono_realizado
FROM registro_pago p
RIGHT JOIN evento e ON p.id_evento = e.id_evento
ORDER BY abono_realizado ASC;