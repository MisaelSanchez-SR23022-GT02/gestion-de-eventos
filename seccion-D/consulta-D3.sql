SELECT e.nombre_evento, s.capacidad_max, e.id_categoria
FROM evento e
JOIN salon s ON e.id_salon = s.id_salon
WHERE s.capacidad_max > (
    SELECT AVG(s2.capacidad_max)
    FROM evento e2
    JOIN salon s2 ON e2.id_salon = s2.id_salon
    WHERE e2.id_categoria = e.id_categoria
);