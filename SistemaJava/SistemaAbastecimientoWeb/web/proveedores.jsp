<%-- 
    Document   : proveedores
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
                <small>Carga de datos > <b>Proveedores</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Proveedores</h4>
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

                            </h4> <strong>Correcto!</strong> El proveedor elegido se ha eliminado correctamente.
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

                            </h4> <strong>Error!</strong> El proveedor elegido no ha sido eliminada. Vuelva a intentarlo.
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

                            </h4> <strong>Correcto!</strong> El proveedor se ha activado correctamente.
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

                            </h4> <strong>Error!</strong> El proveedor no ha sido activado. Vuelva a intentarlo.
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
                            </select>
                        </div> 
                    </div>
                    <div class="col-md-8 column">
                        <div class="form-group">
                            <i class="fa fa-search"></i>
                            <label for="buscar">Buscar:</label><input type="text" class="form-control" id="buscar" onkeyup="var data2 = {name: 'busqueda', value: document.getElementById('buscar').value};
                                    var data = {name: 'filtro', value: document.getElementById('filtro').value};
                                    $('.tablaProveedores').flexOptions({params: [data2, data]}).flexReload();">
                        </div>
                    </div>             
                </div>
                <div class="col-md-12 column" style=" margin-bottom: 20px;">
                    <table id="tablaProveedores" class="tablaProveedores">                                       
                    </table>
                </div>


            </div>
        </div>
        <div class="col-md-12 column">
            <!--<a id="modal-871707" href="#ventanaArticulo" role="button" class="btn" data-toggle="modal">Launch demo modal</a>-->

            <div class="modal fade" id="ventanaProveedores" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                <div class="modal-dialog" style="">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title" id="myModalLabel">
                                Proveedor
                            </h4>
                        </div>
                        <form action="ABMProveedor" id="formArticulo" method="post">
                            <div class="modal-body">
                                <div class="col-md-12 column">                                  
                                    <div class="col-md-7 column col-lg-7 col-xs-12 col-sm-12">
                                        <div class="form-group">
                                            <label for="idmenu">CUIT:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span> 
                                                <input type="number" autocomplete="off" required class="form-control" id="cuitProveedor" name="cuitProveedor" style="font-size:20px; height: 40px;" value=""/>
                                            </div>
                                        </div>  
                                        <div class="form-group">
                                            <label for="nombre" style=" font-size: 15px;">Nombre:</label>                                            
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <input type="text" required class="form-control" id="nombreProveedor" name="nombreProveedor"/>
                                            </div>                
                                        </div>   
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Apellido:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                <input type="text" class="form-control" id="apellidoProveedor" name="apellidoProveedor"/>
                                            </div>
                                        </div>
                                    </div>                               
                                    <div class="col-md-5 column col-lg-5 hidden-xs hidden-sm" style=" padding-top: 10px;">
                                        <div style="">
                                            <img id="imagenArticulo" src="imagenes/proveedor.png" style="width: 100%;text-align: center;"/>                                           
                                        </div> 
                                    </div>
                                    <div class="col-md-12 column" style=" margin-top: 20px;"> 
                                        <div class="form-horizontal" style="">                                                                                  
                                            <div class="form-group" style="clear: both;">
                                                <label for="direccion" class="col-sm-2 control-label" style=" font-size: 15px;">Dirección:</label>
                                                <div class="col-sm-10">
                                                    <input type="text" autocomplete="off" required class="form-control" id="direccionProveedor" name="direccionProveedor"/>
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
                                                    <input type="number" autocomplete="off" class="form-control" id="telefonoProveedor" name="telefonoProveedor"/>
                                                </div>
                                            </div>
                                            <div class="form-group" style="clear: both;">
                                                <label for="celular" class="col-sm-2 control-label" style=" font-size: 15px;">Celular:</label>
                                                <div class="col-sm-10">
                                                    <input type="number" autocomplete="off" class="form-control" id="celularProveedor" name="celularProveedor"/>
                                                </div>
                                            </div>
                                            <div class="form-group" style="clear: both;">
                                                <label for="email" class="col-sm-2 control-label" style=" font-size: 15px;">Email:</label>
                                                <div class="col-sm-10">
                                                    <input type="email" autocomplete="off" class="form-control" id="emailProveedor" name="emailProveedor"/>
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
                                                                        $('.tablaProveedores').flexigrid({
                                                                            height: 'auto',
                                                                            url: '/SistemaAbastecimientoWeb/cargarTablaProveedores',
                                                                            method: 'GET',
                                                                            dataType: 'json',
                                                                            colModel: [
                                                                                {display: 'CUIT', name: 'cuitProveedor', width: 90, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Nombre', name: 'nombreProveedor', width: 160, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Apellido', name: 'apellidoProveedor', width: 160, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Dirección', name: 'direccionProveedor', hide: true, width: 60, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Provincia', name: 'dProvincia', width: 100, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Provincia', hide: 'true', name: 'provinciaProveedor', width: 60, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Ciudad', name: 'dLocalidad', width: 80, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Ciudad', name: 'localidadProveedor', width: 60, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Telefono', name: 'telefonoProveedor', width: 100, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Celular', name: 'celularProveedor', width: 100, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Email', name: 'emailProveedor', width: 150, sortable: true, align: 'left', process: procMe},
                                                                                {display: 'Estado', name: 'estadoProveedor', width: 60, sortable: true, align: 'left', process: procMe}

                                                                            ],
                                                                            sortname: "nombreProveedor",
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
                                                                            estado = $(this).parent().siblings().next().next().next().next().next().next().next().next().next().next().next().children().html();
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
                                                                        document.getElementById("accion").value = "alta";
                                                                        document.getElementById('btnAgregar').value = "Agregar";
                                                                        document.getElementById('cuitProveedor').value = "";
                                                                        document.getElementById('nombreProveedor').value = "";
                                                                        document.getElementById('apellidoProveedor').value = "";
                                                                        document.getElementById('direccionProveedor').value = "";
                                                                        document.getElementById('telefonoProveedor').value = "";
                                                                        document.getElementById('celularProveedor').value = "";
                                                                        document.getElementById('provincia').value = "";
                                                                        document.getElementById('ciudad').value = "";
                                                                        document.getElementById('ciudad').options.length = 0;
                                                                        document.getElementById('cuitProveedor').readOnly = false;
                                                                        $('#ventanaProveedores').modal('toggle');
                                                                        document.getElementById('cuitProveedor').focus();

                                                                    }
                                                                    ;
                                                                    function btnModificarOnclick() {
                                                                        var band = 0;
                                                                        document.getElementById("accion").value = "modificacion";
                                                                        jQuery('#tablaProveedores .trSelected').each(function () {
                                                                            document.getElementById('cuitProveedor').value = jQuery('[abbr="cuitProveedor"]', this).text();
                                                                            email = jQuery('[abbr="emailProveedor"]', this).text()
                                                                            if (email !== "")
                                                                                document.getElementById('emailProveedor').value = email;
                                                                            document.getElementById('nombreProveedor').value = jQuery('[abbr="nombreProveedor"]', this).text();
                                                                            document.getElementById('apellidoProveedor').value = jQuery('[abbr="apellidoProveedor"]', this).text();
                                                                            document.getElementById('direccionProveedor').value = jQuery('[abbr="direccionProveedor"]', this).text();
                                                                            document.getElementById('telefonoProveedor').value = jQuery('[abbr="telefonoProveedor"]', this).text();
                                                                            document.getElementById('celularProveedor').value = jQuery('[abbr="celularProveedor"]', this).text();
                                                                            $("#provincia").load("cargarProvincias");
                                                                            provincia = parseInt(jQuery('[abbr="provinciaProveedor"]', this).text());
                                                                            localidad = parseInt(jQuery('[abbr="localidadProveedor"]', this).text());
                                                                            setTimeout(function () {
                                                                                document.getElementById('provincia').value = provincia;
                                                                                cargarCiudades();
                                                                            }, 800);
                                                                            setTimeout(function () {
                                                                                document.getElementById('ciudad').value = localidad;
                                                                            }, 1800);
                                                                            document.getElementById('cuitProveedor').readOnly = "true";
                                                                            document.getElementById('btnAgregar').value = "Modificar";
                                                                            band = 1;
                                                                            $('#ventanaProveedores').modal('toggle');
                                                                            document.getElementById('nombreProveedor').focus();
                                                                        });
                                                                        if (band === 0)
                                                                            document.getElementById('alerta').style.display = 'block';
                                                                    }
                                                                    ;

                                                                    function btnEliminarOnclick() {
                                                                        var band = 0;
                                                                        jQuery('#tablaProveedores .trSelected').each(function () {
                                                                            if (jQuery('[abbr="estadoProveedor"]', this).text() === "Activo")
                                                                            {
                                                                                document.getElementById("accion").value = "eliminar";

                                                                            }
                                                                            else
                                                                            {
                                                                                document.getElementById("accion").value = "activar";

                                                                            }
                                                                            var code = jQuery('[abbr="cuitProveedor"]', this).text();
                                                                            band = 1;
                                                                            $.post('ABMProveedor', {cuitProveedor: code, accion: document.getElementById("accion").value}, function (error) {
                                                                                $('.tablaProveedores').flexReload();
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
