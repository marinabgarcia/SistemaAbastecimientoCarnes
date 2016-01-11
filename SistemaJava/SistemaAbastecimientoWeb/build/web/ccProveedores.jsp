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
        <%}
        else
        {
        Entidades.Usuario usuarioConectado=(Entidades.Usuario) session.getAttribute("usuarioConectado");
        if (!"Administrador".equals(usuarioConectado.getTipoUsuario())) {%>
        <script>
            location.href = 'login.jsp';
        </script> 
        <%}}%>
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
                <small>Consultas > <b>CC</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Cuenta Corriente Clientes</h4>
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

            <div class="col-md-12" style="">
                <div class="table-responsive clearfix">
                    <table id="gridProveedores" name="gridProveedores" class="table table-hover table-striped" >
                        <thead>
                            <tr>
                                <th data-column-id="cuitProveedor" data-identifier="true" data-sortable="true" data-type="numeric" data-order="asc">Cuit</th>
                                <th data-column-id="nombreProveedor" data-sortable="true">Nombre</th>
                                <th data-column-id="apellidoProveedor"data-sortable="true">Apellido</th>
                                <th data-column-id="cuentaCorrienteProveedor" data-formatter="precio" data-sortable="false">Cuenta Corriente</th>
                                <th data-column-id="direccionProveedor" data-sortable="false">Dirección</th>
                                <th data-column-id="dLocalidad" data-sortable="false">Localidad</th>
                                <th data-column-id="dProvincia" data-sortable="false">Provincia</th>
                                <th data-column-id="telefonoProveedor" data-sortable="false">Telefono</th>
                                <th data-column-id="celularProveedor" data-sortable="false">Celular</th>
                                <th data-column-id="emailProveedor" data-sortable="false">Email</th>
                               

                                <th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn"></th>

                            </tr>

                        </thead>  

                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-12 column">
            <div class="modal fade" id="ventanaDeuda" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                Deudas Pendientes
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12 column"> 
                                <div class="col-md-12 column col-lg-12 col-xs-12 col-sm-12">
                                    <div class="col-md-12 column" style="">
                                        <div class="form-group">
                                            <label for="apellido" style=" font-size: 15px;">Cuit Proveedor:</label>
                                            <div class="input-group">
                                                <input type="number" readonly required class="form-control" id="dniClienteP" name="dniClienteP"/>
                                                <span id="btnBuscarCliente" name="btnBuscarClienteP" class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
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
                                  
                                </div> 
                                <div class="col-lg-12 col-md-12">
                                    <div class="table-responsive clearfix">
                                        <table id="grid3" name="grid3" class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th data-column-id="idCompra" data-formatter="idCompra" data-identifier="true" data-type="numeric" data-sortable="false">Id Compra</th>
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
                                                    <th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn"></th>

                                                </tr>
                                            </thead>                 
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style=" clear: both">
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
        <script src="js/jquery.steps.js"></script>
        <script>
                                var seleccion = 0;
                                window.onload = function cargaInicial() {
                                    //$("#alertAdvertencia").alert('close');
                                    $('[data-toggle="tooltip"]').tooltip({
                                        placement: 'left'
                                    });
                                    cargaProveedores();



                                };

                                //carga tabla principal
                                function cargaProveedores()
                                {
                                    var grid2 = $("#gridProveedores").bootgrid({
                                        ajax: true,
                                        rowCount: [40, 50, 60, 10],
                                        url: "cargarTablaProveedoresB", formatters: {
                                            "precio": function (column, row)
                                            {
                                                return "<span class=\"label label-default\"><big>$ " + row.cuentaCorrienteProveedor + "</big></span>";
                                            },
                                            "tipo"
                                                    : function (column, row)
                                                    {
                                                        return "<span class=\"tipo\" name=\"" + row.dTipoCliente + "\"> " + row.dTipoCliente + "</span>";
                                                    },
                                            "commands": function (column, row)
                                            {
                                                return "<button type=\"button\" id=\"" + row.idArticulo + "-button1\" class=\"btn btn-xs btn-default command-info\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Ver Deuda\" style=\"width:25px; margin-top:5px; vertical-align:center;\"><span id=\"" + row.idArticulo + "-span1\" class=\"fa fa-info\" style=\"color:black;\"></span></button> ";
                                            }

                                        }}).on("loaded.rs.jquery.bootgrid", function (e) {
                                        
                                        grid2.find(".command-info").on("click", function (e) {
                                            // seleccion = $(this).data("row-id");

                                        });
                                    }).on("selected.rs.jquery.bootgrid", function (e, selectedRows)
                                    {

                                        var row, quantity;
                                        for (var i = 0; i < selectedRows.length; i++)
                                        {
                                            row = selectedRows[i];
                                            //alert(row.idCompra);
                                            seleccion = row.dniCliente;
                                        }
                                    }).on("deselected.rs.jquery.bootgrid", function (e, deselectedRows)
                                    {
                                        seleccion = 0;

                                    }).on("click.rs.jquery.bootgrid", function (e, columns, row)
                                    {
                                        seleccion = row.cuitProveedor;
                                        if (seleccion != 0)
                                        {
                                            var datos = $('#gridProveedores').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                                            var row;
                                            for (var i = 0; i < datos.length; i++)
                                            {
                                                if (datos[i].cuitProveedor == seleccion)
                                                {
                                                    row = datos[i];
                                                }
                                            }
                                            //cargar info clientes
                                            document.getElementById("dniClienteP").value = row.cuitProveedor;
                                            document.getElementById("nombreClienteP").value = row.nombreProveedor;
                                            document.getElementById("apellidoClienteP").value = row.apellidoProveedor;
                                            $("#grid3").bootgrid("destroy");
                                            cargaCompras();
                                            $('#ventanaDeuda').modal('show');
                                        }
                                        else
                                        {
                                            document.getElementById("alerta").style.display = "inline";
                                        }
                                    }
                                    );
                                }
                                ;
                                //carga tabla principal
                                function cargaCompras()
                                {
                                    var data = [];
                                    var grid3 = $("#grid3").bootgrid({
                                        ajax: true,
                                        post: function ()
                                        {
                                            return {
                                                cuitProveedor: document.getElementById("dniClienteP").value

                                            };
                                        },
                                        navigation: 0,
                                        url: "cargarTablaComprasProveedor",
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
                                                        return "<span id=\"" + row.fechaEntregaCompraS + row.horaEntregaCompraS + "\"class=\"\">" + row.idCompra + "</span>";
                                                    },
                                            "commands": function (column, row)
                                            {
                                                return "<button type=\"button\" id=\"" + row.idArticulo + "-button1\" class=\"btn btn-xs btn-default command-pagar\" data-row-id=\"" + row.idArticulo + "\" data-toggle=\"tooltip\" data-original-title=\"Pagar\" style=\"width:25px; margin-top:5px; vertical-align:center;\"><span id=\"" + row.idArticulo + "-span1\" class=\"fa fa-dollar\" style=\"color:black;\"></span></button> ";
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
                                           // document.getElementById("alertAdvertencia").style.display = 'block';
                                        }
                                        grid3.find(".command-pagar").on("click", function (e) {

                                        });


                                        // Resets the selected data array on reload, searching, sorting or changing page
                                        data = [];
                                        /* Executes after data is loaded and rendered */
                                    }).on("click.rs.jquery.bootgrid", function (e, columns, row)
                                    {
                                        location.href = "compra.jsp?idCompra=" + row.idCompra;

                                    })
                                }
                                ;


        </script>

    </body>
</html>