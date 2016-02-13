<%-- 
    Document   : listaprecios
    Created on : 12/01/2015, 15:14:45
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
        <link rel="stylesheet" href="font-awesome/css/font-awesome.css">
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
        
                <small>Carga de datos > <b>Lista de Precios</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Lista de Precios</h4>
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
                 <form id='imprimir' method='post' action="ImprimirLista">
                <div class="col-md-12col-sm-12 col-xs-12 col-lg-12 column" style="">
                    <div class="col-md-6 col-sm-12 col-xs-12 col-lg-6 column" style="">
                        <div class="form-group">
                            <label for="calidad">Tipo Lista de Precios:</label>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-star"></span></span>
                                <select style="font-size: 15px;" required class="form-control" id="tipoPrecio" name="tipoPrecio" onchange="cambiarLista()">
                                    <option value="proveedor" selected>Compra a Proveedores</option>
                                    <option value="cliente">Venta a Clientes</option>
                                </select>
                            </div>
                        </div> 
                         <button type="button" class="btn btn-info btn-block" data-dismiss="alert" onClick="OnImprimirClick()" aria-hidden="true" style=" height: 100px; width: 110px; margin-left: 0px;"><span class="fa fa-print fa-3x" style=" color: white; display: block;"></span>Imprimir Lista</button>
                    </div>
                    <div class="col-md-6 col-sm-12 col-xs-12 col-lg-6 column" style="">
                        <div id="divProveedor" class="form-group">
                            <label for="calidad">Proveedores:</label>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="fa fa-truck"></span></span>
                                <select style="font-size: 15px;" onchange="$('#grid').bootgrid('reload');" required class="form-control" id="proveedores" name="proveedores">                                   
                                </select>
                            </div>
                        </div> 
                        <div id="divCliente" class="form-group" style=" display: none;">
                            <label for="calidad">Clientes:</label>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="fa fa-users"></span></span>
                                <select style="font-size: 15px;" onchange="$('#grid').bootgrid('reload');
                                        cambiarListaCliente();" required class="form-control" id="clientes" name="clientes">                                   
                                </select>
                            </div>
                        </div> 
                       
                           
                        
                       
                    </div>
                </div>
                     </form>
                <div id="divRestablecer" class="col-md-12 column col-sm-12 col-xs-12 col-lg-12 column" style="padding: 20px; display: none;">
                    <div class="col-md-9 column col-sm-12 col-xs-12 col-lg-9 column" style=" margin-top:15px;">
                        <div class="progress progress-striped active">
                            <div id="progressb" class="progress-bar progress-bar-danger">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 col-xs-12 col-lg-3 column" style=" text-align: right; margin-top: 10px;">
                        <input type="button" id="btnRestablecer" name="btnRestablecer" onclick="restablecer();" class="btn btn-danger btn-sm btn-block" value="Restablecer precios" style="display: none;">

                        <input type="button" id="btnRestablecerGenerico" name="btnRestablecerGenerico" onclick="restablecerGenerico();" class="btn btn-danger btn-sm btn-block" value="Restablecer precios Genéricos" style="display: none;">
                    </div>
                </div>
                <table id="grid" class="table table-condensed table-hover table-striped">
                    <thead>
                        <tr>
                            <th data-column-id="idArticulo" data-identifier="true" data-header-css-class="commandIdArticulo" data-type="numeric">Id Artículo</th>
                            <th data-column-id="descripcionArticulo" data-order="asc">Descripción</th>
                            <th data-column-id="descripcionCalidad">Calidad</th>
                            <th data-column-id="quantity" data-formatter="quantity">Precio</th>
                            <th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn">Modificar</th>
                        </tr>
                    </thead>                 
                </table>

            </div>
        </div>
        <div class="col-md-12 column">
            <!--<a id="modal-748572" href="#ventanaRestablecerPrecios" role="button" class="btn" data-toggle="modal">Launch demo modal</a>-->

            <div class="modal fade" id="ventanaRestablecerPrecios" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Restablecer Precios
                            </h4>
                        </div>
                        <div class="modal-body">
                            <p>Los precios de la lista correspondiente al tipo de cliente <b id="tipoCliente"></b> se restablecerán de acuerdo
                                a los precios establecidos en la Lista Genérica sumándo un porcentaje correspondiente al siguiente:</p>
                            <div class="col-md-7 col-lg-7 col-sm-12 col-xs-12 column">
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Porcentaje aumento:</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="porcentajePrecioVenta" />
                                        <span class="input-group-addon">%&nbsp;&nbsp;&nbsp;<span id="tickPorcentaje" class=" fa fa-check" style=" display: none; color: green;"></span></span>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5 col-lg-5 col-sm-12 col-xs-12 column">

                                <input type="button" class="btn btn-warning" value='Modificar Porcentaje' onclick="$.post('modificarTipoCliente', {idTipoCliente: document.getElementById('clientes').value, descripcionTipoCliente: document.getElementById('clientes').options[document.getElementById('clientes').selectedIndex].text, porcentajeTipoCliente: document.getElementById('porcentajePrecioVenta').value}, function (rta) {
                                            if (rta == 1) {
                                                document.getElementById('tickPorcentaje').style.display = 'inline';
                                                $('#tickPorcentaje').removeClass('fa-minus-circle');
                                                $('#tickPorcentaje').addClass('fa-check');
                                                document.getElementById('tickPorcentaje').style.color = 'green';
                                            }
                                            else
                                            {
                                                document.getElementById('tickPorcentaje').style.display = 'inline';
                                                $('#tickPorcentaje').removeClass('fa-check');
                                                $('#tickPorcentaje').addClass('fa-minus-circle');
                                                document.getElementById('tickPorcentaje').style.color = 'red';
                                            }
                                        })" style="margin: 25px"/> 

                            </div>
                        </div>

                        <div class="modal-footer" style=" clear: both;">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> 
                            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="btnRestablecerOnclick()">Restablecer</button>
                        </div>
                    </div>

                </div>

            </div>

        </div>
        <div class="col-md-12 column">
            <!--<a id="modal-748572" href="#ventanaRestablecerPreciosGenericos" role="button" class="btn" data-toggle="modal">Launch demo modal</a>-->

            <div class="modal fade" id="ventanaRestablecerPreciosGenericos" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Restablecer Precios
                            </h4>
                        </div>
                        <div class="modal-body">
                            <p>Los precios de la lista correspondiente al tipo de cliente <b id="tipoCliente"></b> se restablecerán de acuerdo
                                a los precios establecidos en la Lista de Compra del siguiente proveedor:</p>
                            <div class="col-md-7 col-lg-7 col-sm-12 col-xs-12 column">
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Proveedor:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon"><span id="cuitProveedorTick" class=" fa fa-check" style=" display: none; color: green;"></span></span>
                                        <select class="form-control" id="cuitProveedor">
                                        </select>


                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="modal-footer" style=" clear: both;">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button> 
                            <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="btnRestablecerOnclick2()">Restablecer</button>
                        </div>
                    </div>

                </div>

            </div>

        </div>
        <div class="col-md-12 column">
            <!--<a id="modal-748572" href="#ventanaDetallePrecio" role="button" class="btn" data-toggle="modal">Launch demo modal</a>-->

            <div class="modal fade" id="ventanaDetallePrecio" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                                        <input class="form-control" readonly id="idArticulo">  
                                    </div>
                            </div>
                            <h4>Precios vigentes de Compra a proveedor</h4>
                            <table id="gridPrecioCompra" class="table table-condensed table-hover table-striped">
                                <thead>
                                    <tr>

                                        <th data-column-id="cuitProveedor" data-order="asc">Cuit</th>
                                        <th data-column-id="nombreProveedor">Proveedor</th>
                                        <th data-column-id="quantity" data-formatter="quantity">Precio</th>

                                    </tr>
                                </thead>                 
                            </table>
                            <h4>Precios vigentes de Venta a cliente</h4>
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

                        <div class="modal-footer" style=" clear: both;">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>                            
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
        <script>
                                window.onload = function carga() {
                                    $('[data-toggle="tooltip"]').tooltip({
                                        placement: 'left'
                                    });
                                    $("#proveedores").load("cargarProveedores");
                                    $("#clientes").load("cargarTiposCliente");
                                    setTimeout(function () {
                                        $(function ()
                                        {
                                            var data = [];
                                            var grid = $("#grid").bootgrid({
                                                ajax: true,
                                                post: function ()
                                                {
                                                    return {
                                                        proveedor: document.getElementById('proveedores').value,
                                                        tipoLista: document.getElementById('tipoPrecio').value,
                                                        tipoCliente: document.getElementById('clientes').value

                                                    };
                                                },
                                                url: "cargarTablaPrecio",
                                                formatters: {
                                                    "quantity"
                                                            : function (column, row)
                                                            {
                                                                return "<div id=\"" + row.idArticulo + "-div\" class=\"input-group\"><span class=\"input-group-addon\"><i id=\"" + row.idArticulo + "-tick\" class=\"fa fa-usd\" style=\"color:green;\"></i></span><input type=\"number\" step=\"any\"  style=\"\" id=\"" + row.idArticulo + "-quantity\" readonly type=\"text\" onfocus=\"document.getElementById('" + row.idArticulo + "-quantity\').readOnly=false; boton2(" + row.idArticulo + ");\" class=\"quantity form-control\" value=\"" + row.montoPrecioCompra + "\" /></div>";
                                                            }
                                                    ,
                                                    "commands"
                                                            : function (column, row)
                                                            {
                                                                return "<button type=\"button\" id=\"" + row.idArticulo + "-button1\" class=\"btn btn-xs btn-default command-edit\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Cambiar Precio\" style=\"width:25px; margin-top:5px; vertical-align:center;\"><span id=\"" + row.idArticulo + "-span1\" class=\"fa fa-pencil\"></span></button> "
                                                                        + "<button type=\"button\" id=\"" + row.idArticulo + "-button2\" class=\"btn btn-xs btn-success command-edit-aceptar\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Aceptar\" style=\"width:25px; margin-top:5px; vertical-align:center; display:none;\"><span id=\"" + row.idArticulo + "-span2\" class=\"fa fa-check\" style=\"color:white;\"></span></button> "
                                                                        +"<button type=\"button\" id=\"" + row.idArticulo + "-button3\" class=\"btn btn-xs btn-default command-edit-info\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Informacion\" style=\"width:25px; margin-top:5px; vertical-align:center;\"><i id=\"" + row.idArticulo + "-span3\" class=\"fa fa-info\" style=\"color:black;\"></i></button> ";
                                                            }

                                                }
                                            }).on("loaded.rs.jquery.bootgrid", function (e)
                                            {

                                                // Resets the selected data array on reload, searching, sorting or changing page
                                                data = [];
                                                grid.on("keyup", "input.quantity", function ()
                                                {
                                                    e.stopPropagation();
                                                    // Array.first is an extension of bootgrid
                                                    var $this = $(this),
                                                            rowId = +$this.attr("id").split("-")[0], // "+" to convert the a string to an integer
                                                            item = data.first(function (item) {
                                                                return item.id === rowId;
                                                            });
                                                    if (item != null)
                                                    {
                                                        item.quantity = $this.val();
                                                    }
                                                });
                                                /* Executes after data is loaded and rendered */
                                                grid.find(".command-edit").on("click", function (e)
                                                {
                                                    //alert("You pressed edit on row: " + $(this).data("row-id"));
                                                    document.getElementById($(this).data("row-id") + "-quantity").readOnly = false;
                                                    document.getElementById(($(this).data("row-id") + "-button1")).style.display = "none";
                                                    document.getElementById(($(this).data("row-id") + "-button2")).style.display = "inline";
                                                });
                                                grid.find(".command-edit-aceptar").on("click", function (e)
                                                {
                                                    id = $(this).data("row-id");
                                                    quantity = grid.find("#" + $(this).data("row-id") + "-quantity").val();
                                                    //alert("You pressed edit on row: " + $(this).data("row-id") + quantity);
                                                    document.getElementById($(this).data("row-id") + "-quantity").readOnly = true;
                                                    document.getElementById(($(this).data("row-id") + "-button2")).style.display = "none";
                                                    document.getElementById(($(this).data("row-id") + "-button1")).style.display = "inline";
                                                    var f = new Date();
                                                    fechaHoy = f.getFullYear() + "-" + (f.getMonth() + 1) + "-" + f.getDate();
                                                    $.post("modificarPrecio", {idArticulo: $(this).data("row-id"), precioArticulo: grid.find("#" + $(this).data("row-id") + "-quantity").val(), tipoPrecio: document.getElementById('tipoPrecio').value, cliente: document.getElementById('clientes').value, proveedor: document.getElementById('proveedores').value, fechaHoy: fechaHoy}, function (rta) {
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
                                                    //document.getElementById(($(this).data("row-id")+"-tick")).style.display="initial";




                                                });
                                                grid.find(".command-edit-info").on("click", function (e)
                                                {

        
                                                    document.getElementById("idArticulo").value = $(this).data("row-id");;
                                                    cargarTablaPrecios();
                                                    $("#gridPrecioCompra").bootgrid("reload");
                                                    $("#gridPrecioVenta").bootgrid("reload");
                                                    $('#ventanaDetallePrecio').modal('toggle');
                                      
                                                });
                                            }).on("selected.rs.jquery.bootgrid", function (e, selectedRows)
                                            {
                                                var row, quantity;
                                                for (var i = 0; i < selectedRows.length; i++)
                                                {
                                                    row = selectedRows[i];
                                                    // Array.contains is an extension of bootgrid
                                                    if (!data.contains(function (item) {
                                                        return item.id === row.id;
                                                    }))
                                                    {
                                                        quantity = grid.find("#" + row.id + "-quantity").val();
                                                        data.push({idArticulo: row.idArticulo, montoPrecioArticulo: montoPrecioArticulo || 0});
                                                    }
                                                }
                                            }).on("deselected.rs.jquery.bootgrid", function (e, deselectedRows)
                                            {
                                                var row;
                                                for (var i = 0; i < deselectedRows.length; i++)
                                                {
                                                    row = deselectedRows[i];
                                                    for (var j = 0; j < data.length; j++)
                                                    {
                                                        if (data[j].id === row.id)
                                                        {
                                                            data.splice(j, 1);
                                                            return;
                                                        }
                                                    }
                                                }

                                            }).on("click.rs.jquery.bootgrid", function (e, columns, row)
                                            {
                                               

                                            }
                                            );
                                            $("#send").on("click", function ()
                                            {
                                                var params = $.param({"": data});
                                                //alert(decodeURIComponent(params));
                                            });
                                        });
                                    }, 1000);


                                };
                                function  OnImprimirClick()
                                {
                                    //aca agarrar los datos adecuados  y hacer submit
                                    //var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                                   // document.getElementById("cuit").value = datos[0].idVentaS;
                                   // document.getElementById("tipoCliente").value = 2;
                                    document.getElementById("imprimir").submit();
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
                                                idArticulo: document.getElementById('idArticulo').value

                                            };
                                        },
                                        url: "cargarTablaPrecioCompra",
                                        formatters: {
                                            "quantity"
                                                    : function (column, row)
                                                    {
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
                                                idArticulo: document.getElementById('idArticulo').value

                                            };
                                        },
                                        url: "cargarTablaPrecioVenta",
                                        formatters: {
                                            "quantity"
                                                    : function (column, row)
                                                    {
                                                        return "<span class=\"label label-default\">$ " + row.montoPrecioVenta + "</span>";
                                                    }


                                        }

                                    })
                                }
                                ;
                                
                                function cambiarLista()
                                {
                                    if (document.getElementById('tipoPrecio').value !== "proveedor")
                                    {

                                        document.getElementById("divProveedor").style.display = "none";
                                        document.getElementById("divCliente").style.display = "inline";
                                        $("#grid").bootgrid("reload");
                                        if (document.getElementById('clientes').value == 1)
                                        {
                                            document.getElementById("divRestablecer").style.display = "inline";
                                            document.getElementById("btnRestablecer").style.display = "none";
                                            document.getElementById("btnRestablecerGenerico").style.display = "inline";
                                        }
                                        else
                                        {
                                            document.getElementById("divRestablecer").style.display = "inline";
                                            document.getElementById("btnRestablecer").style.display = "inline";
                                            document.getElementById("btnRestablecerGenerico").style.display = "none";
                                        }
                                    }
                                    else
                                    {
                                        document.getElementById("divRestablecer").style.display = "none";
                                        document.getElementById("btnRestablecer").style.display = "none";
                                        document.getElementById("btnRestablecerGenerico").style.display = "none";
                                        document.getElementById("divProveedor").style.display = "inline";
                                        document.getElementById("divCliente").style.display = "none";
                                        $("#grid").bootgrid("reload");

                                    }

                                }
                                function cambiarListaCliente()
                                {
                                    if (document.getElementById('clientes').value == 1)
                                    {
                                        document.getElementById("divRestablecer").style.display = "inline";
                                        document.getElementById("btnRestablecer").style.display = "none";
                                        document.getElementById("btnRestablecerGenerico").style.display = "inline";
                                    }
                                    else
                                    {
                                        document.getElementById("divRestablecer").style.display = "inline";
                                        document.getElementById("btnRestablecer").style.display = "inline";
                                        document.getElementById("btnRestablecerGenerico").style.display = "none";
                                    }
                                }
                                function boton2(id)
                                {
                                    document.getElementById(id + "-quantity").readOnly = false;
                                    document.getElementById(id + "-button1").style.display = "none";
                                    document.getElementById(id + "-button2").style.display = "inline";
                                }
                                function btnRestablecerOnclick()
                                {
                                    var f = new Date();
                                    fechaHoy = f.getFullYear() + "-" + (f.getMonth() + 1) + "-" + f.getDate();
                                    /*$.post("restablecerLista", {idTipoCliente: document.getElementById('clientes').value, fechaHoy: fechaHoy}, function (rta) {
                                     if (rta != 1)
                                     {
                                     document.getElementById("errorModificarD").style.display = "inline";
                                     document.getElementById("errorModificar").innerHTML = rta;
                                     }
                                     else
                                     {
                                     $("#grid").bootgrid("reload");
                                     }
                                     
                                     });*/
                                    $.ajax({
                                        xhr: function ()
                                        {
                                            var xhr = new window.XMLHttpRequest();
                                            //Upload progress
                                            xhr.upload.addEventListener("progress", function (evt) {
                                                if (evt.lengthComputable) {
                                                    var percentComplete = evt.loaded / evt.total;
                                                    setTimeout(function () {
                                                        document.getElementById("progressb").style.width = percentComplete * 100 + "%";
                                                    }, 50);
                                                    //Do something with upload progress
                                                    console.log(percentComplete);
                                                }
                                            }, false);
                                            //Download progress
                                            xhr.addEventListener("progress", function (evt) {
                                                if (evt.lengthComputable) {
                                                    var percentComplete = evt.loaded / evt.total;
                                                    //Do something with download progress
                                                    console.log(percentComplete);
                                                }
                                            }, false);
                                            return xhr;
                                        },
                                        type: 'POST',
                                        url: "restablecerLista",
                                        data: {idTipoCliente: document.getElementById('clientes').value, fechaHoy: fechaHoy},
                                        success: function (rta) {
                                            //Do something success-ish
                                            if (rta != 1)
                                            {
                                                document.getElementById("errorModificarD").style.display = "inline";
                                                document.getElementById("errorModificar").innerHTML = rta;
                                            }
                                            else
                                            {
                                                $("#grid").bootgrid("reload");
                                            }
                                            setTimeout(function () {
                                                document.getElementById("progressb").style.width = 0 + "%";
                                            }, 900);

                                        }
                                    });
                                }
                                function btnRestablecerOnclick2()
                                {
                                    var f = new Date();
                                    fechaHoy = f.getFullYear() + "-" + (f.getMonth() + 1) + "-" + f.getDate();
                                    /*
                                     $.post("restablecerListaGenerica", {cuitProveedor: document.getElementById('cuitProveedor').value, fechaHoy: fechaHoy}, function (rta) {
                                     if (rta != 1)
                                     {
                                     document.getElementById("errorModificarD").style.display = "inline";
                                     document.getElementById("errorModificar").innerHTML = rta;
                                     }
                                     else
                                     {
                                     $("#grid").bootgrid("reload");
                                     }
                                     
                                     });
                                     */
                                    $.ajax({
                                        xhr: function ()
                                        {
                                            var xhr = new window.XMLHttpRequest();
                                            //Upload progress
                                            xhr.upload.addEventListener("progress", function (evt) {
                                                if (evt.lengthComputable) {
                                                    var percentComplete = evt.loaded / evt.total;
                                                    setTimeout(function () {
                                                        document.getElementById("progressb").style.width = percentComplete * 100 + "%";
                                                    }, 50);
                                                    //Do something with upload progress
                                                    console.log(percentComplete);
                                                }
                                            }, false);
                                            //Download progress
                                            xhr.addEventListener("progress", function (evt) {
                                                if (evt.lengthComputable) {
                                                    var percentComplete = evt.loaded / evt.total;
                                                    //Do something with download progress
                                                    console.log(percentComplete);
                                                }
                                            }, false);
                                            return xhr;
                                        },
                                        type: 'POST',
                                        url: "restablecerListaGenerica",
                                        data: {cuitProveedor: document.getElementById('cuitProveedor').value, fechaHoy: fechaHoy},
                                        success: function (rta) {
                                            //Do something success-ish
                                            if (rta != 1)
                                            {
                                                document.getElementById("errorModificarD").style.display = "inline";
                                                document.getElementById("errorModificar").innerHTML = rta;
                                            }
                                            else
                                            {
                                                $("#grid").bootgrid("reload");
                                            }
                                            setTimeout(function () {
                                                document.getElementById("progressb").style.width = 0 + "%";
                                            }, 900);

                                        }
                                    });
                                }
                                function restablecer()
                                {
                                    document.getElementById('tickPorcentaje').style.display = 'none';
                                    document.getElementById("tipoCliente").innerHTML = document.getElementById("clientes").options[document.getElementById('clientes').selectedIndex].text;
                                    document.getElementById("tipoCliente").innerHTML = document.getElementById('clientes').options[document.getElementById('clientes').selectedIndex].text;
                                    $.post("recuperarPorcentajeTipoCliente", {idTipoCliente: document.getElementById('clientes').value}, function (rta) {
                                        document.getElementById('porcentajePrecioVenta').value = rta;
                                    });
                                    $('#ventanaRestablecerPrecios').modal('toggle');

                                }
                                function restablecerGenerico()
                                {
                                    document.getElementById('cuitProveedorTick').style.display = 'none';
                                    document.getElementById("tipoCliente").innerHTML = document.getElementById("clientes").options[document.getElementById('clientes').selectedIndex].text;
                                    $("#cuitProveedor").load("cargarProveedores");
                                    $('#ventanaRestablecerPreciosGenericos').modal('toggle');

                                }
        </script>
    </body>
</html>
