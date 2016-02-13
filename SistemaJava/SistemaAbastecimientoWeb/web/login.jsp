<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>

        <meta charset="utf-8">
        <title>Ingreso al Sistema Abastesimiento de Carnes</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- CSS -->
        <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'>
        <!--<link rel="stylesheet" href="assets/css/reset.css">-->
        <link rel="stylesheet" href="css/supersized.css">
        <link rel="stylesheet" href="css/style.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Javascript -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="js/supersized.3.2.7.min.js"></script>
        <script src="js/supersized-init.js"></script>
        <script src="js/scripts.js"></script>

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

    </head>

    <body id="loginP">

        <div class="page-container">
            <h1 style=" color:#ffffff; text-align: center;">Sistema de Abastecimiento de Carnes</h1>
            <form id="loginF" action="loginPrincipal" method="post">
                <%
                    if (request.getAttribute("error") != null) {
                %>
                <p style="color:red;"><span>                      
                        <%
                            out.println(request.getAttribute("error"));
                            request.setAttribute("error", "");
                        %>
                    </span></p>
                    <%
                        }
                    %>
                    <%
                        if (request.getAttribute("correcto") != null) {
                    %>
                <p style="color:green;"><span>                      
                        <%
                            out.println(request.getAttribute("correcto"));
                            request.setAttribute("correcto", "");
                        %>
                    </span></p>
                    <%
                        }
                    %>
                <input id="loginDni" type="text" name="loginDni" autocomplete="false" class="username" placeholder="DNI" style="color: #ffffff;">
                <input id="loginContra" type="password" name="loginContra" class="password" placeholder="Contraseña">
                <button id="loginBtn" type="submit">Entrar al Sistema</button>


                <div class="error"><span>
                    </span>
                </div>
            </form>
        </div>




    </body>

</html>

