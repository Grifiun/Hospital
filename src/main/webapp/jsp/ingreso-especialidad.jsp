<%-- 
    Document   : ingreso-especialidad
    Created on : 04-oct-2020, 22:43:28
    Author     : grifiun
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="conection_db.Consultar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ejemplo de ventana emergente centrada con Javascript</title>
        <%
        String identificador = "ESPECIALIDAD,codigo,titulo";
        session.setAttribute("identificador", identificador);       
        session.setAttribute("codigoAleatorio", "desactivado"); //desactivamos la generacion del codigo aleatorio
        Consultar cons = new Consultar();
        List<ArrayList<String>> lista = cons.obtenerRegistros("DOCTOR", //tabla
                new ArrayList<>(Arrays.asList("codigo","nombre")), //datos a obtener
                new ArrayList<String>(), //restricciones
                new ArrayList<String>()); //valor a cumplor
        
        List<ArrayList<String>> lista2 = cons.obtenerRegistros("CONSULTA", //tabla
                new ArrayList<>(Arrays.asList("tipo")), //datos a obtener
                new ArrayList<String>(), //restricciones
                new ArrayList<String>()); //valor a cumplor
        %>    
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-admin/form-ingresar-especialidad.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
