<%-- 
    Document   : home
    Created on : 26/01/2015, 20:58:40
    Author     : Marina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema Abastecimiento de Carnes</title>
        <%if (session.getAttribute("usuarioConectado") == null) {%>
        <script>
            location.href = 'login.jsp';
        </script> 
        <%} else {
            Entidades.Usuario usuarioConectado = (Entidades.Usuario) session.getAttribute("usuarioConectado");
            String tipo = usuarioConectado.getTipoUsuario();

            if (!"Administrador".equals(usuarioConectado.getTipoUsuario())) {%>
        <script>

            location.href = 'login.jsp';
        </script> 
        <%}
            }%>
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
        <%@ include file="BarraSuperiorLateralEmpleado.jspf" %>
        <div class="col-lg-10 col-md-10" style=" margin:0px; padding:0px; background-color:rgba(252,252,252,1.00)">
            <div class="col-lg-12 col-md-12" style=" background-color:rgba(249,249,249,1.00); margin:0px; border-bottom:2px inset rgba(227,227,227,1.00); padding:15px; padding-left:25px; margin-bottom:20px;">
                <small>Home > <b>Tablero de registros</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Tablero de registros</h1>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" >
                <div class="widget" style=" background-color:#03a9f4">
                    <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5" style="margin:0px; padding:0px;">
                        <i class="iconosWidget fa fa-users fa-5x"></i>
                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-7" style="margin:0px; padding:0px; text-align:right; padding-right:5px;">
                        <b style="color:white;">Cantidad Clientes</b>
                        <b id="clientes" style="color:white; font-size:30px; margin:0px">2.000</b>
                    </div>
                    <div class="clearfix visible-sm-block"></div>
                    <div class="clearfix visible-xs-block"></div>
                    <div class="clearfix visible-lg-block"></div>
                    <div class="clearfix visible-md-block"></div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" >
                <div class="widget" style=" background-color:#8bc34a">
                    <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5" style="margin:0px; padding:0px;">
                        <i class="iconosWidget fa fa-truck fa-5x"></i>
                    </div>
                    <div class="col-lg-7 col-md-7 col-sm-7 col-xs-7" style="margin:0px; padding:0px; text-align:right; padding-right:5px;">
                        <b style="color:white;">Cantidad Proveedores</b>
                        <b id="proveedores" style="color:white; font-size:30px; margin:0px">1.000</b>
                    </div>
                    <div class="clearfix visible-sm-block"></div>
                    <div class="clearfix visible-xs-block"></div>
                    <div class="clearfix visible-lg-block"></div>
                    <div class="clearfix visible-md-block"></div>
                </div>
            </div>

            <div class="clearfix visible-sm-block"></div>
            <div class="clearfix visible-xs-block"></div>
            <div class="clearfix visible-lg-block"></div>
            <div class="clearfix visible-md-block"></div>
            <div class="col-md-7 column" style=" margin-bottom: 20px; margin-top: 50px ">
                <div style="border:1px solid rgba(227,227,227,.3); background-color:#e84e40; padding:10px; border-radius:5px; margin:0px; padding:0px;">
                    <h4 style=" color:white; padding:10px; display:inline-block">Mes:</h4><big id="mes" style="color:white; display:inline; padding:10px;"></big>
                    <div style=" background-color: white; text-align:center">
                        <div class="col-md-4 column" style=" text-align:center;">
                            <div id="fechaCirculo" class="personas chart" data-percent="0" style=" max-width:150px;">
                                <span class="percent"></span>
                                <p>Mes completado</p>
                            </div>
                        </div>
                        <div class="col-md-8 column" style=" text-align:left; padding:20px; ">
                            <b>Fecha</b><p id="fechaTexto" style=" display:inline;padding-left:15px"></p>
                            <br/><br/>
                            <b>Usuario:</b><p id="tipoUsuario" style=" display:inline; padding-left:15px;">Administrador</p>
                            <br/>
                            <b>Nombre:</b><p id="nombre" style=" display:inline; padding-left:15px;">Alex</p>
                            <br/>
                            <!--<b>Última conexión:</b><p style=" display:inline; padding-left:15px;">11/08/2014 10:34</p>-->
                            <div class="col-md-12 column">
                                <button type="button" class="btn btn-danger btn-block">Cambiar Contraseña</button>
                            </div>


                        </div>
                        <div class="clearfix visible-sm-block"></div>
                        <div class="clearfix visible-xs-block"></div>
                        <div class="clearfix visible-lg-block"></div>
                        <div class="clearfix visible-md-block"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-5 column" style=" margin-bottom: 20px;margin-top: 50px "> 
                <div id="weather"></div>
            </div>
            <div class="clearfix visible-sm-block"></div>
            <div class="clearfix visible-xs-block"></div>
            <div class="clearfix visible-lg-block"></div>
            <div class="clearfix visible-md-block"></div>
            <div class="col-lg-12">
                <div class="main-box clearfix" style=" background-color:white; padding:15px; border:3px solid rgba(227,227,227,.3); margin-bottom:20px; margin-top:20px;">
                    <header class="main-box-header clearfix">
                        <h2 class="pull-left">Ventas pendientes de entrega</h2>
                    </header>
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

           


        </div>
        <div class="clearfix visible-sm-block"></div>
        <div class="clearfix visible-xs-block"></div>
        <div class="clearfix visible-lg-block"></div>
        <div class="clearfix visible-md-block"></div>
        <%@ include file="PieDePagina.jspf" %>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/Chart.js"></script>
        <script src="js/jquery.simpleWeather.js"></script>
        <script type="text/javascript" src="js/easypiechart.js"></script>
        <script type="text/javascript" src="js/jquery.easypiechart.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.bootgrid.js"></script>
        <script>

            window.onload = function () {
                cargarWidgets();

                carga2();

            }
            <% Negocio.Controlador con = new Negocio.Controlador();
                String consumosVentas = con.ventaMensualActual();
                String consumosCompras = con.compraMensualActual();

            %>

          
            // Docs at http://simpleweatherjs.com

            /* Does your browser support geolocation? */
            if ("geolocation" in navigator) {
                $('.js-geolocation').show();
            } else {
                $('.js-geolocation').hide();
            }

            /* Where in the world are you? */
            $('.js-geolocation').on('click', function () {
                navigator.geolocation.getCurrentPosition(function (position) {
                    loadWeather(position.coords.latitude + ',' + position.coords.longitude); //load weather using your lat/lng coordinates
                });
            });

            /* 
             * Test Locations
             * Austin lat/long: 30.2676,-97.74298
             * Austin WOEID: 2357536
             */
            $(document).ready(function () {
                loadWeather('Rosario,Argentina', ''); //@params location, woeid
                navigator.geolocation.getCurrentPosition(function (position) {
                    loadWeather(position.coords.latitude + ',' + position.coords.longitude); //load weather using your lat/lng coordinates
                })
            });

            function loadWeather(location, woeid) {
                $.simpleWeather({
                    location: location,
                    woeid: woeid,
                    unit: 'c',
                    success: function (weather) {
                        html = '<h2><i class="icon-' + weather.code + '"></i> ' + weather.temp + '&deg;' + weather.units.temp + '</h2>';
                        html += '<ul><li>' + weather.city + ', ' + weather.region + '</li>';
                        //html += '<li class="currently">'+weather.currently+'</li>';
                        //html += '<li>'+weather.alt.temp+'&deg;C</li></ul>';  

                        $("#weather").html(html);
                    },
                    error: function (error) {
                        $("#weather").html('<p>' + error + '</p>');
                    }
                });
            }
            $('.personas').easyPieChart({
                //easing: 'easeOutCirc',
                barColor: '#e84e40',
                //trackColor: 'white',
                //scaleColor:false,
                scaleLength: 10,
                percent: 67,
                lineCap: 'round',
                lineWidth: 8, //12
                size: 150, //110
                animate: {duration: 4000, enabled: true},
                onStep: function (from, to, percent) {
                    $(this.el).find('.percent').text(Math.round(percent));
                }
            });
            $(document).ready(function () {
                var f = new Date();
                var meses = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");
                fecha = new Date(f.getFullYear(), f.getMonth() + 1, 0);
                $("#fechaFinMes").html(fecha.getDate() + " de " + meses[fecha.getMonth()] + " de " + fecha.getFullYear());

                $("#fechaPrincipioMes").html("1" + " de " + meses[f.getMonth()] + " de " + f.getFullYear());
                $('.personas').data('easyPieChart').update(f.getDate() * 100 / fecha.getDate());
                $("#fechaTexto").html(f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());
                $("#mes").html(meses[f.getMonth()]);


            });
            function cargarWidgets()
            {
                $.post("cargarWidgets", function (rta) {
                    var elem = rta.split('-');
                    cantidadClientes = elem[0];
                    cantidadProveedores = elem[1];
                    totalPorCobrar = elem[2];
                    totalAdeudado = elem[3];
                    tipoUsuario = elem[4];
                    nombre = elem[5];
                    document.getElementById("clientes").innerHTML = cantidadClientes;
                    document.getElementById("proveedores").innerHTML = cantidadProveedores;
                    document.getElementById("pagos").innerHTML = "$" + totalAdeudado;
                    document.getElementById("cobros").innerHTML = "$" + totalPorCobrar;
                    document.getElementById("tipoUsuario").innerHTML = tipoUsuario;
                    document.getElementById("nombre").innerHTML = nombre;

                })
            }


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
                    url: "cargarTablaVentasHome",
                    //navigation: 1,
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
        </script>
    </body>
</html>