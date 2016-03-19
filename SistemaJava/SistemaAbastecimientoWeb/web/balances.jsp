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
        <div class="col-lg-10 col-md-10" style=" margin:0px; padding:0px; background-color:rgba(252,252,252,1.00)">
            <div class="col-lg-12 col-md-12" style=" background-color:rgba(249,249,249,1.00); margin:0px; border-bottom:2px inset rgba(227,227,227,1.00); padding:15px; padding-left:25px; margin-bottom:20px;">
                <small>Consultas > <b>Balance</b></small>
                <h4 style=" color:rgba(235,57,60,1.00)">Balance</h4>
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
            </div>  

            <div class="col-md-12" style="">

                <form id='imprimir' method='post' action="ImprimirBalance">
                    <div class="col-md-8" style="">
                        <div class="form-group">
                            <label for="calidad">Fecha Inicio:</label>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                <input type="date" required class="form-control" id="fecha_ini"  required="true" name="fecha_ini"/>
                            </div>
                        </div> 


                        <div id="divProveedor" class="form-group">
                            <label for="calidad">Fecha Fin:</label>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                                <input type="date" required class="form-control" id="fecha_fin" required="true" name="fecha_fin"/>
                            </div>
                        </div> 
                    </div>
                    <div class="col-md-4" style="">
                        <button type="submit" class="btn btn-info btn-block" data-dismiss="alert" aria-hidden="true" style=" height: 100px; width: 110px; margin-left: 0px;"><span class="fa fa-print fa-3x" style=" color: white; display: block;"></span>Imprimir </button>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="PieDePagina.jspf" %>
        <script>
            function  OnImprimirClick()
            {
                //aca agarrar los datos adecuados  y hacer submit
                //var datos = $('#grid3').bootgrid().data('.rs.jquery.bootgrid').currentRows;
                // document.getElementById("cuit").value = datos[0].idVentaS;
                // document.getElementById("tipoCliente").value = 2;
                document.getElementById("imprimir").submit();
            }
        </script>
    </body>
</html>
