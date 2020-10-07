<%-- 
    Document   : reporte-mostrar-historial-paciente
    Created on : 06-oct-2020, 5:41:42
    Author     : grifiun
--%>

<%@page import="java.util.List"%>
<%@page import="conection_db.Consultar"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%        
        //titulos
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("codigo","paciente","medico","especialidad","fecha","hora","estado"));
        String paciente;
        String rol = (String)session.getAttribute("rol"); 
        if(rol.equals("paciente")){
             paciente = (String) session.getAttribute("codigo");
        }else{
             paciente = request.getParameter("paciente");
        }        
        Consultar cons = new Consultar();
        cons.setTipoConsulta("codigo,paciente,medico,especialidad,fecha,hora,estado");
        List<ArrayList<String>> lista = cons.obtenerRegistros("CITA", //tabla
                new ArrayList<>(Arrays.asList("codigo","paciente","medico","especialidad","fecha","hora","estado")), //datos a obtener
                new ArrayList<String>(Arrays.asList("paciente = ? ORDER BY fecha")), //restricciones
                new ArrayList<String>(Arrays.asList(paciente))); //valor a cumplor  
        
        cons.setTipoConsulta("codigo,examen,fecha,estado,medico,paciente,orden");
        ArrayList<String> titulo2 = new ArrayList<>(Arrays.asList("codigo","examen","fecha","estado","medico","paciente","orden"));
        List<ArrayList<String>> lista2 = cons.obtenerRegistros("CITA_EXAMEN", //tabla
                new ArrayList<>(Arrays.asList("codigo","examen","fecha","estado","medico","paciente","orden")), //datos a obtener
                new ArrayList<String>(Arrays.asList("paciente = ? ORDER BY fecha")), //restricciones
                new ArrayList<String>(Arrays.asList(paciente))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%          
            System.out.println(rol);
            switch(rol){
                case "admin":%><%@include file="../html/navs/nav-admin.html" %><%
                break; 
                case "paciente":%><%@include file="../html/navs/nav-paciente.html" %><%
                break; 
                case "doctor":%><%@include file="../html/navs/nav-doctor.html" %><%
                break; 
                case "laboratorista":%><%@include file="../html/navs/nav-laboratorista.html" %><%
                break; 
            } 
        %>      
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-doctor/form-mostrar-historial-paciente.html"%>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
