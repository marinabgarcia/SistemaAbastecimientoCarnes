<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema Abastecimiento de Carnes</title>
        <%if (session.getAttribute("usuarioConectado") == null) {%>
        <script>
            location.href = 'login.jsp';
        </script> 
        <%}%>
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/home.css" rel="stylesheet">
        <!-- Roboto Font -->
        <link href="http://fonts.googleapis.com/css?family=Roboto:400,700,300,500" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="font-awesome/css/font-awesome.css">
        <link href="css/jquery.bootgrid.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/jquery.steps.css">
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <%@ include file="BarraSuperiorLateral.jspf" %>
        <div class="col-lg-10 col-md-10" style=" margin:0px; padding:0px; background-color:rgba(252,252,252,1.00)">
            <div class="col-lg-12 col-md-12" style=" background-color:rgba(249,249,249,1.00); margin:0px; border-bottom:2px inset rgba(227,227,227,1.00); padding:15px; padding-left:25px; margin-bottom:20px;">
                <small>Home > <b>Compra</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Compra a Proveedores</h4>
            </div>
            <div class="col-lg-12 col-md-12 center-block" style=" text-align:center">
                <div class="alert alert-warning" id="alertAdvertencia" style=" display: none; text-align:center">
                    <a href="#" class="close" data-dismiss="alert">×</a>
                    <strong>Advertencia!</strong> Hay deudas que han alcanzado la fecha de vencimiento estimada.
                </div>
            </div>
            <div class="row clearfix" id="alertaError" hidden style="margin-bottom: -20px; margin-top: 10px;">
                <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                <div class="col-md-6 column" style="margin-bottom: 0px;">
                    <div class="alert alert-dismissable alert-danger">
                        <button type="button" class="close" onclick="document.getElementById('alertaError').style.display = 'none';">×</button>
                        <h4>

                        </h4> <strong>Error!</strong> <p id="error"></p>
                    </div>
                </div>
                <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
            </div>
            <div class="col-md-12 col-lg-12 col-xs-12 col-sm-12" style="color: #373737;">                
                <div class="row clearfix" id="errorModificarD" hidden style="margin-bottom: -20px; margin-top: 10px;">
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                    <div class="col-md-6 column" style="margin-bottom: 0px;">
                        <div class="alert alert-dismissable alert-danger">
                            <button type="button" class="close" onclick="document.getElementById('errorModificarD').style.display = 'none';">×</button>
                            <h4>
                            </h4> <strong>Error!</strong> <p id="errorModificar"></p>
                        </div>
                    </div>
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                </div>
                <div class="row clearfix" id="alerta" hidden style="margin-bottom: -20px; margin-top: 10px;">
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                    <div class="col-md-6 column" style="margin-bottom: 0px;">
                        <div class="alert alert-dismissable alert-warning">
                            <button type="button" class="close" onclick="document.getElementById('alerta').style.display = 'none';">×</button>
                            <h4>

                            </h4> <strong>Cuidado!</strong> Debes seleccionar una casilla primero.
                        </div>
                    </div>
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                </div></div>
                <div class="col-md-12 column" style="margin-bottom: 0px;">
                    <div class="bs-example" style=" margin-bottom: 15px;">
                        <ul class="nav nav-pills">
                            <li><button onclick="btnAgregarOnclick()" type="button" role="button" class="btn btn-success btn-block" value="Agregar" style=" height: 110px; min-width: 110px"><span class="fa fa-plus fa-3x" style=" color: white; display: block;"></span>Agregar</button></li>
                            <li><button onclick="btnEliminarOnClick()" type="button" role="button" class="btn btn-danger btn-block" value="Agregar" style=" height: 110px; min-width: 110px"><span class="fa fa-times fa-3x" style=" color: white; display: block;"></span>Eliminar</button></li>
                            <li> <button onclick="btnPagarOnclick()" type="button" role="button" class="btn btn-warning btn-block" value="Agregar" style=" height: 110px; min-width: 110px"><span class="fa fa-dollar fa-3x" style=" color: white; display: block;"></span>Pagar</button></li>
                            <li> <button onclick="btnDetallesOnclick()" type="button" role="button" class="btn btn-info btn-block" value="detalles" style=" height: 110px; min-width: 110px"><span class="fa fa-search fa-3x" style=" color: white; display: block;"></span>Detalles</button></li>
                            <li><button onclick="btnFraccionarOnclick()" type="button" role="button" class="btn btn-primary btn-block" value="Agregar" style="display: none; height: 110px; min-width: 110px"><span class="fa fa-cut fa-3x" style=" color: white; display: block;"></span>Fraccionar</button></li>

                        </ul>
                    </div>
                </div>
            
            <div class="col-lg-12 col-md-12">
                <div class="table-responsive clearfix">
                    <table id="grid3" name="grid3" class="table table-striped">
                        <thead>
                            <tr>
                                <th data-column-id="cuitProveedor"  data-type="numeric" data-sortable="true">Cuit Proveedor</th>
                                <th data-column-id="proveedor" data-sortable="false">Proveedor</th>
                                <th data-column-id="idCompraS" data-formatter="idCompra" data-type="string" data-identifier="true" data-sortable="false">Id Compra</th>
                                <th data-column-id="precioTotalCompraCalculado" data-formatter="precioCalculado" data-sortable="false">Total</th>
                                <th data-column-id="precioTotalCompra" data-formatter="precio" data-sortable="false">Total Remito</th>
                                <th data-column-id="fechaEntregaCompraS" data-order="desc" data-sortable="true">Fecha Entrega</th>
                                <th data-column-id="horaEntregaCompraS" data-sortable="false">Hora Entrega</th>
                                <th data-column-id="fechaVencimientoCompraS" data-formatter="vencimiento" data-sortable="true">Fecha Vencimiento</th>
                                <th data-column-id="nroFacturaCompra" data-visible="false">Factura</th>
                                <th data-column-id="nroRemitoCompra" data-visible="false">Remito</th>
                                <th data-column-id="fechaUPagoCompra" data-visible="false">Fecha Pago</th>
                                <th data-column-id="horaUPagoCompra" data-visible="false">Hora Pago</th>
                                <th data-column-id="estadoCompra" data-formatter="quantity" data-sortable="true">Estado</th>

                            </tr>
                        </thead>                 
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-12 column">
            <div class="modal bs-example-modal-lg" id="agregarVentana" tabindex="-1" data-backdrop="static"  aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" style=" min-width: 60%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Compra
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12 column"> 
                                <form id="formPrincipal" onsubmit="agregarCompra();
                                        return false;">
                                    <div id="datosProveedor">
                                        <div class="col-md-7 column col-lg-7 col-xs-12 col-sm-12">
                                            <div class="form-group">
                                                <label for="idmenu">Proveedor:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-truck"></span></span> 
                                                    <select required class="form-control" id="cuitProveedor1" name="cuitProveedor1" onchange="document.getElementById('cuitProveedor').value = document.getElementById('cuitProveedor1').value;
                                                            $('#grid').bootgrid('reload');" style="font-size:20px; height: 40px;">
                                                    </select>
                                                    <input class="form-control" hidden id="cuitProveedor" name="cuitProveedor" style="font-size:20px; height: 40px; display: none">
                                                </div>
                                            </div>  
                                        </div>                               
                                        <div class="col-md-5 column col-lg-5 hidden-xs hidden-sm" style=" text-align: center; margin: 0px; padding: 0px;">
                                            <div style="">
                                                <img id="imagenArticulo" src="imagenes/proveedor2.png" style="width: 30%;text-align: center;"/>                                           
                                            </div> 
                                        </div>
                                    </div>
                                    <div  class="col-md-12 column" style=" margin-top: 20px;"> 
                                        <div id="divIdCompra" class="col-md-12 column" style="">
                                            <div class="form-group">
                                                <label for="nombre" style=" font-size: 15px;">Id Compra:</label>                                            
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                                    <input readonly type="text" class="form-control" id="idCompra" name="idCompra"/>
                                                </div>                
                                            </div>  
                                        </div>
                                        <div id="datosCompra">
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Número de Factura:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                                        <input type="text" class="form-control" id="nroFacturaCompra" name="nroFacturaCompra"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Número de Remito:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                                        <input type="text" class="form-control" id="nroRemitoCompra" name="nroRemitoCompra"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style=""> 
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Fecha Entrega:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                        <input type="date" class="form-control" id="fechaHoy" name="fechaHoy"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Hora Entrega:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                        <input type="time" class="form-control" id="horaHoy" name="horaHoy"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divFechaVencimientoCompra" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Fecha Vencimiento:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                        <input readonly type="date" class="form-control" id="fechaVencimientoCompra" name="fechaVencimientoCompra"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                            <div id="divEstadoCompra" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Estado:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-flag"></span></span>
                                                        <input readonly type="text" class="form-control" id="estadoCompra" name="estadoCompra"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                            <div id="divFechaUPagoCompra" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Fecha Ultimo Pago:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                        <input readonly type="date" class="form-control" id="fechaUPagoCompra" name="fechaUPagoCompra"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                            <div id="divHoraUPagoCompra" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Hora Ultimo Pago:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                        <input readonly type="time" class="form-control" id="horaUPagoCompra" name="horaUPagoCompra"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <form id="formAgregarArt" style="text-align: center;" >
                                    <div id="divAgregarArticulo" class="col-md-12 column" style="background-color:rgba(252,252,252,1.00); padding: 15px; padding-bottom: 25px">
                                        <h4 style=" margin: 15px;">Artículos comprados</h4>
                                        <div class="col-md-9 column" style="text-align: center; margin: 0px; padding: 0px;">

                                            <div class="col-md-4 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Id Artículo:</label>
                                                    <div class="input-group">
                                                        <input type="number" required class="form-control" id="idArticulo" onchange="cambiarDescripcion()" name="idArticulo"/>
                                                        <span onclick="$('#ventanaDetalle').modal('show');" class="boton input-group-addon btn-default"><span class="glyphicon glyphicon-search"></span></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-8 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Descripcion:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class=" fa fa-pencil"></span></span>
                                                        <input type="text" required readonly tabindex="-1" class="form-control" id="descripcionArticulo" name="descripcionArticulo"/>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Peso:</label>
                                                    <div class="input-group">                                                           
                                                        <input required type="number" min="0.1" step='any' class="form-control" id="pesoLineaCompra" name="pesoLineaCompra"/>
                                                        <span class="input-group-addon">kg</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-8 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Calidad:</label>
                                                    <div class="input-group">  
                                                        <span class="input-group-addon"><span class=" fa fa-star"></span></span>                                                         
                                                        <input type="text" readonly tabindex="-1" class="form-control" id="calidadArticulo" name="calidadArticulo"/>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style="display: none">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Cantidad en unidades:</label>
                                                    <div class="input-group">

                                                        <input type="number" value="0" class="form-control" id="cantidadLineaCompra" name="cantidadLineaCompra"/>
                                                        <span class="input-group-addon">u</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 column" style="text-align: center;">
                                                <div class="form-group" style="clear: both;">
                                                    <label for="direccion" class="col-sm-3 control-label" style=" font-size: 15px; padding-right: 25px">Observación:</label>
                                                    <div class="col-sm-9">
                                                        <textarea class="form-control" id="observacionLineaCompra" name="observacionLineaCompra"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3 column" style="text-align: center; vertical-align: middle; padding-top:15px;">
                                            <div class="form-group" style="text-align: center; vertical-align: middle;">                                                   
                                                <button type="submit" class="btn btn-success btn-block" style=" height: 80px">Agregar Artículo</button>
                                            </div>
                                        </div>
                                    </div>
                                    <form id="formF">
                                        <div class="col-md-12" style="">
                                            <div class="table-responsive clearfix">
                                                <table id="grid2" name="grid2" class="table table-hover table-striped" >
                                                    <thead>
                                                        <tr>
                                                            <th data-column-id="idArticulo" data-identifier="true" data-order="asc" data-header-css-class="commandIdArticulo" data-type="numeric">Id Artículo</th>
                                                            <th data-column-id="descripcionArticulo" >Descripcion</th>
                                                            <th data-column-id="descripcionCalidad" >Calidad</th>
                                                            <th id="precioCompra" data-column-id="precioCompra" data-formatter="precio">Precio kg</th>
                                                            /<!--<th data-column-id="cantidadLineaCompra" data-formatter="unidad" data-header-css-class="commandIdArticulo">Unidades</th>-->
                                                            <th data-column-id="pesoLineaCompra" data-formatter="peso" data-header-css-class="commandIdArticulo">Peso</th>
                                                            <th data-column-id="precioLineaCompra" data-formatter="precioLinea">Total</th>
                                                            <th data-column-id="observacionLineaCompra" data-visible="false">Observacion</th>
                                                            <th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn"></th>
                                                            <th data-column-id="idLineaCompraS" data-visible="false">idLineaCompra</th>
                                                            <th data-column-id="cantidadFraccionada" data-visible="false">Cantidad Fraccionada</th>
                                                            <!--<th data-column-id="idFraccionamiento">Fraccionamiento</th>-->
                                                        </tr>
                                                    </thead>  
                                                </table>
                                            </div>
                                        </div>
                                        <div id="referencia" class="col-md-6 pull-left" style=" display: none; margin-top: 40px">
                                            <dl class="dl-horizontal">
                                                <dt><i class="fa fa-stop fa-2x" style=" color: #d0e9c6"></i></dt>
                                                <dd>Artículos que pueden ser fraccionados.</dd>
                                                <dt><i class="fa fa-stop fa-2x" style=" color: #faf2cc"></i></dt>
                                                <dd>Artículos que han derivado del fraccionamiento del precedente coloreado en verde</dd>
                                            </dl>
                                        </div>
                                    </form>
                                    <div class="col-md-4 column pull-right" style=" text-align:right; margin-bottom: 10px">
                                        <div class="form-group" style=" text-align:right">
                                            <label for="idmenu">Total Calculado:</label>
                                            <div class="input-group pull-right" style=" text-align:right">
                                                <span class="input-group-addon "><span class='fa fa-money'></span></span> 
                                                <input readonly type=number step="any" class="form-control" id="totalCompraCalculado" name="totalCompraCalculado" style="font-size:20px; height: 40px; ">
                                            </div>
                                        </div> 
                                    </div>
                                    <div id="divTotalCompraRemito" class="col-md-4 column pull-right" style=" text-align:right; margin-bottom: 10px">
                                        <div class="form-group" style=" text-align:right">
                                            <label for="idmenu">Total Remito</label>
                                            <div class="input-group pull-right" style=" text-align:right">
                                                <span class="input-group-addon "><span class='fa fa-money'></span></span> 
                                                <input readonly type=number step="any" class="form-control" id="totalCompraRemito" name="totalCompraRemito" style="font-size:20px; height: 40px; ">
                                            </div>
                                        </div> 
                                    </div>
                                    <input id="accion" name="accion" type="text" hidden />                 
                            </div>
                        </div>
                        <div class="modal-footer" style=" clear: both;">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Volver</button> 
                            <button type="button" id="btnGuardarCompra" class="btn btn-primary" onclick="validar();">Guardar compra</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 column">
            <div class="modal fade" id="ventanaDetalle" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel">
                                Articulos
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12" style="">
                                <div class="table-responsive clearfix">
                                    <table id="grid" class="table table-condensed table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th data-column-id="idArticulo" data-identifier="true" data-header-css-class="commandIdArticulo" data-type="numeric">Id Artículo</th>
                                                <th data-column-id="descripcionArticulo" data-order="asc">Descripción</th>
                                                <th data-column-id="descripcionCalidad">Calidad</th>
                                                <th data-column-id="quantity" data-formatter="quantity">Precio</th>
                                                <th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn"></th>
                                            </tr>
                                        </thead>                 
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="clear: both">
                            <button type="button" class="btn btn-default" onclick="$('#agregarVentana').modal('hide');
                                    $('#ventanaDetalle').modal('hide');

                                    setTimeout(function () {
                                        $('#agregarVentana').modal('show')
                                    }, 600);">Volver</button> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 column">
            <!--<a id="modal-748572" href="#ventanaDetallePrecio" role="button" class="btn" data-toggle="modal">Launch demo modal</a>-->

            <div class="modal fade" id="ventanaDetallePrecio" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Precio
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group" style=" margin-bottom: 50px;">                                                               
                                <label class="control-label col-xs-2" for="exampleInputPassword1">Artículo</label>
                                <div class="col-xs-10">                        
                                    <input class="form-control" readonly id="idArticulo2">  
                                </div>
                            </div>
                            <h4>Precios vigentes de Compra a proveedor</h4>
                            <div class="table-responsive clearfix">
                                <table id="gridPrecioCompra" class="table table-condensed table-hover table-striped">
                                    <thead>
                                        <tr>

                                            <th data-column-id="cuitProveedor" data-order="asc">Cuit</th>
                                            <th data-column-id="nombreProveedor">Proveedor</th>
                                            <th data-column-id="quantity" data-formatter="quantity">Precio</th>
                                        </tr>
                                    </thead>                 
                                </table>
                            </div>
                            <h4>Precios vigentes de Venta a cliente</h4>
                            <div class="table-responsive clearfix">
                                <table id="gridPrecioVenta" class="table table-condensed table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th data-column-id="idTipoCliente" data-order="asc">Id Tipo Cliente</th>
                                            <th data-column-id="descripcionTipoCliente">Tipo Cliente</th>
                                            <th data-column-id="quantity" data-formatter="quantity">Precio</th>
                                        </tr>
                                    </thead>                 
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer" style=" clear: both;">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 column">
            <div class="modal fade" id="ventanaConfirmacion" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel">
                                Confirmar Compra
                            </h4>
                        </div>
                        <form id="formConfirmar" onsubmit="agregarCompraConfirmacion();
                                return false;">
                            <div class="modal-body">
                                <div class="col-md-12 column" style="margin-bottom: 10px">
                                    <p id="montoTotalConfirmado">
                                        Coincide con el monto calculado con el monto descripto en el remito recibido?
                                    </p>

                                </div>

                                <div class="col-md-6 column" style="margin-bottom: 10px">

                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <label><input type="radio" id='si' name="group1" value="si" checked onchange='cambiarRadio()'> Si</label>
                                        </span>
                                        <input readonly type=number step="any" class="form-control" id="totalCalculadoCompra" name="totalCalculadoCompra" style="font-size:20px; height: 40px; ">

                                    </div>

                                </div>
                                <div class="col-md-6 column" style="margin-bottom: 10px">

                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <label> <input type="radio" id='no' name="group1" value="no" onchange='cambiarRadio()'> No</label>
                                        </span>
                                        <input readonly type=number step="any" class="form-control" id="totalCompraRemitoR" name="totalCompraRemitoR"  style="font-size:20px; height: 40px; ">
                                    </div>

                                </div>


                            </div>
                            <div class="modal-footer" style=" clear: both">
                                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="$('#agregarVentana').modal('hide');
                                        $('#ventanaConfirmacion').modal('hide');

                                        setTimeout(function () {
                                            $('#agregarVentana').modal('show')
                                        }, 700);">Volver</button> 
                                <button type="submit" class="btn btn-danger">Aceptar</button>
                            </div>
                        </form>
                    </div>

                </div>

            </div>

        </div>
        <div class="col-md-12 column">


            <div class="modal fade bs-example-modal-lg" id="ventanaPagos" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" style=" min-width: 60%;">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Realizar Pago
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12 column"> 
                                <div class="col-md-12 column col-lg-12 col-xs-12 col-sm-12">
                                    <div class="form-group">
                                        <label for="idmenu">Proveedor:</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><span class="fa fa-truck"></span></span> 

                                            <input readonly class="form-control"  id="cuitProveedorP" name="cuitProveedorP" style="font-size:20px; height: 40px;">
                                        </div>
                                    </div>  
                                </div>                               

                                <div  class="col-md-12 column" style=" margin-top: 20px;"> 
                                    <div id="divIdCompra" class="col-md-12 column" style="">
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Id Compra:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                                <input readonly type="text" class="form-control" id="idCompraP" name="idCompraP"/>
                                            </div>                
                                        </div>  
                                    </div>
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Número de Factura:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                                <input readonly="" type="text" class="form-control" id="nroFacturaCompraP" name="nroFacturaCompraP"/>
                                            </div>                
                                        </div>  
                                    </div>
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Número de Remito:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                                <input readonly type="text" class="form-control" id="nroRemitoCompraP" name="nroRemitoCompraP"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 column" style=""> 
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Fecha Entrega:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                <input readonly type="date" class="form-control" id="fechaHoyP" name="fechaHoyP"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Hora Entrega:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                <input readonly type="time" class="form-control" id="horaHoyP" name="horaHoyP"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="divFechaVencimientoCompra" class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Fecha Vencimiento:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                <input readonly type="date" class="form-control" id="fechaVencimientoCompraP" name="fechaVencimientoCompraP"/>
                                            </div>                
                                        </div>  
                                    </div>
                                    <div id="divEstadoCompra" class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Estado:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-flag"></span></span>
                                                <input readonly type="text" class="form-control" id="estadoCompraP" name="estadoCompraP"/>
                                            </div>                
                                        </div>  
                                    </div>
                                    <div id="divFechaUPagoCompra" class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Fecha Ultimo Pago:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                <input readonly type="date" class="form-control" id="fechaUPagoCompraP" name="fechaUPagoCompraP"/>
                                            </div>                
                                        </div>  
                                    </div>
                                    <div id="divHoraUPagoCompra" class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Hora Ultimo Pago:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                <input readonly type="time" class="form-control" id="horaUPagoCompraP" name="horaUPagoCompraP"/>
                                            </div>                
                                        </div>  
                                    </div>
                                </div>                                    
                                <div class="col-md-12" style="">
                                    <div class="table-responsive clearfix">
                                        <table id="gridPagos" name="gridPagos" class="table table-hover table-striped" >
                                            <thead>
                                                <tr>
                                                    <th data-column-id="idTransaccion" data-visible="false" data-sortable="true" data-identifier="true" data-order="asc" data-header-css-class="commandIdArticulo" data-type="numeric">Id Transaccion</th>
                                                    <th data-column-id="tipoTransaccion" data-visible="false" data-sortable="false">Tipo transaccion</th>
                                                    <th data-column-id="formaDePago" data-sortable="true">Forma de Pago</th>
                                                    <th data-column-id="montoPago" data-formatter="precio" data-sortable="true">Monto</th>
                                                    <th data-column-id="fechaPagoS"  data-sortable="true">Fecha</th>
                                                    <th data-column-id="horaPagoS" data-sortable="false">Hora</th>
                                                    <th data-column-id="nroCheque" data-sortable="false">Cheque</th>
                                                    <th data-column-id="bancoCheque" data-sortable="false">Banco</th>
                                                    <th data-column-id="nombreCheque" data-sortable="false">Nombre</th>
                                                    <th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn"></th>

                                                </tr>

                                            </thead>  

                                        </table>
                                    </div>
                                </div>
                                <div class="col-md-4 column" style=" text-align:right; margin-bottom: 10px">
                                    <div class="form-group" style=" text-align:right">
                                        <label for="idmenu">Total Compra:</label>
                                        <div class="input-group pull-right" style=" text-align:right">
                                            <span class="input-group-addon "><span class='fa fa-money'></span></span> 
                                            <input readonly type=number step="any" class="form-control" id="totalCompraRemitoP" name="totalCompraRemitoP" style="font-size:20px; height: 40px; ">
                                        </div>
                                    </div> 
                                </div>
                                <div id="divTotalCompraRemito" class="col-md-4 column" style=" text-align:right; margin-bottom: 10px">
                                    <div class="form-group" style=" text-align:right">
                                        <label for="idmenu">Total Pagado:</label>
                                        <div class="input-group pull-right" style=" text-align:right">
                                            <span class="input-group-addon "><span class='fa fa-money'></span></span> 
                                            <input readonly type=number step="any" class="form-control" id="totalPagado" name="totalPagado" style="font-size:20px; height: 40px; ">
                                        </div>
                                    </div> 
                                </div>
                                <div id="divTotalCompraRemito" class="col-md-4 column" style=" text-align:right; margin-bottom: 10px">
                                    <div class="form-group" style=" text-align:right">
                                        <label for="idmenu">Total Adeudado:</label>
                                        <div class="input-group pull-right" style=" text-align:right">
                                            <span class="input-group-addon "><span class='fa fa-money'></span></span> 
                                            <input readonly type=number step="any" class="form-control" id="totalAdeudado" name="totalAdeudado" style="font-size:20px; height: 40px; ">
                                        </div>
                                    </div> 
                                </div>

                                </form>

                                <input id="accion" name="accion" type="text" hidden />                 
                            </div>
                        </div>
                        <div class="modal-footer" style="clear: both">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> 
                            <button id="btnNuevoPago" type="button" class="btn btn-primary" onclick="$('#ventanaRealizarPago').modal('toggle');
                                    nuevoPago();">Nuevo Pago</button>
                        </div>
                    </div>

                </div>

            </div>

        </div>
        <div class="col-md-12 column">
            <div class="modal fade" id="ventanaRealizarPago" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Realizar Pago
                            </h4>
                        </div> 
                        <form id="formPago" name="formPago" onsubmit="guardarPagoOnClick();
                                return false;"> 
                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="idmenu">Forma de Pago:</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span> 
                                            <select required class="form-control" id="formaDePago" name="formaDePago" style="font-size:20px; height: 40px;"
                                                    onchange="if (document.getElementById('formaDePago').value == 'Cheque') {
                                                                document.getElementById('infoCheque').style.display = 'inline';
                                                            }
                                                            else {
                                                                document.getElementById('infoCheque').style.display = 'none';
                                                            }">
                                                <option value="Efectivo">Efectivo</option>
                                                <option value="Cheque">Cheque</option>
                                                <option value="Tarjeta">Tarjeta</option>
                                            </select>

                                        </div>
                                    </div>  
                                    <div class="col-md-6 column" style=""> 
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Fecha Pago:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <input required  type="date" class="form-control" id="fechaPago" name="fechaHoyP"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Hora Pago:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <input required type="time" step="any" class="form-control" id="horaPago" name="horaHoyP"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Monto Pago:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <input required type="number" step='any' class="form-control" id="montoPago" name="montoPago"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="infoCheque" style="display: none">
                                        <div class="col-md-6 column" style=""> 
                                            <div class="form-group">
                                                <label for="apellido" style=" font-size: 15px;">Número de Cheque:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                    <input type="text" class="form-control" id="nroCheque" name="nroCheque"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="apellido" style=" font-size: 15px;">Banco:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                    <input type="text" class="form-control" id="bancoCheque" name="bancoCheque"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12 column" style="">
                                            <div class="form-group">
                                                <label for="apellido" style=" font-size: 15px;">Nombre:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                    <input type="text" class="form-control" id="nombreCheque" name="nombreCheque"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div> 

                            </div>
                            <div class="modal-footer" style="clear: both">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
                                <button type="submit" class="btn btn-primary" onclick="">Aceptar</button>
                            </div></form>
                    </div>

                </div>

            </div>

        </div>
        <div class="col-md-12 column">
            <div class="modal fade" id="ventanaEliminar" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Eliminar Compra
                            </h4>
                        </div>
                        <div class="modal-body">
                            <big>Se eliminaran los siguientes elementos relacionados con la compra elegida:</big>
                            <dl class="dl-horizontal">
                                <dt>Compra</dt>
                                <dd>Datos relacionados a la compra.</dd>
                                <dt>Línea de pedido</dt>
                                <dd>Datos correspondientes a los artículos comprados.</dd>
                                <dt>Pagos</dt>
                                <dd>Datos de pagos realizados y se descontarán de la cuenta corriente del proveedor.</dd>
                                <dt>CC de Proveedor</dt>
                                <dd>Se cancelará la deuda pendiente con el proveedor.</dd>
                                <dt>Stock</dt>
                                <dd>Se eliminarán los artículos del stock.</dd>
                            </dl>
                            <big>¿Desea eliminar la siguiente compra?</big>
                            <div class="col-md-12 column col-lg-12 col-xs-12 col-sm-12">
                                <div class="form-group">
                                    <label for="idmenu">Proveedor:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class="fa fa-truck"></span></span> 

                                        <input readonly class="form-control"  id="cuitProveedorE" name="cuitProveedorE" style="font-size:20px; height: 40px;">
                                    </div>
                                </div>  
                            </div>                                                      
                            <div id="divIdCompra" class="col-md-12 column" style="">
                                <div class="form-group">
                                    <label for="nombre" style=" font-size: 15px;">Id Compra:</label>                                            
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                        <input readonly type="text" class="form-control" id="idCompraE" name="idCompraE"/>
                                    </div>                
                                </div>  
                            </div>                                   
                            <div class="col-md-6 column" style=""> 
                                <div class="form-group">
                                    <label for="apellido" style=" font-size: 15px;">Fecha Entrega:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                        <input readonly type="date" class="form-control" id="fechaHoyE" name="fechaHoyE"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 column" style="">
                                <div class="form-group">
                                    <label for="apellido" style=" font-size: 15px;">Hora Entrega:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                        <input readonly type="time" class="form-control" id="horaHoyE" name="horaHoyE"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style=" clear: both;">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button> 
                            <button type="button" class="btn btn-danger" onclick="btnEliminarOnClick2();">Eliminar</button>
                        </div>
                    </div>

                </div>

            </div>

        </div>
        <div class="col-md-12 column">
            <div class="modal fade" id="ventanaFraccionamiento" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog"> 
                    <form id="formFraccionar" name="formFraccionar" onsubmit="btnFraccionar();
                            return false;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h4 class="modal-title" id="myModalLabel">
                                    Fraccionar media res
                                </h4>
                            </div>

                            <div class="modal-body">
                                <div id="divIdCompra" class="col-md-12 column" style="">
                                    <div class="form-group">
                                        <label for="nombre" style=" font-size: 15px;">Id Línea de Compra:</label>                                            
                                        <div class="input-group">
                                            <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                            <input readonly required type="text" class="form-control" id="idLineaCompra" name="idLineaCompra"/>
                                        </div>                
                                    </div>  
                                </div>

                                <div class="col-md-6 column" style="">
                                    <div class="form-group">
                                        <label for="nombre" style=" font-size: 15px;">Cantidad de media res a fraccionar:</label>                                            
                                        <div class="input-group">
                                            <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                            <input type="number" required class="form-control" id="cantidadAFraccionar" name="cantidadAFraccionar"/>
                                        </div>                
                                    </div>  
                                </div>
                                <div class="col-md-6 column" style="">
                                    <div class="form-group">
                                        <label for="nombre" style=" font-size: 15px;">Id de Articulo a fraccionar:</label>                                            
                                        <div class="input-group">
                                            <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                            <input type="number" readonly class="form-control" id="idArticuloAFraccionar" name="idArticuloAFraccionar"/>
                                        </div>                
                                    </div>  
                                </div>
                                <div class="col-md-6 column" style="">
                                    <div class="form-group">
                                        <label for="nombre" style=" font-size: 15px;">Unidades disponibles para fraccionar:</label>                                            
                                        <div class="input-group">
                                            <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                            <input type="number" readonly class="form-control" id="cantidadDisponible" name="cantidadDisponible"/>
                                        </div>                
                                    </div>  
                                </div>
                                <div class="col-md-12 column" style="text-align: center; vertical-align: middle; padding-top:15px;">
                                    <div class="form-group" style="text-align: center; vertical-align: middle;">                                                   
                                        <button type="button" class="btn btn-success btn-block" style="" onclick="$('#ventanaArticulos').modal('show');">Agregar Cortes</button>
                                    </div>
                                </div>                                                    
                                <div class="col-md-12" style="">
                                    <div class="table-responsive clearfix">
                                        <table id="gridCortes" name="gridCortes" class="table table-hover table-striped" >
                                            <thead>
                                                <tr>
                                                    <th data-column-id="idArticulo" data-identifier="true" data-order="asc" data-header-css-class="commandIdArticulo" data-type="numeric">Id Artículo</th>
                                                    <th data-column-id="descripcionArticulo" >Descripcion</th>
                                                    <th data-column-id="descripcionCalidad" >Calidad</th>                                                 
                                                    <th data-column-id="cantidadLineaCompra" data-formatter="unidades">Unidades</th>
                                                    
                                                    <th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn"></th>
                                                </tr>

                                            </thead>  

                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer" style="clear: both">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Volver</button> 
                                <button type="submit" class="btn btn-primary">Guardar</button>
                            </div>
                        </div>
                    </form>

                </div>

            </div>

        </div>
        <div class="col-md-12 column">
            <div class="modal fade" id="ventanaArticulos" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">

                            <h4 class="modal-title" id="myModalLabel">
                                Articulos
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12" style="">
                                <div class="table-responsive clearfix">
                                    <table id="gridArticulos" class="table table-condensed table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th data-column-id="idArticulo" data-identifier="true" data-header-css-class="commandIdArticulo" data-type="numeric">Id Artículo</th>
                                                <th data-column-id="descripcionArticulo" data-order="asc">Descripción</th>
                                                <th data-column-id="descripcionCalidad">Calidad</th>

                                            </tr>
                                        </thead>                 
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="clear: both">
                            <button type="button" class="btn btn-default" onclick="$('#ventanaFraccionamiento').modal('hide');
                                    $('#ventanaArticulos').modal('hide');

                                    setTimeout(function () {
                                        $('#ventanaFraccionamiento').modal('show')
                                    }, 600);">Aceptar</button> 

                        </div>
                    </div>

                </div>
            </div>
        </div>
        <%@ include file="PieDePagina.jspf" %>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.bootgrid.js"></script>
        <script src="js/jquery.steps.js"></script>
        <script>
                                var seleccion = 0;
                                window.onload = function cargaInicial() {
                                    //$("#alertAdvertencia").alert('close');
                                    $('[data-toggle="tooltip"]').tooltip({
                                        placement: 'left'
                                    });
                                    $("#cuitProveedor1").load("cargarProveedores");
                                    carga2();
                                    cargaArt();
                                    setTimeout(function () {
                                        document.getElementById('cuitProveedor').value = document.getElementById('cuitProveedor1').value;
                                        setTimeout(function () {
                                            carga();
                                        }, 600);
                                    }, 300);
                                    //$("#clientes").load("cargarTiposCliente");
                                    $.post("verificarVencimientosCompra", function (rta) {
                                        if (rta != 0)
                                        {
                                            document.getElementById("alertAdvertencia").style.display = 'block';
                                        }
                                        else
                                        {
                                            {
                                                document.getElementById("alertAdvertencia").style.display = 'none';
                                            }
                                        }
                                    });
                                    setTimeout(function () {
                                    //recibir query string
                                    var cadVariables = "";
                                    cadVariables = location.search.substring(1, location.search.length);
                                    if (cadVariables != "") {
                                        arrVariables = cadVariables.split("&");
                                        for (i = 0; i < arrVariables.length; i++) {
                                            arrVariableActual = arrVariables[i].split("=");
                                            if (arrVariableActual[0] == "idCompra") {
                                                var idCompra=arrVariableActual[1];
                              
                                            }
                                        }
                                        if (idCompra != "")
                                        {
                                            seleccion = idCompra;
                                            btnPagarOnclick();
                                        }
                                    }
                                }, 1900);


                                };

                                //carga tabla principal
                                function carga2()
                                {
                                    var data = [];
                                    var grid3 = $("#grid3").bootgrid({
                                        ajax: true,
                                        selection: true,
                                        keepSelection: false,
                                        rowSelect: true,
                                        rowCount: [40, 50, 60, 10],
                                        url: "cargarTablaCompras",
                                        formatters: {
                                            "quantity"
                                                    : function (column, row)
                                                    {
                                                        return "<span class=\"estados\" name=\"" + row.estadoCompra + "\"> " + row.estadoCompra + "</span>";
                                                    }, "vencimiento"
                                                    : function (column, row)
                                                    {
                                                        return "<span class=\"vencimiento\" name=\"" + row.fechaVencimientoCompraS + "\"> " + row.fechaVencimientoCompraS + "</span>";
                                                    },
                                            "precio"
                                                    : function (column, row)
                                                    {
                                                        return "<span class=\"label label-default\">$ " + row.precioTotalCompra + "</span>";
                                                    },
                                            "precioCalculado"
                                                    : function (column, row)
                                                    {
                                                        return "<span class=\"label label-default\">$ " + row.precioTotalCompraCalculado + "</span>";
                                                    },
                                            "idCompra"
                                                    : function (column, row)
                                                    {
                                                        return "<span id=\"" + row.fechaEntregaCompraS + row.horaEntregaCompraS + "\"class=\"\">" + row.idCompraS + "</span>";
                                                    }
                                        }
                                    }).on("loaded.rs.jquery.bootgrid", function (e)
                                    {
                                        var estados = document.getElementsByClassName('estados');
                                        for (var i = 0; i < estados.length; i++)
                                        {
                                            if ($(estados.item(i)).attr("name") == "Entregado")
                                            {
                                                $(estados.item(i)).addClass("label label-primary");
                                            }
                                            if ($(estados.item(i)).attr("name") == "Pagado")
                                            {
                                                $(estados.item(i)).addClass("label label-success");
                                            }
                                            if ($(estados.item(i)).attr("name") == "Pago Parcial")
                                            {
                                                $(estados.item(i)).addClass("label label-warning");
                                            }
                                        }
                                        var f = new Date();
                                        dia = (String(f.getDate())).length == 1 ? '0' + (f.getDate()) : (f.getDate());
                                        mes = (String(f.getMonth() + 1)).length == 1 ? '0' + (f.getMonth() + 1) : (f.getMonth() + 1);
                                        fechaHoy = f.getFullYear() + "-" + mes + "-" + dia;
                                        var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                                        var row;
                                        var vencimientos = document.getElementsByClassName('vencimiento');
                                        var vencimientos2 = document.getElementsByTagName('tr');
                                        var band = 0;
                                        for (var i = 0; i < datos.length; i++)
                                        {
                                            if (datos[i].fechaVencimientoCompraS < fechaHoy)
                                            {
                                                if (datos[i].estadoCompra != "Pagado")
                                                {
                                                    $(vencimientos.item(i)).addClass("label label-danger masgrande");
                                                    $(vencimientos2.item(i + 1)).addClass("danger");
                                                    band = 1;
                                                }
                                            }
                                        }
                                        if (band == 1)
                                        {
                                            document.getElementById("alertAdvertencia").style.display = 'block';


                                        }



                                        // Resets the selected data array on reload, searching, sorting or changing page
                                        data = [];

                                        /* Executes after data is loaded and rendered */
                                    }).on("selected.rs.jquery.bootgrid", function (e, selectedRows)
                                    {

                                        var row, quantity;
                                        for (var i = 0; i < selectedRows.length; i++)
                                        {
                                            row = selectedRows[i];
                                            //alert(row.idCompra);
                                            seleccion = row.idCompraS;
                                        }
                                    }).on("deselected.rs.jquery.bootgrid", function (e, deselectedRows)
                                    {
                                        seleccion = 0;

                                    }).on("click.rs.jquery.bootgrid", function (e, columns, row)
                                    {

                                    }
                                    );

                                }
                                ;
                                //carga tabla precios y articulos
                                function carga()
                                {

                                    setTimeout(function () {
                                        $(function ()
                                        {
                                            var data = [];
                                            var grid = $("#grid").bootgrid({
                                                ajax: true,
                                                selection: true,
                                                post: function ()
                                                {
                                                    return {
                                                        proveedor: document.getElementById('cuitProveedor').value,
                                                        tipoLista: 'proveedor',
                                                        tipoCliente: 1

                                                    };
                                                },
                                                url: "cargarTablaPrecio",
                                                formatters: {
                                                    "quantity"
                                                            : function (column, row)
                                                            {
                                                                return "<div id=\"" + row.idArticulo + "-div\" class=\"input-group\"><span class=\"input-group-addon\"><i id=\"" + row.idArticulo + "-tick\" class=\"fa fa-usd\" style=\"color:green;\"></i></span><input type=\"number\" step=\"any\"  style=\"\" id=\"" + row.idArticulo + "-quantity\" readonly type=\"text\" onfocus=\"document.getElementById('" + row.idArticulo + "-quantity\').readOnly=false;\" class=\"quantity form-control\" value=\"" + row.montoPrecioCompra + "\" /></div>";
                                                            }
                                                    ,
                                                    "commands"
                                                            : function (column, row)
                                                            {
                                                                return "<button type=\"button\" id=\"" + row.idArticulo + "-button1\" class=\"btn btn-xs btn-default command-edit\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Cambiar Precio\" style=\"width:25px; margin-top:5px; vertical-align:center;\"><span id=\"" + row.idArticulo + "-span1\" class=\"fa fa-pencil\"></span></button> "
                                                                        + "<button type=\"button\" id=\"" + row.idArticulo + "-button2\" class=\"btn btn-xs btn-success aceptar\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Aceptar\" style=\"width:25px; margin-top:5px; vertical-align:center; display:none;\"><span id=\"" + row.idArticulo + "-span2\" class=\"fa fa-check\" style=\"color:white;\"></span></button> "
                                                                        + "<button type=\"button\" id=\"" + row.idArticulo + "-button3\" class=\"btn btn-xs btn-default info\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Informacion\" style=\"width:25px; margin-top:5px; vertical-align:center;\"><i id=\"" + row.idArticulo + "-span3\" class=\"fa fa-info\" style=\"color:black;\"></i></button> ";
                                                            }

                                                }
                                            }).on("loaded.rs.jquery.bootgrid", function (e)
                                            {
                                                /* Executes after data is loaded and rendered */
                                                grid.find(".command-edit").on("click", function (e)
                                                {
                                                    //alert("You pressed edit on row: " + $(this).data("row-id"));
                                                    document.getElementById($(this).data("row-id") + "-quantity").readOnly = false;
                                                    document.getElementById(($(this).data("row-id") + "-button1")).style.display = "none";
                                                    document.getElementById(($(this).data("row-id") + "-button2")).style.display = "inline";
                                                });
                                                grid.find(".aceptar").on("click", function (e)
                                                {
                                                    id = $(this).data("row-id");
                                                    quantity = grid.find("#" + $(this).data("row-id") + "-quantity").val();
                                                    //alert("You pressed edit on row: " + $(this).data("row-id") + quantity);
                                                    document.getElementById($(this).data("row-id") + "-quantity").readOnly = true;
                                                    document.getElementById(($(this).data("row-id") + "-button2")).style.display = "none";
                                                    document.getElementById(($(this).data("row-id") + "-button1")).style.display = "inline";
                                                    var f = new Date();
                                                    fechaHoy = f.getFullYear() + "-" + (f.getMonth() + 1) + "-" + f.getDate();
                                                    $.post("modificarPrecio", {idArticulo: $(this).data("row-id"), precioArticulo: grid.find("#" + $(this).data("row-id") + "-quantity").val(), tipoPrecio: "proveedor", cliente: 1, proveedor: document.getElementById('cuitProveedor').value, fechaHoy: fechaHoy}, function (rta) {
                                                        //alert(rta);
                                                        if (rta == 1)
                                                        {
                                                            //alert(id);
                                                            $("#" + (id + "-tick")).removeClass('fa-usd');
                                                            $("#" + (id + "-tick")).removeClass('fa-minus-circle');
                                                            $("#" + (id + "-tick")).addClass('fa-check');
                                                            $("#" + (id + "-div")).addClass('input-group');
                                                            document.getElementById(id + "-tick").style.color = 'green';
                                                        }
                                                        else
                                                        {
                                                            document.getElementById("errorModificarD").style.display = "inline";
                                                            document.getElementById("errorModificar").innerHTML = rta;
                                                            $("#" + (id + "-tick")).removeClass('fa-usd');
                                                            $("#" + (id + "-tick")).removeClass('fa-check');
                                                            $("#" + (id + "-tick")).addClass('fa-minus-circle');
                                                            document.getElementById(id + "-tick").style.color = 'red';
                                                        }
                                                    });
                                                });
                                                grid.find(".info").on("click", function (e)
                                                {
                                                    document.getElementById("idArticulo2").value = $(this).data("row-id");
                                                    cargarTablaPrecios();
                                                    $("#gridPrecioCompra").bootgrid("reload");
                                                    $("#gridPrecioVenta").bootgrid("reload");
                                                    $('#ventanaDetallePrecio').modal('toggle');
                                                });
                                            }).on("selected.rs.jquery.bootgrid", function (e, rows)
                                            {
                                                document.getElementById("idArticulo").value = rows[0].idArticulo;
                                                cambiarDescripcion();
                                                $('#agregarVentana').modal('hide');
                                                $('#ventanaDetalle').modal('hide');

                                                setTimeout(function () {
                                                    $('#agregarVentana').modal('show')
                                                }, 700);

                                            }
                                            );

                                        });
                                    }, 1000);
                                }
                                function cargaArt()
                                {

                                    setTimeout(function () {
                                        $(function ()
                                        {
                                            var data = [];
                                            var grid = $("#gridArticulos").bootgrid({
                                                ajax: true,
                                                selection: true,
                                                multiSelect: true,
                                                keepSelection: true,
                                                rowSelect: true,
                                                post: function ()
                                                {
                                                    return {
                                                        proveedor: 1,
                                                        tipoLista: 'cliente',
                                                        tipoCliente: 1

                                                    };
                                                },
                                                url: "cargarTablaPrecio",
                                                formatters: {
                                                }
                                            }).on("loaded.rs.jquery.bootgrid", function (e)
                                            {
                                                /* Executes after data is loaded and rendered */

                                            }).on("selected.rs.jquery.bootgrid", function (e, selectedRows)
                                            {
                                                for (var i = 0; i < selectedRows.length; i++)
                                                {
                                                    row = selectedRows[i];
                                                    datosFraccionamiento[datosFraccionamiento.length] = {idArticulo: row.idArticulo, cantidadLineaCompra: 1};
                                                    $("#gridCortes").bootgrid("append", [{
                                                            idArticulo: parseInt(datosFraccionamiento[datosFraccionamiento.length - 1].idArticulo),
                                                            cantidadLineaCompra: datosFraccionamiento[datosFraccionamiento.length - 1].cantidadLineaCompra,
                                                            descripcionArticulo: row.descripcionArticulo,
                                                            descripcionCalidad: row.descripcionCalidad
                                                        }
                                                    ]);
                                                }
                                                if (datosFraccionamiento.length == 0)
                                                {

                                                    document.getElementById("cantidadAFraccionar").setCustomValidity("Debe ingresar los cortes realizados.");
                                                }
                                                else
                                                {
                                                    document.getElementById("cantidadAFraccionar").setCustomValidity("");
                                                }

                                            }).on("deselected.rs.jquery.bootgrid", function (e, selectedRows)
                                            {
                                                borrar2(selectedRows[0].idArticulo);
                                                if (datosFraccionamiento.length == 0)
                                                {
                                                    document.getElementById("cantidadAFraccionar").setCustomValidity("Debe ingresar los cortes realizados.");
                                                }
                                                else
                                                {
                                                    document.getElementById("cantidadAFraccionar").setCustomValidity("");
                                                }
                                            });
                                        })
                                    }, 1000);
                                }






        </script>
        <script>
            var datosLineasCompra = [];
            var datosFraccionamiento = [];
            var descripcionArticulo;
            var descripcionCalidad;
            var precioCompra;
            var totalCompra = 0;

            //carga articulos comprados
            function cargaTablaArticulos()
            {

                function init()
                {
                    var grid2 = $("#grid2").bootgrid({
                        formatters: {
                            "link": function (column, row)
                            {
                                return "<a href=\"#\">" + column.id + ": " + row.id + "</a>";
                            },
                            "commands": function (column, row)
                            {
                                return "<button type=\"button\" id=\"" + row.idArticulo + "-button1\" class=\"btn btn-xs btn-default command-delete\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Cambiar Precio\" style=\"width:25px; margin-top:5px; vertical-align:center;\"><span id=\"" + row.idArticulo + "-span1\" class=\"fa fa-trash\" style=\"color:black;\"></span></button> ";
                            },
                            "precio"
                                    : function (column, row)
                                    {
                                        return "<span class=\"label label-default\">$ " + row.precioCompra + "</span>";
                                    }
                            , "precioLinea"
                                    : function (column, row)
                                    {
                                        return "<span class=\"label label-default\">$ " + row.precioLineaCompra + "</span>";
                                    }
                            ,
                            "peso"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.pesoLineaCompra + " kg</span>";
                                    }
                            , "unidad"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.cantidadLineaCompra + " u</span>";
                                    },
                        }}).on("loaded.rs.jquery.bootgrid", function (e)
                    {
                        grid2.find(".command-delete").on("click", function (e)
                        {
                            borrar($(this).data("row-id"));

                        });
                    })


                }
                init();


            }
            ;
            //carga cortes
            function cargaTablaCortes()
            {

                function init()
                {
                    var gridCortes = $("#gridCortes").bootgrid({
                        navigation: 0,
                        formatters: {
                            "unidades"
                                    : function (column, row)
                                    {
                                        return "<div class=\"input-group\"><input required type=\"number\" min=\"1\" value=\"" + row.cantidadLineaCompra + "\" class=\"form-control\" id=\"" + row.idArticulo + "-unidades\"/><span class=\"input-group-addon\">u</span></div> ";

                                    },
                            "commands": function (column, row)
                            {
                                return "<button type=\"button\" id=\"" + row.idArticulo + "-button1\" class=\"btn btn-xs btn-default delete\" style=\"display:none\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Cambiar Precio\" style=\"width:25px; margin-top:5px; vertical-align:center;\"><span id=\"" + row.idArticulo + "-span1\" class=\"fa fa-trash\" style=\"color:black;\"></span></button> ";
                            }
                        }
                    }).on("loaded.rs.jquery.bootgrid", function (e)
                    {

                        gridCortes.find(".delete").on("click", function (e)
                        {

                            borrar2($(this).data("row-id"));

                        });
                    })


                }
                init();


            }
            ;
            $("#formAgregarArt").on("submit", function ()
            {
                document.getElementById("cuitProveedor1").disabled = true;
                document.getElementById("descripcionArticulo").value = "";
                document.getElementById("calidadArticulo").value = "";
                idArticulo = document.getElementById('idArticulo').value;
                //alert(idArticulo);
                cantidadLineaCompra = document.getElementById('cantidadLineaCompra').value;
                pesoLineaCompra = document.getElementById('pesoLineaCompra').value;
                observacionLineaCompra = document.getElementById('observacionLineaCompra').value;
                datosLineasCompra[datosLineasCompra.length] = {idArticulo: idArticulo, cantidadLineaCompra: cantidadLineaCompra, pesoLineaCompra: pesoLineaCompra, observacionLineaCompra: observacionLineaCompra, precioCompra: precioCompra};                 //alert(datosLineasCompra);
                $("#grid2").bootgrid("append", [{
                        idArticulo: parseInt(datosLineasCompra[datosLineasCompra.length - 1].idArticulo),
                        cantidadLineaCompra: datosLineasCompra[datosLineasCompra.length - 1].cantidadLineaCompra,
                        pesoLineaCompra: datosLineasCompra[datosLineasCompra.length - 1].pesoLineaCompra,
                        observacionLineaCompra: datosLineasCompra[datosLineasCompra.length - 1].observacionLineaCompra,
                        descripcionArticulo: descripcionArticulo,
                        descripcionCalidad: descripcionCalidad,
                        precioCompra: precioCompra,
                        precioLineaCompra: Math.round((precioCompra * datosLineasCompra[datosLineasCompra.length - 1].pesoLineaCompra) * 100) / 100
                    }
                ]);
                totalCompra = Math.round((totalCompra + precioCompra * pesoLineaCompra) * 100) / 100;
                document.getElementById('totalCompraCalculado').value = totalCompra;
                document.getElementById('idArticulo').value = '';
                document.getElementById('cantidadLineaCompra').value = '0';
                document.getElementById('pesoLineaCompra').value = '';
                document.getElementById('observacionLineaCompra').value = '';
                document.getElementById("descripcionArticulo").value = '';
                document.getElementById("calidadArticulo").value = '';
                document.getElementById("idArticulo").focus();
                return false;
            });

            function borrar(id)
            {
                var rows = Array();
                rows[0] = id;
                for (var i = 0; i < datosLineasCompra.length; i++)
                {
                    if (datosLineasCompra[i].idArticulo == id)
                    {
                        precioCompra = datosLineasCompra[i].precioCompra;
                        pesoLineaCompra = parseFloat(datosLineasCompra[i].pesoLineaCompra);
                        totalCompra = Math.round((totalCompra - (precioCompra * pesoLineaCompra)) * 100) / 100;
                        document.getElementById('totalCompraCalculado').value = totalCompra;
                        datosLineasCompra.splice(i, 1);
                        break;

                    }
                }
                $("#grid2").bootgrid('remove', rows);
                document.getElementById('idArticulo').value = '';
                document.getElementById('cantidadLineaCompra').value = '0';
                document.getElementById('pesoLineaCompra').value = '';
                document.getElementById('observacionLineaCompra').value = '';
                document.getElementById("descripcionArticulo").value = '';
                document.getElementById("calidadArticulo").value = '';
            }
            function borrar2(id)
            {
                var rows = Array();
                rows[0] = id;
                for (var i = 0; i < datosFraccionamiento.length; i++)
                {
                    if (datosFraccionamiento[i].idArticulo == id)
                    {
                        datosLineasCompra.splice(i, 1);
                        break;

                    }
                }
                $("#gridCortes").bootgrid('remove', rows);
                $("#gridArticulos").bootgrid("deselect", rows);

            }

            function agregarCompra()
            {

                document.getElementById('totalCalculadoCompra').value = totalCompra;
                $('#ventanaConfirmacion').modal('show');

                //alert("ola");                 //datos = [[1, 2, 3], [4, 5, 6]];

            }
            function agregarCompraConfirmacion()
            {

                /* var f = new Date();
                 fechaHoy = f.getFullYear() + "-" + (f.getMonth() + 1) + "-" + f.getDate();
                 horaHoy = f.getHours() + ":" + f.getMinutes() + ":" + f.getSeconds();*/
                var f = new Date();
                dia = (String(f.getDate())).length == 1 ? '0' + (f.getDate()) : (f.getDate());
                mes = (String(f.getMonth() + 1)).length == 1 ? '0' + (f.getMonth() + 1) : (f.getMonth() + 1);
                minutos = (String(f.getMinutes())).length == 1 ? '0' + (f.getMinutes()) : (f.getMinutes());
                segundos = (String(f.getSeconds())).length == 1 ? '0' + (f.getSeconds()) : (f.getSeconds());
                horas = (String(f.getHours())).length == 1 ? '0' + (f.getHours()) : (f.getHours());
                fechaHoy = f.getFullYear() + "-" + mes + "-" + dia;
                horaHoy = horas + ":" + minutos + ":" + segundos;
                $.post('compra', {cuitProveedor: document.getElementById('cuitProveedor').value, nroFacturaCompra: document.getElementById('nroFacturaCompra').value, nroRemitoCompra: document.getElementById('idArticulo').value, fechaHoy: fechaHoy, horaHoy: horaHoy, datosLineas: '{\"datos\":' + JSON.stringify(datosLineasCompra) + '}', totalCompraRemito: document.getElementById('totalCompraRemitoR').value, coincide: document.getElementById('si').checked, totalCompraCalculado: totalCompra}, function (rta) {
                    if (rta === "")
                    {
                        $("#grid3").bootgrid('reload');
                        var filas = document.getElementsByTagName('tr');
                        setTimeout(function () {
                            $(filas.item(1)).addClass("success")
                        }, 4500);
                        setTimeout(function () {
                            $(filas.item(1)).removeClass("success")
                        }, 10000);
                        setTimeout(function () {
                            $(filas.item(1)).addClass("success")
                        }, 1500);
                        setTimeout(function () {
                            $(filas.item(1)).removeClass("success")
                        }, 5000);
                    }
                    else
                    {
                        document.getElementById("alertaError").style.display = "inline";
                        document.getElementById("error").innerHTML = rta;
                    }


                    $('#ventanaConfirmacion').modal('hide');
                    $('#agregarVentana').modal('hide');
                });
            }
            function btnAgregarOnclick()
            {
                var f = new Date();
                dia = (String(f.getDate())).length == 1 ? '0' + (f.getDate()) : (f.getDate());
                mes = (String(f.getMonth() + 1)).length == 1 ? '0' + (f.getMonth() + 1) : (f.getMonth() + 1);
                minutos = (String(f.getMinutes())).length == 1 ? '0' + (f.getMinutes()) : (f.getMinutes());
                segundos = (String(f.getSeconds())).length == 1 ? '0' + (f.getSeconds()) : (f.getSeconds());
                horas = (String(f.getHours())).length == 1 ? '0' + (f.getHours()) : (f.getHours());
                document.getElementById("fechaHoy").value = f.getFullYear() + "-" + mes + "-" + dia;
                document.getElementById("horaHoy").value = horas + ":" + minutos + ":" + segundos;
                $("#cuitProveedor1").load("cargarProveedores");
                carga2();
                setTimeout(function () {
                    document.getElementById('cuitProveedor').value = document.getElementById('cuitProveedor1').value;
                    setTimeout(function () {                         //carga();
                        $('#grid').bootgrid('reload');
                    }, 1000);
                }, 100);
                datosLineasCompra = [];
                totalCompra = 0;
                document.getElementById("cuitProveedor1").disabled = false;
                document.getElementById("idCompra").value = "";
                document.getElementById("idArticulo").value = "";
                document.getElementById("descripcionArticulo").value = "";
                document.getElementById("calidadArticulo").value = "";
                document.getElementById("divIdCompra").style.display = "none";
                document.getElementById("nroFacturaCompra").value = "";
                document.getElementById("nroFacturaCompra").readOnly = false;
                document.getElementById("nroRemitoCompra").value = "";
                document.getElementById("nroRemitoCompra").readOnly = false;
                document.getElementById("fechaHoy").readOnly = false;
                document.getElementById("horaHoy").readOnly = false;
                document.getElementById("fechaVencimientoCompra").value = "";
                document.getElementById("divFechaVencimientoCompra").style.display = "none";
                document.getElementById("fechaUPagoCompra").value = "";
                document.getElementById("divFechaUPagoCompra").style.display = "none";
                document.getElementById("horaUPagoCompra").value = "";
                document.getElementById("divHoraUPagoCompra").style.display = "none";
                document.getElementById("estadoCompra").value = "";
                document.getElementById("divEstadoCompra").style.display = "none";
                document.getElementById("totalCompraCalculado").value = 0;
                document.getElementById("totalCompraRemito").value = 0;
                document.getElementById("divTotalCompraRemito").style.display = "none";
                document.getElementById("divAgregarArticulo").style.display = "inline";
                document.getElementById("btnGuardarCompra").style.display = "inline";
                document.getElementById("datosCompra").style.display = "inline";
                document.getElementById("datosProveedor").style.display = "inline";
                document.getElementById("referencia").style.display = "none";
                $("#grid2").bootgrid("destroy");
                cargaTablaArticulos();
                setTimeout(function () {
                    $('#agregarVentana').modal('toggle');
                }, 200);
            }
            function btnDetallesOnclick()
            {
                if (seleccion != 0)
                {
                    var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                    var row;
                    for (var i = 0; i < datos.length; i++)
                    {
                        if (datos[i].idCompraS == seleccion)
                        {
                            row = datos[i];
                        }
                    }
                    document.getElementById("cuitProveedor").value = row.cuitProveedor;
                    document.getElementById("cuitProveedor").readOnly = true;
                    document.getElementById("cuitProveedor1").value = row.cuitProveedor;
                    document.getElementById("idCompra").value = row.idCompraS;
                    document.getElementById("divIdCompra").style.display = "inline";
                    document.getElementById("nroFacturaCompra").value = row.nroFacturaCompra;
                    document.getElementById("nroFacturaCompra").readOnly = true;
                    document.getElementById("nroRemitoCompra").value = row.nroRemitoCompra;
                    document.getElementById("nroRemitoCompra").readOnly = true;
                    document.getElementById("fechaHoy").value = (row.fechaEntregaCompraS);
                    document.getElementById("fechaHoy").readOnly = true;
                    document.getElementById("horaHoy").value = row.horaEntregaCompraS;
                    document.getElementById("horaHoy").readOnly = true;
                    document.getElementById("fechaVencimientoCompra").value = row.fechaVencimientoCompraS;
                    document.getElementById("divFechaVencimientoCompra").style.display = "inline";
                    document.getElementById("fechaUPagoCompra").value = row.fechaUPagoCompraS;
                    document.getElementById("divFechaUPagoCompra").style.display = "inline";
                    document.getElementById("horaUPagoCompra").value = row.horaUPagoCompraS;
                    document.getElementById("divHoraUPagoCompra").style.display = "inline";
                    document.getElementById("estadoCompra").value = row.estadoCompra;
                    document.getElementById("divEstadoCompra").style.display = "inline";
                    document.getElementById("totalCompraCalculado").value = row.precioTotalCompraCalculado;
                    document.getElementById("totalCompraRemito").value = row.precioTotalCompra;
                    document.getElementById("divTotalCompraRemito").style.display = "inline";
                    document.getElementById("divAgregarArticulo").style.display = "none";
                    document.getElementById("btnGuardarCompra").style.display = "none";
                    document.getElementById("datosCompra").style.display = "inline";
                    document.getElementById("datosProveedor").style.display = "inline";
                    document.getElementById("referencia").style.display = "none";
                    $("#grid2").bootgrid("destroy");
                    var grid2 = $("#grid2").bootgrid({
                        ajax: true,
                        post: function ()
                        {
                            return {
                                idCompra: document.getElementById('idCompra').value

                            };
                        },
                        url: "cargarTablaLineasCompra",
                        formatters: {
                            "link": function (column, row)
                            {
                                return "<a href=\"#\">" + column.id + ": " + row.id + "</a>";
                            },
                            "precio": function (column, row)
                            {
                                return "<span class=\"label label-default\">$ " + row.precioCompra + "</span>";
                            }
                            , "precioLinea"
                                    : function (column, row)
                                    {
                                        return "<span class=\"label label-default\">$ " + row.precioLineaCompra + "</span>";
                                    }
                            ,
                            "peso"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.pesoLineaCompra + " kg</span>";
                                    }
                            , "unidad"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.cantidadLineaCompra + " u</span>";
                                    },
                        }
                    }).on("loaded.rs.jquery.bootgrid", function (e)
                    {
                        grid2.find(".command-delete").on("click", function (e)
                        {
                            borrar($(this).data("row-id"));
                        });
                    })
                    setTimeout(function () {
                        $('#agregarVentana').modal('toggle');
                    }, 200);
                }
                else
                {
                    document.getElementById("alerta").style.display = "inline";
                }
            }
            function btnPagarOnclick()
            {
                if (seleccion != 0)
                {
                    var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                    var row;
                    var totalPagado = 0;
                    for (var i = 0; i < datos.length; i++)
                    {
                        if (datos[i].idCompraS == seleccion)
                        {
                            row = datos[i];
                        }
                    }

                    var f = new Date();
                    dia = (String(f.getDate())).length == 1 ? '0' + (f.getDate()) : (f.getDate());
                    mes = (String(f.getMonth() + 1)).length == 1 ? '0' + (f.getMonth() + 1) : (f.getMonth() + 1);
                    minutos = (String(f.getMinutes())).length == 1 ? '0' + (f.getMinutes()) : (f.getMinutes());
                    segundos = (String(f.getSeconds())).length == 1 ? '0' + (f.getSeconds()) : (f.getSeconds());
                    horas = (String(f.getHours())).length == 1 ? '0' + (f.getHours()) : (f.getHours());
                    document.getElementById("fechaPago").value = f.getFullYear() + "-" + mes + "-" + dia;
                    document.getElementById("horaPago").value = horas + ":" + minutos + ":" + segundos;
                    document.getElementById("cuitProveedorP").value = row.cuitProveedor;
                    document.getElementById("idCompraP").value = row.idCompraS;
                    document.getElementById("nroFacturaCompraP").value = row.nroFacturaCompra;
                    document.getElementById("nroRemitoCompraP").value = row.nroRemitoCompra;
                    document.getElementById("fechaHoyP").value = (row.fechaEntregaCompraS);
                    document.getElementById("horaHoyP").value = row.horaEntregaCompraS;
                    document.getElementById("fechaVencimientoCompraP").value = row.fechaVencimientoCompraS;
                    document.getElementById("fechaUPagoCompraP").value = row.fechaUPagoCompraS;
                    document.getElementById("horaUPagoCompraP").value = row.horaUPagoCompraS;
                    document.getElementById("estadoCompraP").value = row.estadoCompra;
                    if (row.estadoCompra == "Pagado")
                    {
                        document.getElementById("btnNuevoPago").disabled = true;
                    }
                    else
                    {
                        document.getElementById("btnNuevoPago").disabled = false;
                    }
                    document.getElementById("montoPago").value = "";
                    document.getElementById("nroCheque").value = "";
                    document.getElementById("bancoCheque").value = "";
                    document.getElementById("nombreCheque").value = "";
                    $("#gridPagos").bootgrid("destroy");
                    var grid2 = $("#gridPagos").bootgrid({
                        ajax: true,
                        post: function ()
                        {
                            return {
                                idTransaccion: document.getElementById('idCompraP').value

                            };
                        },
                        url: "cargarTablaPagos", formatters: {
                            "link": function (column, row)
                            {
                                return "<a href=\"#\">" + column.id + ": " + row.id + "</a>";
                            },
                            "precio": function (column, row)
                            {
                                return "<span class=\"label label-default\">$ " + row.montoPago + "</span>";
                            }

                        }}).on("loaded.rs.jquery.bootgrid", function (e) {
                        grid2.find(".command-delete").on("click", function (e) {
                            borrar($(this).data("row-id"));
                        });
                    })
                    setTimeout(function () {
                        var datosPagos = $('#gridPagos').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                        for (var i = 0; i < datosPagos.length; i++)
                        {
                            totalPagado = totalPagado + datosPagos[i].montoPago;
                        }
                        document.getElementById("totalPagado").value = totalPagado;
                        document.getElementById("totalCompraRemitoP").value = row.precioTotalCompra;
                        document.getElementById("totalAdeudado").value = Math.round((row.precioTotalCompra - totalPagado) * 100) / 100;
                        //$('[type="numeric"].montoPago').prop('max', Math.round((row.precioTotalCompra - totalPagado) * 100) / 100);
                        document.formPago.montoPago.setAttribute("max", Math.round((row.precioTotalCompra - totalPagado) * 100) / 100);
                    }, 300);
                    $('#ventanaPagos').modal('toggle');
                }
                else
                {
                    document.getElementById("alerta").style.display = "inline";
                }
            }
            function nuevoPago()
            {
                document.getElementById("montoPago").value = "";
                document.getElementById("nroCheque").value = "";
                document.getElementById("bancoCheque").value = "";
                document.getElementById("nombreCheque").value = "";
                var f = new Date();
                dia = (String(f.getDate())).length == 1 ? '0' + (f.getDate()) : (f.getDate());
                mes = (String(f.getMonth() + 1)).length == 1 ? '0' + (f.getMonth() + 1) : (f.getMonth() + 1);
                minutos = (String(f.getMinutes())).length == 1 ? '0' + (f.getMinutes()) : (f.getMinutes());
                segundos = (String(f.getSeconds())).length == 1 ? '0' + (f.getSeconds()) : (f.getSeconds());
                horas = (String(f.getHours())).length == 1 ? '0' + (f.getHours()) : (f.getHours());
                document.getElementById("fechaPago").value = f.getFullYear() + "-" + mes + "-" + dia;
                document.getElementById("horaPago").value = horas + ":" + minutos + ":" + segundos;
            }
            function guardarPagoOnClick()
            {
                $.post('PagoCompra', {idCompra: document.getElementById('idCompraP').value, formaDePago: document.getElementById('formaDePago').value, montoPago: document.getElementById('montoPago').value, nroCheque: document.getElementById('nroCheque').value, bancoCheque: document.getElementById('bancoCheque').value, nombreCheque: document.getElementById('nombreCheque').value, fechaPago: document.getElementById('fechaPago').value, horaPago: document.getElementById('horaPago').value, tipoTransaccion: 'compra'}, function (rta) {
                    if (rta === "")
                    {

                    }
                    else
                    {
                        document.getElementById("alertaError").style.display = "inline";
                        document.getElementById("error").innerHTML = rta;
                    }

                    $("#grid3").bootgrid('reload');
                    $("#gridPagos").bootgrid('reload');
                    totalPagado = 0;
                    setTimeout(function () {
                        var datosPagos = $('#gridPagos').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                        for (var i = 0; i < datosPagos.length; i++) {
                            totalPagado = totalPagado + datosPagos[i].montoPago;
                        }
                        document.getElementById("totalPagado").value = totalPagado;
                        precioTotalCompra = document.getElementById("totalCompraRemitoP").value;
                        document.getElementById("totalAdeudado").value = Math.round((precioTotalCompra - totalPagado) * 100) / 100;
                        //$('[type="numeric"].montoPago').prop('max', Math.round((row.precioTotalCompra - totalPagado) * 100) / 100);
                        document.formPago.montoPago.setAttribute("max", Math.round((precioTotalCompra - totalPagado) * 100) / 100);
                        var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                        for (var i = 0; i < datos.length; i++) {
                            if (datos[i].idCompraS == seleccion) {
                                row = datos[i];
                            }
                        }
                        document.getElementById("fechaUPagoCompraP").value = row.fechaUPagoCompraS;
                        document.getElementById("horaUPagoCompraP").value = row.horaUPagoCompraS;
                        document.getElementById("estadoCompraP").value = row.estadoCompra;
                        if (row.estadoCompra == "Pagado")
                        {
                            document.getElementById("btnNuevoPago").disabled = true;
                        }
                        else
                        {
                            document.getElementById("btnNuevoPago").disabled = false;
                        }
                    }, 500);
                    $('#ventanaPagos').modal('hide');
                    $('#ventanaRealizarPago').modal('hide');
                    setTimeout(function () {
                        $('#ventanaPagos').modal('show');
                    }, 700);
                });
            }
            function btnEliminarOnClick()
            {
                if (seleccion != 0)
                {
                    var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                    var row;
                    for (var i = 0; i < datos.length; i++)
                    {
                        if (datos[i].idCompraS == seleccion)
                        {
                            row = datos[i];
                        }
                    }
                    document.getElementById("cuitProveedorE").value = row.cuitProveedor;
                    document.getElementById("idCompraE").value = row.idCompraS;
                    document.getElementById("fechaHoyE").value = (row.fechaEntregaCompraS);
                    document.getElementById("horaHoyE").value = row.horaEntregaCompraS;
                    $('#ventanaEliminar').modal('show');
                }
                else
                {
                    document.getElementById("alerta").style.display = "inline";
                }
            }
            function btnEliminarOnClick2()
            {
                $.post("eliminarCompra", {idCompra: document.getElementById("idCompraE").value}, function (rta) {
                    if (rta === "")
                    {
                        $('#ventanaEliminar').modal('hide');
                    }
                    else
                    {
                        document.getElementById("alertaError").style.display = "inline";
                        document.getElementById("error").innerHTML = rta;
                        $('#ventanaEliminar').modal('hide');
                    }
                    $("#grid3").bootgrid('reload');
                });
            }
            function btnFraccionarOnclick()
            {
                if (seleccion != 0) {
                    var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                    var row;
                    for (var i = 0; i < datos.length; i++)
                    {
                        if (datos[i].idCompraS == seleccion)
                        {
                            row = datos[i];
                        }
                    }

                    document.getElementById("idCompra").value = row.idCompraS;
                    document.getElementById("divIdCompra").style.display = "inline";
                    document.getElementById("datosCompra").style.display = "none";
                    document.getElementById("datosProveedor").style.display = "none";
                    document.getElementById("totalCompraCalculado").value = row.precioTotalCompraCalculado;
                    document.getElementById("totalCompraRemito").value = row.precioTotalCompra;
                    document.getElementById("divTotalCompraRemito").style.display = "inline";
                    document.getElementById("divAgregarArticulo").style.display = "none";
                    document.getElementById("btnGuardarCompra").style.display = "none";
                    document.getElementById("referencia").style.display = "inline";
                    datosFraccionamiento = [];
                    $("#grid2").bootgrid("destroy");
                    var grid2 = $("#grid2").bootgrid({
                        navigation: 0,
                        ajax: true,
                        post: function ()
                        {
                            return {
                                idCompra: document.getElementById('idCompra').value

                            };
                        },
                        url: "cargarTablaLineasFraccionamiento",
                        formatters: {
                            "precio"
                                    : function (column, row)
                                    {
                                        return "<span class=\"label label-default\">$ " + row.precioCompra + "</span>";
                                    }
                            ,
                            "precioLinea"
                                    : function (column, row)
                                    {
                                        return "<span class=\"label label-default\">$ " + row.precioLineaCompra + "</span>";
                                    }
                            ,
                            "peso"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.pesoLineaCompra + " kg</span>";
                                    }
                            ,
                            "unidad"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.cantidadLineaCompra + " u</span>";
                                    }
                            ,
                            "commands"
                                    : function (column, row)
                                    {
                                        return "<button type=\"button\" id=\"" + row.idArticulo + "-button1\" class=\"btn btn-xs btn-default command-fraccionar\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Fraccionar\" style=\"width:25px; margin-top:5px; vertical-align:center;display:none;\"><span id=\"" + row.idArticulo + "-span1\" class=\"fa fa-cut fa-1x\"></span></button> " +
                                               "<button type=\"button\" id=\"" + row.idArticulo + "-eliminar\" class=\"btn btn-xs btn-default command-eliminar\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Fraccionar\" style=\"width:25px; margin-top:5px; vertical-align:center;display:none;\"><span id=\"" + row.idArticulo + "-span1\" class=\"fa fa-trash fa-1x\"></span></button> " ;
                                    }}
                    }).on("loaded.rs.jquery.bootgrid", function (e)
                    {
                        //document.formF.cantidadFraccionamiento.setAttribute("data-visible", true);
                        var datos = $('#grid2').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                        var grilla = document.getElementById("grid2");
                        var filas = grilla.getElementsByTagName("tr");
                        var col = grilla.getElementsByTagName("th");
                        col[4].setAttribute("data-visible", false);
                        for (var i = 0; i < datos.length; i++)
                        {
                            if (datos[i].precioCompra == 0)
                            {
                                $(filas.item(i + 1)).addClass("warning");
                                //document.getElementById("" + datos[i].idArticulo + "-button1").style.display = "none";
                            }
                            else {
                                if (datos[i].descripcionArticulo.toLowerCase() == "media res" || datos[i].descripcionArticulo.toLowerCase() == "mediares")
                                {
                                    $(filas.item(i + 1)).addClass("success");
                                    if (datos[i].cantidadLineaCompra - datos[i].cantidadFraccionada != 0)
                                    {
                                        document.getElementById("" + datos[i].idArticulo + "-button1").style.display = "inherit";
                                    }

                                }
                                else {
                                    $(filas.item(i + 1)).addClass("active");
                                    //document.getElementById("" + datos[i].idArticulo + "-button1").style.display = "none";

                                }
                            }
                            if (datos[i].idFraccionamiento != 0)
                                {
                                     document.getElementById("" + datos[i].idArticulo + "-eliminar").style.display = "inherit";
                                }
                        }
                         grid2.find(".command-eliminar").on("click", function (e)
                        {
                            var datos = $('#grid2').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                            var row;
                            for (var i = 0; i < datos.length; i++)
                            {
                                if (datos[i].precioCompra == 0)
                                {
                                    if (datos[i].idArticulo == $(this).data("row-id"))
                                    {
                                        row = datos[i];
                                    }
                                }
                            } 
                            $.post("eliminarFraccionamiento",{idFraccionamiento: row.idFraccionamiento},function(rta){})
                        })
                        grid2.find(".command-fraccionar").on("click", function (e)
                        {
                            var datos = $('#grid2').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                            var row;
                            for (var i = 0; i < datos.length; i++)
                            {
                                if (datos[i].precioCompra != 0)
                                {
                                    if (datos[i].idArticulo == $(this).data("row-id"))
                                    {
                                        row = datos[i];
                                    }
                                }
                            }
                            document.getElementById("idLineaCompra").value = row.idLineaCompraS;
                            document.getElementById("idArticuloAFraccionar").value = $(this).data("row-id");
                            document.getElementById("cantidadAFraccionar").value = "";
                            document.getElementById("cantidadDisponible").value = row.cantidadLineaCompra - row.cantidadFraccionada;
                            document.formFraccionar.cantidadAFraccionar.setAttribute("max", row.cantidadLineaCompra - row.cantidadFraccionada);
                            $("#gridCortes").bootgrid("destroy");
                            cargaTablaCortes();
                            datosFraccionamiento = [];
                            $("#gridArticulos").bootgrid("destroy");
                            cargaArt();
                            $('#ventanaFraccionamiento').modal('toggle');
                            if (datosFraccionamiento.length == 0)
                            {
                                document.getElementById("cantidadAFraccionar").setCustomValidity("Debe ingresar los cortes realizados.");
                            }
                            else
                            {
                                document.getElementById("cantidadAFraccionar").setCustomValidity("");
                            }
                        });
                    })
                    setTimeout(function () {
                        $('#agregarVentana').modal('toggle');
                    }, 200);
                }
                else
                {
                    document.getElementById("alerta").style.display = "inline";
                }
            }
            function cambiarDescripcion()
            {
                descripcionArticulo = 'null';
                document.getElementById("descripcionArticulo").value = "";
                document.getElementById("calidadArticulo").value = "";
                $.post("recuperarDatosArticulo", {idArticulo: document.getElementById("idArticulo").value, cuitProveedor: document.getElementById("cuitProveedor").value}, function (rta) {
                    var datos = rta.split("-");
                    descripcionArticulo = datos[0];
                    descripcionCalidad = datos[1];
                    precioCompra = datos[2];
                    if (descripcionArticulo == "null")
                    {
                        document.getElementById("idArticulo").setCustomValidity("El proveedor no tiene registro de precio para este articulo");
                    }
                    else
                    {
                        document.getElementById("idArticulo").setCustomValidity("");
                        document.getElementById("descripcionArticulo").value = descripcionArticulo;
                        document.getElementById("calidadArticulo").value = descripcionCalidad;
                    }
                    for (var i = 0; i < datosLineasCompra.length; i++)
                    {
                        if (datosLineasCompra[i].idArticulo == document.getElementById("idArticulo").value)
                        {
                            document.getElementById("idArticulo").setCustomValidity("El articulo ya se registro");
                            break;
                        }
                        else
                        {
                            document.getElementById("idArticulo").setCustomValidity("");
                        }


                    }
                    if (descripcionArticulo == "null")
                    {
                        document.getElementById("idArticulo").setCustomValidity("El proveedor no tiene registro de precio para este articulo");
                    }

                });
            }
            function cargarTablaPrecios()
            {
                var data = [];
                var grid = $("#gridPrecioCompra").bootgrid({
                    sorting: false,
                    navigation: 0,
                    ajax: true,
                    post: function ()
                    {
                        return {
                            idArticulo: document.getElementById('idArticulo2').value

                        };
                    },
                    url: "cargarTablaPrecioCompra",
                    formatters: {
                        "quantity"
                                : function (column, row) {
                                    return "<span class=\"label label-default\">$ " + row.montoPrecioCompra + "</span>";
                                }


                    }
                });
                var data = [];
                var grid = $("#gridPrecioVenta").bootgrid({
                    sorting: false,
                    navigation: 0,
                    ajax: true,
                    post: function ()
                    {
                        return {
                            idArticulo: document.getElementById('idArticulo2').value

                        };
                    },
                    url: "cargarTablaPrecioVenta",
                    formatters: {
                        "quantity"
                                : function (column, row) {
                                    return "<span class=\"label label-default\">$ " + row.montoPrecioVenta + "</span>";
                                }


                    }
                })

            }
            ;
            function cambiarRadio()
            {
                if (document.getElementById('si').checked == true)
                {

                    document.getElementById('totalCompraRemitoR').readOnly = true;
                    document.getElementById('totalCompraRemitoR').required = true;
                }
                else
                {

                    document.getElementById('totalCompraRemitoR').readOnly = false;
                    document.getElementById('totalCompraRemitoR').required = false;
                }

            }
            function validar()
            {
                if (datosLineasCompra.length == 0)
                {
                    document.getElementById("cuitProveedor").setCustomValidity("No se ha registrado ningun articulo");
                }
                else
                {
                    document.getElementById("cuitProveedor").setCustomValidity("");
                    $('#formPrincipal').submit();
                }

            }
            //FRACCIONAMIENTO


            function btnFraccionar()
            {
                //alert('ola');
                var datos = $('#gridCortes').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                $.post('fraccionamiento', {idLineaCompra: document.getElementById('idLineaCompra').value, cantidadAFraccionar: document.getElementById('cantidadAFraccionar').value, datosFraccionamiento: '{\"datos\":' + JSON.stringify(datos) + '}', idArticuloAFraccionar: document.getElementById("idArticuloAFraccionar").value}, function (rta) {
                    if (rta === "")
                    {

                    }
                    else
                    {
                        document.getElementById("alertaError").style.display = "inline";
                        document.getElementById("error").innerHTML = rta;
                    }
                    $("#grid3").bootgrid('reload');
                    $("#grid2").bootgrid('reload');
                    $('#ventanaFraccionamiento').modal('hide');
                    $('#agregarVentana').modal('hide');
                    $('#ventanaFraccionamiento').modal('hide');

                    setTimeout(function () {
                        $('#agregarVentana').modal('show')
                    }, 700);
                })

            }


        </script>

    </body>
</html>
