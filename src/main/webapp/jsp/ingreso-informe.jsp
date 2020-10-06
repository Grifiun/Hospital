<%-- 
    Document   : ingreso-informe
    Created on : 05-oct-2020, 23:08:41
    Author     : grifiun
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="conection_db.Consultar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso informe de cita</title>  
        <%
        String identificador = "REPORTE,codigo,paciente,medico,informe,fecha,hora";
        session.setAttribute("identificador", identificador);
        String cita = request.getParameter("cita");//codigo cita
        System.out.println(cita);
        Consultar cons = new Consultar();
        List<ArrayList<String>> lista = cons.obtenerRegistros("CITA", //tabla
                new ArrayList<>(Arrays.asList("paciente","medico","fecha","hora")), //datos a obtener
                new ArrayList<String>(Arrays.asList("codigo")), //restricciones
                new ArrayList<String>(Arrays.asList(cita))); //valor a cumplor
        String paciente = lista.get(0).get(0);
        String medico = lista.get(0).get(1);
        String fecha = lista.get(0).get(2);
        String hora = lista.get(0).get(3);
        %>    
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-doctor/form-ingreso-informe.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>



            
            