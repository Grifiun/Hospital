<%-- 
    Document   : actualizar-datos-examen
    Created on : 08-oct-2020, 11:56:51
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
        String identificador2 = "EXAMEN,nombre,orden,descripcion,costo,informe";
        session.setAttribute("identificador", identificador2);         
        ArrayList identificador = new ArrayList<String>(Arrays.asList(identificador2.split(",")));
        request.setAttribute("prueba", "prueba");
        /**
         *  +-------------+---------------+------+-----+---------+-------+
            | Field       | Type          | Null | Key | Default | Extra |
            +-------------+---------------+------+-----+---------+-------+
            | codigo      | varchar(20)   | NO   | PRI | NULL    |       |
            | nombre      | varchar(45)   | NO   |     | NULL    |       |
            | orden       | varchar(45)   | NO   |     | NULL    |       |
            | descripcion | varchar(450)  | NO   |     | NULL    |       |
            | costo       | decimal(11,2) | NO   |     | NULL    |       |
            | informe     | varchar(3)    | NO   |     | NULL    |       |
            +-------------+---------------+------+-----+---------+-------+

         */
        String codigo = "";
        String rol = (String) session.getAttribute("rol");        
        codigo  = request.getParameter("examen");
        
                
        Consultar cons = new Consultar();         
        List<ArrayList<String>> lista = cons.obtenerRegistros("EXAMEN", //tabla
                new ArrayList<>(Arrays.asList("nombre","orden","descripcion","costo","informe")), //datos a obtener
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