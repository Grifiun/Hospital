<%-- 
    Document   : home-admin
    Created on : 03-oct-2020, 2:15:30
    Author     : grifiun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String fecha = "2020/10/04";
            session.setAttribute("fecha_sistema", fecha);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../html/css-bootstrap.html"%>
        <title>Admin</title>
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/form-mensaje-resultado-ingreso.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>

