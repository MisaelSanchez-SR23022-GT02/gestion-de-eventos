DECLARE
    TYPE id_array IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    v_ids_asistentes id_array;

    TYPE num_list IS TABLE OF NUMBER;
    v_lista_ids num_list;
    v_lista_ids_mezc num_list := num_list();

    v_total_asistentes NUMBER;
    v_capacidad_salon NUMBER;
    v_asistentes_por_evento NUMBER;
    v_evento_id NUMBER;
    v_id_salon NUMBER;
    v_idx NUMBER;
    v_temp NUMBER;
BEGIN
    SELECT id_asistente
    BULK COLLECT INTO v_lista_ids
    FROM asistente;

    v_total_asistentes := v_lista_ids.COUNT;

    FOR evento_rec IN (
        SELECT e.id_evento, e.id_salon
        FROM evento e
        ORDER BY e.id_evento
    ) LOOP
        v_evento_id := evento_rec.id_evento;
        v_id_salon := evento_rec.id_salon;

        SELECT capacidad_max
        INTO v_capacidad_salon
        FROM salon
        WHERE id_salon = v_id_salon;

        v_asistentes_por_evento := TRUNC(
            DBMS_RANDOM.VALUE(10, LEAST(v_capacidad_salon, v_total_asistentes) + 1)
        );

        v_lista_ids_mezc := v_lista_ids;
        FOR j IN REVERSE 2..v_total_asistentes LOOP
            v_idx := TRUNC(DBMS_RANDOM.VALUE(1, j + 1));
            v_temp := v_lista_ids_mezc(j);
            v_lista_ids_mezc(j) := v_lista_ids_mezc(v_idx);
            v_lista_ids_mezc(v_idx) := v_temp;
        END LOOP;

        FOR i IN 1..v_asistentes_por_evento LOOP
            INSERT INTO control_asistencia (id_asistente, id_evento)
            VALUES (v_lista_ids_mezc(i), v_evento_id);
        END LOOP;

    END LOOP;

    COMMIT;
END;
/