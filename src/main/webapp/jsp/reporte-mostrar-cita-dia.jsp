<%-- 
    Document   : reporte-mostrar-cita-dia
    Created on : 05-oct-2020, 23:39:30
    Author     : grifiun
--%>

<%@page import="java.util.List"%>
<%@page import="conection_db.Consultar"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%        
        //titulos
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("codigo","paciente","medico","especialidad","fecha","hora","estado"));
        String medico = (String) session.getAttribute("codigo");
        String fecha = (String) session.getAttribute("fecha_sistema");
        
        Consultar cons = new Consultar();
        List<ArrayList<String>> lista = cons.obtenerRegistros("CITA", //tabla
                new ArrayList<>(Arrays.asList("codigo","paciente","medico","especialidad","fecha","hora","estado")), //datos a obtener
                new ArrayList<String>(Arrays.asList(" estado = 'En proceso' AND medico","fecha")), //restricciones
                new ArrayList<String>(Arrays.asList(medico,fecha))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-doctor.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-doctor/form-tabla-cita-informe-superior.html" %>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos-doctor/form-tabla-cita-informe-inferior.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
