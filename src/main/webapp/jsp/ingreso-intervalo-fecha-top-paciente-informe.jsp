<%-- 
    Document   : ingreso-intervalo-fecha-top-paciente-informe
    Created on : 06-oct-2020, 6:39:35
    Author     : grifiun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingresar intervalo de tiempo</title>        
        <%
            String destino = "reporte-top-pacientes-informe.jsp";
        %>
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-doctor.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/form-ingreso-datos-generales/form-ingreso-intervalo-tiempo.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>