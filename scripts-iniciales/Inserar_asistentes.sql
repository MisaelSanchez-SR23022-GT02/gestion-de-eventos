DECLARE
    TYPE arr_nombres   IS TABLE OF VARCHAR2(50);
    TYPE arr_apellidos IS TABLE OF VARCHAR2(50);

    v_nombres arr_nombres := arr_nombres(
        'Juan','María','Carlos','Ana','Luis','Laura','José','Carmen','Miguel','Isabel',
        'Javier','Marta','Pablo','Lucía','Alejandro','Patricia','Andrés','Raquel','Fernando','Elena',
        'Diego','Sofía','Ricardo','Valentina','Manuel','Claudia','Raúl','Daniela','Sergio','Natalia',
        'Gabriel','Paula','David','Andrea','Jorge','Camila','Adrián','Verónica','Roberto','Silvia'
    );
    v_apellidos arr_apellidos := arr_apellidos(
        'García','Martínez','López','Rodríguez','Sánchez','Pérez','González',
        'Ramírez','Flores','Morales','Rojas','Vargas','Castro','Ortega',
        'Mendoza','Silva','Romero','Ruiz','Torres','Álvarez'
    );

    v_idx_nombre   NUMBER;
    v_idx_apellido NUMBER;
BEGIN
    FOR i IN 1..200 LOOP
        v_idx_nombre := TRUNC(DBMS_RANDOM.VALUE(1, v_nombres.COUNT + 1));
        v_idx_apellido := TRUNC(DBMS_RANDOM.VALUE(1, v_apellidos.COUNT + 1));

        INSERT INTO asistente (nombre_asistente, apellido_asistente, telefono_asistente)
        VALUES (
            v_nombres(v_idx_nombre),
            v_apellidos(v_idx_apellido),
            '7' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1000000, 9999999)))
        );
    END LOOP;
    COMMIT;
END;
/