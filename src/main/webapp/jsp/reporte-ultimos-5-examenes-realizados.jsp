<%-- 
    Document   : reporte-ultimos-5-examenes-realizados
    Created on : 07-oct-2020, 3:17:01
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("Nombre del examen de laboratorio","Fecha","Codigo del medico a cargo","Estado del examen"));
        String laboratorista = (String) session.getAttribute("codigo");
        
        Consultar cons = new Consultar();
        String query = "SELECT B.nombre,A.fecha,A.medico,A.estado FROM CITA_EXAMEN AS A JOIN (SELECT codigo, nombre FROM EXAMEN) AS B ON A.examen = B.codigo WHERE (A.paciente = ?) AND A.estado='atendido' ORDER BY A.fecha DESC LIMIT 5";
        List<ArrayList<String>> lista = cons.obtenerRegistros(query, //query a ejecutar
                new ArrayList<>(Arrays.asList("nombre","fecha","medico","estado")), //datos a obtener
                new ArrayList<String>(Arrays.asList(laboratorista))); //valor a cumplor  
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte ultimos examenes</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-paciente.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h3>Ultimos 5 examenes de laboratorios realizados</h3>
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>