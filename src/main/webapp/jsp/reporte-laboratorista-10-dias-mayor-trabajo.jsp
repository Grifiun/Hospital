<%-- 
    Document   : reporte-laboratorista-10-dias-mayor-trabajo
    Created on : 07-oct-2020, 2:36:12
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
        
        Consultar cons = new Consultar();
        String query = "SELECT fecha, COUNT(*) AS cantidad FROM RESULTADO WHERE laboratorista = ? GROUP BY fecha ORDER BY cantidad DESC LIMIT 10";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("fecha","cantidad")), //datos a obtener
                new ArrayList<String>(Arrays.asList(laboratorista))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Utilizacion de dias</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-laboratorista.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h3>10 fechas con mas trabajo realizado</h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>