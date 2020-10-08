<%-- 
    Document   : reporte-ingreso-por-medico
    Created on : 07-oct-2020, 14:56:49
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Codigo medico","total","Nombre","colegiado","DPI","Correo"));
        
        //fechas
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        Consultar cons = new Consultar();
        String query = "SELECT AA.medico, SUM(AA.cantidad * BB.costo) AS total, CC.nombre, CC.colegiado, CC.dpi, CC.correo FROM (SELECT A.medico, A.especialidad, COUNT(A.medico) AS cantidad FROM CITA AS A WHERE (A.fecha BETWEEN ? AND ?) AND A.estado = 'atendido' GROUP BY A.medico, A.especialidad) AA JOIN CONSULTA AS BB ON AA.especialidad = BB.tipo JOIN DOCTOR AS CC ON AA.medico = CC.codigo GROUP BY AA.medico ORDER BY SUM(AA.cantidad * BB.costo) DESC";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("medico","total","nombre","colegiado","dpi","correo")), //datos a obtener
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
        <h3>Ingreso por medico entre el intervalo <%=fecha_inicio%> y <%=fecha_fin%></h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>