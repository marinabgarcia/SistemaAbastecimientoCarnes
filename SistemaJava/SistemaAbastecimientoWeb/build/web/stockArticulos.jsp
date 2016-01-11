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
                <small>Consultas > <b>Stock</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Control de Stock</h4>
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
            <div class="col-lg-12 col-md-12">
                <div class="table-responsive clearfix">
                    <table id="gridArticulos" name="grid3" class="table table-striped">
                        <thead>
                            <tr>
                                <th data-column-id="idArticulo" data-type="numeric" data-sortable="true">Id Artículo</th>
                                <th data-column-id="descripcionArticulo" data-type="string" data-order="asc" data-sortable="true">Descripción</th>
                                <th data-column-id="descripcionCalidad" data-formatter="tipo" data-sortable="true">Calidad</th>
                                <th data-column-id="stockUnidad" data-formatter="stock" data-sortable="true">Stock</th>
                                <th data-column-id="pesoEstimadoArticulo" data-type="string" data-sortable="false">Peso Estimado</th>
                                <!--<th data-column-id="estadoArticulo" data-formatter="quantity" data-sortable="true">Estado</th>-->

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
                                cargaArticulos();
                              

                            };

                            //carga tabla principal
                            function cargaArticulos()
                            {
                                var data = [];
                                var grid3 = $("#gridArticulos").bootgrid({
                                    ajax: true,
                                    
                                    rowCount: [40, 50, 60, 10],
                                    url: "cargarTablaArticulosB",
                                    formatters: {

                                       "tipo"
                                                : function (column, row)
                                                {
                                                    return "<span class=\"tipo\" name=\"" + row.descripcionCalidad + "\"> " + row.descripcionCalidad + "</span>";
                                                },
                                        "stock"
                                                : function (column, row)
                                                {
                                                    return "<span class=\"stock\">" + row.stockUnidad + "</span>";
                                                }
                                    }
                                }).on("loaded.rs.jquery.bootgrid", function (e)
                                {
                                    var tipos = document.getElementsByClassName('tipo');
                                    for (var i = 0; i < tipos.length; i++)
                                    {
                                        if ($(tipos.item(i)).attr("name") == "Ternero")
                                        {
                                            $(tipos.item(i)).addClass("label label-info");
                                        }
                                        if ($(tipos.item(i)).attr("name") == "Vaca")
                                        {
                                            $(tipos.item(i)).addClass("label label-primary");
                                        }
                                        if ($(tipos.item(i)).attr("name") == "Novillo")
                                        {
                                            $(tipos.item(i)).addClass("label label-success");
                                        }
                                        if ($(tipos.item(i)).attr("name") == "Novillito")
                                        {
                                            $(tipos.item(i)).addClass("label label-warning");
                                        }
                                        if ($(tipos.item(i)).attr("name") == "Vaquillona")
                                        {
                                            $(tipos.item(i)).addClass("label label-danger");
                                        }
                                    }
                             
                                    var datos = $('#gridArticulos').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                                    var stock = document.getElementsByClassName('stock');
                                    var stock2 = document.getElementsByTagName('tr');
                                    for (var i = 0; i < datos.length; i++)
                                    {
                                        if (datos[i].stockUnidad <= 0)
                                        {
                                            
                                                $(stock.item(i)).addClass("label label-danger masgrande");
                                                //$(stock2.item(i + 1)).addClass("danger");
                                            
                                        }
                                    }
                                   
                                   

                                    /* Executes after data is loaded and rendered */
                                }).on("selected.rs.jquery.bootgrid", function (e, selectedRows)
                                {

                                }).on("deselected.rs.jquery.bootgrid", function (e, deselectedRows)
                                {
                                  

                                }).on("click.rs.jquery.bootgrid", function (e, columns, row)
                                {

                                }
                                );

                            }
                            ;
        </script>

    </body>
</html>
