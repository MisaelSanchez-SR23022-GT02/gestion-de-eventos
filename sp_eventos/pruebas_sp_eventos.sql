--Testear el funcionamiento del procedimiento almacenado sp_resumen_periodo

SET SERVEROUTPUT ON; 
EXEC sp_resumen_periodo(TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));