<%-- 
    Document   : ingreso-mostrar-laboratorista
    Created on : 08-oct-2020, 11:00:01
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
        <%        //String identificador2 = "LABORATORISTA,nombre,registro,dpi,telefono,examen,correo,trabajof,password";
        //titulos
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("codigo","nombre","registro","DPI","telefono","examen","correo","fecha de ingreso"));
        String destino = request.getParameter("destino");
        request.getSession().setAttribute("fechaSistema", "desactivado");
        String rol = (String) session.getAttribute("rol");
        Consultar cons = new Consultar();
        List<ArrayList<String>> lista = cons.obtenerRegistros("LABORATORISTA", //tabla
                new ArrayList<>(Arrays.asList("codigo","nombre","registro","dpi","telefono","examen","correo","trabajof")), //datos a obtener
                new ArrayList<String>(), //restricciones
                new ArrayList<String>()); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado pacientes, elija uno</title>        
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
        <%@include file="../html/mostrar-registro/form-codigo-laboratorista.html"%>       
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
