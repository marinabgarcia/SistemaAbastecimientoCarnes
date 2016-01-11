<%-- 
    Document   : clientes
    Created on : 06/01/2015, 10:51:17
    Author     : Marina
--%>

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
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/flexigrid.pack.css" />
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
                <small>Carga de datos > <b>Clientes</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Clientes</h4>
            </div>
            <div class="col-md-12 col-lg-12 col-xs-12 col-sm-12" style="color: #373737;">

                <!--MENSAJE DE ERROR-->
                <%
                    if (request.getAttribute("div") == "") {
                        if (request.getAttribute("error") != null) {
                %>
                <div class="alert alert-danger alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4>

                    </h4> <strong>Error!</strong> 

                    <%
                        out.println(request.getAttribute("error"));
                        request.setAttribute("error", "");
                    %>
                </div>
                <%
                        }
                    }
                %>
                <!--FIN-->
                <div class="row clearfix" id="alertaEliminar" hidden style="margin-bottom: -20px; margin-top: 10px;">
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                    <div class="col-md-6 column" style="margin-bottom: 0px;">
                        <div class="alert alert-dismissable alert-success">
                            <button type="button" class="close" onclick="document.getElementById('alertaEliminar').style.display = 'none';">×</button>
                            <h4>

                            </h4> <strong>Correcto!</strong> El cliente elegido se ha eliminado correctamente.
                        </div>
                    </div>
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                </div>
                <div class="row clearfix" id="errorEliminar" hidden style="margin-bottom: -20px; margin-top: 10px;">
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                    <div class="col-md-6 column" style="margin-bottom: 0px;">
                        <div class="alert alert-dismissable alert-danger">
                            <button type="button" class="close" onclick="document.getElementById('errorEliminar').style.display = 'none';">×</button>
                            <h4>

                            </h4> <strong>Error!</strong> El cliente elegido no ha sido eliminada. Vuelva a intentarlo.
                        </div>
                    </div>
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                </div>
                <div class="row clearfix" id="alertaActivar" hidden style="margin-bottom: -20px; margin-top: 10px;">
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                    <div class="col-md-6 column" style="margin-bottom: 0px;">
                        <div class="alert alert-dismissable alert-success">
                            <button type="button" class="close" onclick="document.getElementById('alertaActivar').style.display = 'none';">×</button>
                            <h4>

                            </h4> <strong>Correcto!</strong> El cliente se ha activado correctamente.
                        </div>
                    </div>
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                </div>
                <div class="row clearfix" id="errorActivar" hidden style="margin-bottom: -20px; margin-top: 10px;">
                    <div class="col-md-3 column" style="margin-bottom: 0px;"></div>
                    <div class="col-md-6 column" style="margin-bottom: 0px;">
                        <div class="alert alert-dismissable alert-danger">
                            <button type="button" class="close" onclick="document.getElementById('errorActivar').style.display = 'none';">×</button>
                            <h4>

                            </h4> <strong>Error!</strong> El cliente no ha sido activado. Vuelva a intentarlo.
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
                </div>

                <!--MENSAJE DE OPERACIÓN EXITOSA-->
                <%
                    if (request.getAttribute(
                            "div") == "") {
                        if (request.getAttribute("mensaje") != null) {
                %>
                <div class="alert alert-success alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4>

                    </h4> <strong>Correcto!</strong> 

                    <%
                        out.println(request.getAttribute("mensaje"));
                        request.setAttribute("mensaje", "");
                    %>
                </div>
                <%
                        }
                    }
                %>
                <!--FIN-->
                <!--BOTONES abm-->
                <div class="row clearfix" style="margin-top: 50px; margin-bottom: 50px;">
                    <div class="col-md-12 column">
                        <div class="row clearfix">
                            <div class="col-md-4 column col-lg-4 col-sm-4 hidden-xs">
                                <input onclick="btnAgregarOnclick()" type="button" role="button" class="btn btn-success btn-block" value="Agregar">
                            </div>
                            <div class="col-xs-4 hidden-lg hidden-md hidden-sm">
                                <button onclick="btnAgregarOnclick()" type="button" role="button" class="btn btn-success" style=" width: 100%;" data-toggle="tooltip" data-original-title="Agregar"><i class=" fa fa-plus fa-2x" ></i></button>
                            </div>
                            <div class="col-md-4 column col-lg-4 col-sm-4 hidden-xs">
                                <input type="button" id="btnModificar" name="btnModificar" onclick="btnModificarOnclick()" class="btn btn-info btn-block" value="Modificar">
                            </div>
                            <div class="col-xs-4 hidden-lg hidden-md hidden-sm">
                                <button onclick="btnModificarOnclick()" id="btnModificar" name="btnModificar" type="button" role="button" class="btn btn-info" style=" width: 100%;" data-toggle="tooltip" data-original-title="Modificar"><i class=" fa fa-pencil fa-2x"></i></button>
                            </div>
                            <div class="col-md-4 column col-lg-4 col-sm-4 hidden-xs">
                                <input type="button" id="btnEliminar" name="btnEliminar" onclick="btnEliminarOnclick()" class="btn btn-danger btn-block" value="Eliminar">
                            </div>
                            <div class="col-xs-4 hidden-lg hidden-md hidden-sm">
                                <button onclick="btnEliminarOnclick()" id="btnEliminar" name="btnEliminar" type="button" role="button" class="btn btn-danger" style=" width: 100%;" data-toggle="tooltip" data-original-title="Eliminar o Activar"><i class=" fa fa-minus-circle fa-2x"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 column">
                    <div class="col-md-4 column">
                        <div class="form-group">
                            <i class="fa fa-filter"></i>
                            <label for="filtro">Filtro:</label>
                            <select class="form-control" id="filtro" name="filtro" onchange="document.getElementById('buscar').value = '';">
                                <option value="apellidoCliente">Apellido</option>
                                <option value="nombreCliente">Nombre</option>                                    
                                <option value="cuitCliente">CUIT</option>                                    
                                <option value="dniCliente">DNI</option>                                    
                            </select>
                        </div> 
                    </div>
                    <div class="col-md-8 column">
                        <div class="form-group">
                            <i class="fa fa-search"></i>
                            <label for="buscar">Buscar:</label><input type="text" class="form-control" id="buscar" onkeyup="var data2 = {name: 'busqueda', value: document.getElementById('buscar').value};
                                    var data = {name: 'filtro', value: document.getElementById('filtro').value};
                                    $('.tablaClientes').flexOptions({params: [data2, data]}).flexReload();">
                        </div>
                    </div>             
                </div>
                <div class="col-md-12 column" style=" margin-bottom: 20px;">
                    <table id="tablaClientes" class="tablaClientes">                                       
                    </table>
                </div>


            </div>
        </div>
        <div class="col-md-12 column">
            <!--<a id="modal-871707" href="#ventanaArticulo" role="button" class="btn" data-toggle="modal">Launch demo modal</a>-->

            <div class="modal fade" id="ventanaCliente" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                <div class="modal-dialog" style="">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title" id="myModalLabel">
                                Cliente
                            </h4>
                        </div>
                        <form action="ABMCliente" id="formArticulo" method="post">
                            <div class="modal-body">
                                <div class="col-md-12 column">                                  
                                    <div class="col-md-7 column col-lg-7 col-xs-12 col-sm-12">
                                        <div class="form-group">
                                            <label for="idmenu">DNI:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span> 
                                                <input type="number" readonly autocomplete="off" required class="form-control" id="dniCliente" name="dniCliente" style="font-size:20px; height: 40px;" value=""/>
                                            </div>
                                        </div>  
                                        <div class="form-group">
                                            <label for="idmenu">CUIT:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span> 
                                                <input type="number" autocomplete="off" required class="form-control" id="cuitCliente" name="cuitCliente" style="font-size:20px; height: 40px;" value=""/>
                                            </div>
                                        </div>  

                                        <div class="form-group">
                                            <label for="calidad">Tipo Cliente:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-star"></span></span>
                                                <select style="font-size: 15px;" required class="form-control" id="tipoCliente" name="tipoCliente">
                                                </select>
                                            </div>
                                        </div> 
                                    </div>                               
                                    <div class="col-md-5 column col-lg-5 hidden-xs hidden-sm" style=" padding-top: 10px;">
                                        <div style="">
                                            <img id="imagenArticulo" src="imagenes/admin.png" style="width: 100%;text-align: center;"/>                                           
                                        </div> 
                                    </div>
                                    <div class="col-md-12 column" style=" margin-top: 20px;"> 
                                        <div class="form-horizontal" style="">
                                            <div class="form-group">
                                                <label for="nombre" class="col-sm-2 control-label" style=" font-size: 15px;">Nombre:</label>
                                                <div class="col-sm-10">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                        <input type="text" required class="form-control" id="nombreCliente" name="nombreCliente"/>
                                                    </div>
                                                </div>
                                            </div>   
                                            <div class="form-group">
                                                <label for="apellido" class="col-sm-2 control-label" style=" font-size: 15px;">Apellido:</label>
                                                <div class="col-sm-10">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                        <input type="text" required class="form-control" id="apellidoCliente" name="apellidoCliente"/>
                                                    </div>
                                                </div>
                                            </div> 
                                            <div class="form-group" style="clear: both;">
                                                <label for="direccion" class="col-sm-2 control-label" style=" font-size: 15px;">Razón Social:</label>
                                                <div class="col-sm-10">
                                                    <input type="text" autocomplete="off" required class="form-control" id="razonSocialCliente" name="razonSocialCliente"/>
                                                </div>
                                            </div>
                                            <div class="form-group" style="clear: both;">
                                                <label for="direccion" class="col-sm-2 control-label" style=" font-size: 15px;">Dirección:</label>
                                                <div class="col-sm-10">
                                                    <input type="text" autocomplete="off" required class="form-control" id="direccionCliente" name="direccionCliente"/>
                                                </div>
                                            </div>
                                            <div class="col-md-12" style=" margin-left: 0px; padding-left: 0px;margin-right: 0px; padding-right: 0px">
                                                <div class="col-md-6" style=" margin-left: 0px; padding-left: 0px; margin-right: 0px; padding-right: 4px">
                                                    <div class="form-group" style="clear: both;">
                                                        <div class="col-sm-12 col-lg-8 col-md-8 col-xs-12" style=" ">
                                                            <label for="provincia" class="control-label" style=" font-size: 15px ">Provincia:</label>
                                                        </div>
                                                        <div class="col-sm-12 col-lg-4 col-md-4 col-xs-12">
                                                            <div style="text-align: right; background-color: white; float: right;">
                                                                <select required class="form-control" id="provincia" name="provincia" onchange="cargarCiudades();" style="min-width: 170px;"></select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6" style=" margin-left: 0px; padding-left: 4px; margin-right: 0px; padding-right: 0px ">
                                                    <div class="form-group" style="clear: both;">
                                                        <div class="col-sm-12 col-lg-8 col-md-8 col-xs-12">
                                                            <label for="ciudad" class="control-label"  style=" font-size: 15px; ">Ciudad:</label>
                                                        </div>
                                                        <div class="col-sm-12 col-lg-4 col-md-4 col-xs-12">
                                                            <div style="text-align: right; background-color: white; float: right;">
                                                                <select required class="form-control" id="ciudad" name="ciudad" style="min-width: 180px;"></select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group" style="clear: both;">
                                                <label for="telefono" class="col-sm-2 control-label" style=" font-size: 15px;">Teléfono:</label>
                                                <div class="col-sm-10">
                                                    <input type="number" autocomplete="off" class="form-control" id="telefonoCliente" name="telefonoCliente"/>
                                                </div>
                                            </div>
                                            <div class="form-group" style="clear: both;">
                                                <label for="celular" class="col-sm-2 control-label" style=" font-size: 15px;">Celular:</label>
                                                <div class="col-sm-10">
                                                    <input type="number" autocomplete="off" class="form-control" id="celularCliente" name="celularCliente"/>
                                                </div>
                                            </div>
                                            <div class="form-group" style="clear: both;">
                                                <label for="email" class="col-sm-2 control-label" style=" font-size: 15px;">Email:</label>
                                                <div class="col-sm-10">
                                                    <input type="email" autocomplete="off" class="form-control" id="emailCliente" name="emailCliente"/>
                                                </div>
                                            </div>                                                     
                                        </div>
                                    </div>
                                    <input id="accion" name="accion" type="text" hidden />                 
                                </div>
                            </div>
                            <div class="modal-footer" style=" clear: both;">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cerrar"> 
                                <input type="submit" id="btnAgregar" class="btn btn-primary" onclick="" value="Agregar">
                            </div> 
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="PieDePagina.jspf" %>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/Chart.js"></script>
        <script src="js/jquery.simpleWeather.js"></script>
        <script type="text/javascript" src="js/easypiechart.js"></script>
        <script type="text/javascript" src="js/jquery.easypiechart.js"></script>
        <script type="text/javascript" src="js/flexigrid.pack.js"></script>
        <script type="text/javascript" src="js/flexigrid.js"></script>
        <script>
                                                                    $(document).ready(function () {
                                                                        $('.tablaClientes').flexigrid({
                                                                            height: 'auto',
                                                                            url: '/SistemaAbastecimientoWeb/cargarTablaClientes',
                                                                            method: 'GET',
                                                                            dataType: 'json',
                                                                            colModel: [
                                                                                {display: 'DNI', name: 'dniCliente', width: 80, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'CUIT', name: 'cuitCliente', width: 90, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Nombre', name: 'nombreCliente', width: 160, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Apellido', name: 'apellidoCliente', width: 160, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Razón Social', name: 'razonSocialCliente', width: 160, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Tipo Cliente', name: 'idTipoCliente', hide: true, width: 60, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Tipo Cliente', name: 'dTipoCliente', width: 80, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Dirección', name: 'direccionCliente', hide: true, width: 60, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Provincia', name: 'dProvincia', width: 80, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Provincia', hide: 'true', name: 'provinciaCliente', width: 60, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Ciudad', name: 'dLocalidad', width: 80, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Ciudad', name: 'localidadCliente', width: 60, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Telefono', name: 'telefonoCliente', width: 100, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Celular', name: 'celularCliente', width: 100, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Email', name: 'emailCliente', width: 150, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Estado', name: 'estadoCliente', width: 60, sortable: true, align: 'left', process: procMe}

                                                                            ],
                                                                            sortname: "apellidoCliente",
                                                                            sortorder: "asc",
                                                                            usepager: true,
                                                                            //title: 'Líneas de Pedido',
                                                                            useRp: true,
                                                                            width: 'auto',
                                                                            rp: 50,
                                                                            resizable: true,
                                                                            params: [{name: 'busqueda', value: ''}, {name: 'filtro', value: ''}],
                                                                            showTableToggleBtn: false,
                                                                            singleSelect: true
                                                                        });
                                                                    });

                                                                    function procMe(celDiv, id) {
                                                                        $(celDiv).click(function () {
                                                                            estado = $(this).parent().siblings().next().next().next().next().next().next().next().next().next().next().next().next().next().next().children().html();
                                                                            console.log(estado);
                                                                            if (estado === "Inactivo")
                                                                            {
                                                                                document.getElementById("btnEliminar").value = "Activar";
                                                                            }
                                                                            else
                                                                            {
                                                                                document.getElementById("btnEliminar").value = "Eliminar";
                                                                            }
                                                                        });
                                                                    }
                                                                    $(document).ready(function () {
                                                                        $('[data-toggle="tooltip"]').tooltip({
                                                                            placement: 'bottom'
                                                                        });
                                                                    });
                                                                    function btnAgregarOnclick() {

                                                                        $("#tipoCliente").load("cargarTiposCliente");
                                                                        document.getElementById("accion").value = "alta";
                                                                        document.getElementById('btnAgregar').value = "Agregar";
                                                                        document.getElementById('dniCliente').value = "";
                                                                        document.getElementById('tipoCliente').value = "";
                                                                        document.getElementById('cuitCliente').value = "";
                                                                        document.getElementById('razonSocialCliente').value = "";
                                                                        document.getElementById('nombreCliente').value = "";
                                                                        document.getElementById('apellidoCliente').value = "";
                                                                        document.getElementById('direccionCliente').value = "";
                                                                        document.getElementById('telefonoCliente').value = "";
                                                                        document.getElementById('celularCliente').value = "";
                                                                        document.getElementById('provincia').value = "";
                                                                        document.getElementById('ciudad').value = "";
                                                                        document.getElementById('ciudad').options.length = 0;
                                                                        document.getElementById('dniCliente').readOnly = false;
                                                                        $('#ventanaCliente').modal('toggle');
                                                                        document.getElementById('dniCliente').focus();

                                                                    }
                                                                    ;
                                                                    function btnModificarOnclick() {
                                                                        var band = 0;
                                                                        document.getElementById("accion").value = "modificacion";
                                                                        jQuery('#tablaClientes .trSelected').each(function () {

                                                                            document.getElementById('dniCliente').value = jQuery('[abbr="dniCliente"]', this).text();
                                                                            document.getElementById('cuitCliente').value = jQuery('[abbr="cuitCliente"]', this).text();
                                                                            document.getElementById('razonSocialCliente').value = jQuery('[abbr="razonSocialCliente"]', this).text();
                                                                            tipo = parseInt(jQuery('[abbr="idTipoCliente"]', this).text());
                                                                            $("#tipoCliente").load("cargarTiposCliente");
                                                                            setTimeout(function () {
                                                                                document.getElementById('tipoCliente').value = tipo;
                                                                            }, 800);
                                                                            email = jQuery('[abbr="emailCliente"]', this).text()
                                                                            if (email !== "")
                                                                                document.getElementById('emailCliente').value = email;
                                                                            document.getElementById('nombreCliente').value = jQuery('[abbr="nombreCliente"]', this).text();
                                                                            document.getElementById('apellidoCliente').value = jQuery('[abbr="apellidoCliente"]', this).text();
                                                                            document.getElementById('direccionCliente').value = jQuery('[abbr="direccionCliente"]', this).text();
                                                                            document.getElementById('telefonoCliente').value = jQuery('[abbr="telefonoCliente"]', this).text();
                                                                            document.getElementById('celularCliente').value = jQuery('[abbr="celularCliente"]', this).text();
                                                                            $("#provincia").load("cargarProvincias");
                                                                            provincia = parseInt(jQuery('[abbr="provinciaCliente"]', this).text());
                                                                            localidad = parseInt(jQuery('[abbr="localidadCliente"]', this).text());
                                                                            setTimeout(function () {
                                                                                document.getElementById('provincia').value = provincia;
                                                                                cargarCiudades();
                                                                            }, 800);
                                                                            setTimeout(function () {
                                                                                document.getElementById('ciudad').value = localidad;
                                                                            }, 1800);
                                                                            document.getElementById('dniCliente').readOnly = "true";
                                                                            document.getElementById('btnAgregar').value = "Modificar";
                                                                            band = 1;
                                                                            $('#ventanaCliente').modal('toggle');
                                                                            document.getElementById('cuitCliente').focus();
                                                                        });
                                                                        if (band === 0)
                                                                            document.getElementById('alerta').style.display = 'block';
                                                                    }
                                                                    ;

                                                                    function btnEliminarOnclick() {
                                                                        var band = 0;
                                                                        jQuery('#tablaClientes .trSelected').each(function () {
                                                                            if (jQuery('[abbr="estadoCliente"]', this).text() === "Activo")
                                                                            {
                                                                                document.getElementById("accion").value = "eliminar";

                                                                            }
                                                                            else
                                                                            {
                                                                                document.getElementById("accion").value = "activar";

                                                                            }
                                                                            var code = jQuery('[abbr="dniCliente"]', this).text();
                                                                            band = 1;
                                                                            $.post('ABMCliente', {dniCliente: code, accion: document.getElementById("accion").value}, function (error) {
                                                                                $('.tablaClientes').flexReload();
                                                                                if (error === "")
                                                                                {
                                                                                    if (document.getElementById("accion").value === "eliminar")
                                                                                        document.getElementById('alertaEliminar').style.display = 'inline';
                                                                                    else
                                                                                        document.getElementById('alertaActivar').style.display = 'inline';
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (document.getElementById("accion").value === "eliminar")
                                                                                        document.getElementById('errorEliminar').style.display = 'inline';
                                                                                    else
                                                                                        document.getElementById('errorActivar').style.display = 'inline';
                                                                                }
                                                                            });
                                                                        });
                                                                        if (band === 0)
                                                                            document.getElementById('alerta').style.display = 'block';
                                                                    }
                                                                    function cargarCiudades() {
                                                                        //obtiene los objetos productCode, 
                                                                        var code = $("#provincia").val(); //.. y se obtiene el valor
                                                                        //llama al servlet con el parametro seleccionado
                                                                        $("#ciudad").load("cargarCiudades", {idProvincia: code});
                                                                    }

                                                                    $(document).ready(function () {
                                                                        $("#provincia").load("cargarProvincias");
                                                                    });
        </script>
    </body>
</html>
