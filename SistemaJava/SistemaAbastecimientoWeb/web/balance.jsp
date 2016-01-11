<%-- 
    Document   : balance
    Created on : 18/03/2015, 01:55:48 PM
    Author     : Hamal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Balance</title>
    </head>
    <body>
        <h1>Balance</h1>
        <form action="balance" method="post" >
       <label>Fecha Inicio </label> <input type="date"  id="fechaTransaccion" name="fechaInicio" >
       <label>Fecha fin </label> <input type="date"  id="fechaTransaccion" name="fechaFin" >
        <button type="submit"> Cambiar estado </button>
        </form>
        </body>
</html>
