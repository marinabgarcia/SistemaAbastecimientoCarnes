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
                <small>Consultas > <b>Pagos</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Pagos Realizados</h4>
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
            <div class="col-md-3 column" style="margin-bottom: 0px;">
             <button onclick="location.href='compra.jsp'" type="button" role="button" class="btn btn-warning " value="Agregar" style=" height: 110px; min-width: 110px"><span class="fa fa-dollar fa-3x" style=" color: white; display: block;"></span>Registrar Pago</button>
            </div>
            <div class="col-md-12" style="">
                <div class="table-responsive clearfix">
                    <table id="gridPagos" name="gridPagos" class="table table-hover table-striped" >
                        <thead>
                            <tr>
                                 <th data-column-id="id" data-sortable="false">Id Compra</th>
                                <th data-column-id="idTransaccion" data-visible="false" data-sortable="true" data-identifier="true" data-header-css-class="commandIdArticulo" data-type="numeric">Id Transaccion</th>
                                <th data-column-id="tipoTransaccion" data-visible="false" data-sortable="false">Tipo transaccion</th>
                                <th data-column-id="formaDePago" data-formatter="tipo" data-sortable="true">Forma de Pago</th>
                                <th data-column-id="montoPago" data-formatter="precio" data-sortable="true">Monto</th>
                                <th data-column-id="fechaPagoS"  data-sortable="true" data-order="desc">Fecha</th>
                                <th data-column-id="horaPagoS" data-sortable="false">Hora</th>
                                <th data-column-id="nroCheque" data-sortable="false">Cheque</th>
                                <th data-column-id="bancoCheque" data-sortable="false">Banco</th>
                                <th data-column-id="nombreCheque" data-sortable="false">Nombre</th>
                                <th data-column-id="nombre" data-sortable="false">Nombre Proveedor</th>
                                <th data-column-id="cuit" data-sortable="false">Cuit Proveedor</th>
                               <th data-column-id="telefono" data-sortable="false">Telefono Cliente</th>
                                <th data-column-id="celular" data-sortable="false">Celular Cliente</th>
                                <!--<th data-column-id="commands" data-formatter="commands" class="comando" data-sortable="false" style="" data-header-css-class="commandColumn"></th>-->

                            </tr>

                        </thead>  

                    </table>
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
                                    cargaPagos();


                                };

                                //carga tabla principal
                                function cargaPagos()
                                {
                                    var grid2 = $("#gridPagos").bootgrid({
                                        ajax: true,
                                        rowCount: [40, 50, 60, 10],
                                        post: function ()
                                        {
                                            return {
                                                tipoTransaccion: "compra"

                                            };
                                        },
                                        url: "cargarTablaPagosTipo", formatters: {
                                            "link": function (column, row)
                                            {
                                                return "<a href=\"#\">" + column.id + ": " + row.id + "</a>";
                                            },
                                            "precio": function (column, row)
                                            {
                                                return "<span class=\"label label-default\">$ " + row.montoPago + "</span>";
                                            },
                                            "tipo"
                                                    : function (column, row)
                                                    {
                                                        return "<span class=\"tipo\" name=\"" + row.formaDePago + "\"> " + row.formaDePago + "</span>";
                                                    }

                                        }}).on("loaded.rs.jquery.bootgrid", function (e) {
                                        var tipos = document.getElementsByClassName('tipo');
                                        for (var i = 0; i < tipos.length; i++)
                                        {
                                            if ($(tipos.item(i)).attr("name") == "Tarjeta")
                                            {
                                                $(tipos.item(i)).addClass("label label-info");
                                            }
                                            if ($(tipos.item(i)).attr("name") == "Efectivo")
                                            {
                                                $(tipos.item(i)).addClass("label label-success");
                                            }
                                            if ($(tipos.item(i)).attr("name") == "Cheque")
                                            {
                                                $(tipos.item(i)).addClass("label label-warning");
                                            }

                                        }
                                        grid2.find(".command-delete").on("click", function (e) {
                                            borrar($(this).data("row-id"));
                                        });
                                    })
                                }
                                ;
        </script>

    </body>
</html>
