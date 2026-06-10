SELECT 
    s.nombre_salon,
    cat.nombre_categoria AS tipo_de_evento_alojado,
    COUNT(e.id_evento) AS total_veces_realizado
FROM salon s
LEFT JOIN evento e ON s.id_salon = e.id_salon
LEFT JOIN categoria cat ON e.id_categoria = cat.id_categoria
GROUP BY s.nombre_salon, cat.nombre_categoria
ORDER BY s.nombre_salon ASC, total_veces_realizado DESC;
