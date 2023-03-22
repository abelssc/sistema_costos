DROP DATABASE if exists sistema_grano_de_oro;
CREATE DATABASE sistema_grano_de_oro;
USE sistema_grano_de_oro;

CREATE TABLE usuarios(
id INT NOT NULL AUTO_INCREMENT,
usuario varchar(255) NOT NULL,
contrasena varchar(255) NOT NULL,
nombre varchar(255) NOT NULL,
apellido varchar(255) NOT NULL,
-- CARGO Y ROL, NCESITA EDICION
cargo ENUM('administrador','gerente','vendedor','usuario') NOT NULL,
activo BOOLEAN DEFAULT TRUE,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);
CREATE TABLE vendedores(
id INT NOT NULL auto_increment,
codigo_vendedor INT NOT NULL,
vendedor varchar(255) NOT NULL,
estado BOOLEAN DEFAULT TRUE,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
primary key(id)
);
CREATE TABLE proveedores(
id INT NOT NULL AUTO_INCREMENT,
ruc_dni varchar(20),
razon_social_nombres varchar(20),
telefono1 varchar(10),
telefono2 varchar(10),
direccion varchar(255),
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);

CREATE TABLE clientes(
id INT NOT NULL AUTO_INCREMENT,
ruc_dni varchar(20),
razon_social_nombres varchar(20),
telefono1 varchar(10),
telefono2 varchar(10),
direccion varchar(255),
mercado varchar(255),
giro varchar(255),
sector varchar(255),
distrito varchar(20),
tipo_cliente ENUM ('minorista','mayorista'),
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);

CREATE TABLE marcas(
id int not null auto_increment,
marca varchar(255) not null,
primary key(id)
);
CREATE TABLE categorias(
id INT NOT NULL AUTO_INCREMENT,
codigo varchar(255) NOT NULL,
categoria varchar(255) NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);
CREATE TABLE unidad_medidas(
id INT not null auto_increment,
medida varchar(20) not null,
primary key(id)
);
CREATE TABLE productos(
id INT NOT NULL AUTO_INCREMENT,
categorias_id INT NOT NULL,
producto VARCHAR(255) NOT NULL,
codigo VARCHAR(10),
codigo2 VARCHAR(10),
grupo ENUM('Interno','Externo'),
descripcion TEXT,
stock_minimo INT,
stock_maximo INT,
unidad_medidas_id INT not null,
marcas_id int not null,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
foreign key (categorias_id) references categorias(id),
foreign key(marcas_id) references marcas(id),
foreign key (unidad_medidas_id) references unidad_medidas(id)
);
-- COMPRAS CAN BE INFORMAL
CREATE TABLE compras(
id INT NOT NULL AUTO_INCREMENT,
codigo varchar(255),
fecha DATE NOT NULL,
total_valor DECIMAL(10,2) NOT NULL,
igv DECIMAL(10,2) NOT NULL,
estado ENUM('aceptado','rechazado','pendiente') NOT NULL,  
proveedores_id INT NOT NULL,
vendedores_id INT NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
FOREIGN KEY (proveedores_id) REFERENCES proveedores(id),
FOREIGN KEY (vendedores_id) REFERENCES vendedores(id)
);
CREATE TABLE detalle_compra(
id INT NOT NULL AUTO_INCREMENT,
compras_id INT NOT NULL,
productos_id INT NOT NULL,
cantidad INT NOT NULL,
-- UNIDADES DE MEDIDA....
unidad_medida VARCHAR(20),
-- unid sin igv
valor_unitario DECIMAL(10,2) NOT NULL,
-- unid con igv
precio_unitario DECIMAL(10,2) NOT NULL,
PRIMARY KEY(id,compras_id),
FOREIGN KEY (compras_id) REFERENCES compras(id),
FOREIGN KEY (productos_id) REFERENCES productos(id)
);
-- CAN BE INFORMAL
CREATE TABLE ventas(
id INT NOT NULL AUTO_INCREMENT,
codigo varchar(255),
fecha DATE NOT NULL,
-- total sin igv
total_valor DECIMAL(10,2) NOT NULL,
-- igv
igv DECIMAL(10,2) NOT NULL,
-- 
-- importe de percepcion
percepcion DECIMAL(10,2) NOT NULL,
estado ENUM('aceptado','rechazado','pendiente') NOT NULL,  
clientes_id INT NOT NULL,
vendedores_id INT NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
FOREIGN KEY (clientes_id) REFERENCES clientes(id),
FOREIGN KEY (vendedores_id) REFERENCES vendedores(id)
);
CREATE TABLE detalle_venta(
id INT NOT NULL AUTO_INCREMENT,
ventas_id INT NOT NULL,
productos_id INT NOT NULL,
cantidad INT NOT NULL,
-- UNIDADES DE MEDIDA....
unidad_medida VARCHAR(20),
-- unid sin igv
valor_unitario DECIMAL(10,2) NOT NULL,
-- unid con igv
precio_unitario DECIMAL(10,2) NOT NULL,
PRIMARY KEY(id,ventas_id),
FOREIGN KEY (ventas_id) REFERENCES ventas(id),
FOREIGN KEY (productos_id) REFERENCES productos(id)
);
CREATE TABLE pagos_venta (
  id INT NOT NULL AUTO_INCREMENT,
  ventas_id INT(11) NOT NULL,
  tipo_pago ENUM('contado','deposito') NOT NULL,
  monto DECIMAL(10,2) NOT NULL,
  fecha DATETIME NOT NULL,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id,ventas_id),
  FOREIGN KEY (ventas_id) REFERENCES ventas(id)
);
-- devoluciones, traslado a otro almacen, donaciones, perdidas x robo daño caducidad  
CREATE TABLE tipo_ajuste(
id INT NOT NULL AUTO_INCREMENT,
ajuste ENUM('entrada','salida') NOT NULL,
motivo ENUM('devolucion','donacion','perdida','otro') NOT NULL,
descripcion text,
PRIMARY KEY (id)
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

CREATE TABLE kardex(
id int not null auto_increment,
productos_id int not null,
codigo varchar(255) NOT NULL,
fecha datetime NOT NULL,
detalle varchar(255),
tipo ENUM("entrada","salida") not null,
cantidad int not null,
costo_unit decimal(10,2) not null,
costo_final decimal(10,2) not null,
saldos_cant int not null,
saldos_pu decimal(10,2) not null,
saldos_pt decimal(10,2) not null,
primary key(id,productos_id),
foreign key(productos_id) references productos(id)
);

/* 
** VISTAS
*/
--
-- PRODUCTOS
--
CREATE VIEW view_categorias as
SELECT c.id, c.categoria,c.updated
FROM categorias c;

CREATE VIEW view_productos as 
SELECT p.id,p.codigo as abreviaturas,  c.categoria as tipo_producto, m.marca,grupo,p.producto as nombre_corto,p.codigo2 as abreviaturas2,c.codigo as abreviaturas_producto 
FROM productos p 
JOIN categorias c ON p.categorias_id=c.id
JOIN marcas m ON p.marcas_id = m.id;
--
-- CONTACTOS
--
CREATE VIEW view_vendedores as
SELECT id,codigo_vendedor,vendedor,estado
FROM vendedores;

CREATE VIEW view_clientes as
SELECT c.id, c.razon_social_nombres as cliente,c.ruc_dni, c.direccion, c.sector,c.mercado,c.giro,c.distrito,c.tipo_cliente,c.telefono1,c.updated
FROM clientes c;

CREATE VIEW view_proveedores as
SELECT p.id,p.ruc_dni,p.razon_social_nombres as proveedor,p.telefono1,p.direccion,p.updated
FROM proveedores p;

--
-- OPERACIONES
--
-- COMPRAS
-- VENTAS

--
-- REPORTES
--
CREATE VIEW view_reporte_inventario as
SELECT p.codigo, p.producto,k.saldos_cant,k.saldos_pu,k.saldos_pt FROM kardex k 
JOIN productos p ON k.productos_id=p.id
WHERE k.id IN (select max(id) from kardex group by productos_id);

/* 
** TRIGGERS
*/
DROP TRIGGER IF EXISTS insert_kardex_compras;
DELIMITER //
CREATE TRIGGER insert_kardex_compras AFTER INSERT ON detalle_compra
FOR EACH ROW
BEGIN
	DECLARE proveedor_new varchar(255);
    
    DECLARE codigo_new varchar(255);
	DECLARE fecha_new date;
    
    DECLARE saldos_cant_new INT;
    DECLARE saldos_pu_new decimal(10,2);
    DECLARE saldos_pt_new decimal(10,2);
    
	SELECT p.razon_social_nombres,c.codigo,c.fecha INTO proveedor_new,codigo_new,fecha_new FROM detalle_compra dc
    JOIN  compras c ON dc.compras_id=c.id
    JOIN proveedores p ON p.id=c.proveedores_id
    WHERE dc.compras_id=NEW.compras_id
    LIMIT 1;
    
	IF (SELECT MAX(id) FROM kardex WHERE productos_id = NEW.productos_id)>0 THEN
		SELECT 
		saldos_cant+NEW.cantidad, 
		(saldos_pu*saldos_cant+NEW.cantidad*NEW.valor_unitario)/(saldos_cant+NEW.cantidad),
		(saldos_cant+NEW.cantidad) * (saldos_pu*saldos_cant+NEW.cantidad*NEW.valor_unitario)/(saldos_cant+NEW.cantidad)
		FROM kardex WHERE id = (SELECT MAX(id) FROM kardex WHERE productos_id = NEW.productos_id) INTO saldos_cant_new, saldos_pu_new, saldos_pt_new;
	ELSE 
		SET saldos_cant_new=NEW.cantidad;
        SET saldos_pu_new=NEW.valor_unitario;
        SET saldos_pt_new=saldos_cant_new*saldos_pu_new;
    END IF;
   

	INSERT INTO kardex (productos_id, codigo, fecha, detalle, tipo, cantidad, costo_unit, costo_final, 
    saldos_cant, saldos_pu, saldos_pt)
    VALUES (NEW.productos_id,codigo_new,fecha_new,CONCAT("COMPRA AL PROVEEDOR ",proveedor_new),'entrada',NEW.cantidad,NEW.valor_unitario,NEW.cantidad*NEW.valor_unitario,saldos_cant_new,saldos_pu_new,saldos_pt_new);
END//
DELIMITER ;

DROP TRIGGER IF EXISTS insert_kardex_ventas;
DELIMITER //
CREATE TRIGGER insert_kardex_ventas AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
	DECLARE cliente_new varchar(255);
    
    DECLARE codigo_new varchar(255);
	DECLARE fecha_new date;
    
    DECLARE saldos_cant_new INT;
    DECLARE saldos_pu_new decimal(10,2);
    DECLARE saldos_pt_new decimal(10,2);
    
	SELECT c.razon_social_nombres,v.codigo,v.fecha INTO cliente_new,codigo_new,fecha_new FROM detalle_venta dv
    JOIN  ventas v ON dv.ventas_id=v.id
    JOIN clientes c ON c.id=v.clientes_id
    WHERE dv.ventas_id=NEW.ventas_id
    LIMIT 1;
    
	IF (SELECT MAX(id) FROM kardex WHERE productos_id = NEW.productos_id)>0 THEN
		SELECT 
		saldos_cant-NEW.cantidad, 
		saldos_pu,
		(saldos_cant-NEW.cantidad) * (saldos_pu)
		FROM kardex WHERE id = (SELECT MAX(id) FROM kardex WHERE productos_id = NEW.productos_id) INTO saldos_cant_new, saldos_pu_new, saldos_pt_new;
	ELSE 
		SET saldos_cant_new=-NEW.cantidad;
        SET saldos_pu_new=0;
        SET saldos_pt_new=0;
    END IF;
   

	INSERT INTO kardex (productos_id, codigo, fecha, detalle, tipo, cantidad, costo_unit, costo_final, 
    saldos_cant, saldos_pu, saldos_pt)
    VALUES (NEW.productos_id,codigo_new,fecha_new,CONCAT("VENTA AL CLIENTE ",cliente_new),'salida',NEW.cantidad,saldos_pu_new,NEW.cantidad*saldos_pu_new,saldos_cant_new,saldos_pu_new,saldos_pt_new);
END//
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_kardex(IN _id int)
BEGIN
SELECT codigo,fecha,detalle,
IF(tipo='entrada',cantidad,'') as entrada_cantidad, 
IF(tipo='entrada',costo_unit,'') as entrada_costo_unit, 
IF(tipo='entrada',costo_final,'') as entrada_costo_final,
IF(tipo='salida',cantidad,'') as salida_cantidad, 
IF(tipo='salida',costo_unit,'') as salida_costo_unit, 
IF(tipo='salida',costo_final,'') as salida_costo_final,
saldos_cant,saldos_pu,saldos_pt
FROM kardex 
WHERE productos_id=_id;
END $$
DELIMITER ;

CREATE TABLE detalle_compra(
id INT NOT NULL AUTO_INCREMENT,
compras_id INT NOT NULL,
productos_id INT NOT NULL,
cantidad INT NOT NULL,
-- UNIDADES DE MEDIDA....
unidad_medida VARCHAR(20),
-- unid sin igv
valor_unitario DECIMAL(10,2) NOT NULL,
-- unid con igv
precio_unitario DECIMAL(10,2) NOT NULL,
PRIMARY KEY(id,compras_id),
FOREIGN KEY (compras_id) REFERENCES compras(id),
FOREIGN KEY (productos_id) REFERENCES productos(id)
);
/*
** INSERTS
*/

INSERT INTO usuarios (usuario, contrasena, nombre, apellido, cargo) VALUES
('admin', 'admin123', 'Administrador', 'Principal', 'administrador'),
('gerente1', 'gerente123', 'Gerente', 'Ventas', 'gerente'),
('vendedor1', 'vendedor123', 'Vendedor', 'Uno', 'vendedor'),
('usuario1', 'usuario123', 'Usuario', 'Uno', 'usuario');

INSERT INTO vendedores (codigo_vendedor, vendedor) VALUES
(1001, 'Vendedor 1'),
(1002, 'Vendedor 2'),
(1003, 'Vendedor 3');

INSERT INTO proveedores (ruc_dni, razon_social_nombres, telefono1, direccion) VALUES
('20541234567', 'Proveedor 1 SAC', '012345678', 'Av. Los Proveedores 123'),
('20551234568', 'Proveedor 2 EIRL', '012345679', 'Calle Los Proveedores 456'),
('20561234569', 'Proveedor 3 SRL', '012345680', 'Jr. Los Proveedores 789');

INSERT INTO clientes (ruc_dni, razon_social_nombres, telefono1, direccion, mercado, giro, sector, distrito, tipo_cliente) VALUES
('20123456789', 'Cliente 1 SAC', '012345678', 'Av. Los Clientes 123', 'Retail', 'Ropa', 'Textil', 'Lima', 'mayorista'),
('20134567890', 'Cliente 2 EIRL', '012345679', 'Calle Los Clientes 456', 'Comercio', 'Alimentos', 'Consumo Masivo', 'Trujillo', 'minorista'),
('20145678901', 'Cliente 3 SRL', '012345680', 'Jr. Los Clientes 789', 'Retail', 'Juguetes', 'Juguetes', 'Lima', 'mayorista');

INSERT INTO marcas (marca) VALUES
('Marca 1'),
('Marca 2'),
('Marca 3');

INSERT INTO categorias (codigo, categoria) VALUES
('CAT001', 'Categoría 1'),
('CAT002', 'Categoría 2'),
('CAT003', 'Categoría 3');

INSERT INTO unidad_medidas (medida) VALUES
('Unidad'),
('Docena'),
('Kilogramo');

INSERT INTO productos (categorias_id, producto, codigo, codigo2, grupo, descripcion, stock_minimo, stock_maximo, unidad_medidas_id, marcas_id) VALUES
(1, 'Producto 1', 'PRD001', 'PRD001-A', 'Interno', 'Descripción del producto 1', 10, 100, 1, 1),
(2, 'Producto 2', 'PRD002', 'PRD002-A', 'Externo', 'Descripción del producto 2', 5, 50, 2, 2),
(3, 'Producto 3', 'PRD003', 'PRD003-A', 'Interno', 'Descripción del producto 3', 20, 200, 3, 3);


INSERT INTO compras(codigo, fecha, total_valor, igv, estado, proveedores_id, vendedores_id)
VALUES('001', '2022-01-01', 200.00, 36.00, 'aceptado', 1, 1),
('002', '2022-02-01', 400.00, 72.00, 'rechazado', 2, 2);

INSERT INTO detalle_compra(compras_id, productos_id, cantidad, unidad_medida, valor_unitario, precio_unitario)
VALUES
(1, 1, 5, 'Unidad 1', 20.00, 23.60),
(1, 2, 10, 'Unidad 2', 15.00, 17.70),
(2, 1, 10, 'Unidad 1', 20.00, 23.60),
(2, 2, 20, 'Unidad 2', 15.00, 17.70);

INSERT INTO ventas(codigo, fecha, total_valor, igv, percepcion, estado, clientes_id, vendedores_id)
VALUES
('001', '2022-03-01', 500.00, 90.00, 9.00, 'aceptado', 1, 1),
('002', '2022-04-01', 1000.00, 180.00,18,'aceptado',2,2);

INSERT INTO detalle_venta(ventas_id, productos_id, cantidad, unidad_medida, valor_unitario, precio_unitario)
VALUES
(1, 1, 5, 'Unidad 1', 40.00, 50.60),
(1, 2, 10, 'Unidad 2', 55.00, 67.70),
(2, 1, 10, 'Unidad 1', 70.00, 83.60),
(2, 2, 20, 'Unidad 2', 85.00, 97.70);


