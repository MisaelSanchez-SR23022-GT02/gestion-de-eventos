CREATE OR REPLACE TRIGGER trg_evitar_cruce_eventos
BEFORE INSERT OR UPDATE ON evento
FOR EACH ROW
DECLARE
    v_coincidencias NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_coincidencias
    FROM evento
    WHERE id_salon = :NEW.id_salon
      AND (:NEW.fecha_hora_inicio < fecha_hora_fin AND :NEW.fecha_hora_fin > fecha_hora_inicio)
      AND ( :NEW.id_evento IS NULL OR id_evento != :NEW.id_evento );

    IF v_coincidencias > 0 THEN
        RAISE_APPLICATION_ERROR(-20060,
            'Conflicto de Reserva: El salón seleccionado ya se encuentra ocupado o reservado ' ||
            'en el rango de fecha y hora solicitado para el evento: "' || :NEW.nombre_evento || '".');
    END IF;
END;
/