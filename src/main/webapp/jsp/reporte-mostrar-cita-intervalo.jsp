<%-- 
    Document   : reporte-mostrar-cita-intervalo
    Created on : 06-oct-2020, 2:18:24
    Author     : grifiun
--%>

<%@page import="java.util.List"%>
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("codigo","paciente","medico","especialidad","fecha","hora","estado"));
        String medico = (String) session.getAttribute("codigo");
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        
        Consultar cons = new Consultar();
        List<ArrayList<String>> lista = cons.obtenerRegistros("CITA", //tabla
                new ArrayList<>(Arrays.asList("codigo","paciente","medico","especialidad","fecha","hora","estado")), //datos a obtener
                new ArrayList<String>(Arrays.asList("(fecha BETWEEN ? AND ?) AND medico ")), //restricciones
                new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin,medico))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-doctor.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h1>Reporte: Citas agendadas entre las fechas: <%=fecha_inicio%> y <%=fecha_fin%></h1>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
