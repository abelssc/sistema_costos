-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-03-2023 a las 06:01:00
-- Versión del servidor: 5.7.33
-- Versión de PHP: 8.1.4

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
  `id` int(11) NOT NULL,
  `tipo_ajuste_id` int(11) NOT NULL,
  `productos_id` int(11) NOT NULL,
  `codigo_compra_venta` varchar(255) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
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
  `id` int(11) NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `categoria` varchar(255) NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `codigo`, `categoria`, `updated`, `created`) VALUES
(1, 'CAT001', 'Categoría 1', '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(2, 'CAT002', 'Categoría 2', '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(3, 'CAT003', 'Categoría 3', '2023-03-12 22:31:42', '2023-03-12 22:31:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
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

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `ruc_dni`, `razon_social_nombres`, `telefono1`, `telefono2`, `direccion`, `mercado`, `giro`, `sector`, `distrito`, `tipo_cliente`, `updated`, `created`) VALUES
(1, '20123456789', 'Cliente 1 SAC', '012345678', NULL, 'Av. Los Clientes 123', 'Retail', 'Ropa', 'Textil', 'Lima', 'mayorista', '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(2, '20134567890', 'Cliente 2 EIRL', '012345679', NULL, 'Calle Los Clientes 456', 'Comercio', 'Alimentos', 'Consumo Masivo', 'Trujillo', 'minorista', '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(3, '20145678901', 'Cliente 3 SRL', '012345680', NULL, 'Jr. Los Clientes 789', 'Retail', 'Juguetes', 'Juguetes', 'Lima', 'mayorista', '2023-03-12 22:31:42', '2023-03-12 22:31:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `codigo` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `total_valor` decimal(10,2) NOT NULL,
  `igv` decimal(10,2) NOT NULL,
  `estado` enum('aceptado','rechazado','pendiente') NOT NULL,
  `proveedores_id` int(11) NOT NULL,
  `vendedores_id` int(11) NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `codigo`, `fecha`, `total_valor`, `igv`, `estado`, `proveedores_id`, `vendedores_id`, `updated`, `created`) VALUES
(1, '001', '2022-01-01', '200.00', '36.00', 'aceptado', 1, 1, '2023-03-12 22:37:10', '2023-03-12 22:37:10'),
(2, '002', '2022-02-01', '400.00', '72.00', 'rechazado', 2, 2, '2023-03-12 22:37:10', '2023-03-12 22:37:10'),
(3, '3', '2023-03-20', '1000.00', '180.00', 'aceptado', 1, 1, '2023-03-21 04:53:31', '2023-03-21 04:53:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `id` int(11) NOT NULL,
  `compras_id` int(11) NOT NULL,
  `productos_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_compra`
--

INSERT INTO `detalle_compra` (`id`, `compras_id`, `productos_id`, `cantidad`, `unidad_medida`, `valor_unitario`, `precio_unitario`) VALUES
(1, 1, 1, 5, 'Unidad 1', '20.00', '23.60'),
(2, 1, 2, 10, 'Unidad 2', '15.00', '17.70'),
(3, 2, 1, 10, 'Unidad 1', '20.00', '23.60'),
(4, 2, 2, 20, 'Unidad 2', '15.00', '17.70'),
(20, 3, 1, 10, '20', '30.00', '40.00'),
(21, 3, 2, 20, '30', '40.00', '50.00'),
(22, 3, 3, 30, '40', '50.00', '60.00');

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
  `id` int(11) NOT NULL,
  `ventas_id` int(11) NOT NULL,
  `productos_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `valor_unitario` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`id`, `ventas_id`, `productos_id`, `cantidad`, `unidad_medida`, `valor_unitario`, `precio_unitario`) VALUES
(1, 1, 1, 5, 'Unidad 1', '40.00', '50.60'),
(2, 1, 2, 10, 'Unidad 2', '55.00', '67.70'),
(3, 2, 1, 10, 'Unidad 1', '70.00', '83.60'),
(4, 2, 2, 20, 'Unidad 2', '85.00', '97.70');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE `kardex` (
  `id` int(11) NOT NULL,
  `productos_id` int(11) NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `fecha` datetime NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `tipo` enum('entrada','salida') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costo_unit` decimal(10,2) NOT NULL,
  `costo_final` decimal(10,2) NOT NULL,
  `saldos_cant` int(11) NOT NULL,
  `saldos_pu` decimal(10,0) NOT NULL,
  `saldos_pt` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `kardex`
--

INSERT INTO `kardex` (`id`, `productos_id`, `codigo`, `fecha`, `detalle`, `tipo`, `cantidad`, `costo_unit`, `costo_final`, `saldos_cant`, `saldos_pu`, `saldos_pt`) VALUES
(1, 1, '3', '2023-03-20 00:00:00', 'COMPRA AL PROVEEDOR Proveedor 1 SAC', 'entrada', 10, '30.00', '300.00', 10, '30', '300'),
(2, 2, '3', '2023-03-20 00:00:00', 'COMPRA AL PROVEEDOR Proveedor 1 SAC', 'entrada', 20, '40.00', '800.00', 20, '40', '800'),
(3, 3, '3', '2023-03-20 00:00:00', 'COMPRA AL PROVEEDOR Proveedor 1 SAC', 'entrada', 30, '50.00', '1500.00', 30, '50', '1500');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id` int(11) NOT NULL,
  `marca` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`id`, `marca`) VALUES
(1, 'Marca 1'),
(2, 'Marca 2'),
(3, 'Marca 3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_venta`
--

CREATE TABLE `pagos_venta` (
  `id` int(11) NOT NULL,
  `ventas_id` int(11) NOT NULL,
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
  `id` int(11) NOT NULL,
  `categorias_id` int(11) NOT NULL,
  `producto` varchar(255) NOT NULL,
  `codigo` varchar(10) DEFAULT NULL,
  `codigo2` varchar(10) DEFAULT NULL,
  `grupo` enum('Interno','Externo') DEFAULT NULL,
  `descripcion` text,
  `stock_minimo` int(11) DEFAULT NULL,
  `stock_maximo` int(11) DEFAULT NULL,
  `unidad_medidas_id` int(11) NOT NULL,
  `marcas_id` int(11) NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `categorias_id`, `producto`, `codigo`, `codigo2`, `grupo`, `descripcion`, `stock_minimo`, `stock_maximo`, `unidad_medidas_id`, `marcas_id`, `updated`, `created`) VALUES
(1, 1, 'Producto 1', 'PRD001', 'PRD001-A', 'Interno', 'Descripción del producto 1', 10, 100, 1, 1, '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(2, 2, 'Producto 2', 'PRD002', 'PRD002-A', 'Externo', 'Descripción del producto 2', 5, 50, 2, 2, '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(3, 3, 'Producto 3', 'PRD003', 'PRD003-A', 'Interno', 'Descripción del producto 3', 20, 200, 3, 3, '2023-03-12 22:31:42', '2023-03-12 22:31:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `ruc_dni` varchar(20) DEFAULT NULL,
  `razon_social_nombres` varchar(20) DEFAULT NULL,
  `telefono1` varchar(10) DEFAULT NULL,
  `telefono2` varchar(10) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `ruc_dni`, `razon_social_nombres`, `telefono1`, `telefono2`, `direccion`, `updated`, `created`) VALUES
(1, '20541234567', 'Proveedor 1 SAC', '012345678', NULL, 'Av. Los Proveedores 123', '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(2, '20551234568', 'Proveedor 2 EIRL', '012345679', NULL, 'Calle Los Proveedores 456', '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(3, '20561234569', 'Proveedor 3 SRL', '012345680', NULL, 'Jr. Los Proveedores 789', '2023-03-12 22:31:42', '2023-03-12 22:31:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_ajuste`
--

CREATE TABLE `tipo_ajuste` (
  `id` int(11) NOT NULL,
  `ajuste` enum('entrada','salida') NOT NULL,
  `motivo` enum('devolucion','donacion','perdida','otro') NOT NULL,
  `descripcion` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_medidas`
--

CREATE TABLE `unidad_medidas` (
  `id` int(11) NOT NULL,
  `medida` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `unidad_medidas`
--

INSERT INTO `unidad_medidas` (`id`, `medida`) VALUES
(1, 'Unidad'),
(2, 'Docena'),
(3, 'Kilogramo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
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
(1, 'admin', 'admin123', 'Administrador', 'Principal', 'administrador', 1, '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(2, 'gerente1', 'gerente123', 'Gerente', 'Ventas', 'gerente', 1, '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(3, 'vendedor1', 'vendedor123', 'Vendedor', 'Uno', 'vendedor', 1, '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(4, 'usuario1', 'usuario123', 'Usuario', 'Uno', 'usuario', 1, '2023-03-12 22:31:42', '2023-03-12 22:31:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `id` int(11) NOT NULL,
  `codigo_vendedor` int(11) NOT NULL,
  `vendedor` varchar(255) NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`id`, `codigo_vendedor`, `vendedor`, `estado`, `updated`, `created`) VALUES
(1, 1001, 'Vendedor 1', 1, '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(2, 1002, 'Vendedor 2', 1, '2023-03-12 22:31:42', '2023-03-12 22:31:42'),
(3, 1003, 'Vendedor 3', 1, '2023-03-12 22:31:42', '2023-03-12 22:31:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `codigo` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `total_valor` decimal(10,2) NOT NULL,
  `igv` decimal(10,2) NOT NULL,
  `percepcion` decimal(10,2) NOT NULL,
  `estado` enum('aceptado','rechazado','pendiente') NOT NULL,
  `clientes_id` int(11) NOT NULL,
  `vendedores_id` int(11) NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `codigo`, `fecha`, `total_valor`, `igv`, `percepcion`, `estado`, `clientes_id`, `vendedores_id`, `updated`, `created`) VALUES
(1, '001', '2022-03-01', '500.00', '90.00', '9.00', 'aceptado', 1, 1, '2023-03-12 22:37:10', '2023-03-12 22:37:10'),
(2, '002', '2022-04-01', '1000.00', '180.00', '18.00', 'aceptado', 2, 2, '2023-03-12 22:37:10', '2023-03-12 22:37:10');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_categorias`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_categorias` (
`id` int(11)
,`categoria` varchar(255)
,`updated` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_clientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_clientes` (
`id` int(11)
,`cliente` varchar(20)
,`ruc_dni` varchar(20)
,`direccion` varchar(255)
,`sector` varchar(255)
,`mercado` varchar(255)
,`giro` varchar(255)
,`distrito` varchar(20)
,`tipo_cliente` enum('minorista','mayorista')
,`telefono` varchar(10)
,`updated` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_productos` (
`id` int(11)
,`abreviaturas` varchar(10)
,`tipo_producto` varchar(255)
,`marca` varchar(255)
,`grupo` enum('Interno','Externo')
,`nombre_corto` varchar(255)
,`abreviaturas2` varchar(10)
,`abreviaturas_producto` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_proveedores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_proveedores` (
`id` int(11)
,`ruc_dni` varchar(20)
,`proveedor` varchar(20)
,`telefono` varchar(10)
,`direccion` varchar(255)
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
,`saldos_cant` int(11)
,`saldos_pu` decimal(10,0)
,`saldos_pt` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_usuarios` (
`id` int(11)
,`usuario` varchar(255)
,`nombre` varchar(255)
,`apellido` varchar(255)
,`cargo` enum('administrador','gerente','vendedor','usuario')
,`activo` tinyint(1)
,`updated` timestamp
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_vendedores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_vendedores` (
`id` int(11)
,`codigo_vendedor` int(11)
,`vendedor` varchar(255)
,`estado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `view_categorias`
--
DROP TABLE IF EXISTS `view_categorias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_categorias`  AS SELECT `c`.`id` AS `id`, `c`.`categoria` AS `categoria`, `c`.`updated` AS `updated` FROM `categorias` AS `c``c`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_clientes`
--
DROP TABLE IF EXISTS `view_clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_clientes`  AS SELECT `c`.`id` AS `id`, `c`.`razon_social_nombres` AS `cliente`, `c`.`ruc_dni` AS `ruc_dni`, `c`.`direccion` AS `direccion`, `c`.`sector` AS `sector`, `c`.`mercado` AS `mercado`, `c`.`giro` AS `giro`, `c`.`distrito` AS `distrito`, `c`.`tipo_cliente` AS `tipo_cliente`, `c`.`telefono1` AS `telefono`, `c`.`updated` AS `updated` FROM `clientes` AS `c``c`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_productos`
--
DROP TABLE IF EXISTS `view_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_productos`  AS SELECT `p`.`id` AS `id`, `p`.`codigo` AS `abreviaturas`, `c`.`categoria` AS `tipo_producto`, `m`.`marca` AS `marca`, `p`.`grupo` AS `grupo`, `p`.`producto` AS `nombre_corto`, `p`.`codigo2` AS `abreviaturas2`, `c`.`codigo` AS `abreviaturas_producto` FROM ((`productos` `p` join `categorias` `c` on((`p`.`categorias_id` = `c`.`id`))) join `marcas` `m` on((`p`.`marcas_id` = `m`.`id`)))  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_proveedores`
--
DROP TABLE IF EXISTS `view_proveedores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_proveedores`  AS SELECT `p`.`id` AS `id`, `p`.`ruc_dni` AS `ruc_dni`, `p`.`razon_social_nombres` AS `proveedor`, `p`.`telefono1` AS `telefono`, `p`.`direccion` AS `direccion`, `p`.`updated` AS `updated` FROM `proveedores` AS `p``p`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_reporte_inventario`
--
DROP TABLE IF EXISTS `view_reporte_inventario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_reporte_inventario`  AS SELECT `p`.`codigo` AS `codigo`, `p`.`producto` AS `producto`, `k`.`saldos_cant` AS `saldos_cant`, `k`.`saldos_pu` AS `saldos_pu`, `k`.`saldos_pt` AS `saldos_pt` FROM (`kardex` `k` join `productos` `p` on((`k`.`productos_id` = `p`.`id`))) WHERE `k`.`id` in (select max(`kardex`.`id`) from `kardex` group by `kardex`.`productos_id`)  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_usuarios`
--
DROP TABLE IF EXISTS `view_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_usuarios`  AS SELECT `usuarios`.`id` AS `id`, `usuarios`.`usuario` AS `usuario`, `usuarios`.`nombre` AS `nombre`, `usuarios`.`apellido` AS `apellido`, `usuarios`.`cargo` AS `cargo`, `usuarios`.`activo` AS `activo`, `usuarios`.`updated` AS `updated` FROM `usuarios``usuarios`  ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_vendedores`
--
DROP TABLE IF EXISTS `view_vendedores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_vendedores`  AS SELECT `vendedores`.`id` AS `id`, `vendedores`.`codigo_vendedor` AS `codigo_vendedor`, `vendedores`.`vendedor` AS `vendedor`, `vendedores`.`estado` AS `estado` FROM `vendedores``vendedores`  ;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `kardex`
--
ALTER TABLE `kardex`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pagos_venta`
--
ALTER TABLE `pagos_venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_ajuste`
--
ALTER TABLE `tipo_ajuste`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `unidad_medidas`
--
ALTER TABLE `unidad_medidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
