-- D1: Eventos con al menos un asistente registrado
SELECT nombre_evento, fecha_hora_inicio  AS FECHA
FROM evento
WHERE id_evento IN (
    SELECT id_evento
    FROM control_asistencia
);

-- D2: Clientes sin ningún pago registrado (ni siquiera han pagado algún evento)
SELECT nombre_cliente || ' ' || apellido_cliente AS cliente
FROM cliente
WHERE id_cliente NOT IN (
    SELECT DISTINCT e.id_cliente
    FROM evento e
    JOIN registro_pago r ON e.id_evento = r.id_evento
);


-- D3: Eventos cuyo salón tiene capacidad mayor al promedio de capacidad de los salones
-- usados en eventos de la misma categoría
SELECT e.nombre_evento, s.capacidad_max, e.id_categoria
FROM evento e
JOIN salon s ON e.id_salon = s.id_salon
WHERE s.capacidad_max > (
    SELECT AVG(s2.capacidad_max)
    FROM evento e2
    JOIN salon s2 ON e2.id_salon = s2.id_salon
    WHERE e2.id_categoria = e.id_categoria
);

-- D4: Lista los eventos con la cantidad de asistentes registrados
SELECT e.nombre_evento,
       (SELECT COUNT(*)
        FROM control_asistencia ca
        WHERE ca.id_evento = e.id_evento) AS total_asistentes
FROM evento e;

-- D5: Promedio del monto pagado por cada categoría de evento (redondeado a 2 decimales)
SELECT id_categoria, ROUND(AVG(monto_pagado), 2) AS promedio_pago
FROM (
    SELECT e.id_categoria, r.monto_pagado
    FROM evento e
    JOIN registro_pago r ON e.id_evento = r.id_evento
) pagos_categoria
GROUP BY id_categoria;

-- D6: Eventos con al menos un registro de pago
SELECT nombre_evento
FROM evento e
WHERE EXISTS (
    SELECT 1
    FROM registro_pago r
    WHERE r.id_evento = e.id_evento
);