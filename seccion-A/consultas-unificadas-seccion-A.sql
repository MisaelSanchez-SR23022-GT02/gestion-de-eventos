--Consulta 1 : Detalla una transaccion
SELECT 
    e.nombre_evento AS "Nombre del Evento",
    c.nombre_cliente || ' ' || c.apellido_cliente AS "Cliente",
    em.nombre_empleado || ' ' || em.apellido_empleado AS "Responsable",
    s.nombre_salon AS "Salón",
    e.fecha_hora_inicio AS "Inicio",
    e.fecha_hora_fin AS "Fin"
FROM evento e
INNER JOIN cliente c ON e.id_cliente = c.id_cliente
INNER JOIN empleado em ON e.id_empleado = em.id_empleado
INNER JOIN salon s ON e.id_salon = s.id_salon;

--Consulta 2: Filtra una busqueda atraves de WHERE buscando los eventos confirmados en 2026

SELECT 
    e.nombre_evento AS "Evento",
    c.nombre_cliente || ' ' || c.apellido_cliente AS "Cliente",
    s.nombre_salon AS "Salón",
    e.fecha_hora_inicio AS "Inicio",
    e.estado AS "Estado"
FROM evento e
INNER JOIN cliente c ON e.id_cliente = c.id_cliente
INNER JOIN salon s ON e.id_salon = s.id_salon
INNER JOIN categoria cat ON e.id_categoria = cat.id_categoria
WHERE e.estado = 'Confirmado'
  AND EXTRACT(YEAR FROM e.fecha_hora_inicio) = 2026
ORDER BY e.fecha_hora_inicio ASC;

--Consulta 3: filtra y ordena los eventos de un semestre(6 meses)

SELECT 
    e.fecha_hora_inicio AS "Fecha",
    e.nombre_evento AS "Evento",
    cat.nombre_categoria AS "Categoría",
    s.nombre_salon AS "Salón",
    em.nombre_empleado || ' ' || em.apellido_empleado AS "Responsable"
FROM evento e
INNER JOIN salon s ON e.id_salon = s.id_salon
INNER JOIN empleado em ON e.id_empleado = em.id_empleado
INNER JOIN categoria cat ON e.id_categoria = cat.id_categoria
WHERE e.fecha_hora_inicio BETWEEN TO_DATE('2026-01-01', 'YYYY-MM-DD') 
                              AND TO_DATE('2026-06-30', 'YYYY-MM-DD')
ORDER BY e.fecha_hora_inicio ASC;

--Consulta 4: Proposito de posible auditoria en los ultimos 60 dias para conocer los datos de los eventos y el responsable

SELECT 
    e.fecha_hora_inicio AS "Fecha",
    e.nombre_evento AS "Evento",
    c.nombre_cliente || ' ' || c.apellido_cliente AS "Cliente",
    s.nombre_salon AS "Salón",
    em.nombre_empleado || ' ' || em.apellido_empleado AS "Responsable",
    e.estado AS "Estado"
FROM evento e
INNER JOIN cliente c ON e.id_cliente = c.id_cliente
INNER JOIN empleado em ON e.id_empleado = em.id_empleado
INNER JOIN salon s ON e.id_salon = s.id_salon
WHERE e.estado IN ('Cancelado', 'Finalizado')
  AND e.fecha_hora_inicio >= (SYSDATE - 60)
ORDER BY e.fecha_hora_inicio DESC;

--Consulta 5: comunicacion natural sin lenguaje tecnico.

SELECT 
    e.nombre_evento AS "Nombre del Evento",
    cat.nombre_categoria AS "Tipo de Celebración",
    c.nombre_cliente || ' ' || c.apellido_cliente AS "Cliente Responsable",
    s.nombre_salon AS "Salón Asignado",
    TO_CHAR(e.fecha_hora_inicio, 'DD "de" Month "de" YYYY') AS "Fecha de Realización"
FROM evento e
INNER JOIN categoria cat ON e.id_categoria = cat.id_categoria
INNER JOIN cliente c ON e.id_cliente = c.id_cliente
INNER JOIN salon s ON e.id_salon = s.id_salon
WHERE e.estado = 'Confirmado'
ORDER BY e.fecha_hora_inicio ASC;

--Consulta 6: iNFORMACION DE USO MAS FRECUENTE DE INSTALACIONES.

SELECT 
    s.nombre_salon AS "Salón",
    COUNT(e.id_evento) AS "Total Eventos Programados",
    ROUND(AVG((e.fecha_hora_fin - e.fecha_hora_inicio) * 24), 2) AS "Horas Promedio por Evento",
    COUNT(DISTINCT e.id_cliente) AS "Clientes Únicos Atendidos"
FROM salon s
INNER JOIN evento e ON s.id_salon = e.id_salon
INNER JOIN categoria cat ON e.id_categoria = cat.id_categoria
GROUP BY s.nombre_salon
ORDER BY "Total Eventos Programados" DESC;