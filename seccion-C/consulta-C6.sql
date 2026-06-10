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