<%-- 
    Document   : reporte-ultimos-5-citas
    Created on : 07-oct-2020, 4:35:04
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Fecha","Hora","Codigo consulta","Cod. medico","Especialidad de consulta","Estado"));
        String paciente = (String) session.getAttribute("codigo");
        
        Consultar cons = new Consultar();
        String query = "SELECT fecha,hora,codigo,medico,especialidad,estado FROM CITA WHERE (paciente = ?) AND estado='atendido' ORDER BY fecha DESC LIMIT 5";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("fecha","hora","codigo","medico","especialidad","estado")), //datos a obtener
                new ArrayList<String>(Arrays.asList(paciente))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte ultimos examenes</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-paciente.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h3>Ultimos 5 consultas realizadas</h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>