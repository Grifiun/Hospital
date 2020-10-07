<%-- 
    Document   : reporte-utlizacion-dias-de-trabajo
    Created on : 07-oct-2020, 2:00:21
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Fecha","Cantidad de examenes realizados"));
        String laboratorista = (String) session.getAttribute("codigo");
        String fecha1 = request.getParameter("fecha_inicio");
        String fecha2 = request.getParameter("fecha_fin");
        
        Consultar cons = new Consultar();
        String query = "SELECT fecha, COUNT(*) AS cantidad FROM RESULTADO WHERE (fecha BETWEEN ? AND ?) AND laboratorista = ? GROUP BY fecha ORDER BY fecha";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("fecha","cantidad")), //datos a obtener
                new ArrayList<String>(Arrays.asList(fecha1,fecha2,laboratorista))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Utilizacion de dias</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-laboratorista.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h5>Reportes realizados entre las fechas: <%=fecha1%> Y <%=fecha2%>, ordenados por fecha</h5>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
