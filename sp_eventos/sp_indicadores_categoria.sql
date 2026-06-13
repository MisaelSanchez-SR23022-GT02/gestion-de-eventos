CREATE OR REPLACE PROCEDURE sp_indicadores_categoria (p_anio IN NUMBER, p_mes IN NUMBER) AS
    v_mes_ant  NUMBER := CASE p_mes WHEN 1 THEN 12 ELSE p_mes - 1 END;
    v_anio_ant NUMBER := CASE p_mes WHEN 1 THEN p_anio - 1 ELSE p_anio END;
    v_error    VARCHAR2(4000);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Periodo actual: '||p_anio||'-'||p_mes||' | Anterior: '||v_anio_ant||'-'||v_mes_ant);
    
    FOR r IN (
        SELECT c.nombre_categoria,
               NVL(SUM(CASE WHEN EXTRACT(YEAR FROM rp.fecha_pago)=p_anio AND EXTRACT(MONTH FROM rp.fecha_pago)=p_mes THEN rp.monto_pagado END),0) AS ing_act,
               NVL(SUM(CASE WHEN EXTRACT(YEAR FROM rp.fecha_pago)=v_anio_ant AND EXTRACT(MONTH FROM rp.fecha_pago)=v_mes_ant THEN rp.monto_pagado END),0) AS ing_ant
        FROM categoria c
        LEFT JOIN evento e ON e.id_categoria = c.id_categoria
        LEFT JOIN registro_pago rp ON rp.id_evento = e.id_evento
        GROUP BY c.nombre_categoria
    ) LOOP
        DECLARE
            var NUMBER;
        BEGIN
            var := CASE WHEN r.ing_ant=0 THEN CASE WHEN r.ing_act=0 THEN 0 ELSE 100 END
                        ELSE ((r.ing_act - r.ing_ant)/r.ing_ant)*100 END;
            DBMS_OUTPUT.PUT_LINE(r.nombre_categoria||' | Actual: '||r.ing_act||' | Anterior: '||r.ing_ant||' | Var: '||ROUND(var,2)||'%');
        END;
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        v_error := SQLERRM;
        ROLLBACK;
        INSERT INTO LOG_ERRORES (nombre_procedimiento, mensaje_error) VALUES ('sp_indicadores_categoria', v_error);
        COMMIT;
        RAISE;
END;
/