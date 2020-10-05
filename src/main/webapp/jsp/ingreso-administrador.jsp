<%-- 
    Document   : ingreso-administrador
    Created on : 05-oct-2020, 3:52:33
    Author     : grifiun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <%
        String identificador = "ADMIN,codigo,nombre,dpi,password";    
        
        session.setAttribute("identificador", identificador);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso administrador</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-admin/form-ingresar-administrador.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
