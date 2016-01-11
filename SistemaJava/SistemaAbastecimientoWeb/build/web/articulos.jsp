<%-- 
    Document   : articulos
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
                <small>Carga de datos > <b>Artículos</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Artículos</h4>
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

                            </h4> <strong>Correcto!</strong> El artículo elegido se ha eliminado correctamente.
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

                            </h4> <strong>Error!</strong> El artículo elegido no ha sido eliminada. Vuelva a intentarlo.
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

                            </h4> <strong>Correcto!</strong> El artículo se ha activado correctamente.
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

                            </h4> <strong>Error!</strong> El artículo no ha sido activado. Vuelva a intentarlo.
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
                                <option value="descripcionArticulo">Descripción</option>
                                <option value="descripcionCalidad">Calidad</option>                                    
                            </select>
                        </div> 
                    </div>
                    <div class="col-md-8 column">
                        <div class="form-group">
                            <i class="fa fa-search"></i>
                            <label for="buscar">Buscar:</label><input type="text" class="form-control" id="buscar" onkeyup="var data2 = {name: 'busqueda', value: document.getElementById('buscar').value};
                                    var data = {name: 'filtro', value: document.getElementById('filtro').value};
                                    $('.tablaArticulos').flexOptions({params: [data2, data]}).flexReload();">
                        </div>
                    </div>             
                </div>
                <div class="col-md-12 column" style=" margin-bottom: 20px;">
                    <table id="tablaArticulos" class="tablaArticulos">                                       
                    </table>
                </div>


            </div>
        </div>
        <div class="col-md-12 column">
            <!--<a id="modal-871707" href="#ventanaArticulo" role="button" class="btn" data-toggle="modal">Launch demo modal</a>-->

            <div class="modal fade" id="ventanaArticulo" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                <div class="modal-dialog" style="">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title" id="myModalLabel">
                                Artículo
                            </h4>
                        </div>
                        <form action="ABMArticulo" id="formArticulo" method="post">
                            <div class="modal-body">
                                <div class="col-md-12 column">                                  
                                    <div class="col-md-7 column col-lg-7 col-xs-12 col-sm-12">
                                        <div class="form-group">
                                            <label for="idmenu">Id Artículo:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span> 
                                                <input type="number" readonly autocomplete="off" required class="form-control" id="idArticulo" name="idArticulo" style="font-size:20px; height: 40px;" value=""/>
                                            </div>
                                        </div>   
                                        <div class="form-group">
                                            <label for="calidad">Calidad:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-star"></span></span>
                                                <select style="font-size: 15px;" required class="form-control" id="calidad" name="calidad">
                                                </select>
                                            </div>
                                        </div>                        
                                    </div>                               
                                    <div class="col-md-5 column col-lg-5 hidden-xs hidden-sm" style=" padding-top: 10px;">
                                        <div style="">
                                            <img id="imagenArticulo" src="imagenes/vacapartes.png" style="width: 100%;text-align: center;"/>                                           
                                        </div> 
                                    </div>
                                    <div class="col-md-12 column" style=" margin-top: 20px;"> 
                                        <div class="form-horizontal" style="">
                                            <div class="form-group" style="clear: both;">
                                                <label for="descripcionArticulo" class="col-sm-2 control-label">Descripción:</label>
                                                <div class="col-sm-10">
                                                    <input type="text" required class="form-control" id="descripcionArticulo" name="descripcionArticulo"/>
                                                </div>
                                            </div>                                                     
                                        </div>
                                        <div class="form-horizontal" style="">
                                            <div class="form-group" style="clear: both;">
                                                <label for="pesoEstimado" class="col-sm-2 control-label">Peso Estimado:</label>
                                                <div class="col-sm-10">
                                                    <div class="input-group">
                                                        <input type="number" required class="form-control" id="pesoEstimadoArticulo" name="pesoEstimadoArticulo"/>
                                                        <span class="input-group-addon">kg</span>
                                                    </div>
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
                                    $('.tablaArticulos').flexigrid({
                                        height: 'auto',
                                        url: '/SistemaAbastecimientoWeb/cargarTablaArticulos',
                                        method: 'GET',
                                        dataType: 'json',
                                        colModel: [
                                            {display: 'Código', name: 'idArticulo', width: 80, sortable: true, align: 'left', process: procMe},
                                            {display: 'Descripción', name: 'descripcionArticulo', width: 600, sortable: true, align: 'left', process: procMe},
                                            {display: 'Peso estimado', name: 'pesoEstimadoArticulo', width: 160, sortable: true, align: 'left', process: procMe},
                                            {display: 'Estado', name: 'estadoArticulo', width: 60, sortable: true, align: 'left', process: procMe},
                                            {display: 'IdCalidad', name: 'idCalidad', hide: true, width: 60, sortable: true, align: 'left', process: procMe},
                                            {display: 'Calidad', name: 'descripcionCalidad', width: 150, sortable: true, align: 'left', process: procMe}

                                        ],
                                        sortname: "descripcionArticulo",
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
                                        estado = $(this).parent().siblings().next().next().next().children().html();
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
                                    $.post('recuperarUltimoIdArticulo', function (datos)
                                    {
                                        document.getElementById('idArticulo').value = datos;
                                    })
                                    $("#calidad").load("cargarCalidades");
                                    document.getElementById("accion").value = "alta";
                                    document.getElementById('btnAgregar').value = "Agregar";
                                    document.getElementById('idArticulo').value = "";
                                    document.getElementById('calidad').value = "";
                                    document.getElementById('descripcionArticulo').value = "";
                                    document.getElementById('pesoEstimadoArticulo').value = "";
                                    $('#ventanaArticulo').modal('toggle');
                                    document.getElementById('calidad').focus();

                                }
                                ;
                                function btnModificarOnclick() {
                                    var band = 0;
                                    document.getElementById("accion").value = "modificacion";
                                    jQuery('#tablaArticulos .trSelected').each(function () {

                                        document.getElementById('idArticulo').value = jQuery('[abbr="idArticulo"]', this).text();
                                        document.getElementById('descripcionArticulo').value = jQuery('[abbr="descripcionArticulo"]', this).text();
                                        document.getElementById('pesoEstimadoArticulo').value = jQuery('[abbr="pesoEstimadoArticulo"]', this).text();
                                        calidad = parseInt(jQuery('[abbr="idCalidad"]', this).text());
                                        $("#calidad").load("cargarCalidades");
                                        setTimeout(function () {
                                            document.getElementById('calidad').value = calidad;
                                        }, 800);
                                        document.getElementById('idArticulo').readOnly = "true";
                                        document.getElementById('btnAgregar').value = "Modificar";
                                        band = 1;
                                        $('#ventanaArticulo').modal('toggle');
                                        document.getElementById('calidad').focus();
                                    });
                                    if (band === 0)
                                        document.getElementById('alerta').style.display = 'block';
                                }
                                ;

                                function btnEliminarOnclick() {
                                    var band = 0;
                                    jQuery('#tablaArticulos .trSelected').each(function () {
                                        if (jQuery('[abbr="estadoArticulo"]', this).text() === "Activo")
                                        {
                                            document.getElementById("accion").value = "eliminar";

                                        }
                                        else
                                        {
                                            document.getElementById("accion").value = "activar";

                                        }
                                        var code = jQuery('[abbr="idArticulo"]', this).text();
                                        band = 1;
                                        $.post('ABMArticulo', {idArticulo: code, accion: document.getElementById("accion").value}, function (error) {
                                            $('.tablaArticulos').flexReload();
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

        </script>
    </body>
</html>
