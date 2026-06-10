CREATE OR REPLACE VIEW vista_reporting_ingresos AS
SELECT 
    TO_CHAR(rp.fecha_pago, 'YYYY-MM') AS anio_mes,
    cat.nombre_categoria,
    COUNT(DISTINCT e.id_evento) AS cantidad_eventos,
    SUM(rp.monto_pagado) AS ingreso_total,
    ROUND(AVG(rp.monto_pagado), 2) AS ingreso_promedio_por_evento,
    ROUND(SUM(rp.monto_pagado) * 1.13, 2) AS ingreso_con_impuesto_estimado,
    LPAD(TO_CHAR(SUM(rp.monto_pagado), '999,999,990.00'), 15, ' ') AS ingreso_total_formateado
FROM registro_pago rp
JOIN evento e ON e.id_evento = rp.id_evento
JOIN categoria cat ON cat.id_categoria = e.id_categoria
GROUP BY TO_CHAR(rp.fecha_pago, 'YYYY-MM'), cat.nombre_categoria
ORDER BY anio_mes DESC, ingreso_total DESC;