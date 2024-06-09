<%-- 
    Document   : index
    Created on : 8/06/2024, 11:03:51 p. m.
    Author     : Edwin Andrés Samboní Ortiz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Datos del cliente</h1>
        <form action="SvUsuario" method="POST">
            <p>
                <label>Dni:</label>
                <input type="text" name="dni">
            </p>
            <p>
                <label>Nombre:</label>
                <input type="text" name="nombre">
            </p>
            <p>
                <label>Apellido:</label>
                <input type="text" name="apellido">
            </p>
            <p>
                <label>Teléfono:</label>
                <input type="text" name="telefono">
            </p>
            <input type="submit" value="Enviar" name="enviar" />
        </form>
    </body>
</html>
