SELECT nombre_cliente || ' ' || apellido_cliente AS cliente
FROM cliente
WHERE id_cliente NOT IN (
    SELECT DISTINCT e.id_cliente
    FROM evento e
    JOIN registro_pago r ON e.id_evento = r.id_evento
);
