<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>

        <meta charset="utf-8">
        <title> Cambio de Contraseña</title>
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
        
                    <div class="col-md-12">
                        <h1 style=" color:#ffffff; text-align: center;">Cambio de Contraseña</h1>
                        <form role="form" method="post" action="cambiarClave">

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
                            <div class="col-md-12" style="text-align: center">
                                <input id="loginDni" type="text" name="loginDni" autocomplete="false" class="username" placeholder="DNI" style="color: #ffffff;">
                            </div>
                            <div class="col-md-12" style="text-align: center">
                                <input id="loginContra" type="password"  name="passAct" class="username" placeholder="CONTRASEÑA ACTUAL" style="color: #ffffff;" />
                            </div>
                            <div class="col-md-12" style="text-align: center">
                                <input id="loginContra" name="passNew"  type="password" class="username" placeholder="CONTRASEÑA NUEVA" style="color: #ffffff;" />
                            </div>
                            <div class="col-md-12" style="text-align: center">
                                <input id="loginContra" name="passNew2" type="password" class="username" placeholder="REPITA CONTRASEÑA  NUEVA" style="color: #ffffff;" />
                            </div>
                            <br>
                            <br>
                            <div class="col-md-12" style="text-align: center">
                            <button id="loginBtn"  type="submit" onClick="onVolverClick()" >
                                Volver
                            </button>

                            <button id="loginBtn" type="submit">
                                Guardar
                            </button>
                            </div>





                        </form>
                    </div>
                    <div class="col-md-4">
                    </div>
                </div>
      



        <script>
            function onVolverClick() {
                document.location.href = 'home.jsp';
            }
            ;
        </script>                


    </body>

</html>