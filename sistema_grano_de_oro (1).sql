-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 25-03-2023 a las 18:09:04
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_grano_de_oro`
--
CREATE DATABASE IF NOT EXISTS `sistema_grano_de_oro` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sistema_grano_de_oro`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ajuste`
--

CREATE TABLE `ajuste` (
  `id` int NOT NULL,
  `tipo_ajuste_id` int NOT NULL,
  `productos_id` int NOT NULL,
  `codigo_compra_venta` varchar(255) DEFAULT NULL,
  `cantidad` int NOT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `fecha` datetime NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `categoria` varchar(255) NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `codigo`, `categoria`, `updated`, `created`) VALUES
(1, 'Ave1', 'Avenas', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(2, 'Cho2', 'Chocolates Imperial', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(3, 'Con3', 'Condimento', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(4, 'Con4', 'Confiteria Nestle', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(5, 'Con5', 'Conservas de Pescado', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(6, 'Con6', 'Conservas Gourmet', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(7, 'Fid7', 'Fideos', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(8, 'Gal8', 'Galletas', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(9, 'Har9', 'Harina PAN', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(10, 'Har10', 'Harinas', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(11, 'Lac11', 'Lacteos', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(12, 'Nes12', 'Nestle', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(13, 'Pan13', 'Panaderia', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(14, 'Pas14', 'Pastas', '2023-03-25 16:04:05', '2023-03-25 16:04:05'),
(15, 'Rep15', 'Reposteria', '2023-03-25 16:04:05', '2023-03-25 16:04:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int NOT NULL,
  `ruc_dni` varchar(20) DEFAULT NULL,
  `razon_social_nombres` varchar(20) DEFAULT NULL,
  `telefono1` varchar(10) DEFAULT NULL,
  `telefono2` varchar(10) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `mercado` varchar(255) DEFAULT NULL,
  `giro` varchar(255) DEFAULT NULL,
  `sector` varchar(255) DEFAULT NULL,
  `distrito` varchar(20) DEFAULT NULL,
  `tipo_cliente` enum('minorista','mayorista') DEFAULT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int NOT NULL,
  `codigo` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `total_valor` decimal(10,2) NOT NULL,
  `igv` decimal(10,2) NOT NULL,
  `estado` enum('aceptado','rechazado','pendiente') NOT NULL,
  `proveedores_id` int NOT NULL,
  `vendedores_id` int NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id` int NOT NULL,
  `compras_id` int NOT NULL,
  `productos_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Disparadores `detalle_compra`
--
DELIMITER $$
CREATE TRIGGER `insert_kardex_compras` AFTER INSERT ON `detalle_compra` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `id` int NOT NULL,
  `ventas_id` int NOT NULL,
  `productos_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `insert_kardex_ventas` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE `kardex` (
  `id` int NOT NULL,
  `productos_id` int NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `fecha` datetime NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `tipo` enum('entrada','salida') NOT NULL,
  `cantidad` int NOT NULL,
  `costo_unit` decimal(10,2) NOT NULL,
  `costo_final` decimal(10,2) NOT NULL,
  `saldos_cant` int NOT NULL,
  `saldos_pu` decimal(10,2) NOT NULL,
  `saldos_pt` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id` int NOT NULL,
  `marca` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`id`, `marca`) VALUES
(1, 'Choice Peru'),
(2, 'Estrella del Cusco'),
(3, 'Gissela'),
(4, 'Gloria'),
(5, 'GN'),
(6, 'Grano de Oro'),
(7, 'La Señito'),
(8, 'MIGROS'),
(9, 'Nestle'),
(10, 'Parmalat'),
(11, 'San Jorge'),
(12, 'Sibarita'),
(13, 'Universal'),
(14, 'VIGO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_venta`
--

CREATE TABLE `pagos_venta` (
  `id` int NOT NULL,
  `ventas_id` int NOT NULL,
  `tipo_pago` enum('contado','deposito') NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha` datetime NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int NOT NULL,
  `categorias_id` int NOT NULL,
  `producto` varchar(255) NOT NULL,
  `codigo` varchar(10) DEFAULT NULL,
  `codigo2` varchar(10) DEFAULT NULL,
  `grupo` enum('Interno','Externo') DEFAULT NULL,
  `descripcion` text,
  `stock_minimo` int DEFAULT NULL,
  `stock_maximo` int DEFAULT NULL,
  `unidad_medidas_id` int NOT NULL,
  `marcas_id` int NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `categorias_id`, `producto`, `codigo`, `codigo2`, `grupo`, `descripcion`, `stock_minimo`, `stock_maximo`, `unidad_medidas_id`, `marcas_id`, `updated`, `created`) VALUES
(1, 8, 'WAFER DE VAINILLAX29G', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(2, 8, 'WAFER DE FRESAX29G', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(3, 8, 'WAFER DE CHOCOLATEX29G', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(4, 3, 'VINAGRE VENTURO TINTO 600 ML', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(5, 3, 'VINAGRE VENTURO TINTO 125X12', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(6, 3, 'VINAGRE VENTURO TINTO 1000 ML (1LT)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(7, 3, 'VINAGRE TINTO VALLE VERDE 1000X12', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(8, 3, 'VINAGRE DEL FIRME TINTO 125X12', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(9, 3, 'VINAGRE DEL FIRME TINTO 1100X13 DOY PACK', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(10, 3, 'VINAGRE DEL FIRME TINTO 1100X12 DOY PACK', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(11, 3, 'VINAGRE DEL FIRME TINTO 1000X12 BOTELLA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(12, 3, 'VINAGRE VENTURO BLANCO 600 ML', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(13, 3, 'VINAGRE VENTURO BLANCO 125X12', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(14, 3, 'VINAGRE VENTURO BLANCO 1000 ML (1LT)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(15, 3, 'VINAGRE BLANCO VALLE VERDE 1000X12', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(16, 3, 'VINAGRE DEL FIRME BLANCO 125X12 ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(17, 3, 'VINAGRE DEL FIRME BLANCO 1100X13 DOY PACK', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(18, 3, 'VINAGRE DEL FIRME BLANCO 1100X12 DOY PACK', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(19, 3, 'VINAGRE DEL FIRME BLANCO 1000X12 BOTELLA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(20, 8, 'VAINILLAX40PQTSX28GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(21, 8, 'VAINILLA X 20 PQTS X 120 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(22, 3, 'SAZONADOR TUCO TALLARIN SIB ECOX84', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(23, 3, 'SAZONADOR TUCO TALLARIN SIB GIGX42', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(24, 4, 'TRIANGULO MARMOLEADO 24 (22X30G)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(25, 4, 'TRIANGULO CLASICO 24 (22X30G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(26, 14, 'TORNILLO X 20 PAQ X 250 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(27, 7, 'TORNILLO X 20 PAQ X 250 GRS SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(28, 14, 'TALLARIN X 20 PAQ X 500 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(29, 7, 'TALLARIN X 20 PAQ X 500 GRS SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(30, 5, 'TALL de Jurel', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 3, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(31, 4, 'NESTLE SUBLIME SONRISA BLANCO 24 (20X40G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(32, 4, 'NESTLE SUBLIME SONRISA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(33, 4, 'SUBLIME GALLETA RELLENA 24 (6X46G)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(34, 4, 'SUBLIME EXTREMO 24 (15.50G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(35, 4, 'SUBLIME CLASICO 27 (24X30G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(36, 4, 'SUBLIME ANIVERSARIO 24 (20X40G)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(37, 14, 'SPAGUETTI X 20 PAQ X 500 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(38, 7, 'SPAGUETTI X 20 PAQ X 500 GR  SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(39, 8, 'SODA X 28 PQTS X 40 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(40, 8, 'SODA FAMILIAR X 20 PQTS X 85 GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(41, 8, 'SODA GOURMET 12 PACKS  X 250 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(42, 8, 'SODA CRACKERS X 30 PQTS X 40 GR SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(43, 3, 'SILLAO TITO 85MLX12 ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(44, 3, 'SILLAO TITO 500MLX12 ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(45, 3, 'SAZONADOR SIN PCTE SIB ECONOMICOX84', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(46, 3, 'SAZONADOR SIN PCTE SIB GIGANTE X42', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(47, 3, 'SAZONADOR MERIX42 ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(48, 3, 'SAZONADOR SIN PCTE SIB ECONOMICO X 84', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(49, 3, 'SAZONADOR AMARILLITO SIB GIGANTE X42', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(50, 8, 'GALLETAS SALADITAS', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(51, 8, 'SABROCHAS', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(52, 14, 'RIGATON X 20 PAQ X 250 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(53, 7, 'RIGATON X 20 PAQ X 250 GR SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(54, 8, 'RELLENITA TACOX24UNIDADES SURTIDA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(55, 8, 'RELLENITA TACOX24UNIDADES FRESA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(56, 8, 'RELLENITA TACOX24UNIDADES CHOCOLATE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(57, 8, 'RELLENITA TACOX24UNIDADES COCO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(58, 8, 'RELL. SURTIDA X 6 UNID X 40 PQTS GN', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(59, 8, 'RELL. LUC X 6UND X PQTS GN', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(60, 8, 'RELL. LIMON X 6 UNID X  40 PQTS GN', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(61, 8, 'RELL. FRESA X 6 UNID X 40 PQTS GN', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(62, 8, 'RELL. CHOCO & MENTA X 6 UNID X 40 PQTS GN', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(63, 8, 'RELL. CHOCO & FRESA X 6 UNID X 40 PQTS GN', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(64, 8, 'RELL. CHOCOLATE X 6 UNID X 40 PQTS  GN', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(65, 8, 'RELL. COCO X 6 UNID X 40 PQTS GN', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(66, 1, 'QUINUA AVENA X 170 GR GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(67, 15, 'Pudin de Vainilla por 12 und', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(68, 15, 'PUDIN VAINILLA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(69, 15, 'PUDIN SURTIDO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(70, 15, 'Pudin de Chocolate por 12 und', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(71, 15, 'PUDIN CHOCOLATE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(72, 5, 'Portola de Sardinas', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 7, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(73, 4, 'PRINCESA CHOC CAJA 24 (16.8G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(74, 4, 'PRINCESA BARRA 28 (20X30G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(75, 15, 'POLVO DE HORNEAR UNIVERSAL 36UND/25GR JARRA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(76, 15, 'POLVO DE HORNEAR UNIVERSAL 36UND/25GR DISPLAY', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(77, 14, 'PLUMITA X 20 PAQ X 250 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(78, 7, 'PLUMITA X 20 PAQ X 250 GRS SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(79, 3, 'SAZONADOR PIMIENTA MERIX68 SOBRES', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(80, 3, 'SAZONADOR PIMIENTA SIB ECOX50', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(81, 3, 'SAZONADOR PIMIENTA SIB ESTANDARX100', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(82, 3, 'PIMIENTA GIGANTE X UNIDADES', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(83, 3, 'SAZONADOR PIMIENTA CON COMINO X66', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(84, 5, 'Portola de Sardinas', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 3, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(85, 3, 'AJI PANCA SIN PICANTE SIB PANQUITAX48SOB (31GR)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(86, 13, 'PANETON GISSELA X 900GR X 6UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 3, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(87, 3, 'SAZONADOR PALILLO X84', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(88, 3, 'SAZONADOR OREGANO SIB ECO X66', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(89, 8, 'MEGA WAFER VAINILLA 61GRX16PQTS', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(90, 8, 'MEGA WAFER FRESA 61GRX16PQTS', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(91, 8, 'MEGA WAFER CHOCOLATE 61GRX16PQTS', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(92, 8, 'MUNICION X 25 BLS X 55 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(93, 8, 'MUNICION X 6 BLS X 450 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(94, 7, 'MUNICION X 20 PAQ X 250 GRS SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(95, 4, 'BOMBOM MULTIPACK (15X360G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(96, 4, 'MOROCHAS TACO 18 (6X75G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(97, 4, 'PACK DE GALLETAS MOROCHA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(98, 4, 'MOROCHAS SNACK GALLETA 8 (8X42G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(99, 8, 'RELL.X 2 SANDWICH SURTIDA X 8 BLS. X 50 PQTES', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(100, 8, 'RELL.X 2 SANDWICH FRESA X 8 BLS. X 50 PQTES.', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(101, 8, 'RELL.X 2 SANDWICH COCO X 8 BLS. X 50 PQTES.', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(102, 8, 'RELL.X 2 SANDWICH CHOCOLATE X 8 BLS. X 50 PQTES.', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 5, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(103, 15, 'MERMELADA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 4, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(104, 15, 'MAZAMORRA UNIVERSAL DURAZNO 150GR/24UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(105, 15, 'MAZAMORRA UNIVERSAL PIÑA 150GR/24UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(106, 15, 'MAZAMORRA UNIVERSAL MORADA 150GR/24UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(107, 15, 'MAZAMORRA UNIVERSAL MORADA 150GR/12UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(108, 15, 'MAZAMORRA DE PIÑA150GR/12UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(109, 15, 'MAZAMORRA UNIVERSAL DURAZNO 150GR/12UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(110, 15, 'MAICENA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(111, 14, 'MACARRON X 20 PAQ X 250 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(112, 7, 'MACARRON', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(113, 1, 'MACA AVENA X 170 GR GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(114, 7, 'LETRAS Y NUMEROS X 20 PAQ X 250 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(115, 4, 'LENTEJAS', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(116, 4, 'SUBLIME ALMENDRAS 24(15X50G)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(117, 12, 'LECHE IDEAL CREMOSITA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(118, 11, 'Leche Gloria', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 4, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(119, 11, 'Leche Condensada Lata 395 GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 10, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(120, 11, 'LECHE CONDENSADA LATA 393 GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(121, 1, 'KIWI AVENA X 170 GR GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(122, 15, 'HELADO VAINILLA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(123, 15, 'HELADO MARACUYA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(124, 15, 'HELADO LUCUMA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(125, 15, 'HELADO MARACUYA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(126, 15, 'HELADO FRESA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(127, 15, 'HELADO CHOCOLATE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(128, 15, 'HARINA DE CAMOTE 180GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(129, 10, 'HARINA PREPARADA X 1 KG X 6 UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(130, 10, 'HARINA S/P X 1KG X 6 UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(131, 10, 'HARINA S/P X 180 GRX 18 UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(132, 9, 'HARINA PAN BLANCA 1 KG', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 1, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(133, 9, 'HARINA PAN BLANCA COLOMBIANA  1 KG', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 1, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(134, 9, 'HARINA PAN BLANCA COLOMBIANA  1100 GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 1, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(135, 5, 'Grated de Sardinas', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 7, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(136, 5, 'Grated de Jurel', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 7, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(137, 5, 'Grated de Jurel', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 3, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(138, 15, 'MORADA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(139, 15, 'GELATINA UNIVERSAL UVA 150GR/12UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(140, 15, 'GELATINA UNIVERSAL SURTIDA 150GR/24UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(141, 15, 'GELATINA UNIVERSAL PIÑA 150GR/24UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(142, 15, 'GELATINA UNIVERSAL PIÑA150GR/12UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(143, 15, 'GELATINA UNIVERSAL NARANJA 150GR/24UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(144, 15, 'GELATINA UNIVERSAL NARANJA 150GR/12UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(145, 15, 'GELATINA UNIVERSAL LIMON 150GR/24UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(146, 15, 'GELATINA UNIVERSAL LIMON 150GR/12UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(147, 15, 'GELATINA LEAL PIÑA X 5KG', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(148, 15, 'GELATINA LEAL NARANJA X 5KG', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(149, 15, 'GELATINA LEAL FRESA X 5KG', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(150, 15, 'GELATINA UNIVERSAL FRESA 150GR/24UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(151, 15, 'GELATINA UNIVERSAL FRESA 150GR/12UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(152, 15, 'GELATINA UNIVERSAL DURAZNO 150GR/24UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(153, 15, 'GELATINA UNIVERSAL DURAZNO 150GR/12UND 2LT', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(154, 8, 'FRUTA MIXTA X 25 BLS X 55 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(155, 8, 'FRUTA MIXTA X 8 BLS X 450 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(156, 15, 'FLAN UNIVERSAL VAINILLA 1.5LT 150GR/24UND', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(157, 15, 'FLAN UNIVERSAL VAINILLA 1.5LT 150GR/12UND DISPLAY', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(158, 15, 'GELATINA LEAL Flan X 5KG', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(159, 5, 'Filete de Jurel', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 7, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(160, 5, 'Filete de Caballa', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 7, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(161, 5, 'Filete de Caballa', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 3, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(162, 5, 'Filete de Bonito', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 3, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(163, 5, 'Filete de Atun', NULL, NULL, 'Interno', NULL, NULL, NULL, 1, 3, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(164, 6, 'ESPARRAGO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 8, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(165, 15, 'ESCENCIA DE VAINILLAx24UND ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(166, 8, 'DUETO DOBLE SABOR A VAINILLA & MERMELADA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(167, 3, 'CULANTRITO SIBARITAX48SOB (26GR)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(168, 8, 'CRACKNEL ORIGINALE X 20 PQTS X 140 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(169, 8, 'CRACKNEL INTEGRALE X 20 PQTS X 185 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(170, 11, 'CREMA DE LECHE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 10, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(171, 3, 'SAZONADOR COMINO Y PIMIENTA MERI', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(172, 3, 'SAZONADOR COMINO MERIX68 SOBRES', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(173, 3, 'SAZONADOR COMINO SIB ECOX50', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(174, 3, 'SAZONADOR COMINO SIB ESTANDARX100', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(175, 3, 'COMINO GIGANTE X UNIDADES', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(176, 14, 'COMBO GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(177, 15, 'COLAPIZ UNIVERSAL 36UND/20GR JARRA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(178, 15, 'COLAPIZ UNIVERSAL 36 UND DISPLAY ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(179, 7, 'CODO RAYADO X 20 PAQ X 250 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(180, 14, 'CODO X 20 PAQ X 250 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(181, 2, 'COCOA ESTRELLA DEL CUSCO X 160 GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 2, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(182, 2, 'COCOA ESTRELLA DEL CUSCO 50 SOBRES X 11 GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 2, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(183, 2, 'COCOA ESTRELLA DEL CUSCO 50 SOBRES X 23 GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 2, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(184, 15, 'COCOA UNIVERSAL', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(185, 15, 'CHUÑO UNIVERSAL ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(186, 2, '', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 2, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(187, 2, 'TABLETA DE CHOCOLATE TRADICIONAL X 12', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 2, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(188, 8, 'CHOCOGOL22GRX6PQTS', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(189, 1, 'CHIA AVENA X 170 GR GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(190, 2, '', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 2, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(191, 2, '', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 2, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(192, 8, 'CHAMPS X 20 BLS X 60 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(193, 3, 'VINAGRE DEL FIRME TINTO 500X12 BOTELLA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(194, 3, 'VINAGRE DEL FIRME BLANCO 500X12 BOTELLA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(195, 8, 'COCONUT X 25 BLS X 55 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(196, 8, 'COCONUT X 8 BLS X 450 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(197, 14, 'CARACOL X 20 PAQ X 250 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(198, 7, 'CARACOL X 20 PAQ X 250 GRS SAN  JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(199, 14, 'CANUTO X 20 PAQ X 250 GRS GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(200, 7, 'CANUTO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(201, 14, 'CABELLO DE ANGEL X 20 PAQ X 250 GRS  G.O', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(202, 7, 'CABELLO DE ANGEL X 20 PAQ X 250 GRS  SAN JORGE  ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(203, 7, 'CABELLO DE ANGEL X 10 PAQ X 500 GRS  SAN JORGE  ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(204, 4, 'BOMBONES BOX 24 (20X8G)PE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(205, 8, 'BLACK OUT VAINILLA X 32 PQTS X 60 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(206, 8, 'BLACK OUT MENTA X 32 PQTS X 60 GRS SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(207, 8, 'BLACK OUT GN X 6 PQTS X 38 GRS SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(208, 8, 'BLACK OUT COCO GN X 6 PQTS X 38 GRS SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(209, 4, 'BESO DE MOSA X20', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 9, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(210, 15, 'AZUCAR IMPALPABLE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 13, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(211, 1, 'AVENA X 1 KG GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(212, 1, 'AVENA X 145 GR GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(213, 1, 'AVENA X 10 KG GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(214, 1, 'AVENA INTEGRAL X 500 GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(215, 1, 'AVENA INTEGRAL X 5KG GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(216, 1, 'AVENA X 500 GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(217, 1, 'AVENA X 5KG GRANO DE ORO', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 6, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(218, 7, 'ARITO X 20 PAQ X 250 GRS SAN JORGE ', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(219, 8, 'ANIMALITOS X 3 BLS X 1 KG SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(220, 8, 'ANIMALITOS X 20 BLS X 60 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(221, 8, 'ANIMALITOS  TREN X 4 BLS X 500 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(222, 8, 'ANIMALITOS X 10 BLS X 150 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(223, 3, 'AJI AMARILLIN PASTA SIBARITAX84 SOB ( 31GR)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(224, 6, 'ALCACHOFA', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 14, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(225, 3, 'AJOS SIBARITAX48SOB (24GR)', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(226, 8, 'AGUA SAN JORGUE X6 UNIDADES', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(227, 8, 'AGUA SAN JORGUE 20L', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(228, 8, 'AGUA SAN JORGUE X15UNIDADES', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(229, 8, 'VAINILLA GOURMET X 10 PACK X 250 GR', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(230, 8, 'AGUA CRACKERS X 10 BLS X 450 GRS SAN JORGE', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 11, '2023-03-25 16:42:04', '2023-03-25 16:42:04'),
(231, 3, 'AJI PANCA SIN PICANTE SIB PANQUITAX24', NULL, NULL, 'Externo', NULL, NULL, NULL, 1, 12, '2023-03-25 16:42:04', '2023-03-25 16:42:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int NOT NULL,
  `ruc_dni` varchar(20) DEFAULT NULL,
  `razon_social_nombres` varchar(20) DEFAULT NULL,
  `telefono1` varchar(10) DEFAULT NULL,
  `telefono2` varchar(10) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_ajuste`
--

CREATE TABLE `tipo_ajuste` (
  `id` int NOT NULL,
  `ajuste` enum('entrada','salida') NOT NULL,
  `motivo` enum('devolucion','donacion','perdida','otro') NOT NULL,
  `descripcion` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_medidas`
--

CREATE TABLE `unidad_medidas` (
  `id` int NOT NULL,
  `medida` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `unidad_medidas`
--

INSERT INTO `unidad_medidas` (`id`, `medida`) VALUES
(1, 'unid');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `cargo` enum('administrador','gerente','vendedor','usuario') NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `contrasena`, `nombre`, `apellido`, `cargo`, `activo`, `updated`, `created`) VALUES
(1, 'admin', 'admin', 'admin', 'admin', 'administrador', 1, '2023-03-25 17:00:46', '2023-03-25 17:00:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `id` int NOT NULL,
  `codigo_vendedor` int NOT NULL,
  `vendedor` varchar(255) NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`id`, `codigo_vendedor`, `vendedor`, `estado`, `updated`, `created`) VALUES
(1, 1, 'Oficina', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(2, 1, 'Ruddy', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(3, 1, 'Eduardo', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(4, 1, 'Reynaldo', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(5, 1, 'Yenny', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(6, 1, 'Xiomara', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(7, 1, 'Mariela', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(8, 1, 'Wilfredo', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(9, 1, 'Monica', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(10, 1, 'Silvana', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(11, 1, 'Volante', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(12, 1, 'Sergio', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(13, 1, 'Edsel', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(14, 1, 'Gianina', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(15, 1, 'Patty', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(16, 1, 'Julio', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(17, 1, 'Sandra', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(18, 1, 'Maricarmen', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(19, 1, 'No existe', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(20, 1, 'Enrique', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(21, 1, 'Yanhet', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(22, 1, 'Volante 2', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(23, 1, 'Saul', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(24, 1, 'Volante 3', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(25, 1, 'Fernando', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(26, 1, 'Yessica', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(27, 1, 'No existe', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(28, 1, 'No existe', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(29, 1, 'Zoyla', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(30, 1, 'Patricia', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(31, 1, 'No existe', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(32, 1, 'No existe', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36'),
(33, 1, 'Percy', 1, '2023-03-25 16:58:36', '2023-03-25 16:58:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int NOT NULL,
  `codigo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fecha` date NOT NULL,
  `total_valor` decimal(10,2) NOT NULL,
  `igv` decimal(10,2) DEFAULT NULL,
  `percepcion` decimal(10,2) DEFAULT NULL,
  `estado` enum('aceptado','rechazado','pendiente') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `clientes_id` int DEFAULT NULL,
  `vendedores_id` int NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `codigo`, `fecha`, `total_valor`, `igv`, `percepcion`, `estado`, `clientes_id`, `vendedores_id`, `updated`, `created`) VALUES
(1, '84030', '2023-03-01', 72.81, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(2, '84031', '2023-03-01', 80.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(3, '84032', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(4, '84033', '2023-03-01', 120.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(5, '84034', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(6, '84035', '2023-03-01', 112.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(7, '84036', '2023-03-01', 51.40, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(8, '84037', '2023-03-01', 75.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(9, '84038', '2023-03-01', 1047.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(10, '84039', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(11, '84040', '2023-03-01', 81.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(12, '84041', '2023-03-01', 40.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(13, '84042', '2023-03-01', 59.77, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(14, '84043', '2023-03-01', 710.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(15, '84044', '2023-03-01', 57.80, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(16, '84045', '2023-03-01', 20.40, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(17, '84046', '2023-03-01', 225.00, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(18, '84047', '2023-03-01', 128.50, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(19, '84048', '2023-03-01', 25.70, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(20, '84049', '2023-03-01', 20.00, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(21, '84050', '2023-03-01', 82.30, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(22, '84051', '2023-03-01', 40.00, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(23, '84052', '2023-03-01', 52.09, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(24, '84053', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 6, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(25, '84054', '2023-03-01', 156.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(26, '84055', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(27, '84056', '2023-03-01', 64.70, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(28, '84057', '2023-03-01', 39.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(29, '84058', '2023-03-01', 75.25, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(30, '84059', '2023-03-01', 32.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(31, '84060', '2023-03-01', 22.29, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(32, '84061', '2023-03-01', 51.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(33, '84062', '2023-03-01', 39.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(34, '84063', '2023-03-01', 108.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(35, '84064', '2023-03-01', 55.89, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(36, '84065', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(37, '84066', '2023-03-01', 76.94, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(38, '84067', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(39, '84068', '2023-03-01', 51.40, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(40, '84069', '2023-03-01', 89.80, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(41, '84070', '2023-03-01', 62.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(42, '84071', '2023-03-01', 142.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(43, '84072', '2023-03-01', 52.65, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(44, '84073', '2023-03-01', 48.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(45, '84074', '2023-03-01', 60.36, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(46, '84075', '2023-03-01', 99.85, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(47, '84076', '2023-03-01', 62.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(48, '84077', '2023-03-01', 24.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(49, '84078', '2023-03-01', 43.40, NULL, NULL, NULL, NULL, 1, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(50, '84079', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(51, '84080', '2023-03-01', 156.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(52, '84081', '2023-03-01', 68.80, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(53, '84082', '2023-03-01', 156.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(54, '84083', '2023-03-01', 468.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(55, '84084', '2023-03-01', 56.99, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(56, '84085', '2023-03-01', 108.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(57, '84086', '2023-03-01', 62.64, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(58, '84087', '2023-03-01', 770.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(59, '84088', '2023-03-01', 129.50, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(60, '84089', '2023-03-01', 176.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(61, '84090', '2023-03-01', 56.92, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(62, '84091', '2023-03-01', 124.81, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(63, '84092', '2023-03-01', 16.10, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(64, '84093', '2023-03-01', 700.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(65, '84094', '2023-03-01', 1376.36, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(66, '84095', '2023-03-01', 100.95, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(67, '84096', '2023-03-01', 209.50, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(68, '84097', '2023-03-01', 770.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(69, '84098', '2023-03-01', 530.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(70, '84099', '2023-03-01', 600.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(71, '84100', '2023-03-01', 264.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(72, '84101', '2023-03-01', 18.00, NULL, NULL, NULL, NULL, 1, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(73, '84102', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(74, '84103', '2023-03-01', 173.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(75, '84104', '2023-03-01', 156.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(76, '84105', '2023-03-01', 37.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(77, '84106', '2023-03-01', 770.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(78, '84107', '2023-03-01', 35.12, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(79, '84108', '2023-03-01', 31.83, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(80, '84109', '2023-03-01', 96.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(81, '84110', '2023-03-01', 33.33, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(82, '84111', '2023-03-01', 40.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(83, '84112', '2023-03-02', 14.25, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(84, '84113', '2023-03-02', 34.40, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(85, '84114', '2023-03-02', 213.90, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(86, '84115', '2023-03-02', 210.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(87, '84116', '2023-03-02', 17.20, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(88, '84117', '2023-03-02', 113.84, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(89, '84118', '2023-03-02', 412.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(90, '84119', '2023-03-02', 22.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(91, '84120', '2023-03-02', 116.68, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(92, '84121', '2023-03-02', 112.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(93, '84122', '2023-03-02', 37.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(94, '84123', '2023-03-02', 37.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(95, '84124', '2023-03-02', 154.69, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(96, '84125', '2023-03-02', 20.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(97, '84126', '2023-03-02', 90.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(98, '84127', '2023-03-02', 18.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(99, '84128', '2023-03-02', 293.25, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(100, '84129', '2023-03-02', 90.99, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(101, '84130', '2023-03-02', 75.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(102, '84131', '2023-03-02', 57.65, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(103, '84132', '2023-03-02', 44.38, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(104, '84133', '2023-03-02', 401.20, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(105, '84134', '2023-03-02', 45.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(106, '84135', '2023-03-02', 151.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(107, '84136', '2023-03-02', 213.90, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(108, '84137', '2023-03-02', 46.20, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(109, '84138', '2023-03-02', 41.13, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(110, '84139', '2023-03-02', 133.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(111, '84140', '2023-03-02', 46.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(112, '84141', '2023-03-02', 210.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(113, '84142', '2023-03-02', 82.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(114, '84143', '2023-03-02', 165.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(115, '84144', '2023-03-02', 49.40, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(116, '84145', '2023-03-02', 169.43, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(117, '84146', '2023-03-02', 40.08, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(118, '84147', '2023-03-02', 83.52, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(119, '84148', '2023-03-02', 144.45, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(120, '84149', '2023-03-02', 53.60, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(121, '84150', '2023-03-02', 1212.04, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(122, '84151', '2023-03-02', 83.01, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(123, '84152', '2023-03-02', 65.04, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(124, '84153', '2023-03-02', 48.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(125, '84154', '2023-03-02', 75.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(126, '84155', '2023-03-02', 192.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(127, '84156', '2023-03-02', 30.36, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(128, '84157', '2023-03-02', 39.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(129, '84158', '2023-03-02', 24.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(130, '84159', '2023-03-02', 18.75, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(131, '84160', '2023-03-02', 37.50, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(132, '84161', '2023-03-02', 38.60, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(133, '84162', '2023-03-02', 30.75, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(134, '84163', '2023-03-02', 25.80, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(135, '84164', '2023-03-02', 39.00, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(136, '84165', '2023-03-02', 57.20, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(137, '84166', '2023-03-02', 213.90, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(138, '84167', '2023-03-02', 213.90, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(139, '84168', '2023-03-02', 20.00, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(140, '84169', '2023-03-02', 22.50, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(141, '84170', '2023-03-02', 51.50, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(142, '84171', '2023-03-02', 22.27, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(143, '84172', '2023-03-02', 18.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(144, '84173', '2023-03-02', 64.64, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(145, '84174', '2023-03-02', 278.07, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(146, '84175', '2023-03-02', 101.72, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(147, '84176', '2023-03-02', 50.25, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(148, '84177', '2023-03-02', 37.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(149, '84178', '2023-03-02', 142.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(150, '84179', '2023-03-02', 83.21, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(151, '84180', '2023-03-02', 50.48, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(152, '84181', '2023-03-02', 205.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(153, '84182', '2023-03-02', 15.20, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(154, '84183', '2023-03-02', 23.98, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(155, '84184', '2023-03-02', 113.14, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(156, '84185', '2023-03-02', 159.96, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(157, '84186', '2023-03-02', 72.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(158, '84187', '2023-03-02', 156.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(159, '84188', '2023-03-02', 37.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(160, '84189', '2023-03-02', 45.30, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(161, '84190', '2023-03-02', 124.32, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(162, '84191', '2023-03-02', 59.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(163, '84192', '2023-03-02', 23.98, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(164, '84193', '2023-03-02', 28.47, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(165, '84194', '2023-03-02', 22.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(166, '84195', '2023-03-02', 213.90, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(167, '84196', '2023-03-02', 123.75, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(168, '84197', '2023-03-02', 39.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(169, '84198', '2023-03-02', 39.23, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(170, '84199', '2023-03-02', 67.28, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(171, '84200', '2023-03-02', 3220.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(172, '84201', '2023-03-02', 710.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(173, '84202', '2023-03-02', 166.75, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(174, '84203', '2023-03-02', 23.98, NULL, NULL, NULL, NULL, 8, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(175, '84204', '2023-03-02', 917.00, NULL, NULL, NULL, NULL, 8, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(176, '84205', '2023-03-02', 443.00, NULL, NULL, NULL, NULL, 8, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(177, '84206', '2023-03-02', 174.58, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(178, '84207', '2023-03-02', 87.13, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(179, '84208', '2023-03-03', 95.20, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(180, '84209', '2023-03-03', 29.70, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(181, '84210', '2023-03-03', 37.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(182, '84211', '2023-03-03', 59.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(183, '84212', '2023-03-03', 852.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(184, '84213', '2023-03-03', 71.18, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(185, '84214', '2023-03-03', 36.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(186, '84215', '2023-03-03', 47.15, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(187, '84216', '2023-03-03', 77.90, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(188, '84217', '2023-03-03', 51.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(189, '84218', '2023-03-03', 13.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(190, '84219', '2023-03-03', 48.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(191, '84220', '2023-03-03', 45.32, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(192, '84221', '2023-03-03', 36.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(193, '84222', '2023-03-03', 75.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(194, '84223', '2023-03-03', 76.55, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(195, '84224', '2023-03-03', 142.55, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(196, '84225', '2023-03-03', 166.75, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(197, '84226', '2023-03-03', 52.20, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(198, '84227', '2023-03-03', 30.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(199, '84228', '2023-03-03', 34.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(200, '84229', '2023-03-03', 22.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(201, '84230', '2023-03-03', 22.45, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(202, '84231', '2023-03-03', 300.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(203, '84232', '2023-03-03', 20.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(204, '84233', '2023-03-03', 40.10, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(205, '84234', '2023-03-03', 32.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(206, '84235', '2023-03-03', 213.90, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(207, '84236', '2023-03-03', 48.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(208, '84237', '2023-03-03', 22.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(209, '84238', '2023-03-03', 23.13, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(210, '84239', '2023-03-03', 22.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(211, '84240', '2023-03-03', 64.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(212, '84241', '2023-03-03', 134.18, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(213, '84242', '2023-03-03', 51.40, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(214, '84243', '2023-03-03', 81.95, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(215, '84244', '2023-03-03', 53.10, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(216, '84245', '2023-03-03', 321.90, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(217, '84246', '2023-03-03', 977.90, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(218, '84247', '2023-03-03', 37.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(219, '84248', '2023-03-03', 210.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(220, '84249', '2023-03-03', 210.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(221, '84250', '2023-03-03', 238.40, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(222, '84251', '2023-03-03', 45.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(223, '84252', '2023-03-03', 260.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(224, '84253', '2023-03-03', 34.40, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(225, '84254', '2023-03-03', 120.20, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(226, '84255', '2023-03-03', 45.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(227, '84256', '2023-03-03', 90.38, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(228, '84257', '2023-03-03', 375.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(229, '84258', '2023-03-03', 66.30, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(230, '84259', '2023-03-03', 375.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(231, '84260', '2023-03-03', 77.30, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(232, '84261', '2023-03-03', 40.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(233, '84262', '2023-03-03', 44.38, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(234, '84263', '2023-03-03', 20.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(235, '84264', '2023-03-03', 60.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(236, '84265', '2023-03-03', 142.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(237, '84266', '2023-03-03', 103.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(238, '84267', '2023-03-03', 31.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(239, '84268', '2023-03-03', 142.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(240, '84269', '2023-03-03', 56.10, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(241, '84270', '2023-03-03', 33.64, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(242, '84271', '2023-03-03', 34.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(243, '84272', '2023-03-03', 36.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(244, '84273', '2023-03-03', 37.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(245, '84274', '2023-03-03', 85.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(246, '84275', '2023-03-03', 142.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(247, '84276', '2023-03-03', 101.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(248, '84277', '2023-03-03', 92.26, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(249, '84278', '2023-03-03', 62.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(250, '84279', '2023-03-03', 112.50, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(251, '84280', '2023-03-03', 375.00, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(252, '84281', '2023-03-03', 123.55, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(253, '84282', '2023-03-03', 213.90, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(254, '84283', '2023-03-03', 62.50, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(255, '84284', '2023-03-03', 17.20, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(256, '84285', '2023-03-03', 62.50, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(257, '84286', '2023-03-03', 213.90, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(258, '84287', '2023-03-03', 67.50, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(259, '84288', '2023-03-03', 2095.00, NULL, NULL, NULL, NULL, 1, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(260, '84289', '2023-03-03', 98.80, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(261, '84290', '2023-03-03', 272.38, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(262, '84291', '2023-03-03', 173.93, NULL, NULL, NULL, NULL, 24, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(263, '84292', '2023-03-03', 1047.50, NULL, NULL, NULL, NULL, 1, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(264, '84293', '2023-03-03', 351.10, NULL, NULL, NULL, NULL, 1, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(265, '84294', '2023-03-03', 209.50, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(266, '84295', '2023-03-03', 964.50, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(267, '84296', '2023-03-03', 261.10, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(268, '84297', '2023-03-03', 3450.00, NULL, NULL, NULL, NULL, 8, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(269, '84298', '2023-03-03', 108.00, NULL, NULL, NULL, NULL, 22, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(270, '84299', '2023-03-03', 2.42, NULL, NULL, NULL, NULL, 8, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(271, '84300', '2023-03-03', 863.00, NULL, NULL, NULL, NULL, 8, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(272, '84301', '2023-03-04', 232.65, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(273, '84302', '2023-03-04', 38.75, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(274, '84303', '2023-03-04', 37.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(275, '84304', '2023-03-04', 17.20, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(276, '84305', '2023-03-04', 114.49, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(277, '84306', '2023-03-04', 239.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(278, '84307', '2023-03-04', 18.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(279, '84308', '2023-03-04', 39.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(280, '84309', '2023-03-04', 27.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(281, '84310', '2023-03-04', 82.79, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(282, '84311', '2023-03-04', 77.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(283, '84312', '2023-03-04', 25.05, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(284, '84313', '2023-03-04', 79.61, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(285, '84314', '2023-03-04', 20.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(286, '84315', '2023-03-04', 40.20, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(287, '84316', '2023-03-04', 76.83, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(288, '84317', '2023-03-04', 26.70, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(289, '84318', '2023-03-04', 20.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(290, '84319', '2023-03-04', 17.19, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(291, '84320', '2023-03-04', 71.10, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(292, '84321', '2023-03-04', 17.20, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(293, '84322', '2023-03-04', 75.49, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(294, '84323', '2023-03-04', 112.50, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(295, '84324', '2023-03-04', 75.00, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(296, '84325', '2023-03-04', 51.40, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(297, '84326', '2023-03-04', 58.10, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(298, '84327', '2023-03-04', 77.70, NULL, NULL, NULL, NULL, 16, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(299, '84328', '2023-03-04', 20.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(300, '84329', '2023-03-04', 89.80, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(301, '84330', '2023-03-04', 45.30, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(302, '84331', '2023-03-04', 165.40, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(303, '84332', '2023-03-04', 63.18, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(304, '84333', '2023-03-04', 32.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(305, '84334', '2023-03-04', 83.59, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(306, '84335', '2023-03-04', 39.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(307, '84336', '2023-03-04', 300.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(308, '84337', '2023-03-04', 48.15, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(309, '84338', '2023-03-04', 21.20, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(310, '84339', '2023-03-04', 66.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(311, '84340', '2023-03-04', 62.48, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(312, '84341', '2023-03-04', 142.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(313, '84342', '2023-03-04', 53.72, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(314, '84343', '2023-03-04', 58.50, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(315, '84344', '2023-03-04', 45.30, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(316, '84345', '2023-03-04', 72.70, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(317, '84346', '2023-03-04', 42.80, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(318, '84347', '2023-03-04', 111.20, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(319, '84348', '2023-03-04', 105.32, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(320, '84349', '2023-03-04', 61.12, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(321, '84350', '2023-03-04', 56.00, NULL, NULL, NULL, NULL, 13, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(322, '84351', '2023-03-04', 125.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(323, '84352', '2023-03-04', 36.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(324, '84353', '2023-03-04', 80.90, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(325, '84354', '2023-03-04', 64.30, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(326, '84355', '2023-03-04', 28.90, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(327, '84356', '2023-03-04', 37.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(328, '84357', '2023-03-04', 91.22, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(329, '84358', '2023-03-04', 20.00, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(330, '84359', '2023-03-04', 14.50, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(331, '84360', '2023-03-04', 223.17, NULL, NULL, NULL, NULL, 4, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(332, '84361', '2023-03-04', 650.80, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(333, '84362', '2023-03-04', 52.70, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(334, '84363', '2023-03-04', 105.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(335, '84364', '2023-03-04', 775.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(336, '84365', '2023-03-04', 375.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(337, '84366', '2023-03-04', 770.00, NULL, NULL, NULL, NULL, 20, '2023-03-25 18:05:33', '2023-03-25 18:05:33'),
(338, '84367', '2023-03-04', 899.00, NULL, NULL, NULL, NULL, 8, '2023-03-25 18:05:33', '2023-03-25 18:05:33');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_categorias`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_categorias` (
`categoria` varchar(255)
,`id` int
,`updated` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_clientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_clientes` (
`cliente` varchar(20)
,`direccion` varchar(255)
,`distrito` varchar(20)
,`giro` varchar(255)
,`id` int
,`mercado` varchar(255)
,`ruc_dni` varchar(20)
,`sector` varchar(255)
,`telefono` varchar(10)
,`tipo_cliente` enum('minorista','mayorista')
,`updated` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_productos` (
`abreviaturas` varchar(10)
,`abreviaturas2` varchar(10)
,`abreviaturas_producto` varchar(255)
,`grupo` enum('Interno','Externo')
,`id` int
,`marca` varchar(255)
,`nombre_corto` varchar(255)
,`tipo_producto` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_proveedores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_proveedores` (
`direccion` varchar(255)
,`id` int
,`proveedor` varchar(20)
,`ruc_dni` varchar(20)
,`telefono` varchar(10)
,`updated` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_reporte_inventario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_reporte_inventario` (
`codigo` varchar(10)
,`producto` varchar(255)
,`saldos_cant` int
,`saldos_pt` decimal(10,2)
,`saldos_pu` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_usuarios` (
`activo` tinyint(1)
,`apellido` varchar(255)
,`cargo` enum('administrador','gerente','vendedor','usuario')
,`id` int
,`nombre` varchar(255)
,`updated` timestamp
,`usuario` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_vendedores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_vendedores` (
`codigo_vendedor` int
,`estado` tinyint(1)
,`id` int
,`vendedor` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `view_categorias`
--
DROP TABLE IF EXISTS `view_categorias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_categorias`  AS SELECT `c`.`id` AS `id`, `c`.`categoria` AS `categoria`, `c`.`updated` AS `updated` FROM `categorias` AS `c` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_clientes`
--
DROP TABLE IF EXISTS `view_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_clientes`  AS SELECT `c`.`id` AS `id`, `c`.`razon_social_nombres` AS `cliente`, `c`.`ruc_dni` AS `ruc_dni`, `c`.`direccion` AS `direccion`, `c`.`sector` AS `sector`, `c`.`mercado` AS `mercado`, `c`.`giro` AS `giro`, `c`.`distrito` AS `distrito`, `c`.`tipo_cliente` AS `tipo_cliente`, `c`.`telefono1` AS `telefono`, `c`.`updated` AS `updated` FROM `clientes` AS `c` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_productos`
--
DROP TABLE IF EXISTS `view_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_productos`  AS SELECT `p`.`id` AS `id`, `p`.`codigo` AS `abreviaturas`, `c`.`categoria` AS `tipo_producto`, `m`.`marca` AS `marca`, `p`.`grupo` AS `grupo`, `p`.`producto` AS `nombre_corto`, `p`.`codigo2` AS `abreviaturas2`, `c`.`codigo` AS `abreviaturas_producto` FROM ((`productos` `p` join `categorias` `c` on((`p`.`categorias_id` = `c`.`id`))) join `marcas` `m` on((`p`.`marcas_id` = `m`.`id`))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_proveedores`
--
DROP TABLE IF EXISTS `view_proveedores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_proveedores`  AS SELECT `p`.`id` AS `id`, `p`.`ruc_dni` AS `ruc_dni`, `p`.`razon_social_nombres` AS `proveedor`, `p`.`telefono1` AS `telefono`, `p`.`direccion` AS `direccion`, `p`.`updated` AS `updated` FROM `proveedores` AS `p` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_reporte_inventario`
--
DROP TABLE IF EXISTS `view_reporte_inventario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_reporte_inventario`  AS SELECT `p`.`codigo` AS `codigo`, `p`.`producto` AS `producto`, `k`.`saldos_cant` AS `saldos_cant`, `k`.`saldos_pu` AS `saldos_pu`, `k`.`saldos_pt` AS `saldos_pt` FROM (`kardex` `k` join `productos` `p` on((`k`.`productos_id` = `p`.`id`))) WHERE `k`.`id` in (select max(`kardex`.`id`) from `kardex` group by `kardex`.`productos_id`) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_usuarios`
--
DROP TABLE IF EXISTS `view_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_usuarios`  AS SELECT `usuarios`.`id` AS `id`, `usuarios`.`usuario` AS `usuario`, `usuarios`.`nombre` AS `nombre`, `usuarios`.`apellido` AS `apellido`, `usuarios`.`cargo` AS `cargo`, `usuarios`.`activo` AS `activo`, `usuarios`.`updated` AS `updated` FROM `usuarios` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_vendedores`
--
DROP TABLE IF EXISTS `view_vendedores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_vendedores`  AS SELECT `vendedores`.`id` AS `id`, `vendedores`.`codigo_vendedor` AS `codigo_vendedor`, `vendedores`.`vendedor` AS `vendedor`, `vendedores`.`estado` AS `estado` FROM `vendedores` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ajuste`
--
ALTER TABLE `ajuste`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo_ajuste_id` (`tipo_ajuste_id`),
  ADD KEY `productos_id` (`productos_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedores_id` (`proveedores_id`),
  ADD KEY `vendedores_id` (`vendedores_id`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`id`,`compras_id`),
  ADD KEY `compras_id` (`compras_id`),
  ADD KEY `productos_id` (`productos_id`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`id`,`ventas_id`),
  ADD KEY `ventas_id` (`ventas_id`),
  ADD KEY `productos_id` (`productos_id`);

--
-- Indices de la tabla `kardex`
--
ALTER TABLE `kardex`
  ADD PRIMARY KEY (`id`,`productos_id`),
  ADD KEY `productos_id` (`productos_id`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pagos_venta`
--
ALTER TABLE `pagos_venta`
  ADD PRIMARY KEY (`id`,`ventas_id`),
  ADD KEY `ventas_id` (`ventas_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categorias_id` (`categorias_id`),
  ADD KEY `marcas_id` (`marcas_id`),
  ADD KEY `unidad_medidas_id` (`unidad_medidas_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_ajuste`
--
ALTER TABLE `tipo_ajuste`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `unidad_medidas`
--
ALTER TABLE `unidad_medidas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clientes_id` (`clientes_id`),
  ADD KEY `vendedores_id` (`vendedores_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ajuste`
--
ALTER TABLE `ajuste`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `kardex`
--
ALTER TABLE `kardex`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `pagos_venta`
--
ALTER TABLE `pagos_venta`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_ajuste`
--
ALTER TABLE `tipo_ajuste`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `unidad_medidas`
--
ALTER TABLE `unidad_medidas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ajuste`
--
ALTER TABLE `ajuste`
  ADD CONSTRAINT `ajuste_ibfk_1` FOREIGN KEY (`tipo_ajuste_id`) REFERENCES `tipo_ajuste` (`id`),
  ADD CONSTRAINT `ajuste_ibfk_2` FOREIGN KEY (`productos_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`proveedores_id`) REFERENCES `proveedores` (`id`),
  ADD CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`vendedores_id`) REFERENCES `vendedores` (`id`);

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`compras_id`) REFERENCES `compras` (`id`),
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`productos_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`ventas_id`) REFERENCES `ventas` (`id`),
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`productos_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `kardex`
--
ALTER TABLE `kardex`
  ADD CONSTRAINT `kardex_ibfk_1` FOREIGN KEY (`productos_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `pagos_venta`
--
ALTER TABLE `pagos_venta`
  ADD CONSTRAINT `pagos_venta_ibfk_1` FOREIGN KEY (`ventas_id`) REFERENCES `ventas` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`categorias_id`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`marcas_id`) REFERENCES `marcas` (`id`),
  ADD CONSTRAINT `productos_ibfk_3` FOREIGN KEY (`unidad_medidas_id`) REFERENCES `unidad_medidas` (`id`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`clientes_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`vendedores_id`) REFERENCES `vendedores` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
