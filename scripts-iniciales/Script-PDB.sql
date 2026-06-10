-- ============================================================================
-- 1. CONFIGURACIÓN DE RUTA DE ALMACENAMIENTO (SYSDBA EN CDB$ROOT)
-- ============================================================================

-- Linux / Docker
ALTER SYSTEM SET DB_CREATE_FILE_DEST = '/opt/oracle/oradata/';

-- Windows (usar SOLO una de estas líneas según corresponda)
-- ALTER SYSTEM SET DB_CREATE_FILE_DEST = 'C:\app\product\oradata\';
-- ALTER SYSTEM SET DB_CREATE_FILE_DEST = 'C:\app\OracleXE\oradata\';


-- ============================================================================
-- 2. CREACIÓN DE LA PDB
-- ============================================================================

CREATE PLUGGABLE DATABASE PDB_EVENTOS
ADMIN USER admin_eventos IDENTIFIED BY "1234";

ALTER PLUGGABLE DATABASE PDB_EVENTOS OPEN;

ALTER PLUGGABLE DATABASE PDB_EVENTOS SAVE STATE;

ALTER SESSION SET CONTAINER = PDB_EVENTOS;


-- ============================================================================
-- 3. TABLESPACE DEL PROYECTO
-- ============================================================================

CREATE TABLESPACE TS_EVENTOS
DATAFILE SIZE 50M
AUTOEXTEND ON NEXT 10M
MAXSIZE UNLIMITED;


-- ============================================================================
-- 4. USUARIO DESARROLLADOR PRINCIPAL
-- ============================================================================

CREATE USER usr_dev_eventos
IDENTIFIED BY "DevEventos2026#"
DEFAULT TABLESPACE TS_EVENTOS
QUOTA UNLIMITED ON TS_EVENTOS;

GRANT CREATE SESSION TO usr_dev_eventos;
GRANT CREATE TABLE TO usr_dev_eventos;
GRANT CREATE VIEW TO usr_dev_eventos;
GRANT CREATE SEQUENCE TO usr_dev_eventos;
GRANT CREATE TRIGGER TO usr_dev_eventos;
GRANT CREATE PROCEDURE TO usr_dev_eventos;


-- ============================================================================
-- 5. USUARIO DE LECTURA
-- ============================================================================

CREATE USER usr_lectura
IDENTIFIED BY "Lectura2026#"
DEFAULT TABLESPACE TS_EVENTOS
QUOTA 0 ON TS_EVENTOS;

GRANT CREATE SESSION TO usr_lectura;


-- ============================================================================
-- 6. USUARIO ADMINISTRADOR DE OPERACIONES
-- ============================================================================

CREATE USER usr_admin
IDENTIFIED BY "Admin2026#"
DEFAULT TABLESPACE TS_EVENTOS
QUOTA UNLIMITED ON TS_EVENTOS;

GRANT CREATE SESSION TO usr_admin;


-- ============================================================================
-- 7. VERIFICACIÓN
-- ============================================================================

SELECT username, default_tablespace
FROM dba_users
WHERE username IN (
    'USR_DEV_EVENTOS',
    'USR_ADMIN',
    'USR_LECTURA'
);
