CREATE OR REPLACE PROCEDURE sp_resumen_periodo (
    p_fecha_inicio IN DATE,
    p_fecha_fin IN DATE
) AS
    v_volumen_operaciones NUMBER := 0;
    v_monto_total NUMBER := 0;
    v_promedio_operacion NUMBER := 0;
    
    e_fechas_invalidas EXCEPTION;
BEGIN
    IF p_fecha_inicio > p_fecha_fin THEN
        RAISE e_fechas_invalidas;
    END IF;
    
    SELECT
        COUNT(*),
        NVL(SUM(monto_pagado), 0),
        ROUND(NVL(AVG(monto_pagado), 0), 2)
    INTO
        v_volumen_operaciones,
        v_monto_total,
        v_promedio_operacion
    FROM registro_pago
    WHERE fecha_pago BETWEEN p_fecha_inicio AND p_fecha_fin;
    
    IF v_volumen_operaciones = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;
    
    dbms_output.put_line('Resumen de actividad del negocio');
    dbms_output.put_line('Periodo evaluado: ' || TO_CHAR(p_fecha_inicio, 'DD/MM/YYYY') || ' al ' || TO_CHAR(p_fecha_fin, 'DD/MM/YYYY'));
    dbms_output.put_line('Volumen de Operaciones: ' || v_volumen_operaciones || ' pagos realizados.');
    dbms_output.put_line('Monto Total Recaudado: $' || v_monto_total);
    dbms_output.put_line('Promedio por Operacion: $' || v_promedio_operacion);
    
    COMMIT;
EXCEPTION
    WHEN e_fechas_invalidas THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'Error: La fecha de inicio no puede ser posterior a la fecha de fin.');
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Error: No se registraron operaciones financieras en el periodo indicado.');
    WHEN TOO_MANY_ROWS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20003, 'Error: La consulta retorno demasiadas filas.');
    WHEN OTHERS THEN
        ROLLBACK;
        
        DECLARE
            v_err VARCHAR2(4000) := SUBSTR(SQLERRM, 1, 4000);
        BEGIN
            INSERT INTO log_errores (nombre_procedimiento, mensaje_error)
            VALUES ('sp_resumen_periodo', v_err);
            COMMIT;
        END;
        
        RAISE_APPLICATION_ERROR(-20999, 'Error no controlado. Detalles guardados en la tabla de logs error.');
END sp_resumen_periodo;
/