SELECT 
    cat.id_categoria,
    cat.nombre_categoria,
    cat.precio_categoria AS precio_base,
    COUNT(e.id_evento) AS cantidad_solicitada
FROM categoria cat
LEFT JOIN evento e ON cat.id_categoria = e.id_categoria
GROUP BY cat.id_categoria, cat.nombre_categoria, cat.precio_categoria
ORDER BY cantidad_solicitada DESC;
