<%-- 
    Document   : reporte-medicos-con-mas-examenes-pedidos
    Created on : 07-oct-2020, 15:48:02
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Codigo medico","Nombre","N.colegiado","DPI","Correo","Cantidad de examenes pedidos"));
        
        //fechas
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        Consultar cons = new Consultar();
        String query = "SELECT A.medico, B.nombre, B.colegiado, B.dpi, B.correo, COUNT(A.medico) as cantidad FROM CITA_EXAMEN AS A JOIN DOCTOR AS B ON A.medico = B.codigo WHERE (A.fecha BETWEEN ? AND ?) GROUP BY A.medico ORDER BY COUNT(A.medico) DESC";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("medico","nombre","colegiado","dpi","correo","cantidad")), //datos a obtener
                new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medicos con mayor cantidad de examenes de laboratorio requeridos</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h3>Medicos con mayor cantidad de examenes de laboratorio requeridos en el intervalo <%=fecha_inicio%> y <%=fecha_fin%></h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <h6>Nota: se tomaron en cuenta todas las citas de examenes de laboratorio, ya sean citas atendidas o en proceso, porque de igual forma fueron requerridas</h6>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>