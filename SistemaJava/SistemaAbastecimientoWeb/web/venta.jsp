

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
                <small>Home > <b>Venta</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Venta a Clientes</h4>
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
                        <li> <button onclick="btnPagarOnclick()" type="button" role="button" class="btn btn-warning btn-block" value="Agregar" style=" height: 110px; min-width: 110px"><span class="fa fa-dollar fa-3x" style=" color: white; display: block;"></span>Cobrar</button></li>
                        <li> <button onclick="btnDetallesOnclick()" type="button" role="button" class="btn btn-info btn-block" value="detalles" style=" height: 110px; min-width: 110px"><span class="fa fa-search fa-3x" style=" color: white; display: block;"></span>Detalles</button></li>
                        <li><button onclick="btnEntregarOnclick()" type="button" role="button" class="btn btn-primary btn-block" style=" height: 110px; min-width: 110px"><span class="fa fa-truck fa-3x" style=" color: white; display: block;"></span>Entregado</button></li>
                        <li><button onclick="btnReimprimirOnclick()" type="button" role="button" class="btn btn-default btn-block" style=" height: 110px; min-width: 110px"><span class="fa fa-newspaper-o fa-3x" style=" color: black; display: block;"></span>Reimprimir Remito</button></li>

                    </ul>
                </div>
            </div>

            <div class="col-lg-12 col-md-12">
                <div class="table-responsive clearfix">
                    <table id="grid3" name="grid3" class="table table-striped">
                        <thead>
                            <tr>
                                <th data-column-id="dniCliente" data-type="numeric" data-sortable="true">Dni Cliente</th>
                                <th data-column-id="cuitCliente" data-type="numeric" data-sortable="true">Cuit Cliente</th>
                                <th data-column-id="cliente" data-sortable="false">Cliente</th>
                                <th data-column-id="razonSocialCliente" data-sortable="false">Razón Social</th>
                                <th data-column-id="idVentaS" data-formatter="idCompra" data-type="string" data-identifier="true" data-sortable="false">Id Venta</th>
                                <th data-column-id="precioTotalVenta" data-formatter="precioCalculado" data-sortable="false">Total</th>
                                <th data-column-id="fechaVentaS" data-order="desc" data-sortable="true">Fecha Venta</th>
                                <th data-column-id="horaVentaS" data-sortable="false">Hora Venta</th>
                                <th data-column-id="fechaEntregaVentaS" data-order="desc" data-sortable="true">Fecha Entrega</th>
                                <th data-column-id="horaEntregaVentaS" data-sortable="false">Hora Entrega</th>
                                <th data-column-id="fechaVencimientoVentaS" data-formatter="vencimiento" data-sortable="true">Fecha Vencimiento</th>
                                <th data-column-id="nroFacturaVenta" data-visible="false">Factura</th>
                                <th data-column-id="nroRemitoVenta" data-visible="false">Remito</th>
                                <th data-column-id="fechaUCobroVenta" data-visible="false">Fecha Pago</th>
                                <th data-column-id="horaUCobroVenta" data-visible="false">Hora Pago</th>
                                <th data-column-id="estadoVenta" data-formatter="quantity" data-sortable="true">Estado</th>

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
                                Venta
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12 column"> 
                                <form id="formPrincipal" onsubmit="agregarCompra();
                                        return false;">
                                    <div id="datosProveedor">
                                        <div class="col-md-12 column col-lg-12 col-xs-12 col-sm-12">
                                            <!--<div class="form-group">
                                                <label for="idmenu">Cliente:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-truck"></span></span> 
                                                    <select required class="form-control" id="dniCliente1" name="dniCliente1" onchange="document.getElementById('dniCliente').value = document.getElementById('dniCliente1').value;
                                                            $('#grid').bootgrid('reload');" style="font-size:20px; height: 40px;">
                                                    </select>
                                                    
                                                </div>
                                            </div> -->
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">DNI Cliente:</label>
                                                    <div class="input-group">
                                                        <input type="number" readonly required class="form-control" id="dniCliente" name="dniCliente"/>
                                                        <span id="btnBuscarCliente" name="btnBuscarCliente" onclick="if (datosLineaVenta.length == 0) {
                                                                    $('#ventanaClientes').modal('show');
                                                                }" class="boton input-group-addon btn-default"><span class="glyphicon glyphicon-search"></span></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Tipo Cliente:</label>                                                    
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                        <input type="text" readonly required class="form-control" id="tipoCliente"  name="tipoCliente"/>                                                                                                                                                                    
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="text" readonly hidden required class="form-control" id="idTipoCliente" name="idTipoCliente" style=" display: none"/> 
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Nombre:</label>                                                    
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                        <input type="text" readonly required class="form-control" id="nombreCliente" name="nombreCliente"/>                                                       
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Apellido:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                        <input type="text" readonly required class="form-control" id="apellidoCliente" name="apellidoCliente"/>                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Razón Social:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-users"></span></span>
                                                        <input type="text" readonly required class="form-control" id="razonSocialCliente" name="razonSocialCliente"/>                                                        
                                                    </div>
                                                </div>
                                            </div>

                                        </div>                               

                                    </div>
                                    <div  class="col-md-12 column" style=" margin-top: 20px;"> 
                                        <div id="divIdVenta" class="col-md-12 column" style="">
                                            <div class="form-group">
                                                <label for="nombre" style=" font-size: 15px;">Id Venta:</label>                                            
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                                    <input readonly type="text" class="form-control" id="idVenta" name="idVenta"/>
                                                </div>                
                                            </div>  
                                        </div>
                                        <div id="datosVenta">
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Número de Factura:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                                        <input type="text" class="form-control" id="nroFacturaVenta" name="nroFacturaVenta"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Número de Remito:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                                        <input type="text" class="form-control" id="nroRemitoVenta" name="nroRemitoVenta"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style=""> 
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Fecha Venta:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                        <input type="date" required class="form-control" id="fechaHoy" name="fechaHoy"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Hora Venta:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                        <input type="time" required class="form-control" id="horaHoy" name="horaHoy"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divFechaEntregaVenta" class="col-md-6 column" style=""> 
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Fecha Entrega:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                        <input type="date" readonly class="form-control" id="fechaEntregaVenta" name="fechaEntregaVenta"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divHoraEntregaVenta" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Hora Entrega:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                        <input type="time" readonly class="form-control" id="horaEntregaVenta" name="horaEntregaVenta"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="divFechaVencimientoVenta" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Fecha Vencimiento:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                        <input readonly type="date" class="form-control" id="fechaVencimientoVenta" name="fechaVencimientoVenta"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                            <div id="divEstadoVenta" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Estado:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-flag"></span></span>
                                                        <input readonly type="text" class="form-control" id="estadoVenta" name="estadoVenta"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                            <div id="divFechaUCobroVenta" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Fecha Ultimo Pago:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                        <input readonly type="date" class="form-control" id="fechaUCobroVenta" name="fechaUCobroVenta"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                            <div id="divHoraUCobroVenta" class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="nombre" style=" font-size: 15px;">Hora Ultimo Pago:</label>                                            
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                        <input readonly type="time" class="form-control" id="horaUCobroVenta" name="horaUCobroVenta"/>
                                                    </div>                
                                                </div>  
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <form id="formAgregarArt" style="text-align: center;" >
                                    <div id="divAgregarArticulo" class="col-md-12 column" style="background-color:rgba(252,252,252,1.00); padding: 15px; padding-bottom: 25px">
                                        <h4 style=" margin: 15px;">Artículos vendidos</h4>
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
                                            <div class="col-md-4 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Descripcion:</label>
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class=" fa fa-pencil"></span></span>
                                                        <input type="text" required readonly class="form-control" id="descripcionArticulo" name="descripcionArticulo"/>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Calidad:</label>
                                                    <div class="input-group">  
                                                        <span class="input-group-addon"><span class=" fa fa-star"></span></span>                                                         
                                                        <input type="text" readonly class="form-control" id="calidadArticulo" name="calidadArticulo"/>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Cantidad en unidades:</label>
                                                    <div class="input-group">

                                                        <input type="number" min="1" required class="form-control" id="cantidadLineaVenta" name="cantidadLineaVenta" onchange="validarStock()"/>
                                                        <span class="input-group-addon">u</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 column" style="">
                                                <div class="form-group">
                                                    <label for="apellido" style=" font-size: 15px;">Peso Total:</label>
                                                    <div class="input-group">                                                           
                                                        <input required type="number" min="0" step='any' class="form-control" id="pesoLineaVenta" name="pesoLineaVenta"/>
                                                        <span class="input-group-addon">kg</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12 column" style="text-align: center;">
                                                <div class="form-group" style="clear: both;">
                                                    <label for="direccion" class="col-sm-3 control-label" style=" font-size: 15px; padding-right: 25px">Observación:</label>
                                                    <div class="col-sm-9">
                                                        <textarea class="form-control" id="observacionLineaVenta" name="observacionLineaVenta"></textarea>
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
                                </form>
                                <!--<form id="formF">-->
                                <div class="col-md-12" style="">
                                    <div class="table-responsive clearfix">
                                        <table id="grid2" name="grid2" class="table table-hover table-striped" >
                                            <thead>
                                                <tr>
                                                    <th data-column-id="idArticulo" data-identifier="true" data-order="asc" data-header-css-class="commandIdArticulo" data-type="numeric">Id Artículo</th>
                                                    <th data-column-id="descripcionArticulo" >Descripcion</th>
                                                    <th data-column-id="descripcionCalidad" >Calidad</th>
                                                    <th data-column-id="precioVenta" data-formatter="precio">Precio kg</th>
                                                    <th data-column-id="cantidadLineaVenta" data-formatter="unidad" data-header-css-class="commandIdArticulo">Unidades</th>
                                                    <th data-column-id="pesoLineaVenta" data-formatter="peso" data-header-css-class="commandIdArticulo">Peso</th>
                                                    <th data-column-id="precioLineaVenta" data-formatter="precioLinea">Total</th>
                                                    <th data-column-id="observacionLineaVenta" data-visible="false">Observacion</th>
                                                    <th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn"></th>
                                                    <th data-column-id="idLineaVentaS" data-visible="false">idLineaCompra</th>
                                                </tr>
                                            </thead>  
                                        </table>
                                    </div>
                                </div>                                  

                                <div class="col-md-4 column pull-right" style=" text-align:right; margin-bottom: 10px">
                                    <div class="form-group" style=" text-align:right">
                                        <label for="idmenu">Total Calculado:</label>
                                        <div class="input-group pull-right" style=" text-align:right">
                                            <span class="input-group-addon "><span class='fa fa-money'></span></span> 
                                            <input readonly type=number step="any" class="form-control" id="totalVentaCalculado" name="totalVentaCalculado" style="font-size:20px; height: 40px; ">
                                        </div>
                                    </div> 
                                </div>                                               
                            </div>
                        </div>
                        <div class="modal-footer" style=" clear: both;">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Volver</button> 
                            <button type="button" id="btnGuardarVenta" class="btn btn-primary" onclick="validar();">Guardar venta</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 column">
            <div class="modal fade" id="ventanaClientes" data-backdrop="static" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel">
                                Clientes
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12" style="">
                                <div class="table-responsive clearfix">
                                    <table id="gridClientes" class="table table-condensed table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th data-column-id="dniCliente" data-identifier="true" data-header-css-class="commandIdArticulo" data-sortable="true" data-type="numeric">Dni</th>
                                                <th data-column-id="cuitCliente" data-sortable="false">Cuit</th>
                                                <th data-column-id="nombreCliente" data-sortable="true">Nombre</th>
                                                <th data-column-id="apellidoCliente"data-sortable="true">Apellido</th>
                                                <th data-column-id="razonSocialCliente" data-order="asc">Razón Social</th>
                                                <th data-column-id="direccionCliente" data-sortable="false">Dirección</th>
                                                <th data-column-id="dLocalidad" data-sortable="false">Localidad</th>
                                                <th data-column-id="dProvincia" data-sortable="false">Provincia</th>

                                            </tr>
                                        </thead>                 
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="clear: both">
                            <button type="button" class="btn btn-default" onclick="$('#agregarVentana').modal('hide');
                                    $('#ventanaClientes').modal('hide');

                                    setTimeout(function () {
                                        $('#agregarVentana').modal('show')
                                    }, 600);">Volver</button> 
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
                                                <th data-column-id="stockUnidad" data-type="numeric" data-formatter="stock" data-sortable="false">Stock</th>
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
                                Confirmar Venta
                            </h4>
                        </div>
                        <form id="formConfirmar" onsubmit="agregarCompraConfirmacion();
                                return false;">
                            <div class="modal-body">
                                <div class="col-md-12 column" style="margin-bottom: 10px">
                                    <p id="montoTotalConfirmado">
                                        Desea guardar la compra e imprimir remito?
                                    </p>

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
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">DNI Cliente:</label>
                                            <div class="input-group">
                                                <input type="number" readonly required class="form-control" id="dniClienteP" name="dniClienteP"/>
                                                <span id="btnBuscarCliente" name="btnBuscarClienteP" class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Tipo Cliente:</label>                                                    
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                <input type="text" readonly required class="form-control" id="tipoClienteP"  name="tipoClienteP"/>                                                                                                                                                                    
                                            </div>
                                        </div>
                                    </div>
                                    <input type="text" readonly hidden required class="form-control" id="idTipoClienteP" name="idTipoClienteP" style=" display: none"/> 
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Nombre:</label>                                                    
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                <input type="text" readonly required class="form-control" id="nombreClienteP" name="nombreClienteP"/>                                                       
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Apellido:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                <input type="text" readonly required class="form-control" id="apellidoClienteP" name="apellidoClienteP"/>                                                        
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Razón Social:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-users"></span></span>
                                                <input type="text" readonly required class="form-control" id="razonSocialClienteP" name="razonSocialClienteP"/>                                                        
                                            </div>
                                        </div>
                                    </div>
                                </div>                               
                                <div  class="col-md-12 column" style=" margin-top: 20px;"> 
                                    <div id="divIdCompra" class="col-md-12 column" style="">
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Id Venta:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                                <input readonly type="text" class="form-control" id="idVentaP" name="idVentaP"/>
                                            </div>                
                                        </div>  
                                    </div>
                                    <div id="datosVenta">
                                        <div class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="nombre" style=" font-size: 15px;">Número de Factura:</label>                                            
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                                    <input type="text" readonly class="form-control" id="nroFacturaVentaP" name="nroFacturaVentaP"/>
                                                </div>                
                                            </div>  
                                        </div>
                                        <div class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="apellido" style=" font-size: 15px;">Número de Remito:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-list-alt"></span></span>
                                                    <input type="text" readonly class="form-control" id="nroRemitoVentaP" name="nroRemitoVentaP"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 column" style=""> 
                                            <div class="form-group">
                                                <label for="apellido" style=" font-size: 15px;">Fecha Venta:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                    <input readonly type="date" class="form-control" id="fechaHoyP" name="fechaHoyP"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="apellido" style=" font-size: 15px;">Hora Venta:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                    <input type="time" readonly class="form-control" id="horaHoyP" name="horaHoyP"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 column" style=""> 
                                            <div class="form-group">
                                                <label for="apellido" style=" font-size: 15px;">Fecha Entrega:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                    <input type="date" readonly class="form-control" id="fechaEntregaVentaP" name="fechaEntregaVentaP"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="apellido" style=" font-size: 15px;">Hora Entrega:</label>
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                    <input type="time" readonly class="form-control" id="horaEntregaVentaP" name="horaEntregaVentaP"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="divFechaVencimientoVenta" class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="nombre" style=" font-size: 15px;">Fecha Vencimiento:</label>                                            
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                    <input readonly type="date" class="form-control" id="fechaVencimientoVentaP" name="fechaVencimientoVentaP"/>
                                                </div>                
                                            </div>  
                                        </div>
                                        <div id="divEstadoVenta" class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="nombre" style=" font-size: 15px;">Estado:</label>                                            
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-flag"></span></span>
                                                    <input readonly type="text" class="form-control" id="estadoVentaP" name="estadoVentaP"/>
                                                </div>                
                                            </div>  
                                        </div>
                                        <div id="divFechaUCobroVenta" class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="nombre" style=" font-size: 15px;">Fecha Ultimo Pago:</label>                                            
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                                    <input readonly type="date" class="form-control" id="fechaUCobroVentaP" name="fechaUCobroVentaP"/>
                                                </div>                
                                            </div>  
                                        </div>
                                        <div id="divHoraUCobroVenta" class="col-md-6 column" style="">
                                            <div class="form-group">
                                                <label for="nombre" style=" font-size: 15px;">Hora Ultimo Pago:</label>                                            
                                                <div class="input-group">
                                                    <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                    <input readonly type="time" class="form-control" id="horaUCobroVentaP" name="horaUCobroVentaP"/>
                                                </div>                
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
                                        <label for="idmenu">Total Venta:</label>
                                        <div class="input-group pull-right" style=" text-align:right">
                                            <span class="input-group-addon "><span class='fa fa-money'></span></span> 
                                            <input readonly type=number step="any" class="form-control" id="totalCompraP" name="totalCompraP" style="font-size:20px; height: 40px; ">
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
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> 
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
                                Eliminar Venta
                            </h4>
                        </div>
                        <div class="modal-body">
                            <big>Se eliminaran los siguientes elementos relacionados con la venta elegida:</big>
                            <dl class="dl-horizontal">
                                <dt>Venta</dt>
                                <dd>Datos relacionados a la venta.</dd>
                                <dt>Línea de venta</dt>
                                <dd>Datos correspondientes a los artículos vendidos.</dd>
                                <dt>Pagos</dt>
                                <dd>Datos de pagos realizados y se descontarán de la cuenta corriente del cliente.</dd>
                                <dt>CC de Proveedor</dt>
                                <dd>Se cancelará la deuda pendiente del cliente.</dd>
                                <dt>Stock</dt>
                                <dd>Se agregarán los artículos al stock.</dd>
                            </dl>
                            <big>¿Desea eliminar la siguiente venta?</big>
                            <div class="col-md-12 column col-lg-12 col-xs-12 col-sm-12">
                                <div class="form-group">
                                    <label for="idmenu">Cliente:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class="fa fa-truck"></span></span> 

                                        <input readonly class="form-control"  id="dniClienteE" name="dniClienteE" style="font-size:20px; height: 40px;">
                                    </div>
                                </div>  
                            </div>                                                      
                            <div id="divIdCompra" class="col-md-12 column" style="">
                                <div class="form-group">
                                    <label for="nombre" style=" font-size: 15px;">Id Venta:</label>                                            
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class="fa fa-tag"></span></span>
                                        <input readonly type="text" class="form-control" id="idVentaE" name="idVentaE"/>
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
            <div class="modal fade" id="ventanaEstadoEntregado" data-backdrop="static" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Marcar Venta como Entregada
                            </h4>
                        </div>
                        <form id="formPago" name="formEntrega" onsubmit="btnEntregarOnclick2();
                                return false;"> 
                            <div class="modal-body">
                                <div class="col-md-12"> 
                                    <big style=" margin-bottom: 15px">Desea marcar la siguiente venta como Entregada? <br/></big>
                                    <div class="col-md-6 column" > 
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Id Venta:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span>
                                                <input required  type="text" readonly class="form-control" id="idVentaEstado" name="idVentaEstado"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Estado:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-flag"></span></span>
                                                <input readonly type="text" class="form-control" id="estadoEstado" name="estadoEstado"/>
                                            </div>                
                                        </div>  
                                    </div>
                                    <div class="col-md-6 column" style=""> 
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Fecha Entrega:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                                <input required  type="date" class="form-control" id="fechaEntrega" name="fechaEntrega"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Hora Entrega:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="fa fa-clock-o"></span></span>
                                                <input required type="time" step="any" class="form-control" id="horaEntrega" name="horaEntrega"/>
                                            </div>
                                        </div>
                                    </div>              
                                </div> 

                            </div>
                            <div class="modal-footer" style="clear: both">
                                <button type="button" class="btn btn-default" data-dismiss="modal">No</button> 
                                <button type="submit" class="btn btn-primary" onclick="">Si</button>
                            </div></form>
                    </div>

                </div>

            </div>

        </div>
        <div style="display:none">
            <form id='remito' method='post' action="Remito">
                <input type='text' name='idVentaRemito' id='idVentaRemito'>
                <input type='text' name='copiaRemito' id='copiaRemito'>
            </form>
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
                                //$("#dniCliente1").load("cargarClientesCombo");
                                carga2();
                                //cargaArt();
                                //setTimeout(function () {
                                // document.getElementById('dniCliente').value = document.getElementById('dniCliente1').value;
                                setTimeout(function () {
                                    carga();
                                }, 600);
                                //}, 300);
                                //$("#clientes").load("cargarTiposCliente");
                                cargaClientes();
                                $.post("verificarVencimientosVenta", function (rta) {
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
                                            if (arrVariableActual[0] == "idVenta") {
                                                var idVenta = arrVariableActual[1];

                                            }
                                        }
                                        if (idVenta != "")
                                        {
                                            seleccion = idVenta;
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
                                    url: "cargaTablaVentas",
                                    formatters: {
                                        "quantity"
                                                : function (column, row)
                                                {
                                                    return "<span class=\"estados\" name=\"" + row.estadoVenta + "\"> " + row.estadoVenta + "</span>";
                                                }, "vencimiento"
                                                : function (column, row)
                                                {
                                                    return "<span class=\"vencimiento\" name=\"" + row.fechaVencimientoVentaS + "\"> " + row.fechaVencimientoVentaS + "</span>";
                                                },
                                        "precio"
                                                : function (column, row)
                                                {
                                                    return "<span class=\"label label-default\">$ " + row.precioTotalVenta + "</span>";
                                                },
                                        "precioCalculado"
                                                : function (column, row)
                                                {
                                                    return "<span class=\"label label-default\">$ " + row.precioTotalVenta + "</span>";
                                                },
                                        "idCompra"
                                                : function (column, row)
                                                {
                                                    return "<span id=\"" + row.fechaEntregaCompraS + row.horaEntregaCompraS + "\"class=\"\">" + row.idVentaS + "</span>";
                                                }
                                    }
                                }).on("loaded.rs.jquery.bootgrid", function (e)
                                {
                                    var estados = document.getElementsByClassName('estados');
                                    for (var i = 0; i < estados.length; i++)
                                    {
                                        if ($(estados.item(i)).attr("name") == "Registrado")
                                        {
                                            $(estados.item(i)).addClass("label label-info");
                                        }
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
                                        if (datos[i].fechaVencimientoVentaS < fechaHoy)
                                        {
                                            if (datos[i].estadoVenta != "Pagado")
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
                                        seleccion = row.idVentaS;
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
                                                    proveedor: 1,
                                                    tipoLista: 'cliente',
                                                    tipoCliente: document.getElementById("idTipoCliente").value

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
                                                ,
                                                "stock"
                                                        : function (column, row)
                                                        {
                                                            return "<span class=\"stock\" name=\"" + row.stockUnidad + "\"> " + row.stockUnidad + "</span>";
                                                        }
                                            }
                                        }).on("loaded.rs.jquery.bootgrid", function (e)
                                        {
                                            var datos = $('#grid').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                                            var row;
                                            var vencimientos = document.getElementsByClassName('stock');
                                            var band = 0;
                                            for (var i = 0; i < datos.length; i++)
                                            {
                                                if (datos[i].stockUnidad <= 0)
                                                {

                                                    $(vencimientos.item(i)).addClass("label label-danger masgrande");


                                                }
                                            }
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
                                                $.post("modificarPrecio", {idArticulo: $(this).data("row-id"), precioArticulo: grid.find("#" + $(this).data("row-id") + "-quantity").val(), tipoPrecio: "cliente", cliente: document.getElementById("idTipoCliente").value, proveedor: 1, fechaHoy: fechaHoy}, function (rta) {
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
                            //carga clientes
                            function cargaClientes()
                            {

                                setTimeout(function () {
                                    $(function ()
                                    {
                                        var data = [];
                                        var grid = $("#gridClientes").bootgrid({
                                            ajax: true,
                                            selection: true,
                                            rowSelect: true,
                                            url: "cargarTablaClientesB",
                                            formatters: {
                                            }
                                        }).on("loaded.rs.jquery.bootgrid", function (e)
                                        {

                                        }).on("selected.rs.jquery.bootgrid", function (e, rows)
                                        {
                                            document.getElementById("dniCliente").value = rows[0].dniCliente;
                                            document.getElementById("nombreCliente").value = rows[0].nombreCliente;
                                            document.getElementById("apellidoCliente").value = rows[0].apellidoCliente;
                                            document.getElementById("razonSocialCliente").value = rows[0].razonSocialCliente;
                                            document.getElementById("idTipoCliente").value = rows[0].idTipoCliente;
                                            document.getElementById("tipoCliente").value = rows[0].dTipoCliente;
                                            document.getElementById("divAgregarArticulo").style.display = "inline";
                                            $('#agregarVentana').modal('hide');
                                            $('#ventanaClientes').modal('hide');
                                            $('#grid').bootgrid('reload');

                                            setTimeout(function () {
                                                $('#agregarVentana').modal('show')
                                            }, 700);

                                        }
                                        );

                                    });
                                }, 1000);
                            }

        </script>
        <script>
            var datosLineaVenta = [];
            var descripcionArticulo;
            var descripcionCalidad;
            var precioVenta;
            var totalCompra = 0;
            var stockUnidad = 0;

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
                                        return "<span class=\"\"> " + row.pesoLineaVenta + " kg</span>";
                                    }
                            , "unidad"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.cantidadLineaVenta + " u</span>";
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

            $("#formAgregarArt").on("submit", function ()
            {
                $("#btnBuscarCliente").removeClass("boton btn-default");
                //document.getElementById("cuitProveedor1").disabled = true;
                document.getElementById("descripcionArticulo").value = "";
                document.getElementById("calidadArticulo").value = "";
                idArticulo = document.getElementById('idArticulo').value;
                //alert(idArticulo);
                cantidadLineaVenta = document.getElementById('cantidadLineaVenta').value;
                pesoLineaVenta = document.getElementById('pesoLineaVenta').value;
                observacionLineaVenta = document.getElementById('observacionLineaVenta').value;
                datosLineaVenta[datosLineaVenta.length] = {idArticulo: idArticulo, cantidadLineaVenta: cantidadLineaVenta, pesoLineaVenta: pesoLineaVenta, observacionLineaVenta: observacionLineaVenta, precioCompra: precioVenta};                 //alert(datosLineasCompra);
                $("#grid2").bootgrid("append", [{
                        idArticulo: parseInt(datosLineaVenta[datosLineaVenta.length - 1].idArticulo),
                        cantidadLineaVenta: datosLineaVenta[datosLineaVenta.length - 1].cantidadLineaVenta,
                        pesoLineaVenta: datosLineaVenta[datosLineaVenta.length - 1].pesoLineaVenta,
                        observacionLineaVenta: datosLineaVenta[datosLineaVenta.length - 1].observacionLineaVenta,
                        descripcionArticulo: descripcionArticulo,
                        descripcionCalidad: descripcionCalidad,
                        precioCompra: precioVenta,
                        precioLineaCompra: Math.round((precioVenta * datosLineaVenta[datosLineaVenta.length - 1].pesoLineaVenta) * 100) / 100
                    }
                ]);
                totalCompra = Math.round((totalCompra + precioVenta * pesoLineaVenta) * 100) / 100;
                document.getElementById('totalVentaCalculado').value = totalCompra;
                document.getElementById('idArticulo').value = '';
                document.getElementById('cantidadLineaVenta').value = '';
                document.getElementById('pesoLineaVenta').value = '';
                document.getElementById('observacionLineaVenta').value = '';
                document.getElementById("descripcionArticulo").value = '';
                document.getElementById("calidadArticulo").value = '';

                return false;
            });

            function borrar(id)
            {
                var rows = Array();
                rows[0] = id;
                for (var i = 0; i < datosLineaVenta.length; i++)
                {
                    if (datosLineaVenta[i].idArticulo == id)
                    {
                        precioVenta = datosLineaVenta[i].precioCompra;
                        pesoLineaVenta = parseFloat(datosLineaVenta[i].pesoLineaVenta);
                        totalCompra = Math.round((totalCompra - (precioVenta * pesoLineaVenta)) * 100) / 100;
                        document.getElementById('totalVentaCalculado').value = totalCompra;
                        datosLineaVenta.splice(i, 1);
                        break;

                    }
                }
                $("#grid2").bootgrid('remove', rows);
                document.getElementById('idArticulo').value = '';
                document.getElementById('cantidadLineaVenta').value = '';
                document.getElementById('pesoLineaVenta').value = '';
                document.getElementById('observacionLineaVenta').value = '';
                document.getElementById("descripcionArticulo").value = '';
                document.getElementById("calidadArticulo").value = '';
            }


            function agregarCompra()
            {

                //document.getElementById('totalCalculadoVenta').value = totalCompra;
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
                $.post('venta', {dniCliente: document.getElementById('dniCliente').value, nroFacturaVenta: document.getElementById('nroFacturaVenta').value, nroRemitoVenta: document.getElementById('nroRemitoVenta').value, fechaHoy: fechaHoy, horaHoy: horaHoy, datosLineas: '{\"datos\":' + JSON.stringify(datosLineaVenta) + '}', totalVentaCalculado: totalCompra}, function (rta) {
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
                        var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                        document.getElementById("idVentaRemito").value = datos[0].idVentaS;
                        document.getElementById("copiaRemito").value = 1;
                        document.getElementById("remito").submit();
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
                //$("#dniCliente1").load("cargarClientesCombo");
                carga2();
                /* setTimeout(function () {
                 document.getElementById('dniCliente').value = document.getElementById('dniCliente1').value;
                 setTimeout(function () {                         //carga();
                 $('#grid').bootgrid('reload');
                 }, 1000);
                 }, 100);*/
                datosLineaVenta = [];
                totalCompra = 0;
                $("#btnBuscarCliente").addClass("boton btn-default");
                //document.getElementById("dniCliente1").disabled = false;
                document.getElementById("dniCliente").value = "";
                document.getElementById("tipoCliente").value = "";
                document.getElementById("nombreCliente").value = "";
                document.getElementById("apellidoCliente").value = "";
                document.getElementById("razonSocialCliente").value = "";
                document.getElementById("idVenta").value = "";
                document.getElementById("idArticulo").value = "";
                document.getElementById("descripcionArticulo").value = "";
                document.getElementById("calidadArticulo").value = "";
                document.getElementById("divIdVenta").style.display = "none";
                document.getElementById("nroFacturaVenta").value = "";
                document.getElementById("nroFacturaVenta").readOnly = false;
                document.getElementById("nroRemitoVenta").value = "";
                document.getElementById("nroRemitoVenta").readOnly = false;
                document.getElementById("fechaHoy").readOnly = false;
                document.getElementById("horaHoy").readOnly = false;
                document.getElementById("fechaVencimientoVenta").value = "";
                document.getElementById("divFechaVencimientoVenta").style.display = "none";
                document.getElementById("fechaUCobroVenta").value = "";
                document.getElementById("divFechaUCobroVenta").style.display = "none";
                document.getElementById("horaUCobroVenta").value = "";
                document.getElementById("divFechaEntregaVenta").style.display = "none";
                document.getElementById("fechaEntregaVenta").value = "";
                document.getElementById("divHoraEntregaVenta").style.display = "none";
                document.getElementById("horaEntregaVenta").value = "";
                document.getElementById("divHoraUCobroVenta").style.display = "none";
                document.getElementById("estadoVenta").value = "";
                document.getElementById("divEstadoVenta").style.display = "none";
                document.getElementById("totalVentaCalculado").value = 0;
                document.getElementById("divAgregarArticulo").style.display = "none";
                document.getElementById("btnGuardarVenta").style.display = "inline";
                document.getElementById("datosVenta").style.display = "inline";
                document.getElementById("datosProveedor").style.display = "inline";
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
                        if (datos[i].idVentaS == seleccion)
                        {
                            row = datos[i];
                        }
                    }
                    document.getElementById("dniCliente").value = row.dniCliente;
                    var datosClientes = $('#gridClientes').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                    var rowCliente;
                    for (var i = 0; i < datosClientes.length; i++)
                    {
                        if (datosClientes[i].dniCliente == row.dniCliente)
                        {
                            rowCliente = datosClientes[i];
                        }
                    }
                    document.getElementById("nombreCliente").value = rowCliente.nombreCliente;
                    document.getElementById("apellidoCliente").value = rowCliente.apellidoCliente;
                    document.getElementById("razonSocialCliente").value = rowCliente.razonSocialCliente;
                    document.getElementById("idTipoCliente").value = rowCliente.idTipoCliente;
                    document.getElementById("tipoCliente").value = rowCliente.dTipoCliente;
                    //document.getElementById("dniCliente1").value = row.dniCliente;
                    document.getElementById("idVenta").value = row.idVentaS;
                    document.getElementById("divIdVenta").style.display = "inline";
                    document.getElementById("nroFacturaVenta").value = row.nroFacturaVenta;
                    document.getElementById("nroFacturaVenta").readOnly = true;
                    document.getElementById("nroRemitoVenta").value = row.nroRemitoVenta;
                    document.getElementById("nroRemitoVenta").readOnly = true;
                    document.getElementById("fechaHoy").value = (row.fechaVentaS);
                    document.getElementById("fechaHoy").readOnly = true;
                    document.getElementById("horaHoy").value = row.horaVentaS;
                    document.getElementById("horaHoy").readOnly = true;
                    document.getElementById("fechaVencimientoVenta").value = row.fechaVencimientoVentaS;
                    document.getElementById("divFechaVencimientoVenta").style.display = "inline";
                    document.getElementById("fechaUCobroVenta").value = row.fechaUCobroVentaS;
                    document.getElementById("divFechaUCobroVenta").style.display = "inline";
                    document.getElementById("horaUCobroVenta").value = row.horaUCobroVentaS;
                    document.getElementById("divHoraUCobroVenta").style.display = "inline";
                    document.getElementById("fechaEntregaVenta").value = row.fechaEntregaVentaS;
                    document.getElementById("divFechaEntregaVenta").style.display = "inline";
                    document.getElementById("horaEntregaVenta").value = row.horaEntregaVentaS;
                    document.getElementById("divHoraEntregaVenta").style.display = "inline";
                    document.getElementById("estadoVenta").value = row.estadoVenta;
                    document.getElementById("divEstadoVenta").style.display = "inline";
                    document.getElementById("totalVentaCalculado").value = row.precioTotalVenta;
                    document.getElementById("divAgregarArticulo").style.display = "none";
                    document.getElementById("btnGuardarVenta").style.display = "none";
                    document.getElementById("datosVenta").style.display = "inline";
                    document.getElementById("datosProveedor").style.display = "inline";
                    $("#grid2").bootgrid("destroy");
                    var grid2 = $("#grid2").bootgrid({
                        ajax: true,
                        post: function ()
                        {
                            return {
                                idVenta: document.getElementById('idVenta').value

                            };
                        },
                        url: "cargarTablaLineasVenta",
                        formatters: {
                            "link": function (column, row)
                            {
                                return "<a href=\"#\">" + column.id + ": " + row.id + "</a>";
                            },
                            "precio": function (column, row)
                            {
                                return "<span class=\"label label-default\">$ " + row.precioVenta + "</span>";
                            }
                            , "precioLinea"
                                    : function (column, row)
                                    {
                                        return "<span class=\"label label-default\">$ " + row.precioLineaVenta + "</span>";
                                    }
                            ,
                            "peso"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.pesoLineaVenta + " kg</span>";
                                    }
                            , "unidad"
                                    : function (column, row)
                                    {
                                        return "<span class=\"\"> " + row.cantidadLineaVenta + " u</span>";
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
                        if (datos[i].idVentaS == seleccion)
                        {
                            row = datos[i];
                        }
                    }
                    ;
                    var f = new Date();
                    dia = (String(f.getDate())).length == 1 ? '0' + (f.getDate()) : (f.getDate());
                    mes = (String(f.getMonth() + 1)).length == 1 ? '0' + (f.getMonth() + 1) : (f.getMonth() + 1);
                    minutos = (String(f.getMinutes())).length == 1 ? '0' + (f.getMinutes()) : (f.getMinutes());
                    segundos = (String(f.getSeconds())).length == 1 ? '0' + (f.getSeconds()) : (f.getSeconds());
                    horas = (String(f.getHours())).length == 1 ? '0' + (f.getHours()) : (f.getHours());
                    document.getElementById("fechaPago").value = f.getFullYear() + "-" + mes + "-" + dia;
                    document.getElementById("horaPago").value = horas + ":" + minutos + ":" + segundos;
                    //cargar info clientes
                    document.getElementById("dniCliente").value = row.dniCliente;
                    var datosClientes = $('#gridClientes').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                    var rowCliente;
                    for (var i = 0; i < datosClientes.length; i++)
                    {
                        if (datosClientes[i].dniCliente == row.dniCliente)
                        {
                            rowCliente = datosClientes[i];
                        }
                    }
                    document.getElementById("dniClienteP").value = rowCliente.dniCliente;
                    document.getElementById("nombreClienteP").value = rowCliente.nombreCliente;
                    document.getElementById("apellidoClienteP").value = rowCliente.apellidoCliente;
                    document.getElementById("razonSocialClienteP").value = rowCliente.razonSocialCliente;
                    document.getElementById("idTipoClienteP").value = rowCliente.idTipoCliente;
                    document.getElementById("tipoClienteP").value = rowCliente.dTipoCliente;
                    document.getElementById("idVentaP").value = row.idVentaS;
                    document.getElementById("nroFacturaVentaP").value = row.nroFacturaVenta;
                    document.getElementById("nroRemitoVentaP").value = row.nroRemitoVenta;
                    document.getElementById("fechaHoyP").value = (row.fechaVentaS);
                    document.getElementById("fechaEntregaVentaP").value = (row.fechaEntregaVentaS);
                    document.getElementById("horaHoyP").value = row.horaVentaS;
                    document.getElementById("horaEntregaVentaP").value = row.horaEntregaVentaS;
                    document.getElementById("fechaVencimientoVentaP").value = row.fechaVencimientoVentaS;
                    document.getElementById("fechaUCobroVentaP").value = row.fechaUCobroVentaS;
                    document.getElementById("horaUCobroVentaP").value = row.horaUCobroVentaS;
                    document.getElementById("estadoVentaP").value = row.estadoVenta;
                    if (row.estadoVenta == "Pagado")
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
                                idTransaccion: document.getElementById('idVentaP').value

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
                        document.getElementById("totalCompraP").value = row.precioTotalVenta;
                        document.getElementById("totalAdeudado").value = Math.round((row.precioTotalVenta - totalPagado) * 100) / 100;
                        //$('[type="numeric"].montoPago').prop('max', Math.round((row.precioTotalCompra - totalPagado) * 100) / 100);
                        document.formPago.montoPago.setAttribute("max", Math.round((row.precioTotalVenta - totalPagado) * 100) / 100);
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
                $.post('PagoVenta', {idCompra: document.getElementById('idVentaP').value, formaDePago: document.getElementById('formaDePago').value, montoPago: document.getElementById('montoPago').value, nroCheque: document.getElementById('nroCheque').value, bancoCheque: document.getElementById('bancoCheque').value, nombreCheque: document.getElementById('nombreCheque').value, fechaPago: document.getElementById('fechaPago').value, horaPago: document.getElementById('horaPago').value, tipoTransaccion: 'venta'}, function (rta) {
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
                        precioTotalCompra = document.getElementById("totalCompraP").value;
                        document.getElementById("totalAdeudado").value = Math.round((precioTotalCompra - totalPagado) * 100) / 100;
                        //$('[type="numeric"].montoPago').prop('max', Math.round((row.precioTotalCompra - totalPagado) * 100) / 100);
                        document.formPago.montoPago.setAttribute("max", Math.round((precioTotalCompra - totalPagado) * 100) / 100);
                        var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                        for (var i = 0; i < datos.length; i++) {
                            if (datos[i].idVentaS == seleccion) {
                                row = datos[i];
                            }
                        }
                        document.getElementById("fechaUCobroVentaP").value = row.fechaUCobroVentaS;
                        document.getElementById("horaUCobroVentaP").value = row.horaUCobroVentaS;
                        document.getElementById("estadoVentaP").value = row.estadoVenta;
                        if (row.estadoVenta == "Pagado")
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
                    }, 800);
                });
            }
            function btnEntregarOnclick()
            {
                if (seleccion != 0)
                {
                    var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                    var row;
                    for (var i = 0; i < datos.length; i++)
                    {
                        if (datos[i].idVentaS == seleccion)
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
                    document.getElementById("fechaEntrega").value = f.getFullYear() + "-" + mes + "-" + dia;
                    document.getElementById("horaEntrega").value = horas + ":" + minutos + ":" + segundos;
                    document.getElementById("idVentaEstado").value = row.idVentaS;
                    document.getElementById("estadoEstado").value = row.estadoVenta;
                    $('#ventanaEstadoEntregado').modal('show');
                }
                else
                {
                    document.getElementById("alerta").style.display = "inline";
                }
            }
            function btnEntregarOnclick2()
            {
                $.post('EntregaMercaderia', {estado: document.getElementById('estadoEstado').value, idVenta: document.getElementById('idVentaEstado').value, fechaEntrega: document.getElementById('fechaEntrega').value, horaEntrega: document.getElementById('horaEntrega').value}, function (rta) {
                    if (rta === "")
                    {
                        $('#ventanaEstadoEntregado').modal('hide');
                        $("#grid3").bootgrid('reload');
                    }
                    else
                    {
                        document.getElementById("alertaError").style.display = "inline";
                        document.getElementById("error").innerHTML = rta;
                    }
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
                        if (datos[i].idVentaS == seleccion)
                        {
                            row = datos[i];
                        }
                    }
                    document.getElementById("dniClienteE").value = row.dniCliente;
                    document.getElementById("idVentaE").value = row.idVentaS;
                    document.getElementById("fechaHoyE").value = (row.fechaVentaS);
                    document.getElementById("horaHoyE").value = row.horaVentaS;
                    $('#ventanaEliminar').modal('show');
                }
                else
                {
                    document.getElementById("alerta").style.display = "inline";
                }
            }
            function btnEliminarOnClick2()
            {
                $.post("eliminarVenta", {idVenta: document.getElementById("idVentaE").value}, function (rta) {
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

            function btnReimprimirOnclick()
            {
                if (seleccion != 0)
                {
                    var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                    document.getElementById("idVentaRemito").value = datos[0].idVentaS;
                    document.getElementById("copiaRemito").value = 1;
                    document.getElementById("remito").submit();
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
                var datosArticulo = $('#grid').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                for (var i = 0; i < datosArticulo.length; i++)
                {
                    if (datosArticulo[i].idArticulo == document.getElementById("idArticulo").value)
                    {
                        row = datosArticulo[i];
                    }
                }
                if (row.montoPrecioCompra == 0)
                {
                    document.getElementById("idArticulo").setCustomValidity("No se tiene registro de precio para este articulo para el tipo de cliente específicado");
                    descripcionArticulo = '';
                    precioVenta = 0;
                    descripcionCalidad = '';
                }
                else
                {
                    if (row.stockUnidad > 0)
                    {
                        document.getElementById("idArticulo").setCustomValidity("");
                        document.getElementById("descripcionArticulo").value = row.descripcionArticulo;
                        descripcionArticulo = row.descripcionArticulo;
                        document.getElementById("calidadArticulo").value = row.descripcionCalidad;
                        descripcionCalidad = row.descripcionCalidad;
                        precioVenta = row.montoPrecioCompra;
                        stockUnidad = row.stockUnidad;
                    }
                    else
                    {
                        document.getElementById("idArticulo").setCustomValidity("No hay stock disponible para la venta de este artículo.");
                        descripcionArticulo = '';
                        precioVenta = 0;
                        descripcionCalidad = '';
                    }
                }
                for (var i = 0; i < datosLineaVenta.length; i++)
                {
                    if (datosLineaVenta[i].idArticulo == document.getElementById("idArticulo").value)
                    {
                        document.getElementById("idArticulo").setCustomValidity("El articulo ya se registro");
                        break;
                    }
                    else
                    {
                        document.getElementById("idArticulo").setCustomValidity("");
                    }


                }
                if (row.montoPrecioCompra == 0)
                {
                    document.getElementById("idArticulo").setCustomValidity("No se tiene registro de precio para este articulo para el tipo de cliente específicado");
                }
                if (row.stockUnidad <= 0)
                {
                    document.getElementById("idArticulo").setCustomValidity("No hay stock disponible para la venta de este artículo.");
                }


            }

            function validarStock()
            {
                if (stockUnidad - document.getElementById('cantidadLineaVenta').value < 0)
                {
                    document.getElementById("cantidadLineaVenta").setCustomValidity("No hay stock suficiente para la venta de esta cantidad de artículos.");
                }
                else
                {
                    document.getElementById("cantidadLineaVenta").setCustomValidity("");
                }

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

            function validar()
            {
                if (datosLineaVenta.length == 0)
                {
                    document.getElementById("dniCliente").setCustomValidity("No se ha registrado ningun articulo");
                }
                else
                {
                    document.getElementById("dniCliente").setCustomValidity("");
                    $('#formPrincipal').submit();
                }

            }


        </script>

    </body>
</html>
