CREATE OR REPLACE VIEW vista_eventos_operativos AS
SELECT 
    e.id_evento,
    e.nombre_evento,
    e.fecha_hora_inicio,
    e.fecha_hora_fin,
    ROUND((e.fecha_hora_fin - e.fecha_hora_inicio) * 24, 2) AS duracion_horas,
    e.estado,
    -- Cliente
    c.id_cliente,
    c.nombre_cliente || ' ' || c.apellido_cliente AS nombre_cliente_completo,
    c.telefono_cliente,
    c.email_cliente,
    -- Empleado a cargo
    emp.id_empleado,
    emp.nombre_empleado || ' ' || emp.apellido_empleado AS nombre_empleado_completo,
    -- Categoría
    cat.id_categoria,
    cat.nombre_categoria,
    cat.precio_categoria,
    -- Salón
    s.id_salon,
    s.nombre_salon,
    s.capacidad_max,
    s.precio_hora,
    -- Monto pagado (si existe)
    NVL(rp.monto_pagado, 0) AS monto_pagado,
    -- Cantidad de asistentes registrados
    (SELECT COUNT(*) FROM control_asistencia ca WHERE ca.id_evento = e.id_evento) AS total_asistentes
FROM evento e
JOIN cliente c ON c.id_cliente = e.id_cliente
JOIN empleado emp ON emp.id_empleado = e.id_empleado
JOIN categoria cat ON cat.id_categoria = e.id_categoria
JOIN salon s ON s.id_salon = e.id_salon
LEFT JOIN registro_pago rp ON rp.id_evento = e.id_evento;