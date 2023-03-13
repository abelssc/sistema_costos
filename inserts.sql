-- INSERTS
INSERT INTO usuarios (usuario, contrasena, nombre, apellido, cargo, rol, activo)
VALUES
('juan123', 'contrasena123', 'Juan', 'Perez', 'vendedor', 'usuario', TRUE),
('ana456', 'contrasena456', 'Ana', 'Garcia', 'gerente', 'administrador', TRUE),
('jose789', 'contrasena789', 'Jose', 'Lopez', 'administrador', 'administrador', TRUE);
INSERT INTO proveedores (ruc, razon_social, telefono1, telefono2, direccion)
VALUES
('12345678901', 'Proveedor1', '1234567', '7654321', 'Av. Ejemplo 123'),
('98765432109', 'Proveedor2', '2345678', '8765432', 'Calle Ejemplo 456'),
('45678901234', 'Proveedor3', '3456789', '9876543', 'Jr. Ejemplo 789');
INSERT INTO clientes (ruc, razon_social, telefono1, telefono2, direccion)
VALUES
('01234567890', 'Cliente1', '1234567', '7654321', 'Av. Ejemplo 123'),
('09876543210', 'Cliente2', '2345678', '8765432', 'Calle Ejemplo 456'),
('34567890123', 'Cliente3', '3456789', '9876543', 'Jr. Ejemplo 789');
INSERT INTO categorias (categoria)
VALUES
('Electrónica'),
('Hogar'),
('Ropa'),
('Muebles'),
('Alimentos'),
('Electrodomésticos'),
('Herramientas'),
('Juguetes'),
('Alimentos'),
('Muebles'),
('Libros'),
('Cosméticos'),
('Automóviles'),
('Bebidas'),
('Deportes'),
('Mascotas'),
('Jardín'),
('Joyería'),
('Cine'),
('Viajes'),
('Instrumentos'),
('Salud'),
('Arte'),
('Software');
INSERT INTO productos (categorias_id, producto, codigo, descripcion, stock_minimo, stock_maximo, unidad_medida)
VALUES
(1, 'Laptop HP', 'HP001', 'Laptop HP de alta gama', 10, 50, 'Unidad'),
(1, 'Impresora Epson', 'EP001', 'Impresora Epson multifuncional', 5, 20, 'Unidad'),
(2, 'Sofá cama', 'SC001', 'Sofá cama de tres plazas', 2, 10, 'Unidad'),
(2, 'Mesa de comedor', 'MC001', 'Mesa de comedor de madera', 3, 15, 'Unidad'),
(3, 'Camisa Polo', 'CP001', 'Camisa Polo de algodón', 20, 100, 'Unidad'),
(3, 'Pantalón de vestir', 'PV001', 'Pantalón de vestir para caballero', 15, 50, 'Unidad'),
(4, 'Cama queen', 'CQ001', 'Cama queen de madera sólida', 1, 5, 'Unidad'),
(4, 'Armario de 4 puertas', 'A4P001', 'Armario de 4 puertas de melamina', 2, 8, 'Unidad'),
(5, 'Arroz', 'AR001', 'Arroz de grano largo', 50, 200, 'Kilogramo'),
(5, 'Fideos', 'FD001', 'Fideos tallarines', 30, 150, 'Kilogramo');

INSERT INTO compras (codigo, fecha, total_valor, igv, estado, proveedores_id, usuarios_id)
VALUES
('COMP0001', '2022-01-01', 1000.00, 180.00, 'aceptado', 1, 1),
('COMP0002', '2022-01-02', 500.00, 90.00, 'aceptado', 2, 2),
('COMP0003', '2022-01-03', 800.00, 144.00, 'rechazado', 3, 3),
('COMP0004', '2022-01-04', 2000.00, 360.00, 'pendiente', 1, 3),
('COMP0005', '2022-01-05', 1500.00, 270.00, 'aceptado', 2, 3),
('COMP0006', '2022-01-06', 1200.00, 216.00, 'pendiente', 3, 3),
('COMP0007', '2022-01-07', 900.00, 162.00, 'rechazado', 1, 1),
('COMP0008', '2022-01-08', 700.00, 126.00, 'aceptado', 1, 2),
('COMP0009', '2022-01-09', 3000.00, 540.00, 'pendiente', 2,1),
('COMP0010', '2022-01-10', 2500.00, 450.00, 'aceptado', 2, 2);

INSERT INTO detalle_compra (compras_id, productos_id, cantidad, unidad_medida, valor_unitario, precio_unitario)
VALUES (1, 1, 10, 'unidad', 8.50, 10.00),
(1, 2, 5, 'unidad', 15.00, 17.70),
(2, 3, 20, 'kg', 2.50, 2.95),
(2, 4, 15, 'kg', 3.50, 4.13),
(3, 5, 100, 'm', 0.50, 0.59),
(3, 6, 50, 'm', 1.25, 1.47);

INSERT INTO ventas (codigo, fecha, total_valor, igv, percepcion, estado, clientes_id, usuarios_id)
VALUES ('V-0001', '2022-01-15', 100.00, 18.00, 2.00, 'aceptado', 1, 1),
('V-0002', '2022-02-01', 150.00, 27.00, 3.00, 'pendiente', 2, 1),
('V-0003', '2022-02-15', 80.00, 14.40, 1.60, 'rechazado', 1, 2);
INSERT INTO detalle_venta (ventas_id, productos_id, cantidad, unidad_medida, valor_unitario, precio_unitario)
VALUES (1, 1, 5, 'unidades', 15.00, 17.70),
(1, 2, 3, 'metros', 10.00, 11.80),
(2, 3, 2, 'unidades', 25.00, 29.50),
(2, 4, 1, 'litros', 8.00, 9.44),
(2, 5, 4, 'unidades', 5.00, 5.90),
(3, 6, 10, 'metros', 2.00, 2.36),
(3, 7, 2, 'unidades', 30.00, 35.40);
INSERT INTO pagos_venta (ventas_id, tipo_pago, monto, fecha) VALUES (1, 'contado', 500.00, '2023-03-01 10:00:00');
INSERT INTO pagos_venta (ventas_id, tipo_pago, monto, fecha) VALUES (1, 'deposito', 1000.00, '2023-03-03 15:30:00');
INSERT INTO pagos_venta (ventas_id, tipo_pago, monto, fecha) VALUES (2, 'contado', 800.00, '2023-03-04 12:15:00');
INSERT INTO pagos_venta (ventas_id, tipo_pago, monto, fecha) VALUES (3, 'deposito', 1500.00, '2023-03-07 11:00:00');

INSERT INTO tipo_ajuste (ajuste, motivo, descripcion) VALUES
('entrada', 'devolucion', 'Devolución de producto por cliente'),
('entrada', 'donacion', 'Donación de producto a institución benéfica'),
('entrada', 'otro', 'Ajuste de stock por razones diversas'),
('salida', 'perdida', 'Pérdida de producto por caducidad o deterioro'),
('salida', 'otro', 'Ajuste de stock por razones diversas');

INSERT INTO ajuste (tipo_ajuste_id, productos_id, codigo_compra_venta, cantidad, unidad_medida, valor_unitario, precio_unitario, fecha) VALUES
(1, 1, 'CV-001', 10, 'unidades', 50.00, 59.00, '2022-03-09 15:30:00'),
(2, 2, NULL, 5, 'cajas', 100.00, 118.00, '2022-03-08 10:00:00'),
(3, 3, NULL, 2, 'litros', 5.00, 5.90, '2022-03-07 14:45:00'),
(4, 4, NULL, 1, 'unidades', 30.00, 35.40, '2022-03-06 08:15:00');

