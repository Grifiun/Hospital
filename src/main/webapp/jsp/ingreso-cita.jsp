<%-- 
    Document   : ingreso-cita
    Created on : 04-oct-2020, 23:40:57
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
        String identificador = "CITA,codigo,paciente,medico,especialidad,fecha,hora";
        session.setAttribute("identificador", identificador);
        String medico = (String)request.getParameter("medico");
        String condicion = "";
        session.setAttribute("medico", medico);
        String paciente = (String)session.getAttribute("codigo");
        request.getSession().setAttribute("fechaSistema", "desactivado");
        Consultar cons = new Consultar();
        List<ArrayList<String>> listaDoctor = cons.obtenerRegistros("DOCTOR", //tabla
                new ArrayList<>(Arrays.asList("codigo","nombre")), //datos a obtener
                new ArrayList<String>(), //restricciones
                new ArrayList<String>()); //valor a cumplor     
        if(medico != null){//carga las especialidades del medico seleccionado
            condicion = medico;
        }else{//si no hay ninguno seleccionado se cargan los del primero
            condicion = listaDoctor.get(0).get(0); //valor a cumplor codigo medico        
        }  
        List<ArrayList<String>> listaEspecialidades = cons.obtenerRegistros("ESPECIALIDAD", //tabla
                new ArrayList<>(Arrays.asList("titulo")), //datos a obtener
                new ArrayList<String>(Arrays.asList("codigo")), //restricciones
                new ArrayList<String>(Arrays.asList(condicion))); //valor a cumplor
        
        
        List<ArrayList<String>> listaHorario = cons.obtenerRegistros("HORARIO", //tabla
                new ArrayList<>(Arrays.asList("inicio","fin")), //datos a obtener
                new ArrayList<String>(Arrays.asList("codigo")), //restricciones
                new ArrayList<String>(Arrays.asList(condicion))); //valor a cumplor
       
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-paciente.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-paciente/form-ingreso-cita.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
