DECLARE
    v_fecha_pago DATE;
    v_monto NUMBER;
    v_monto_total NUMBER;
    v_duracion_horas NUMBER;
    v_precio_categoria NUMBER;
    v_precio_salon NUMBER;
BEGIN
    FOR rec IN (
        SELECT e.id_evento, e.fecha_inicio, e.id_categoria,
               e.id_salon,  e.hora_inicio,  e.hora_fin
        FROM evento e
    ) LOOP

        SELECT c.precio_categoria, s.precio_hora
        INTO v_precio_categoria, v_precio_salon
        FROM categoria c, salon s
        WHERE c.id_categoria = rec.id_categoria
          AND s.id_salon = rec.id_salon;

        v_duracion_horas :=
            (
              (TO_NUMBER(SUBSTR(rec.hora_fin, 1, 2)) * 60 + TO_NUMBER(SUBSTR(rec.hora_fin, 4, 2))) -
              (TO_NUMBER(SUBSTR(rec.hora_inicio, 1, 2)) * 60 + TO_NUMBER(SUBSTR(rec.hora_inicio, 4, 2)))
            ) / 60;

        IF v_duracion_horas <= 0 THEN
            v_duracion_horas := 1;
        END IF;

        v_monto_total := (v_precio_categoria + v_precio_salon) * v_duracion_horas;

        v_monto := ROUND(v_monto_total * (0.30 + DBMS_RANDOM.VALUE(0, 0.70)), 2);

        v_fecha_pago := rec.fecha_inicio + TRUNC(DBMS_RANDOM.VALUE(1, 15));

        INSERT INTO registro_pago (id_evento, fecha_pago, monto_pagado)
        VALUES (rec.id_evento, v_fecha_pago, v_monto);

    END LOOP;
    COMMIT;
END;
/