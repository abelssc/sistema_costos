DROP DATABASE sistema_grano_de_oro2;
CREATE DATABASE sistema_grano_de_oro2;
USE sistema_grano_de_oro2;

CREATE TABLE personas(
id INT NOT NULL AUTO_INCREMENT,
tipo_doc_persona ENUM('DNI','RUC','OTRO'),
doc_persona varchar(20),
tipo_persona ENUM('usuarios','clientes','proveedores') NOT NULL,
razon_social varchar(20),
nombre varchar(255),
apellido varchar(255),
telefono1 varchar(10),
telefono2 varchar(10),
direccion varchar(255),
email varchar(255),
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);

CREATE TABLE usuarios(
id INT NOT NULL AUTO_INCREMENT,
usuario varchar(255) NOT NULL,
contrasena varchar(255) NOT NULL,
cargo ENUM('administrador','gerente','vendedor','usuario') NOT NULL,
personas_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY(personas_id) REFERENCES personas(id)
);

-- CREATE TABLE proveedores();
-- CREATE TABLE clientes();

CREATE TABLE categorias(
id INT NOT NULL AUTO_INCREMENT,
categoria varchar(255) NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);
CREATE TABLE unidades_medidas(
id INT NOT NULL AUTO_INCREMENT,
tipo_unidad_medida varchar(255),
nombre_unidad_medida varchar(255),
abreviatura_unidad_medida varchar(10),
PRIMARY KEY(id)
);
CREATE TABLE marcas(
id INT NOT NULL AUTO_INCREMENT,
nombre_marca varchar(255),
PRIMARY KEY(id)
);
CREATE TABLE productos(
id INT NOT NULL AUTO_INCREMENT,
producto VARCHAR(255) NOT NULL,
unidad_medida VARCHAR(20),
codigo VARCHAR(10),
descripcion TEXT,
stock INT,
stock_minimo INT,
stock_maximo INT,
precio_venta DECIMAL(10,2),
categorias_id INT NOT NULL,
marcas_id INT,
unidades_medidas_id INT,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
foreign key (categorias_id) references categorias(id),
foreign key (marcas_id) references marcas(id),
foreign key (unidades_medidas_id) references unidades_medidas(id)
);
CREATE TABLE movimientos(
id INT NOT NULL AUTO_INCREMENT,
origen_movimiento ENUM('compra','venta','ajuste') NOT NULL,
tipo_movimiento ENUM('entrada','salida') NOT NULL,
codigo_movimiento varchar(255),
fecha DATETIME NOT NULL,
total_valor DECIMAL(10,2) NOT NULL,
igv DECIMAL(10,2) NOT NULL,
personas_id INT NOT NULL,
usuarios_id INT NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
FOREIGN KEY (personas_id) REFERENCES personas(id),
FOREIGN KEY (usuarios_id) REFERENCES usuarios(id)
);
CREATE TABLE detalles(
id INT NOT NULL AUTO_INCREMENT,
movimientos_id INT NOT NULL,
productos_id INT NOT NULL,
cantidad INT NOT NULL,
-- unid sin igv
valor_unitario DECIMAL(10,2) NOT NULL,
-- unid con igv
precio_unitario DECIMAL(10,2) NOT NULL,
PRIMARY KEY(id,movimientos_id),
FOREIGN KEY (movimientos_id) REFERENCES movimientos(id),
FOREIGN KEY (productos_id) REFERENCES productos(id)
);

CREATE TABLE pagos_ventas (
  id INT NOT NULL AUTO_INCREMENT,
  movimientos_id INT NOT NULL,
  tipo_pago ENUM('contado','deposito','otros') NOT NULL,
  monto DECIMAL(10,2) NOT NULL,
  fecha DATETIME NOT NULL,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id,movimientos_id),
  FOREIGN KEY (movimientos_id) REFERENCES movimientos(id)
);
-- devoluciones, traslado a otro almacen, donaciones, perdidas x robo daño caducidad  
CREATE TABLE tipo_ajuste(
id INT NOT NULL AUTO_INCREMENT,
ajuste ENUM('entrada','salida') NOT NULL,
motivo ENUM('devolucion','donacion','perdida','otro') NOT NULL,
descripcion text,
PRIMARY KEY (id)
);
CREATE TABLE kardex_saldos(
id INT NOT NULL auto_increment,
productos_id INT NOT NULL,
movimientos_id INT NOT NULL,
stock INT NOT NULL,
costo_unit DECIMAL(10,2) NOT NULL,
costo_total DECIMAL(10,2) NOT NULL,
PRIMARY KEY (id,productos_id),
FOREIGN KEY (productos_id) REFERENCES productos(id),
FOREIGN KEY (movimientos_id) REFERENCES movimientos(id)
);
CREATE TABLE ajuste (
id INT NOT NULL AUTO_INCREMENT,
tipo_ajuste_id INT NOT NULL,
productos_id INT NOT NULL,
codigo_compra_venta varchar(255),
cantidad INT NOT NULL,
-- UNIDADES DE MEDIDA....
unidad_medida VARCHAR(20),
-- unid sin igv
valor_unitario DECIMAL(10,2) NOT NULL,
-- unid con igv
precio_unitario DECIMAL(10,2) NOT NULL,
fecha DATETIME NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(id),
FOREIGN KEY(tipo_ajuste_id) REFERENCES tipo_ajuste(id),
FOREIGN  KEY(productos_id) REFERENCES productos(id)
);

INSERT INTO personas (tipo_doc_persona, doc_persona, tipo_persona, razon_social, nombre, apellido, telefono1, telefono2, direccion, email)
VALUES ('DNI', '12345678', 'clientes', 'Compañía X', 'Juan', 'Pérez', '1234567890', '0987654321', 'Calle 123', 'juanperez@gmail.com');

INSERT INTO personas (tipo_doc_persona, doc_persona, tipo_persona, razon_social, nombre, apellido, telefono1, direccion, email)
VALUES ('RUC', '12345678901', 'proveedores', 'Proveedor A', NULL, NULL, '1234567890', 'Av. 456', 'proveedora@gmail.com');
INSERT INTO personas (tipo_doc_persona, doc_persona, tipo_persona, razon_social, nombre, apellido, telefono1, direccion, email)
VALUES ('RUC', '555555555', 'clientes', 'Cliente A', NULL, NULL, '995555555', 'Av. 456', 'proveedora@gmail.com');
INSERT INTO personas (tipo_doc_persona, doc_persona, tipo_persona, razon_social, nombre, apellido, telefono1, direccion, email)
VALUES ('RUC', '6666666666', 'proveedores', 'Proveedor Y', NULL, NULL, '9966666666', 'Av. 456', 'proveedora@gmail.com');

INSERT INTO personas (tipo_doc_persona, doc_persona, tipo_persona, razon_social, nombre, apellido, telefono1, telefono2, direccion, email)
VALUES ('DNI', '12345678', 'clientes', 'Compañía X', 'Juan', 'Pérez', '1234567890', '0987654321', 'Calle 123', 'juanperez@gmail.com');
INSERT INTO personas (tipo_doc_persona, doc_persona, tipo_persona, razon_social, nombre, apellido, telefono1, direccion, email)
VALUES ('RUC', '12345678901', 'proveedores', 'Proveedor A', NULL, NULL, '1234567890', 'Av. 456', 'proveedora@gmail.com');

INSERT INTO usuarios (usuario, contrasena, cargo, personas_id)
VALUES 
('jlopez', 'password123', 'administrador', 2),
('mmartinez', 'secreto456', 'gerente', 1),
('ABEL', 'ABELABED', 'usuario', 3);

INSERT INTO categorias (categoria) VALUES
('Electrodomésticos'),
('Herramientas'),
('Ropa'),
('Electrónica'),
('Hogar'),
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

INSERT INTO unidades_medidas (tipo_unidad_medida, nombre_unidad_medida, abreviatura_unidad_medida)
VALUES ('Longitud', 'Metros', 'm');
INSERT INTO unidades_medidas (tipo_unidad_medida, nombre_unidad_medida, abreviatura_unidad_medida)
VALUES ('Volumen', 'Litros', 'L');

INSERT INTO marcas (nombre_marca)
VALUES ('Samsung');
INSERT INTO marcas (nombre_marca)
VALUES ('Black & Decker');

INSERT INTO productos 
(producto, unidad_medida, codigo, descripcion, stock, stock_minimo, stock_maximo, precio_venta, categorias_id, marcas_id, unidades_medidas_id) VALUES 
('Televisor 42 pulgadas', 'unidad', '1234', 'Televisor LED Full HD', 10, 5, 50, 1200.00, 1, 1, 1),
('ABC percutor', 'unidad', 'ABC', 'ABC eléctrico inalámbrico', 5, 2, 20, 500.00, 2, 2, 1),
('Taladro XYZ', 'unidad', 'XYZ', 'XYZ eléctrico inalámbrico', 5, 2, 20, 500.00, 2, 2, 1),
('TAD', 'unidad', 'TDD', 'TDD eléctrico inalámbrico', 5, 2, 20, 500.00, 2, 2, 1);

INSERT INTO movimientos (origen_movimiento, tipo_movimiento, codigo_movimiento, fecha, total_valor, igv, personas_id, usuarios_id)
VALUES 
('compra', 'entrada', 	'COMP-001', 	'2022-01-15 15:30:00', 2400.00, 	432.00, 2, 1),
('venta', 'salida', 	'VENT-001', 	'2022-02-02 10:15:00', 1500.00, 	270.00, 1, 2),
('compra','entrada',	'COMP-002', 	'2022-01-15 10:30:00', 2000,		360, 1, 2),
('venta', 'salida',		'VENT-002',	'	2022-02-25 15:45:00', 3000,			540, 2, 3),
('ajuste', 'entrada',	'AJUST-001',	'2022-03-10 09:00:00', 1000,		180, 3, 1),
('compra', 'entrada', 'COD1', '2023-03-10 10:00:00', 100.00, 18.00, 1, 1),
('compra', 'entrada', 'COD2', '2023-03-10 11:00:00', 200.00, 36.00, 2, 2),
('compra', 'entrada', 'COD3', '2023-03-10 12:00:00', 300.00, 54.00, 3, 3),
('venta', 'salida', 'VNTD1', '2023-04-10 10:00:00', 150.00, 38.00, 1, 1),
('venta', 'salida', 'VNTD2', '2023-04-10 11:00:00', 250.00, 46.00, 2, 2),
('venta', 'salida', 'VNTD3', '2023-04-10 12:00:00', 400.00, 70.00, 3, 3);

INSERT INTO detalles(movimientos_id, productos_id, cantidad, valor_unitario, precio_unitario)
VALUES 
(1, 1, 10, 2.50, 3.00),
(1, 2, 5, 3.00, 3.60),
(2, 3, 8, 1.75, 2.10),
(3, 4, 15, 1.20, 1.44),
(6, 1, 10, 20, 30),
(6, 1, 5, 3.00, 3.60),
(7, 1, 8, 50, 70),
(8, 1, 15, 100, 120),
(9, 1, 15, 20, 40),
(10, 1, 20, 30, 50),
(11, 1,30, 50, 60);

INSERT INTO pagos_ventas(movimientos_id, tipo_pago, monto, fecha)
VALUES (1, 'contado', 30.00, '2022-02-20 10:30:00'),
(2, 'deposito', 14.00, '2022-02-22 15:20:00'),
(3, 'otros', 18.00, '2022-02-23 11:10:00');

INSERT INTO tipo_ajuste(ajuste, motivo, descripcion)
VALUES ('entrada', 'devolucion', 'Devolución de producto defectuoso'),
('salida', 'perdida', 'Pérdida de producto por daño en transporte'),
('entrada', 'donacion', 'Donación de producto a organización benéfica');

INSERT INTO kardex_saldos(productos_id, movimientos_id, stock, costo_unit, costo_total)
VALUES (1, 1, 10, 2.50, 25.00),
(2, 1, 5, 3.00, 15.00),
(3, 2, 8, 1.75, 14.00),
(4, 3, 15, 1.20, 18.00);

INSERT INTO ajuste(tipo_ajuste_id, productos_id, codigo_compra_venta, cantidad, unidad_medida, valor_unitario, precio_unitario, fecha)
VALUES (1, 1, 'COMP0001', 2, 'unidades', 2.50, 3.00, '2022-03-01 14:00:00'),
(2, 3, 'VENTA0002', 3, 'litros', 1.75, 2.10, '2022-03-02 09:30:00'),
(3, 2, 'DON0001', 1, 'metros', 3.00, 3.60, '2022-03-03 11:45:00');