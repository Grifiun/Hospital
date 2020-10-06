<%-- 
    Document   : reporte-top-pacientes-informe
    Created on : 06-oct-2020, 6:40:35
    Author     : grifiun
--%>

<%@page import="java.util.List"%>
<%@page import="conection_db.Consultar"%>
<%@page import="conection_db.Consultar"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%        
        //titulos
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("paciente","cantidad de informes"));
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        
        Consultar cons = new Consultar();
        cons.setTipoConsulta(" paciente, COUNT(*) AS cantidad");//restricciones de que obtendremos
        List<ArrayList<String>> lista = cons.obtenerRegistros("REPORTE", //tabla
                new ArrayList<>(Arrays.asList("paciente","cantidad")), //datos a obtener
                new ArrayList<String>(Arrays.asList("fecha BETWEEN ? AND ? GROUP BY paciente")), //restricciones
                new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-doctor.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h1>Reporte: Pacientes con mas informes entre las fechas: <%=fecha_inicio%> y <%=fecha_fin%></h1>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
