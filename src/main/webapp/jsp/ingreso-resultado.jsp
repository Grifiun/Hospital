<%-- 
    Document   : ingreso-resultado
    Created on : 06-oct-2020, 11:40:41
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
        String identificador = "RESULTADO,codigo,paciente,medico,examen,laboratorista,orden,informe,fecha,hora";
        session.setAttribute("identificador", identificador);
        
        String laboratorista = (String) session.getAttribute("codigo");//pbtenemos el codigo del laboratorista
        String cita_examen = request.getParameter("cita_examen");//codigo cita
        Consultar cons = new Consultar();
        List<ArrayList<String>> lista = cons.obtenerRegistros("CITA_EXAMEN", //tabla
                new ArrayList<>(Arrays.asList("paciente","medico","fecha","orden","examen")), //datos a obtener
                new ArrayList<String>(Arrays.asList("codigo")), //get atributo
                new ArrayList<String>(Arrays.asList(cita_examen))); //valor a cumplor       
                
        String paciente = lista.get(0).get(0);
        String medico = lista.get(0).get(1);
        String fecha = lista.get(0).get(2);
        String orden = lista.get(0).get(3);
        String examen = lista.get(0).get(4);
        %>    
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-laboratorista.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-laboratorista/form-ingreso-resultado.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
