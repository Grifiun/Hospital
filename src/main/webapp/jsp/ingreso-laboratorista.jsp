<%-- 
    Document   : crear-laboratorista
    Created on : 04-oct-2020, 8:13:11
    Author     : grifiun
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Array"%>
<%@page import="java.util.ArrayList"%>
<%@page import="conection_db.Consultar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso examen</title>  
        <%
        String identificador = "LABORATORISTA,codigo,nombre,registro,dpi,telefono,examen,correo,trabajof,password";
        session.setAttribute("identificador", identificador);       

        Consultar cons = new Consultar();
        List<ArrayList<String>> lista = cons.obtenerRegistros("EXAMEN", //tabla
                new ArrayList<>(Arrays.asList("nombre")), //datos a obtener
                new ArrayList<String>(), //restricciones
                new ArrayList<String>()); //valor a cumplor
        %>    
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-admin/form-ingresar-laboratorista.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
