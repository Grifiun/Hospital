<%-- 
    Document   : actualizar-datos-laboratorista
    Created on : 08-oct-2020, 10:48:58
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
        String identificador2 = "LABORATORISTA,nombre,registro,dpi,telefono,examen,correo,trabajof,password";
        session.setAttribute("identificador", identificador2);         
        ArrayList identificador = new ArrayList<String>(Arrays.asList(identificador2.split(",")));
        request.setAttribute("prueba", "prueba");
        
        String codigo = "";
        String rol = (String) session.getAttribute("rol");
        
        if(rol.equals("laboratorista")){
           codigo  = (String) session.getAttribute("codigo");
        }else{
           codigo  = request.getParameter("laboratorista");
        }
                
        Consultar cons = new Consultar();         
        List<ArrayList<String>> lista = cons.obtenerRegistros("LABORATORISTA", //tabla
                new ArrayList<>(Arrays.asList("nombre","registro","dpi","telefono","examen","correo","trabajof")), //datos a obtener
                new ArrayList<String>(Arrays.asList("codigo")), //restricciones
                new ArrayList<String>(Arrays.asList(codigo))); //valor a cumplor
       
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar datos</title>        
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
        <%@include file="../html/actualizar-datos/actualizar-datos-usuarios.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
