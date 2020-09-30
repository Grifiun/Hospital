<%-- 
    Document   : crear-usuario
    Created on : 28-sep-2020, 10:51:04
    Author     : grifiun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
        <link href="../css-botstrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../css/posicion-caja1-registro.css" rel="stylesheet" type="text/css"/>
        <link href="../css/style-login.css" rel="stylesheet" type="text/css"/>
        
    </head>
    <body>           
        <%@include file="../html/partes-codigo-html/parte-superior-login.html" %> 
        <%@include file="../html/crear-usuario/imagen.html" %> 
        <%@include file="../html/crear-usuario/formulario-datos-a-registrar.html" %> 
        <%@include file="../html/crear-usuario/boton-registro-a-login.html" %> 
        <%@include file="../html/partes-codigo-html/parte-inferior-login.html" %>    
        <script src="../js-bootstrap/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>
