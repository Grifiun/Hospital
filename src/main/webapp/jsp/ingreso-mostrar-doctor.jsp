<%-- 
    Document   : ingreso-mostrar-doctor
    Created on : 05-oct-2020, 15:31:01
    Author     : grifiun
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="conection_db.Consultar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%        
        //titulos
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("codigo","nombre","colegiado","dpi","correo","trabajo"));
         
        request.getSession().setAttribute("fechaSistema", "desactivado");
        Consultar cons = new Consultar();
        List<ArrayList<String>> lista = cons.obtenerRegistros("DOCTOR", //tabla
                new ArrayList<>(Arrays.asList("codigo","nombre","colegiado","dpi","correo","trabajo")), //datos a obtener
                new ArrayList<String>(), //restricciones
                new ArrayList<String>()); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-paciente.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <%@include file="../html/ingresos-paciente/form-inicio-hacia-cita.html" %>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos-paciente/form-fin-hacia-cita.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
