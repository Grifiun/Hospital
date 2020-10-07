<%-- 
    Document   : reporte-mostrar-medicos-con-mas-informes
    Created on : 07-oct-2020, 11:46:38
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Codigo medico","Nombre","DPI","correo","cantidad de informes realizados"));
        
        //fechas
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        Consultar cons = new Consultar();
        String query = "SELECT A.medico, B.nombre, B.dpi, B.correo, COUNT(A.medico) AS cantidad FROM REPORTE AS A JOIN DOCTOR AS B ON A.medico = B.codigo WHERE A.fecha BETWEEN ? AND ? GROUP BY A.medico ORDER BY cantidad DESC LIMIT 10";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("medico","nombre","dpi","correo","cantidad")), //datos a obtener
                new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Top 10 medicos con informes</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h3>Top 10 medicos que mas informes han realizado dentro de un intervalo de tiempo</h3>
        <h3>Fecha inicio <%=fecha_inicio%> y fecha fin <%=fecha_fin%></h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>