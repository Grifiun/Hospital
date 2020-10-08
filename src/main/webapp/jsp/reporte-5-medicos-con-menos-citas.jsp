<%-- 
    Document   : reporte-5-medicos-con-menos-citas
    Created on : 07-oct-2020, 13:56:03
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Codigo medico","Nombre","DPI","Correo","Cantidad de citas"));
        
        //fechas
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        Consultar cons = new Consultar();
        String query = "SELECT A.medico, B.nombre, B.dpi, B.correo, COUNT(A.medico) AS cantidad FROM CITA AS A JOIN DOCTOR AS B ON A.medico = B.codigo WHERE A.fecha BETWEEN ? AND ? GROUP BY A.medico ORDER BY COUNT(A.medico) ASC LIMIT 5";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("medico","nombre","dpi","correo","cantidad")), //datos a obtener
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
        <h3>5 medicos con menos citas en el intervalo <%=fecha_inicio%> y <%=fecha_fin%></h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <h6>Nota: se tomaron en cuenta todas las citas medicas, ya sean citas atendidas o en proceso, porque de igual forma son demanda</h6>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>