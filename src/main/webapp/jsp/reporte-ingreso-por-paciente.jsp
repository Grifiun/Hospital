<%-- 
    Document   : reporte-ingreso-por-paciente
    Created on : 07-oct-2020, 9:50:33
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
        List<ArrayList<String>> titulos = new ArrayList();        
            titulos.add(new ArrayList<String> (Arrays.asList("Cod. paciente","Subtotal cita","Nombre","Sexo","DPI","Correo")));
            titulos.add(new ArrayList<String> (Arrays.asList("Cod. paciente","Especialidad","Costo","Cantidad","Subtotal","Nombre","Sexo","DPI","Correo"  )));
            titulos.add(new ArrayList<String> (Arrays.asList("Cod. paciente","subtotal_examen","Nombre","Sexo","DPI","Correo")));
            titulos.add(new ArrayList<String> (Arrays.asList("Cod. paciente","Cod. examen","cantidad","costo","subtotal_examen","Nombre","Sexo","DPI","Correo"))); 
            titulos.add(new ArrayList<String> (Arrays.asList("Codigo paciente","Total","Nombre","Sexo","DPI","Correo"))); 
        //querys
        ArrayList<String> querys = new ArrayList();
            querys.add("SELECT A.paciente, SUM(B.costo * A.Cantidad) AS subtotal_cita, C.nombre, C.sexo, C.dpi, C.correo FROM ((SELECT paciente, especialidad, COUNT(paciente) AS cantidad FROM CITA WHERE estado = 'atendido' AND (fecha BETWEEN ? AND ?) GROUP BY paciente, especialidad) AS A JOIN CONSULTA AS B ON A.especialidad = B.tipo) JOIN PACIENTE AS C ON A.paciente = C.codigo GROUP BY A.paciente");
            querys.add("SELECT A.paciente, A.especialidad, B.costo, A.cantidad, B.costo * A.Cantidad AS subtotal, C.nombre, C.sexo, C.dpi, C.correo FROM ((SELECT paciente, especialidad, COUNT(paciente) AS cantidad FROM CITA WHERE estado = 'atendido' AND (fecha BETWEEN ? AND ?) GROUP BY paciente, especialidad) AS A JOIN CONSULTA AS B ON A.especialidad = B.tipo) JOIN PACIENTE AS C ON A.paciente = C.codigo");
            querys.add("SELECT REX.paciente, SUM(REX.cantidad*EX.costo) AS subtotal_examen, C.nombre, C.sexo, C.dpi, C.correo FROM((SELECT CE.paciente, CE.examen, COUNT(CE.paciente) AS cantidad FROM CITA_EXAMEN AS CE WHERE CE.estado = 'atendido' AND (CE.fecha BETWEEN ? AND ?) GROUP BY CE.paciente,CE.examen) AS REX JOIN EXAMEN AS EX ON REX.examen = EX.codigo) JOIN PACIENTE AS C ON C.codigo = REX.PACIENTE GROUP BY REX.paciente");
            querys.add( "SELECT REX.paciente, REX.examen, REX.cantidad, EX.costo, SUM(REX.cantidad*EX.costo) AS subtotal_examen, C.nombre, C.sexo, C.dpi, C.correo FROM((SELECT CE.paciente, CE.examen, COUNT(CE.paciente) AS cantidad FROM CITA_EXAMEN AS CE WHERE CE.estado = 'atendido' AND (CE.fecha BETWEEN ? AND ?) GROUP BY CE.paciente,CE.examen) AS REX JOIN EXAMEN AS EX ON REX.examen = EX.codigo) JOIN PACIENTE AS C ON C.codigo = REX.paciente GROUP BY REX.paciente, REX.examen, REX.cantidad,EX.costo");
        //Atributos a obtener
        List<ArrayList<String>> atributos = new ArrayList();        
            atributos.add(new ArrayList<String> (Arrays.asList("paciente","subtotal_cita","nombre","sexo","dpi","correo")));
            atributos.add(new ArrayList<String> (Arrays.asList("paciente","especialidad","costo","cantidad","subtotal","nombre","sexo","dpi","correo")));
            atributos.add(new ArrayList<String> (Arrays.asList("paciente","subtotal_examen","nombre","sexo","dpi","correo")));
            atributos.add(new ArrayList<String> (Arrays.asList("paciente","examen","cantidad","costo","subtotal_examen","nombre","sexo","dpi","correo"))); 
        //fechas
        String fecha_inicio = request.getParameter("fecha_inicio");
        String fecha_fin = request.getParameter("fecha_fin");
        //titulo auxiliar
       ArrayList<String> titulo = titulos.get(0);
        Consultar cons = new Consultar();
        //lista auxiliar
        List<ArrayList<String>> lista = cons.obtenerRegistros(querys.get(0), //tabla
                new ArrayList<>(atributos.get(0)), //datos a obtener
                new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin))); //valor a cumplor 
        List<ArrayList<String>> lista2 = cons.obtenerRegistros(querys.get(2), //tabla
                new ArrayList<>(atributos.get(2)), //datos a obtener
                new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin))); //valor a cumplor         
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingreso cita</title>        
        <%@include file="../html/css-bootstrap.html"%>
        <link href="../css/style-ingresos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="../html/navs/nav-admin.html" %>    
        <%@include file="../html/ingresos/parte-superior.html" %>
        <h1>Reporte: Ingresos por paciente <%=fecha_inicio%> y <%=fecha_fin%></h1>

        <div id="accordion">          
          <div class="card">
            <div class="card-header" id="headingOne">
              <h5 class="mb-0">
                <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    Ingresos totales
                </button>
              </h5>
            </div>

            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
              <div class="card-body">
                     <%
                    titulo = titulos.get(4);                    
                     %>
                     <%@include file="../html/mostrar-registro/tabla-generica-total-ingresos.html" %></div>
                   
              </div>
            </div>
          </div>
          <div class="card">
            <div class="card-header" id="headingThree">
              <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseThree">
                    Ingresos por citas
                </button>
              </h5>
            </div>
            <div id="collapseFive" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
              <div class="card-body">                
                <%@include file="../html/mostrar-registro/tabla-generica.html" %>
            </div>
          </div>
          <div class="card">
            <div class="card-header" id="headingTwo">
              <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                  Detalles de ingresos por citas
                </button>
              </h5>
            </div>
            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
              <div class="card-body">
                <%
                    titulo = titulos.get(1);
                    lista = cons.obtenerRegistros(querys.get(1), //tabla
                        new ArrayList<>(atributos.get(1)), //datos a obtener
                        new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin))); //valor a cumplor  
                %>
                <%@include file="../html/mostrar-registro/tabla-generica.html" %>
              </div>
            </div>
          </div>
          <div class="card">
            <div class="card-header" id="headingThree">
              <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                  Ingresos por examenes
                </button>
              </h5>
            </div>
            <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
              <div class="card-body">
                <%
                    titulo = titulos.get(2);
                %>
                <%@include file="../html/mostrar-registro/tabla-generica_1.html" %></div>
            </div>
          </div>
          <div class="card">
            <div class="card-header" id="headingThree">
              <h5 class="mb-0">
                <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseThree">
                  Detalles de ingresos por examenes
                </button>
              </h5>
            </div>
            <div id="collapseFour" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
              <div class="card-body">
                <%
                    titulo = titulos.get(3);
                    lista = cons.obtenerRegistros(querys.get(3), //tabla
                        new ArrayList<>(atributos.get(3)), //datos a obtener
                        new ArrayList<String>(Arrays.asList(fecha_inicio,fecha_fin))); //valor a cumplor  
                %>
                <%@include file="../html/mostrar-registro/tabla-generica.html" %></div>
            </div>
          </div>
        </div>          
           
           
        <%@include file="../html/ingresos/parte-inferior.html" %>
        <%@include file="../html/js-bootstrap.html"%>
    </body>
</html>
