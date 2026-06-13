-- ============================================================================
-- ASIGNACIÓN DE PERMISOS PARA usr_lectura 
-- ============================================================================

GRANT SELECT ON usr_dev_eventos.cliente TO usr_lectura;
GRANT SELECT ON usr_dev_eventos.empleado TO usr_lectura;
GRANT SELECT ON usr_dev_eventos.categoria TO usr_lectura;
GRANT SELECT ON usr_dev_eventos.salon TO usr_lectura;
GRANT SELECT ON usr_dev_eventos.asistente TO usr_lectura;
GRANT SELECT ON usr_dev_eventos.evento TO usr_lectura;
GRANT SELECT ON usr_dev_eventos.registro_pago TO usr_lectura;
GRANT SELECT ON usr_dev_eventos.control_asistencia TO usr_lectura;

GRANT SELECT ON usr_dev_eventos.vista_eventos_operativos TO usr_lectura;
GRANT SELECT ON usr_dev_eventos.vista_reporting_ingresos TO usr_lectura;

-- ============================================================================
-- ASIGNACIÓN DE PERMISOS PARA usr_admin
-- ============================================================================

GRANT EXECUTE ON usr_dev_eventos.sp_top_elementos TO usr_admin;
GRANT EXECUTE ON usr_dev_eventos.sp_alertas_negocio TO usr_admin;
GRANT EXECUTE ON usr_dev_eventos.sp_resumen_periodo TO usr_admin;
GRANT EXECUTE ON usr_dev_eventos.sp_indicadores_categoria TO usr_admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON usr_dev_eventos.auditoria_evento TO usr_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON usr_dev_eventos.log_errores TO usr_admin;