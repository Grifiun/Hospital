<%-- 
    Document   : reporte-examenes-mas-demandados
    Created on : 07-oct-2020, 12:38:30
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Codigo examen","nombre","costo","cantidad demandada"));
        
        //fechas
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        Consultar cons = new Consultar();
        String query = "SELECT A.examen, B.nombre, B.costo, COUNT(A.examen) AS cantidad FROM CITA_EXAMEN AS A JOIN EXAMEN AS B ON A.examen = B.codigo WHERE A.fecha BETWEEN ? AND ? GROUP BY A.examen ORDER BY COUNT(A.examen) DESC";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("examen","nombre","costo","cantidad")), //datos a obtener
                new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Examenes mas demandados</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h3>Examenes mas demandados en el intervalo <%=fecha_inicio%> y <%=fecha_fin%></h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <h6>Nota: se tomaron en cuenta todos los examenes de laboratorio reservados, aunque no hayan sido atendidos, porque de igual forma son demanda</h6>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>