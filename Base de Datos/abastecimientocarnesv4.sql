-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-02-2016 a las 03:39:28
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `abastecimientocarnes`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cambiarListaGenerica`(IN cuitProveedorIngresado INT, fechaHoy Date)
BEGIN

-- Variables donde almacenar lo que nos traemos desde el SELECT
  DECLARE o_idArticulo INT;
  DECLARE fin INTEGER DEFAULT 0;
  
-- Variable para controlar el fin del bucle
  

-- El SELECT que vamos a ejecutar
  DECLARE runners_cursor CURSOR FOR 
    -- SELECT idArticulo, fechaDesde, fechaHasta, montoPrecioVenta,idTipoCliente FROM preciosventa;
SELECT idArticulo FROM articulo ;
-- Condición de salida
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;
 
  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO o_idArticulo;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
-- obtiene articulo por articulo
SELECT o_idArticulo;
set @o_idArticulo2=null;
set @o_fechaDesde2=null;
-- averiguo si hay un precio vigente para ese articulo
SELECT o_idArticulo,idArticulo, @o_idArticulo2 := idArticulo,@o_fechaDesde2 := fechaDesde FROM preciosventa where idArticulo=o_idArticulo and fechaHasta is null and idTipoCliente=1;
select @o_idArticulo2,@o_fechaDesde2;
-- obtengo precio de lista generica para ese articulo
set @precioBase:=0;
select @precioBase:=IFNULL(montoPrecioCompra,0) from precioscompra where idArticulo=o_idArticulo and fechaHasta is null and cuitProveedor=cuitProveedorIngresado;
select @precioBase;
if @precioBase is null then
	set @precioBase:=0;
end if;
if @precioBase!=0 then
  IF @o_idArticulo2 is null then
		-- si no hay un precio establecido para ese articulo reo una nueva entrada precio
		Insert into preciosventa (idArticulo,fechaDesde,idTipoCliente,montoPrecioVenta) values (o_idArticulo,fechaHoy,1,@precioBase);
  else
		if DATEDIFF(fechaHoy,@o_fechaDesde2)=0 then
			-- si ya hay un precio para la fecha actual cambio solo el precio
			update preciosventa set montoPrecioVenta=@precioBase where idArticulo=@o_idArticulo2 and idTipoCliente=1 and fechaDesde=@o_fechaDesde2;
		else
			-- si no hay un precio con la fecha actual completo fechaHasta y creo una nueva entrada precio
			update preciosventa set fechaHasta=fechaHoy where  idArticulo=@o_idArticulo2 and idTipoCliente=1 and fechaDesde=@o_fechaDesde2;
Insert into preciosventa (idArticulo,fechaDesde,idTipoCliente,montoPrecioVenta) values (@o_idArticulo2,fechaHoy,1,@precioBase);
		end if;
  end if;
end if;
  END LOOP get_runners;

  CLOSE runners_cursor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cambiarListapreciosventa`(IN idTipoClienteIngresado INT, fechaHoy Date)
BEGIN

-- Variables donde almacenar lo que nos traemos desde el SELECT
  DECLARE o_idArticulo INT;
  DECLARE fin INTEGER DEFAULT 0;
  
-- Variable para controlar el fin del bucle
  

-- El SELECT que vamos a ejecutar
  DECLARE runners_cursor CURSOR FOR 
    -- SELECT idArticulo, fechaDesde, fechaHasta, montoPrecioVenta,idTipoCliente FROM preciosventa;
SELECT idArticulo FROM articulo ;
-- Condición de salida
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;
 
  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO o_idArticulo;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
-- obtiene articulo por articulo
SELECT o_idArticulo;
set @o_idArticulo2=null;
set @o_fechaDesde2=null;
-- averiguo si hay un precio vigente para ese articulo
SELECT o_idArticulo,idArticulo, @o_idArticulo2 := idArticulo,@o_fechaDesde2 := fechaDesde FROM preciosventa where idArticulo=o_idArticulo and fechaHasta is null and idTipoCliente=idTipoClienteIngresado;
select @o_idArticulo2,@o_fechaDesde2;
-- obtengo precio de lista generica para ese articulo
set @precioBase:=0;
select @precioBase:=IFNULL(montoPrecioVenta,0) from preciosventa where idArticulo=o_idArticulo and fechaHasta is null and idTipoCliente=1;
select @precioBase;
if @precioBase is null then
	set @precioBase:=0;
end if;
if @precioBase!=0 then
select @porcentaje:=porcentajeTipoCliente from tipocliente where idTipoCliente=idTipoClienteIngresado;
  IF @o_idArticulo2 is null then
		-- si no hay un precio establecido para ese articulo reo una nueva entrada precio
		Insert into preciosventa (idArticulo,fechaDesde,idTipoCliente,montoPrecioVenta) values (o_idArticulo,fechaHoy,idTipoClienteIngresado,@precioBase*(1+@porcentaje/100));
  else
		if DATEDIFF(fechaHoy,@o_fechaDesde2)=0 then
			-- si ya hay un precio para la fecha actual cambio solo el precio
			update preciosventa set montoPrecioVenta=@precioBase*(1+@porcentaje/100) where idArticulo=@o_idArticulo2 and idTipoCliente=idTipoClienteIngresado and fechaDesde=@o_fechaDesde2;
		else
			-- si no hay un precio con la fecha actual completo fechaHasta y creo una nueva entrada precio
			update preciosventa set fechaHasta=fechaHoy where  idArticulo=@o_idArticulo2 and idTipoCliente=idTipoClienteIngresado and fechaDesde=@o_fechaDesde2;
			Insert into preciosventa (idArticulo,fechaDesde,idTipoCliente,montoPrecioVenta) values (@o_idArticulo2,fechaHoy,idTipoClienteIngresado, @precioBase*(1+@porcentaje/100));
		end if;
  end if;
end if;
  END LOOP get_runners;

  CLOSE runners_cursor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cursorTest`(IN cuitProveedorIngresado INT, fechaHoy Date)
BEGIN

-- Variables donde almacenar lo que nos traemos desde el SELECT
  DECLARE o_idArticulo INT;
  DECLARE fin INTEGER DEFAULT 0;
  
-- Variable para controlar el fin del bucle
  

-- El SELECT que vamos a ejecutar
  DECLARE runners_cursor CURSOR FOR 
    -- SELECT idArticulo, fechaDesde, fechaHasta, montoPrecioVenta,idTipoCliente FROM preciosventa;
SELECT idArticulo FROM articulo ;
-- Condición de salida
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1;
 
  OPEN runners_cursor;
  get_runners: LOOP
    FETCH runners_cursor INTO o_idArticulo;
    IF fin = 1 THEN
       LEAVE get_runners;
    END IF;
-- obtiene articulo por articulo
SELECT o_idArticulo;
set @o_idArticulo2=null;
set @o_fechaDesde2=null;
-- averiguo si hay un precio vigente para ese articulo
SELECT o_idArticulo,idArticulo, @o_idArticulo2 := idArticulo,@o_fechaDesde2 := fechaDesde FROM preciosVenta where idArticulo=o_idArticulo and fechaHasta is null and idTipoCliente=1;
select @o_idArticulo2,@o_fechaDesde2;
-- obtengo precio de lista generica para ese articulo
set @precioBase:=0;
select @precioBase:=IFNULL(montoPrecioCompra,0) from precioscompra where idArticulo=o_idArticulo and fechaHasta is null and cuitProveedor=cuitProveedorIngresado;
select @precioBase;
if @precioBase is null then
	set @precioBase:=0;
end if;
  IF @o_idArticulo2 is null then
		-- si no hay un precio establecido para ese articulo reo una nueva entrada precio
		Insert into preciosVenta (idArticulo,fechaDesde,idTipoCliente,montoPrecioVenta) values (o_idArticulo,fechaHoy,1,@precioBase);
  else
		if DATEDIFF(fechaHoy,@o_fechaDesde2)=0 then
			-- si ya hay un precio para la fecha actual cambio solo el precio
			update preciosVenta set montoPrecioVenta=@precioBase where idArticulo=@o_idArticulo2 and idTipoCliente=1 and fechaDesde=@o_fechaDesde2;
		else
			-- si no hay un precio con la fecha actual completo fechaHasta y creo una nueva entrada precio
			update preciosVenta set fechaHasta=fechaHoy where  idArticulo=@o_idArticulo2 and idTipoCliente=1 and fechaDesde=@o_fechaDesde2;
Insert into preciosVenta (idArticulo,fechaDesde,idTipoCliente,montoPrecioVenta) values (@o_idArticulo2,fechaHoy,1,@precioBase);
		end if;
  end if;
  END LOOP get_runners;

  CLOSE runners_cursor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarCompra`(IN idCompraIng long)
BEGIN
update articulo ar inner join (select * from lineadecompra lin where lin.idCompra=idCompraIng) li on li.idArticulo=ar.idArticulo set ar.stockUnidad=ar.stockUnidad-li.cantidadLineaCompra;
delete from lineadecompra where idCompraIng=idCompra;
set @pagos=0;
select @pagos:=ifnull(sum(montoPago),0) from pago where idTransaccion=idCompraIng;
update proveedor pro inner join compra com on com.cuitProveedor=pro.cuitProveedor set pro.cuentaCorrienteProveedor=pro.cuentaCorrienteProveedor+com.precioTotalCompra-@pagos where com.idCompra=idCompraIng;
delete from pago where idTransaccion=idCompraIng;
delete from compra where idCompra=idCompraIng;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarVenta`(IN idVentaIng long)
BEGIN
update articulo ar inner join (select * from lineadeventa lin where lin.idVenta=idVentaIng) li on li.idArticulo=ar.idArticulo set ar.stockUnidad=ar.stockUnidad-li.cantidadLineaVenta;
delete from lineadeventa where idVentaIng=idVenta;
set @pagos=0;
select @pagos:=ifnull(sum(montoPago),0) from pago where idTransaccion=idVentaIng;
update cliente cli inner join venta ven on cli.dniCliente=ven.dniCliente set cli.cuentaCorrienteCliente=cli.cuentaCorrienteCliente+ven.precioTotalVenta-@pagos where ven.idVenta=idVentaIng;
delete from pago where idTransaccion=idVentaIng;
delete from venta where idVenta=idVentaIng;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE IF NOT EXISTS `articulo` (
  `idArticulo` int(11) NOT NULL,
  `descripcionArticulo` varchar(45) DEFAULT NULL,
  `stockUnidad` bigint(20) DEFAULT NULL,
  `estadoArticulo` varchar(45) DEFAULT NULL,
  `pesoEstimadoArticulo` double DEFAULT NULL,
  `idCalidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`idArticulo`),
  KEY `articulo-calidad_idx` (`idCalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulofraccionamiento`
--

CREATE TABLE IF NOT EXISTS `articulofraccionamiento` (
  `idArticulo` int(11) NOT NULL,
  `idFraccionamiento` bigint(20) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`idArticulo`,`idFraccionamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calidad`
--

CREATE TABLE IF NOT EXISTS `calidad` (
  `idCalidad` int(11) NOT NULL,
  `descripcionCalidad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `dniCliente` bigint(20) NOT NULL,
  `cuitCliente` bigint(20) NOT NULL,
  `nombreCliente` varchar(45) NOT NULL,
  `apellidoCliente` varchar(45) NOT NULL,
  `direccionCliente` varchar(80) DEFAULT NULL,
  `telefonoCliente` varchar(45) DEFAULT NULL,
  `celularCliente` varchar(45) DEFAULT NULL,
  `localidadCliente` int(11) DEFAULT NULL,
  `provinciaCliente` int(11) DEFAULT NULL,
  `emailCliente` varchar(80) DEFAULT NULL,
  `razonSocialCliente` varchar(45) DEFAULT NULL,
  `estadoCliente` varchar(45) NOT NULL,
  `cuentaCorrienteCliente` double NOT NULL DEFAULT '0',
  `idTipoCliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`dniCliente`),
  KEY `cliente-tipocliente_idx` (`idTipoCliente`),
  KEY `cliente-provincia_idx` (`provinciaCliente`),
  KEY `cliente-localidad_idx` (`localidadCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE IF NOT EXISTS `compra` (
  `idCompra` bigint(25) NOT NULL,
  `precioTotalCompraCalculado` decimal(10,2) DEFAULT NULL,
  `precioTotalCompra` decimal(10,2) DEFAULT NULL,
  `fechaCompra` date DEFAULT NULL,
  `fechaEntregaCompra` date NOT NULL,
  `horaEntregaCompra` time NOT NULL,
  `fechaUPagoCompra` date DEFAULT NULL,
  `horaUPagoCompra` time DEFAULT NULL,
  `fechaVencimientoCompra` date NOT NULL,
  `estadoCompra` varchar(45) DEFAULT NULL,
  `nroRemitoCompra` varchar(45) DEFAULT NULL,
  `nroFacturaCompra` varchar(45) DEFAULT NULL,
  `cuitProveedor` bigint(20) DEFAULT NULL,
  `dniUsuario` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idCompra`),
  KEY `compra-proveedor_idx` (`cuitProveedor`),
  KEY `compra-usuario_idx` (`dniUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fraccionamiento`
--

CREATE TABLE IF NOT EXISTS `fraccionamiento` (
  `idLineaDeCompra` bigint(20) NOT NULL,
  `idFraccionamiento` bigint(20) NOT NULL,
  `cantidadFraccionamiento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idFraccionamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lineadecompra`
--

CREATE TABLE IF NOT EXISTS `lineadecompra` (
  `idLineaCompra` bigint(20) NOT NULL,
  `cantidadLineaCompra` int(11) NOT NULL,
  `observacionLineaCompra` varchar(45) DEFAULT NULL,
  `precioLineaCompra` decimal(10,2) DEFAULT NULL,
  `pesoLineaCompra` double DEFAULT NULL,
  `idArticulo` int(11) DEFAULT NULL,
  `idCompra` bigint(20) DEFAULT NULL,
  `cantidadFraccionada` int(11) DEFAULT '0',
  PRIMARY KEY (`idLineaCompra`),
  KEY `lineadecompra-compra_idx` (`idCompra`),
  KEY `lineadecompra-articulo_idx` (`idArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lineadeventa`
--

CREATE TABLE IF NOT EXISTS `lineadeventa` (
  `idLineaVenta` bigint(20) NOT NULL,
  `precioLineaVenta` decimal(10,2) DEFAULT NULL,
  `observacionLineaVenta` varchar(45) DEFAULT NULL,
  `pesoLineaVenta` double DEFAULT NULL,
  `idVenta` bigint(20) DEFAULT NULL,
  `idArticulo` int(11) DEFAULT NULL,
  `cantidadLineaVenta` int(11) DEFAULT NULL,
  PRIMARY KEY (`idLineaVenta`),
  KEY `lineaDeVenta-articulo_idx` (`idArticulo`),
  KEY `lineaDeVenta-venta_idx` (`idVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE IF NOT EXISTS `localidades` (
  `idLocalidad` int(11) NOT NULL AUTO_INCREMENT,
  `idProvincia` int(11) NOT NULL,
  `localidad` varchar(255) NOT NULL,
  PRIMARY KEY (`idLocalidad`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2383 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE IF NOT EXISTS `pago` (
  `idTransaccion` bigint(20) NOT NULL,
  `tipoTransaccion` varchar(45) DEFAULT NULL,
  `formaDePago` varchar(45) DEFAULT NULL,
  `montoPago` decimal(10,2) DEFAULT NULL,
  `fechaPago` date NOT NULL,
  `horaPago` time NOT NULL,
  `nroCheque` varchar(45) DEFAULT NULL,
  `nombreCheque` varchar(45) DEFAULT NULL,
  `bancoCheque` varchar(45) DEFAULT NULL,
  `dniUsuario` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idTransaccion`,`fechaPago`,`horaPago`),
  KEY `pago-usuario_idx` (`dniUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precioscompra`
--

CREATE TABLE IF NOT EXISTS `precioscompra` (
  `idArticulo` int(11) NOT NULL,
  `fechaDesde` date NOT NULL,
  `fechaHasta` date DEFAULT NULL,
  `cuitProveedor` bigint(20) NOT NULL,
  `montoPrecioCompra` double(8,2) NOT NULL,
  PRIMARY KEY (`idArticulo`,`cuitProveedor`,`fechaDesde`),
  KEY `preciosVenta-proveedor_idx` (`cuitProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preciosventa`
--

CREATE TABLE IF NOT EXISTS `preciosventa` (
  `idArticulo` int(11) NOT NULL,
  `fechaDesde` date NOT NULL,
  `fechaHasta` date DEFAULT NULL,
  `idTipoCliente` int(11) NOT NULL,
  `montoPrecioVenta` double(8,2) NOT NULL,
  PRIMARY KEY (`idArticulo`,`idTipoCliente`,`fechaDesde`),
  KEY `preciosCompra-tipoCliente_idx` (`idTipoCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE IF NOT EXISTS `proveedor` (
  `cuitProveedor` bigint(20) NOT NULL,
  `nombreProveedor` varchar(45) NOT NULL,
  `apellidoProveedor` varchar(45) DEFAULT NULL,
  `direccionProveedor` varchar(80) DEFAULT NULL,
  `localidadProveedor` int(11) DEFAULT NULL,
  `provinciaProveedor` int(11) DEFAULT NULL,
  `telefonoProveedor` varchar(45) DEFAULT NULL,
  `celularProveedor` varchar(45) DEFAULT NULL,
  `emailProveedor` varchar(80) DEFAULT NULL,
  `estadoProveedor` varchar(45) DEFAULT NULL,
  `cuentaCorrienteProveedor` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`cuitProveedor`),
  KEY `proveedor-provincia_idx` (`provinciaProveedor`),
  KEY `proveedor-localidad_idx` (`localidadProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

CREATE TABLE IF NOT EXISTS `provincias` (
  `idProvincia` int(11) NOT NULL AUTO_INCREMENT,
  `provincia` varchar(255) NOT NULL,
  PRIMARY KEY (`idProvincia`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipocliente`
--

CREATE TABLE IF NOT EXISTS `tipocliente` (
  `idTipoCliente` int(11) NOT NULL,
  `descripcionTipoCliente` varchar(45) NOT NULL,
  `porcentajeTipoCliente` double NOT NULL,
  PRIMARY KEY (`idTipoCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `dniUsuario` bigint(20) NOT NULL,
  `contraseña` varchar(45) NOT NULL,
  `ultimaSesion` datetime DEFAULT NULL,
  `estado` varchar(45) NOT NULL,
  `nombreUsuario` varchar(45) DEFAULT NULL,
  `apellidoUsuario` varchar(45) DEFAULT NULL,
  `direccionUsuario` varchar(80) DEFAULT NULL,
  `localidadUsuario` int(11) DEFAULT NULL,
  `provinciaUsuario` int(11) DEFAULT NULL,
  `telefonoUsuario` varchar(45) DEFAULT NULL,
  `celularUsuario` varchar(45) DEFAULT NULL,
  `emailUsuario` varchar(80) DEFAULT NULL,
  `fechaAlta` date DEFAULT NULL,
  `fechaBaja` date DEFAULT NULL,
  `fotoUsuario` varchar(90) DEFAULT NULL,
  `tipoUsuario` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`dniUsuario`),
  KEY `usuario-provincia_idx` (`provinciaUsuario`),
  KEY `usuario-localidad_idx` (`localidadUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE IF NOT EXISTS `venta` (
  `idVenta` bigint(20) NOT NULL,
  `fechaVenta` date NOT NULL,
  `horaVenta` time NOT NULL,
  `fechaEntregaVenta` date DEFAULT NULL,
  `horaEntregaVenta` time DEFAULT NULL,
  `fechaUCobroVenta` date DEFAULT NULL,
  `horaUCobroVenta` time DEFAULT NULL,
  `fechaVencimiento` date DEFAULT NULL,
  `estadoVenta` varchar(45) DEFAULT NULL,
  `precioTotalVenta` double DEFAULT NULL,
  `nroRemitoVenta` varchar(45) DEFAULT NULL,
  `nroFacturaVenta` varchar(45) DEFAULT NULL,
  `dniCliente` bigint(20) NOT NULL,
  `dniUsuario` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idVenta`),
  KEY `venta-cliente_idx` (`dniCliente`),
  KEY `venta-usuario_idx` (`dniUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `articulo-calidad` FOREIGN KEY (`idCalidad`) REFERENCES `calidad` (`idCalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente-localidad` FOREIGN KEY (`localidadCliente`) REFERENCES `localidades` (`idLocalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `cliente-provincia` FOREIGN KEY (`provinciaCliente`) REFERENCES `provincias` (`idProvincia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `cliente-tipocliente` FOREIGN KEY (`idTipoCliente`) REFERENCES `tipocliente` (`idTipoCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra-proveedor` FOREIGN KEY (`cuitProveedor`) REFERENCES `proveedor` (`cuitProveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `compra-usuario` FOREIGN KEY (`dniUsuario`) REFERENCES `usuario` (`dniUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `lineadecompra`
--
ALTER TABLE `lineadecompra`
  ADD CONSTRAINT `lineadecompra-articulo` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `lineadecompra-compra` FOREIGN KEY (`idCompra`) REFERENCES `compra` (`idCompra`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `lineadeventa`
--
ALTER TABLE `lineadeventa`
  ADD CONSTRAINT `lineaDeVenta-articulo` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `lineaDeVenta-venta` FOREIGN KEY (`idVenta`) REFERENCES `venta` (`idVenta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago-usuario` FOREIGN KEY (`dniUsuario`) REFERENCES `usuario` (`dniUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `precioscompra`
--
ALTER TABLE `precioscompra`
  ADD CONSTRAINT `preciosVenta-articulo` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `preciosventa`
--
ALTER TABLE `preciosventa`
  ADD CONSTRAINT `preciosCompra-articulo` FOREIGN KEY (`idArticulo`) REFERENCES `articulo` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `preciosCompra-tipoCliente` FOREIGN KEY (`idTipoCliente`) REFERENCES `tipocliente` (`idTipoCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `proveedor-localidad` FOREIGN KEY (`localidadProveedor`) REFERENCES `localidades` (`idLocalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `proveedor-provincia` FOREIGN KEY (`provinciaProveedor`) REFERENCES `provincias` (`idProvincia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario-localidad` FOREIGN KEY (`localidadUsuario`) REFERENCES `localidades` (`idLocalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario-provincia` FOREIGN KEY (`provinciaUsuario`) REFERENCES `provincias` (`idProvincia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta-cliente` FOREIGN KEY (`dniCliente`) REFERENCES `cliente` (`dniCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `venta-usuario` FOREIGN KEY (`dniUsuario`) REFERENCES `usuario` (`dniUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
