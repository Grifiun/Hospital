<%-- 
    Document   : reporte-examenes-laboratorio-en-intervalo-tiempo
    Created on : 07-oct-2020, 3:46:38
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Nombre del examen de laboratorio","Fecha","Codigo del medico a cargo","Estado de la consulta"));
        String paciente = (String) session.getAttribute("codigo");
        String examen = request.getParameter("examen");
        String fecha1 = request.getParameter("fecha_inicio");
        String fecha2 = request.getParameter("fecha_fin");
        Consultar cons = new Consultar();
        String query = "SELECT B.nombre,A.fecha,A.medico,A.estado FROM CITA_EXAMEN AS A JOIN (SELECT nombre FROM EXAMEN WHERE codigo = ?) AS B WHERE A.paciente = ? AND (A.fecha BETWEEN ? AND ?) AND A.estado = 'atendido' AND A.examen = ?";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("nombre","fecha","medico","estado")), //datos a obtener
                new ArrayList<String>(Arrays.asList(examen,paciente,fecha1,fecha2,examen))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Examenes en intervalo tiempo</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-paciente.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h3>Examenes realizados de un tipo en los intervalos de tiempo <%=fecha1%> Y <%=fecha2%></h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <h5>Con un total de <%=lista.size()%> examenes realizados</h5>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>