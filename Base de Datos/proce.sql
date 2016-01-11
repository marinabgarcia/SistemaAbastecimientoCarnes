DROP PROCEDURE IF EXISTS cursorTest;
DELIMITER $$
CREATE PROCEDURE cursorTest (IN cuitProveedorIngresado INT, fechaHoy Date) BEGIN

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
DELIMITER ;

call cursorTest(77,'2015-01-15');
-- SELECT ar.idArticulo, fechaDesde, fechaHasta, montoPrecioVenta,idTipoCliente FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad left join (select * from preciosventa pre where fechaHasta is null and idTipoCliente=1 or idTipoCliente is null) pre on ar.idArticulo=pre.idArticulo;
 