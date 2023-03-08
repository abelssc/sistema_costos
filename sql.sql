CREATE DATABASE sistema_grado_de_oro;
USE sistema_grado_de_oro;

CREATE TABLE usuarios(
id INT NOT NULL AUTO_INCREMENT,
usuario varchar(255) NOT NULL,
contrasena varchar(255) NOT NULL,
nombre varchar(255) NOT NULL,
apellido varchar(255) NOT NULL,
-- CARGO Y ROL, NCESITA EDICION
cargo ENUM('administrador','gerente','vendedor','usuario') NOT NULL,
rol ENUM('administrador','gerente','vendedor','usuario') NOT NULL,  
activo BOOLEAN DEFAULT TRUE,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);
create table entidad(


);
CREATE TABLE contactos(
id INT NOT NULL auto_increment,
tipo_contacto ENUM('clientes','proveedores') NOT NULL,
tipo_entidad ENUM('natural','juridico') NOT NULL,



);
CREATE TABLE proveedores(
id INT NOT NULL AUTO_INCREMENT,
ruc varchar(20),
razon_social varchar(20),
telefono1 varchar(10),
telefono2 varchar(10),
direccion varchar(255),
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);
-- CAN BE INFORMAL
CREATE TABLE clientes(
id INT NOT NULL AUTO_INCREMENT,
ruc varchar(20),
razon_social varchar(20),
telefono1 varchar(10),
telefono2 varchar(10),
direccion varchar(255),
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);

CREATE TABLE categorias(
id INT NOT NULL AUTO_INCREMENT,
categoria varchar(255) NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);
CREATE TABLE productos(
id INT NOT NULL AUTO_INCREMENT,
categoria_id INT NOT NULL,
producto VARCHAR(255) NOT NULL,
codigo VARCHAR(10),
descripcion TEXT,
stock_minimo INT,
stock_maximo INT,
-- UNIDADES DE MEDIDA....
unidad_medida VARCHAR(20),
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
foreign key (categoria_id) references categorias(id)
);
-- COMPRAS CAN BE INFORMAL
CREATE TABLE compras(
id INT NOT NULL AUTO_INCREMENT,
codigo varchar(255),
fecha DATE NOT NULL,
total_valor DECIMAL(10,2) NOT NULL,
igv DECIMAL(10,2) NOT NULL,
estado ENUM('aceptado','rechazado','pendiente') NOT NULL,  
proveedor_id INT NOT NULL,
usuario_id INT NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);
CREATE TABLE detalle_compra(
id INT NOT NULL AUTO_INCREMENT,
compra_id INT NOT NULL,
producto_id INT NOT NULL,
cantidad INT NOT NULL,
-- UNIDADES DE MEDIDA....
unidad_medida VARCHAR(20),
-- unid sin igv
valor_unitario DECIMAL(10,2) NOT NULL,
-- unid con igv
precio_unitario DECIMAL(10,2) NOT NULL,
PRIMARY KEY(id,compra_id),
FOREIGN KEY (compra_id) REFERENCES compras(id),
FOREIGN KEY (producto_id) REFERENCES producto(id)
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
proveedor_id INT NOT NULL,
usuario_id INT NOT NULL,
updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);
CREATE TABLE detalle_venta(
id INT NOT NULL AUTO_INCREMENT,
venta_id INT NOT NULL,
producto_id INT NOT NULL,
cantidad INT NOT NULL,
-- UNIDADES DE MEDIDA....
unidad_medida VARCHAR(20),
-- unid sin igv
valor_unitario DECIMAL(10,2) NOT NULL,
-- unid con igv
precio_unitario DECIMAL(10,2) NOT NULL,
PRIMARY KEY(id,venta_id),
FOREIGN KEY (venta_id) REFERENCES compras(id),
FOREIGN KEY (producto_id) REFERENCES producto(id)
);
CREATE TABLE pagos_venta (
  id INT NOT NULL AUTO_INCREMENT,
  venta_id INT(11) NOT NULL,
  tipo_pago ENUM('contado','deposito') NOT NULL,
  monto DECIMAL(10,2) NOT NULL,
  fecha DATETIME NOT NULL,
  updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id,venta_id),
  FOREIGN KEY (id_venta) REFERENCES ventas(id)
);
-- devoluciones, traslado a otro almacen, donaciones, perdidas x robo daño caducidad  
CREATE TABLE tipo_ajuste(
id INT NOT NULL AUTO_INCREMENT,
ajuste VARCHAR(255) NOT NULL,
descripcion text NULL,
PRIMARY KEY (id)
);
CREATE TABLE ajuste (
id INT NOT NULL AUTO_INCREMENT,
tipo_ajuste_id INT NOT NULL,
producto_id INT NOT NULL,
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
FOREIGN  KEY(producto_id) REFERENCES productos(id)
);
