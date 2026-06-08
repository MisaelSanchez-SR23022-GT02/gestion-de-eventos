DECLARE
    TYPE arr_nombres IS TABLE OF VARCHAR2(50);
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

    v_idx_nombre NUMBER;
    v_idx_apellido NUMBER;
    v_dui NUMBER;
    v_dui_str VARCHAR2(10);
    v_nombre VARCHAR2(50);
    v_apellido VARCHAR2(50);
BEGIN
    FOR i IN 1..50 LOOP
        v_idx_nombre := TRUNC(DBMS_RANDOM.VALUE(1, v_nombres.COUNT + 1));
        v_idx_apellido := TRUNC(DBMS_RANDOM.VALUE(1, v_apellidos.COUNT + 1));
        v_nombre := v_nombres(v_idx_nombre);
        v_apellido := v_apellidos(v_idx_apellido);

        LOOP
            v_dui := TRUNC(DBMS_RANDOM.VALUE(1000000, 9999999));
            v_dui_str := TO_CHAR(v_dui) || '-' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1, 9)));

            BEGIN
                INSERT INTO cliente (
                    nombre_cliente, apellido_cliente,
                    dui_cliente, telefono_cliente, email_cliente
                )
                VALUES (
                    v_nombre,
                    v_apellido,
                    v_dui_str,
                    '7' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1000000, 9999999))),
                    LOWER(v_nombre) || '.' || LOWER(v_apellido) || i || '@gmail.com'
                );
                EXIT;
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    NULL;
            END;
        END LOOP;

    END LOOP;
    COMMIT;
END;
/