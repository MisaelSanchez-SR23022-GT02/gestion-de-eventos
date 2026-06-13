CREATE OR REPLACE PROCEDURE sp_alertas_negocio AS
    v_sin_pago NUMBER;
    v_proximos NUMBER;
    v_inactivos NUMBER;
    v_sobrecupo NUMBER;
    e_critica EXCEPTION;
    v_error_msg VARCHAR2(4000);
BEGIN
    SELECT COUNT(*) INTO v_sin_pago
    FROM evento e LEFT JOIN registro_pago rp ON e.id_evento = rp.id_evento
    WHERE e.estado = 'Confirmado' AND rp.id_pago IS NULL;
    
    SELECT COUNT(*) INTO v_proximos
    FROM evento e LEFT JOIN registro_pago rp ON e.id_evento = rp.id_evento
    WHERE e.estado = 'Confirmado' AND rp.id_pago IS NULL
      AND e.fecha_hora_inicio BETWEEN SYSDATE AND SYSDATE + 7;
    
    SELECT COUNT(*) INTO v_inactivos
    FROM cliente c
    WHERE NOT EXISTS (SELECT 1 FROM evento e WHERE e.id_cliente = c.id_cliente AND e.fecha_hora_inicio >= SYSDATE - 180);
    
    SELECT COUNT(*) INTO v_sobrecupo
    FROM evento e JOIN salon s ON e.id_salon = s.id_salon
    WHERE e.estado = 'Realizado'
      AND (SELECT COUNT(*) FROM control_asistencia ca WHERE ca.id_evento = e.id_evento) > s.capacidad_max;
    
    DBMS_OUTPUT.PUT_LINE('Sin pago: '||v_sin_pago||' | Próximos sin pago: '||v_proximos||
                         ' | Inactivos: '||v_inactivos||' | Sobre cupo: '||v_sobrecupo);
    
    IF v_sin_pago > 10 THEN
        RAISE e_critica;
    END IF;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Sin umbrales críticos.');
    
EXCEPTION
    WHEN e_critica THEN
        ROLLBACK;
        v_error_msg := 'Crítica: +10 eventos sin pago ('||v_sin_pago||')';
        INSERT INTO LOG_ERRORES (nombre_procedimiento, mensaje_error)
        VALUES ('sp_alertas_negocio', v_error_msg);
        COMMIT;
        RAISE_APPLICATION_ERROR(-20002, 'Alerta crítica: muchos eventos sin pago');
    
    WHEN OTHERS THEN
        ROLLBACK;
        v_error_msg := SQLERRM;
        INSERT INTO LOG_ERRORES (nombre_procedimiento, mensaje_error)
        VALUES ('sp_alertas_negocio', v_error_msg);
        COMMIT;
        RAISE;
END;
/