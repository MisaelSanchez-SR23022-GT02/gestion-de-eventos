-- Categoría (10)
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Boda', 3000.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Cumpleaños', 400.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Graduación', 700.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Bautizo', 500.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('XV Años', 1200.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Baby Shower', 300.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Aniversario', 600.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Cena de Gala', 2000.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Conferencia', 800.00);
INSERT INTO categoria (nombre_categoria, precio_categoria) VALUES ('Fiesta Empresarial', 1500.00);
COMMIT;

-- Empleado (10)
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('Laura', 'Gómez', '71234567', 'laura.gomez@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('Carlos', 'Mendoza', '72345678', 'carlos.mendoza@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('María', 'Rodríguez', '73456789', 'maria.rodriguez@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('José', 'López', '74567890', 'jose.lopez@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('Ana', 'Martínez', '75678901', 'ana.martinez@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('Pedro', 'Sánchez', '76789012', 'pedro.sanchez@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('Lucía', 'Pérez', '77890123', 'lucia.perez@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('Javier', 'Ramírez', '78901234', 'javier.ramirez@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('Sofía', 'Flores', '79012345', 'sofia.flores@eventos.com');
INSERT INTO empleado (nombre_empleado, apellido_empleado, telefono_empleado, email_empleado) 
VALUES ('Andrés', 'Morales', '70123456', 'andres.morales@eventos.com');

-- Salón (15)
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Jardín Central', 150, 50.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Terraza Piscina', 80, 60.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Salón Principal', 200, 70.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Mirador del Lago', 60, 80.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Rincón Andaluz', 100, 55.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Área VIP', 40, 100.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Cristal Hall', 180, 65.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Salón Colonial', 120, 60.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Terraza del Mar', 70, 75.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Jardín Secreto', 50, 45.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Auditorio Central', 300, 90.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Salón Real', 250, 85.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Espacio Natural', 90, 50.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Terraza del Sol', 65, 55.00);
INSERT INTO salon (nombre_salon, capacidad_max, precio_hora) VALUES ('Salón de los Espejos', 110, 70.00);
COMMIT;