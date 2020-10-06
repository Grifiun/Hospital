<%-- 
    Document   : ingreso-cita-examen
    Created on : 05-oct-2020, 19:13:41
    Author     : grifiun
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="conection_db.Consultar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>        
        
     <%
        String identificador = "CITA_EXAMEN,codigo,examen,fecha,medico,paciente,orden";
        session.setAttribute("identificador", identificador);        
        
        String paciente = (String) session.getAttribute("codigo");
        String examen = (String) request.getParameter("examen");
        request.getSession().setAttribute("fechaSistema", "desactivado");
        Consultar cons = new Consultar();          
                
        List<ArrayList<String>> listaDoctor = cons.obtenerRegistros("DOCTOR", //tabla
                new ArrayList<>(Arrays.asList("codigo","nombre")), //datos a obtener
                new ArrayList<String>(), //restricciones
                new ArrayList<String>()); //valor a cumplor      
        
        List<ArrayList<String>> listaEx = cons.obtenerRegistros("EXAMEN", //tabla
                new ArrayList<>(Arrays.asList("orden")), //datos a obtener
                new ArrayList<String>(Arrays.asList("codigo")), //restricciones
                new ArrayList<String>(Arrays.asList(examen))); //valor a cumplor  
        String ordenEstado = listaEx.get(0).get(0);
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita exmane</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-paciente.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-paciente/form-ingreso-cita-examen.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>