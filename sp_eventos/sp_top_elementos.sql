CREATE OR REPLACE PROCEDURE sp_top_elementos (p_n IN NUMBER) AS
    CURSOR c IS
        SELECT cl.nombre_cliente || ' ' || cl.apellido_cliente AS nombre,
               SUM(rp.monto_pagado) AS gasto
        FROM cliente cl
        JOIN evento e ON e.id_cliente = cl.id_cliente
        JOIN registro_pago rp ON rp.id_evento = e.id_evento
        GROUP BY cl.id_cliente, cl.nombre_cliente, cl.apellido_cliente
        ORDER BY gasto DESC;
    v_global NUMBER;
    v_acum NUMBER := 0;
    v_cont NUMBER := 0;
    v_error VARCHAR2(4000);
BEGIN
    IF p_n IS NULL OR p_n <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'N debe ser positivo');
    END IF;
    
    SELECT NVL(SUM(monto_pagado), 0) INTO v_global FROM registro_pago;
    IF v_global = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No hay pagos');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Top ' || p_n || ' clientes');
    
    FOR r IN c LOOP
        EXIT WHEN v_cont >= p_n;
        v_cont := v_cont + 1;
        v_acum := v_acum + r.gasto;
        DBMS_OUTPUT.PUT_LINE(
            '- ' || v_cont || ' ' || r.nombre || 
            ' | Gasto: $' || TO_CHAR(r.gasto, '999,999.99') ||
            ' | Acum: ' || ROUND(v_acum / v_global * 100, 2) || '%'
        );
    END LOOP;
    
    IF v_cont = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Procedimiento ejecutado exitosamente.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        v_error := 'NO_DATA_FOUND: No se encontraron clientes con pagos.';
        INSERT INTO LOG_ERRORES (nombre_procedimiento, mensaje_error) VALUES ('sp_top_elementos', v_error);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Error: ' || v_error);
    WHEN TOO_MANY_ROWS THEN
        ROLLBACK;
        v_error := 'TOO_MANY_ROWS inesperado';
        INSERT INTO LOG_ERRORES (nombre_procedimiento, mensaje_error) VALUES ('sp_top_elementos', v_error);
        COMMIT;
        RAISE;
    WHEN OTHERS THEN
        ROLLBACK;
        v_error := SQLERRM;
        INSERT INTO LOG_ERRORES (nombre_procedimiento, mensaje_error) VALUES ('sp_top_elementos', v_error);
        COMMIT;
        RAISE;
END;
/