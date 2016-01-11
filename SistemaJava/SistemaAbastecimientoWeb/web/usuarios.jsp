<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema Abastecimiento de Carnes</title>

        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/home.css" rel="stylesheet">
        <!-- Roboto Font -->
        <link href="http://fonts.googleapis.com/css?family=Roboto:400,700,300,500" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
        <link href="css/jquery.bootgrid.css" rel="stylesheet" />
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
                <small>Carga de datos > <b>Usuarios</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Usuarios</h4>
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

                <div class="col-lg-12 col-md-12">
                    <div class="table-responsive clearfix">
                        <table id="gridUsuarios" name="gridUsuarios" class="table table-striped">
                            <thead>
                                <tr>
                                    <th data-column-id="dniUsuario" data-identifier="true" data-type="numeric" data-sortable="true">Dni</th>
                                    <th data-column-id="nombreUsuario" data-order="asc" data-sortable="true">Nombre</th>
                                    <th data-column-id="apellidoUsuario" data-sortable="true">Apellido</th>
                                    <th data-column-id="direccion" data-sortable="false">Direccion</th>
                                    <th data-column-id="dLocalidad" data-sortable="true">Localidad</th>
                                    <th data-column-id="dProvincia"  data-sortable="true">Provincia</th>
                                    <th data-column-id="telefonoUsuario" data-sortable="false">Telefono</th>
                                    <th data-column-id="celularUsuario" data-order="desc" data-sortable="true">Celular</th>
                                    <th data-column-id="emailUsuario" data-sortable="false">Email</th>
                                    <th data-column-id="estado" data-formatter="quantity" data-sortable="false">Estado</th>
                                    <th data-column-id="fechaAltaS" data-sortable="false">Alta</th>
                                    <th data-column-id="fechaBajaS" data-sortable="false">Baja</th>
                                    <th data-column-id="provinciaUsuario" data-visible="false" data-sortable="false">Provincia</th>
                                    <th data-column-id="localidadUsuario" data-visible="false" data-sortable="false">Localidad</th>

                                </tr>
                            </thead>                 
                        </table>
                    </div>
                </div>


            </div>
        </div>
        <div class="col-md-12 column">
            <!--<a id="modal-871707" href="#ventanaArticulo" role="button" class="btn" data-toggle="modal">Launch demo modal</a>-->

            <div class="modal fade" id="ventanaUsuario" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
                <div class="modal-dialog" style="">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title" id="myModalLabel">
                                Usuario
                            </h4>
                        </div>
                        <form action="ABMUsuario" id="formArticulo" method="post">
                            <div class="modal-body">
                                <div class="col-md-12 column">                                  
                                    <div class="col-md-7 column col-lg-7 col-xs-12 col-sm-12">
                                        <div class="form-group">
                                            <label for="idmenu">DNI:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span> 
                                                <input type="number" autocomplete="off" readonly required class="form-control" id="dniUsuario" name="dniUsuario" style="font-size:20px; height: 40px;" value=""/>
                                            </div>
                                        </div>
                                        <div class="form-group" id="cambiarContraseña" style="margin-top:-10px;">
                                            <div class="col-sm-offset-2 col-sm-10">
                                                <div class="checkbox">
                                                    <label><input id="cambiarContra" name="cambiarContra" type="checkbox" onclick="cambiarContraseña()" /> Cambiar Contraseña</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="idmenu">Contraseña:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-barcode"></span></span> 
                                                <input type="password" autocomplete="off" required class="form-control" id="pass" name="pass" style="font-size:20px; height: 40px;" value=""/>
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="calidad">Tipo Usuario:</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><span class="glyphicon glyphicon-star"></span></span>
                                                <select style="font-size: 15px;" required class="form-control" id="tipoUsuario" name="tipoUsuario">
                                                    <option value="Administrador">Administrador</option>
                                                    <option value="Empleado">Empleado</option>
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
                                                        <input type="text" autocomplete="off" required class="form-control" id="nombreUsuario" name="nombreUsuario"/>
                                                    </div>
                                                </div>
                                            </div>   
                                            <div class="form-group">
                                                <label for="apellido" class="col-sm-2 control-label" style=" font-size: 15px;">Apellido:</label>
                                                <div class="col-sm-10">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                                        <input type="text" autocomplete="off" required class="form-control" id="apellidoUsuario" name="apellidoUsuario"/>
                                                    </div>
                                                </div>
                                            </div> 

                                            <div class="form-group" style="clear: both;">
                                                <label for="direccion" class="col-sm-2 control-label" style=" font-size: 15px;">Dirección:</label>
                                                <div class="col-sm-10">
                                                    <input type="text" autocomplete="off" required class="form-control" id="direccionUsuario" name="direccionUsuario"/>
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
                                                    <input type="number" autocomplete="off" class="form-control" id="telefonoUsuario" name="telefonoUsuario"/>
                                                </div>
                                            </div>
                                            <div class="form-group" style="clear: both;">
                                                <label for="celular" class="col-sm-2 control-label" style=" font-size: 15px;">Celular:</label>
                                                <div class="col-sm-10">
                                                    <input type="number" autocomplete="off" class="form-control" id="celularUsuario" name="celularUsuario"/>
                                                </div>
                                            </div>
                                            <div class="form-group" style="clear: both;">
                                                <label for="email" class="col-sm-2 control-label" style=" font-size: 15px;">Email:</label>
                                                <div class="col-sm-10">
                                                    <input type="email" autocomplete="off" class="form-control" id="emailUsuario" name="emailUsuario"/>
                                                </div>
                                            </div>   
                                            <div id="dFechaAlta" class="form-group" style="clear: both;">
                                                <label for="email" class="col-sm-2 control-label" style=" font-size: 15px;">Fecha Alta:</label>
                                                <div class="col-sm-10">
                                                    <input type="date" readonly autocomplete="off" class="form-control" id="fechaAlta" name="fechaAlta"/>
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
        <script src="js/jquery.bootgrid.js"></script>
        <script>
                                                                    var seleccion = 0;
                                                                    window.onload = function cargaInicial() {
                                                                        //$("#alertAdvertencia").alert('close');
                                                                        $('[data-toggle="tooltip"]').tooltip({
                                                                            placement: 'bottom'
                                                                        });
                                                                        carga2();
                                                                    };

                                                                    //carga tabla principal
                                                                    function carga2()
                                                                    {
                                                                        var data = [];
                                                                        var gridUsuarios = $("#gridUsuarios").bootgrid({
                                                                            ajax: true,
                                                                            selection: true,
                                                                            keepSelection: false,
                                                                            rowSelect: true,
                                                                            rowCount: [40, 50, 60, 10],
                                                                            url: "cargarTablaUsuariosB",
                                                                            formatters: {
                                                                                "quantity"
                                                                                        : function (column, row)
                                                                                        {
                                                                                            return "<span class=\"estados\" name=\"" + row.estado + "\"> " + row.estado + "</span>";
                                                                                        }
                                                                            }
                                                                        }).on("loaded.rs.jquery.bootgrid", function (e)
                                                                        {
                                                                            var estados = document.getElementsByClassName('estados');
                                                                            for (var i = 0; i < estados.length; i++)
                                                                            {
                                                                                if ($(estados.item(i)).attr("name") == "Activo")
                                                                                {
                                                                                    $(estados.item(i)).addClass("label label-success");
                                                                                }
                                                                                if ($(estados.item(i)).attr("name") == "Inactivo")
                                                                                {
                                                                                    $(estados.item(i)).addClass("label label-danger");
                                                                                }

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
                                                                                seleccion = row.dniUsuario;
                                                                            }
                                                                            estado = row.estado;
                                                                            if (estado === "Inactivo")
                                                                            {
                                                                                document.getElementById("btnEliminar").value = "Activar";
                                                                            }
                                                                            else
                                                                            {
                                                                                document.getElementById("btnEliminar").value = "Eliminar";
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


                                                                    function btnAgregarOnclick() {
                                                                        var f = new Date();
                                                                        dia = (String(f.getDate())).length == 1 ? '0' + (f.getDate()) : (f.getDate());
                                                                        mes = (String(f.getMonth() + 1)).length == 1 ? '0' + (f.getMonth() + 1) : (f.getMonth() + 1);
                                                                        fechaHoy = f.getFullYear() + "-" + mes + "-" + dia;
                                                                        document.getElementById("fechaAlta").value = fechaHoy;
                                                                        document.getElementById('pass').readOnly = false;
                                                                        document.getElementById('cambiarContraseña').style.display = 'none';
                                                                        document.getElementById("dFechaAlta").style.display = "inline";
                                                                        document.getElementById("accion").value = "alta";
                                                                        document.getElementById('btnAgregar').value = "Agregar";
                                                                        document.getElementById('dniUsuario').value = "";
                                                                        document.getElementById('tipoUsuario').value = "";
                                                                        document.getElementById('nombreUsuario').value = "";
                                                                        document.getElementById('apellidoUsuario').value = "";
                                                                        document.getElementById('direccionUsuario').value = "";
                                                                        document.getElementById('telefonoUsuario').value = "";
                                                                        document.getElementById('celularUsuario').value = "";
                                                                        document.getElementById('provincia').value = "";
                                                                        document.getElementById('ciudad').value = "";
                                                                        document.getElementById('ciudad').options.length = 0;
                                                                        document.getElementById('dniUsuario').readOnly = false;
                                                                        $('#ventanaUsuario').modal('toggle');
                                                                        document.getElementById('dniUsuario').focus();

                                                                    }
                                                                    ;
                                                                    function btnModificarOnclick() {
                                                                        var band = 0;
                                                                        document.getElementById("accion").value = "modificacion";
                                                                        if (seleccion != 0) {
                                                                            var datos = $('#gridUsuarios').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                                                                            var row;
                                                                            var totalPagado = 0;
                                                                            for (var i = 0; i < datos.length; i++)
                                                                            {
                                                                                if (datos[i].dniUsuario == seleccion)
                                                                                {
                                                                                    row = datos[i];
                                                                                }
                                                                            }
                                                                            document.getElementById('cambiarContraseña').style.display = 'block';
                                                                            document.getElementById('pass').value = "";
                                                                            document.getElementById('pass').readOnly = "true";
                                                                            document.getElementById('dniUsuario').value = row.dniUsuario;
                                                                            document.getElementById('tipoUsuario').value = row.tipoUsuario;
                                                                            document.getElementById("dFechaAlta").style.display = "none";
                                                                            document.getElementById('emailUsuario').value = row.emailUsuario;
                                                                            document.getElementById('nombreUsuario').value = row.nombreUsuario;
                                                                            document.getElementById('apellidoUsuario').value = row.apellidoUsuario;
                                                                            document.getElementById('direccionUsuario').value = row.direccionUsuario;
                                                                            document.getElementById('telefonoUsuario').value = row.telefonoUsuario;
                                                                            document.getElementById('celularUsuario').value = row.celularUsuario;
                                                                            $("#provincia").load("cargarProvincias");
                                                                            provincia = row.provinciaUsuario;
                                                                            localidad = row.localidadUsuario;
                                                                            setTimeout(function () {
                                                                                document.getElementById('provincia').value = provincia;
                                                                                cargarCiudades();
                                                                            }, 800);
                                                                            setTimeout(function () {
                                                                                document.getElementById('ciudad').value = localidad;
                                                                            }, 1800);
                                                                            document.getElementById('dniUsuario').readOnly = "true";
                                                                            document.getElementById('btnAgregar').value = "Modificar";
                                                                            band = 1;
                                                                            $('#ventanaUsuario').modal('toggle');
                                                                            document.getElementById('tipoUsuario').focus();

                                                                        }
                                                                        if (band === 0)
                                                                            document.getElementById('alerta').style.display = 'block';
                                                                    }
                                                                    ;

                                                                    function btnEliminarOnclick() {
                                                                        var band = 0;
                                                                        if (seleccion != 0) {
                                                                            var datos = $('#gridUsuarios').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                                                                            var row;
                                                                            var totalPagado = 0;
                                                                            for (var i = 0; i < datos.length; i++)
                                                                            {
                                                                                if (datos[i].dniUsuario == seleccion)
                                                                                {
                                                                                    row = datos[i];
                                                                                }
                                                                            }
                                                                            if (row.estado === "Activo")
                                                                            {
                                                                                document.getElementById("accion").value = "eliminar";

                                                                            }
                                                                            else
                                                                            {
                                                                                document.getElementById("accion").value = "activar";

                                                                            }
                                                                            var code = row.dniUsuario;
                                                                            band = 1;
                                                                            var f = new Date();
                                                                            dia = (String(f.getDate())).length == 1 ? '0' + (f.getDate()) : (f.getDate());
                                                                            mes = (String(f.getMonth() + 1)).length == 1 ? '0' + (f.getMonth() + 1) : (f.getMonth() + 1);
                                                                            fechaHoy = f.getFullYear() + "-" + mes + "-" + dia;
                                                                            $.post('ABMUsuario', {dniUsuario: code, accion: document.getElementById("accion").value, fechaBaja: fechaHoy}, function (error) {
                                                                                $("#gridUsuarios").bootgrid('reload');
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
                                                                        }
                                                                        ;
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
                                                                    function cambiarContraseña()
                                                                    {
                                                                        if (document.getElementById('cambiarContra').checked)
                                                                        {
                                                                            document.getElementById('pass').readOnly = false;

                                                                        }
                                                                        else
                                                                        {
                                                                            document.getElementById('pass').readOnly = "true";
                                                                            document.getElementById('pass').value = "";
                                                                        }
                                                                    }
        </script>
    </body>
</html>
