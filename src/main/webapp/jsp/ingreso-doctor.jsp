<%-- 
    Document   : ingreso-doctor
    Created on : 04-oct-2020, 18:08:31
    Author     : grifiun
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
        String identificador = "DOCTOR,codigo,nombre,colegiado,dpi,telefono,correo,trabajo,password";    
        
        session.setAttribute("identificador", identificador);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso medico</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-admin/form-ingresar-doctor.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
