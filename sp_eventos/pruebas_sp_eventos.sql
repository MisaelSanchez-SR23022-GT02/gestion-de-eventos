--Testear el funcionamiento del procedimiento almacenado sp_resumen_periodo
SET SERVEROUTPUT ON; 
EXEC sp_resumen_periodo(TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));

--Testear el funcionamiento del procedimiento almacenado sp_top_elementos
SET SERVEROUTPUT ON;
EXEC sp_top_elementos(5);

--Testear el funcionamiento del procedimiento almacenado sp_alerta_negocio
SET SERVEROUTPUT ON;
EXEC SP_ALERTAS_NEGOCIO;

--Testear el funcionamiento del procedimiento almacenado sp_indicadores_categoria
SET SERVEROUTPUT ON;
EXEC sp_indicadores_categoria(2026,6);