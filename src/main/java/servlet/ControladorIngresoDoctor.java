/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import conection_db.Consultar;
import encriptador.Encriptar;
import funciones.GenerarCodigoAleatorio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import registros.RealizarRegistroTabla;

/**
 *
 * @author grifiun
 */
@WebServlet(name = "ControladorIngresoDoctor", urlPatterns = {"/ControladorIngresoDoctor"})
public class ControladorIngresoDoctor extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Instaanciamos 
        RealizarRegistroTabla rrt;
        rrt = new RealizarRegistroTabla();
        //agregamos los identificadores
        String[] ident = String.valueOf(request.getSession().getAttribute("identificador")).split(",");
        rrt.setIdentificador(new ArrayList<String>(Arrays.asList(ident)));//agregamos los identificadores
        //obtenemos los datos
        for(int i = 1; i < rrt.getIdentificador().size(); i++){
            if(rrt.getIdentificador().get(i).equals("codigo") && request.getSession().getAttribute("codigoAleatorio").equals("activado")){
                //Creamos el codigo si esta activado la generacion de codigo aleatorio
                GenerarCodigoAleatorio genC = new GenerarCodigoAleatorio();
                String auxCod = genC.generarCodAleatorio(rrt.getIdentificador().get(0), rrt.getIdentificador().get(0).substring(0, 3), 1000, 9999);
                rrt.addToDato(auxCod);
            }else if(rrt.getIdentificador().get(i).equals("password")){   
                //encriptamos
                Encriptar encrpt = new Encriptar();
                //Class.forName("org.apache.commons.codec.Driver");
                String auxPass = request.getParameter(rrt.getIdentificador().get(i));
                String auxEn = encrpt.getEncriptPass(auxPass);//encriptamos
                rrt.addToDato(auxEn);                
            }else if(rrt.getIdentificador().get(i).equals("trabajo") || 
                    rrt.getIdentificador().get(i).equals("trabajof") ||
                    rrt.getIdentificador().get(i).equals("birth") ||
                    rrt.getIdentificador().get(i).equals("fecha") &&
                    request.getSession().getAttribute("fechaSistema").equals("activado")){
                //Si son fechas
                //Agregamos la fecha
                rrt.addToDato((String)request.getSession().getAttribute("fecha_sistema"));            
            }else if(rrt.getIdentificador().get(i).equals("medico")){
                rrt.addToDato((String)request.getSession().getAttribute("medico"));
            }else{//si es un dato ordinario (a recibir del request)
                 rrt.addToDato(request.getParameter(rrt.getIdentificador().get(i)));
            }
        }                 
        //registramos
        rrt.realizarRegistro();
        
        RealizarRegistroTabla rrt2;
        rrt2 = new RealizarRegistroTabla();
        rrt2.addToIdentificador("HORARIO");
        rrt2.addToIdentificador("codigo");
        rrt2.addToIdentificador("inicio");
        rrt2.addToIdentificador("fin");
        rrt2.addToDato(rrt.getDatos().get(0));
        rrt2.addToDato((String)request.getParameter("inicio"));
        rrt2.addToDato((String)request.getParameter("fin"));
        rrt2.realizarRegistro();
        
        //Retornamos otra pagina dependiendo del resultado
        Consultar cons = new Consultar();
        boolean isRegistroCompleto = false;
        isRegistroCompleto = cons.consultarExistenciaRegistro(rrt.getIdentificador().get(0), //TABLA
                new ArrayList<String>(Arrays.asList(rrt.getIdentificador().get(1))), // Consutlar PK 
                new ArrayList<String>(Arrays.asList(rrt.getDatos().get(0))));//con valor
       
        if(isRegistroCompleto){
            request.getSession().setAttribute("mensaje", "El registro se hizo con satisfaccion");
        }
        else{
            request.getSession().setAttribute("mensaje", "El registro no se realizo debido a un error");
        }
        
        
        
        request.getSession().setAttribute("codigoAleatorio", "activado");//volvemos a activar la generacion del codigo aleatorio
        request.getSession().setAttribute("fechaSistema", "activado");//volvemos a activar la generacion del codigo aleatorio
        String direccion = "jsp/home-"+(String)request.getSession().getAttribute("rol")+".jsp";
        response.sendRedirect(direccion);
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
