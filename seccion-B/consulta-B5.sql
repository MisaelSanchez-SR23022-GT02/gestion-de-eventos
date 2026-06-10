SELECT 
    e.id_evento,
    e.nombre_evento,
    e.estado,
    NVL(p.monto_pagado, 0) AS monto_retenido_abonado
FROM registro_pago p
RIGHT JOIN evento e ON p.id_evento = e.id_evento
WHERE e.estado = 'Cancelado'
ORDER BY monto_retenido_abonado DESC;