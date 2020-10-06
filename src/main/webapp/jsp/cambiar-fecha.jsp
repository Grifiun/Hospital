<%-- 
    Document   : cambiar-fecha
    Created on : 06-oct-2020, 0:02:37
    Author     : grifiun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String rol = (String) session.getAttribute("rol");   
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../html/css-bootstrap.html"%>
        <title>Cambiar fecha</title>
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>       
        
        <%          
            System.out.println(rol);
            switch(rol){
                case "admin":%><%@include file="../html/navs/nav-admin.html" %><%
                break; 
                case "paciente":%><%@include file="../html/navs/nav-paciente.html" %><%
                break; 
                case "doctor":%><%@include file="../html/navs/nav-doctor.html" %><%
                break; 
            } 
        %>

        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/cambiar-fecha/form-ingreso-nueva-fecha.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>