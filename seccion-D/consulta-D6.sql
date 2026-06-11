SELECT nombre_evento
FROM evento e
WHERE EXISTS (
    SELECT 1
    FROM registro_pago r
    WHERE r.id_evento = e.id_evento
);