DECLARE
    TYPE id_array IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

    v_ids_cliente id_array;
    v_ids_empleado id_array;
    v_ids_categoria id_array;
    v_ids_salon id_array;

    v_total_cliente NUMBER;
    v_total_empleado NUMBER;
    v_total_categoria  NUMBER;
    v_total_salon NUMBER;

    v_id_cliente NUMBER;
    v_id_empleado NUMBER;
    v_id_categoria NUMBER;
    v_id_salon NUMBER;

    v_fecha DATE;
    v_hora_inicio_h NUMBER; 
    v_hora_fin_h NUMBER;
    v_hora_inicio VARCHAR2(8);
    v_hora_fin VARCHAR2(8);
    v_estado VARCHAR2(20);
    v_nombre_cliente VARCHAR2(100);
    v_apellido_cliente VARCHAR2(100);
    v_nombre_categoria VARCHAR2(100);
BEGIN
    SELECT id_cliente   BULK COLLECT INTO v_ids_cliente   FROM cliente;
    SELECT id_empleado  BULK COLLECT INTO v_ids_empleado  FROM empleado;
    SELECT id_categoria BULK COLLECT INTO v_ids_categoria FROM categoria;
    SELECT id_salon     BULK COLLECT INTO v_ids_salon     FROM salon;

    v_total_cliente := v_ids_cliente.COUNT;
    v_total_empleado := v_ids_empleado.COUNT;
    v_total_categoria := v_ids_categoria.COUNT;
    v_total_salon := v_ids_salon.COUNT;

    FOR i IN 1..50 LOOP

        v_id_cliente := v_ids_cliente  (TRUNC(DBMS_RANDOM.VALUE(1, v_total_cliente   + 1)));
        v_id_empleado := v_ids_empleado (TRUNC(DBMS_RANDOM.VALUE(1, v_total_empleado  + 1)));
        v_id_categoria := v_ids_categoria(TRUNC(DBMS_RANDOM.VALUE(1, v_total_categoria + 1)));
        v_id_salon := v_ids_salon    (TRUNC(DBMS_RANDOM.VALUE(1, v_total_salon     + 1)));

        SELECT nombre_cliente, apellido_cliente
        INTO v_nombre_cliente, v_apellido_cliente
        FROM cliente
        WHERE id_cliente = v_id_cliente;

        SELECT nombre_categoria
        INTO v_nombre_categoria
        FROM categoria
        WHERE id_categoria = v_id_categoria;

        v_fecha := TO_DATE('2024-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 1095));

        v_hora_inicio_h := TRUNC(DBMS_RANDOM.VALUE(8, 17));  
        v_hora_fin_h := v_hora_inicio_h + TRUNC(DBMS_RANDOM.VALUE(2, 8));

        v_hora_inicio := LPAD(TO_CHAR(v_hora_inicio_h), 2, '0') || ':' ||
                         LPAD(TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 60))), 2, '0');
        v_hora_fin := LPAD(TO_CHAR(v_hora_fin_h),    2, '0') || ':' ||
                         LPAD(TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 60))), 2, '0');

        v_estado := CASE TRUNC(DBMS_RANDOM.VALUE(1, 5))
                        WHEN 1 THEN 'Pendiente'
                        WHEN 2 THEN 'Confirmado'
                        WHEN 3 THEN 'Cancelado'
                        ELSE 'Realizado'
                    END;

        INSERT INTO evento (
            id_cliente, id_empleado, id_categoria, id_salon,
            nombre_evento,
            fecha_inicio, hora_inicio,
            fecha_fin, hora_fin,
            estado
        )
        VALUES (
            v_id_cliente,
            v_id_empleado,
            v_id_categoria,
            v_id_salon,
            v_nombre_categoria || ' de ' || v_nombre_cliente || ' ' || v_apellido_cliente,
            v_fecha, v_hora_inicio,
            v_fecha, v_hora_fin,
            v_estado
        );

    END LOOP;
    COMMIT;
END;
/