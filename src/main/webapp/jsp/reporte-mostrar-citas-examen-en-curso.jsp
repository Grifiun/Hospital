<%-- 
    Document   : reporte-mostrar-citas-examen-en-curso
    Created on : 06-oct-2020, 10:06:49
    Author     : grifiun
--%>


<%@page import="funciones.obtenerCodigosExamenes"%>
<%@page import="conection_db.Registrar"%>
<%@page import="conection_db.Actualizar"%>
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
        ArrayList<String> titulo = new ArrayList<>(Arrays.asList("codigo de la reserva","cod. examen","fecha","estado","cod. medico","cod. paciente","archivo orden"));
        List<ArrayList<String>> lista = new ArrayList<>();
        String fecha = (String) request.getSession().getAttribute("fecha_sistema");
        String codigo = (String) request.getSession().getAttribute("codigo");
        
        obtenerCodigosExamenes oce = new obtenerCodigosExamenes();
        String nombreExamen = oce.getNombreExamen(codigo, fecha);
        System.out.println(nombreExamen);
        String msg = oce.getMsg();
        if(nombreExamen.equals("")){}
        else{
            String query = " SELECT A.* FROM CITA_EXAMEN AS A LEFT JOIN (SELECT codigo FROM EXAMEN WHERE nombre = ?) AS B ON A.examen = B.codigo WHERE A.estado = 'En proceso' AND A.fecha = ?;";
            Consultar cons = new Consultar();
            lista = cons.obtenerRegistros(query, //datos a obtener
                new ArrayList<String>(Arrays.asList("codigo","examen","fecha","estado","medico","paciente","orden")), //rget atributo
                new ArrayList<String>(Arrays.asList(nombreExamen,fecha))); //valor a cumplor
        }    
        %>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-laboratorista.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <form action="../jsp/ingreso-resultado.jsp">
        <%@include file="../html/mostrar-registro/tabla-generica.html" %>
            <div class="form-group align-self-start">
                <h5><%=msg%></h5>
                <select name="cita_examen" class="cont" id="examen" required>   
                   
                    <%
                        for(int i = 0; i < lista.size(); i++){
                    %>            
                    <option value="<%=lista.get(i).get(0)%>"><%=lista.get(i).get(0)%></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-dark">Ingresar resultado</button>
        </form>
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>

