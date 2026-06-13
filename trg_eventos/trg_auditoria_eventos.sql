CREATE OR REPLACE TRIGGER trg_auditoria_evento
AFTER INSERT OR UPDATE ON evento
FOR EACH ROW
DECLARE
    v_accion VARCHAR2(10);
BEGIN

    IF INSERTING THEN
        v_accion := 'INSERT';
    ELSIF UPDATING THEN
        v_accion := 'UPDATE';
    END IF;

    IF INSERTING THEN
        INSERT INTO auditoria_evento (accion, columna_afectada, valor_nuevo, id_evento_afectado)
        VALUES (v_accion, 'ESTADO', :NEW.estado, :NEW.id_evento);
        
        INSERT INTO auditoria_evento (accion, columna_afectada, valor_nuevo, id_evento_afectado)
        VALUES (v_accion, 'FECHA_HORA_INICIO', TO_CHAR(:NEW.fecha_hora_inicio, 'YYYY-MM-DD HH24:MI:SS'), :NEW.id_evento);
        
        INSERT INTO auditoria_evento (accion, columna_afectada, valor_nuevo, id_evento_afectado)
        VALUES (v_accion, 'FECHA_HORA_FIN', TO_CHAR(:NEW.fecha_hora_fin, 'YYYY-MM-DD HH24:MI:SS'), :NEW.id_evento);
        
        INSERT INTO auditoria_evento (accion, columna_afectada, valor_nuevo, id_evento_afectado)
        VALUES (v_accion, 'ID_SALON', TO_CHAR(:NEW.id_salon), :NEW.id_evento);
        
        INSERT INTO auditoria_evento (accion, columna_afectada, valor_nuevo, id_evento_afectado)
        VALUES (v_accion, 'ID_CATEGORIA', TO_CHAR(:NEW.id_categoria), :NEW.id_evento);
    END IF;

    IF UPDATING THEN
        IF :OLD.estado != :NEW.estado THEN
            INSERT INTO auditoria_evento (accion, columna_afectada, valor_anterior, valor_nuevo, id_evento_afectado)
            VALUES (v_accion, 'ESTADO', :OLD.estado, :NEW.estado, :NEW.id_evento);
        END IF;
        
        IF :OLD.fecha_hora_inicio != :NEW.fecha_hora_inicio THEN
            INSERT INTO auditoria_evento (accion, columna_afectada, valor_anterior, valor_nuevo, id_evento_afectado)
            VALUES (v_accion, 'FECHA_HORA_INICIO', 
                    TO_CHAR(:OLD.fecha_hora_inicio, 'YYYY-MM-DD HH24:MI:SS'),
                    TO_CHAR(:NEW.fecha_hora_inicio, 'YYYY-MM-DD HH24:MI:SS'),
                    :NEW.id_evento);
        END IF;
        
        IF :OLD.fecha_hora_fin != :NEW.fecha_hora_fin THEN
            INSERT INTO auditoria_evento (accion, columna_afectada, valor_anterior, valor_nuevo, id_evento_afectado)
            VALUES (v_accion, 'FECHA_HORA_FIN',
                    TO_CHAR(:OLD.fecha_hora_fin, 'YYYY-MM-DD HH24:MI:SS'),
                    TO_CHAR(:NEW.fecha_hora_fin, 'YYYY-MM-DD HH24:MI:SS'),
                    :NEW.id_evento);
        END IF;
        
        IF :OLD.id_salon != :NEW.id_salon THEN
            INSERT INTO auditoria_evento (accion, columna_afectada, valor_anterior, valor_nuevo, id_evento_afectado)
            VALUES (v_accion, 'ID_SALON', TO_CHAR(:OLD.id_salon), TO_CHAR(:NEW.id_salon), :NEW.id_evento);
        END IF;
        
        IF :OLD.id_categoria != :NEW.id_categoria THEN
            INSERT INTO auditoria_evento (accion, columna_afectada, valor_anterior, valor_nuevo, id_evento_afectado)
            VALUES (v_accion, 'ID_CATEGORIA', TO_CHAR(:OLD.id_categoria), TO_CHAR(:NEW.id_categoria), :NEW.id_evento);
        END IF;
    END IF;
    
END trg_auditoria_evento;
/