<%-- 
    Document   : reporte-citas-con-un-medico-en-intervalo-tiempo
    Created on : 07-oct-2020, 5:44:15
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
        String medico = request.getParameter("medico");
        String fecha1 = request.getParameter("fecha_inicio");
        String fecha2 = request.getParameter("fecha_fin");
        Consultar cons = new Consultar();
        String query = "SELECT fecha,hora,codigo,medico,especialidad,estado FROM CITA WHERE paciente = ? AND medico = ? AND (fecha BETWEEN ? AND ?) AND estado = 'atendido' ORDER BY fecha ASC, hora ASC";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("fecha","hora","codigo","medico","especialidad","estado")), //datos a obtener
                new ArrayList<String>(Arrays.asList(paciente,medico,fecha1,fecha2))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Examenes en intervalo tiempo</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-paciente.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h3>Citas realizadas con un medico en el intervalo de tiempo <%=fecha1%> Y <%=fecha2%></h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <h5>Con un total de <%=lista.size()%> Consultas realizadas</h5>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>