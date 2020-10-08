/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import conection_db.Consultar;
import java.io.IOException;
import funciones.GenerarCodigoAleatorio;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import registros.RealizarRegistroTabla;
import encriptador.Encriptar;


/**
 *
 * @author grifiun
 */
@WebServlet(name = "ControladorCrearUsuario", urlPatterns = {"/ControladorCrearUsuario"})
public class ControladorCrearUsuario extends HttpServlet {
     
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
        //Ingresamos los identificadores
        //creamos un AL para guardar los datos        
        //nombre tabla
        rrt.addToIdentificador("PACIENTE");
        //Atributos
        rrt.addToIdentificador("password");
        rrt.addToIdentificador("nombre");
        rrt.addToIdentificador("sexo");
        rrt.addToIdentificador("birth");
        rrt.addToIdentificador("dpi");
        rrt.addToIdentificador("telefono");
        rrt.addToIdentificador("peso");
        rrt.addToIdentificador("sangre");
        rrt.addToIdentificador("correo");        
        rrt.addToIdentificador("codigo");
        //obtenemos los datos
        for(int i = 1; i < rrt.getIdentificador().size() - 1; i++){
            if(rrt.getIdentificador().get(i).equals("password")){   
                //encriptamos
                Encriptar encrpt = new Encriptar();
                //Class.forName("org.apache.commons.codec.Driver");
                String auxPass = request.getParameter(rrt.getIdentificador().get(i));
                String auxEn = encrpt.getEncriptPass(auxPass);//encriptamos
                rrt.addToDato(auxEn);                
            }else
            rrt.addToDato(request.getParameter(rrt.getIdentificador().get(i)));            
        }         
        //Creamos el codigo
        GenerarCodigoAleatorio genC = new GenerarCodigoAleatorio();
        String auxCod = genC.generarCodAleatorio("PACIENTE", "PAC", 1000, 9999);
        rrt.addToDato(auxCod);
        //registramos
        rrt.realizarRegistro();
        
         //Retornamos otra pagina dependiendo del resultado
        Consultar cons = new Consultar();
        boolean isRegistroCompleto = false;
        isRegistroCompleto = cons.consultarExistenciaRegistro(rrt.getIdentificador().get(0), //TABLA
                new ArrayList<String>(Arrays.asList("codigo")), // Consutlar PK 
                new ArrayList<String>(Arrays.asList(auxCod)));//con valor
        request.getSession().setAttribute("rol", "paciente");
        request.getSession().setAttribute("codigo", auxCod);
        
        if(isRegistroCompleto){
            request.getSession().setAttribute("mensaje", "El registro se hizo con satisfaccion, su CODIGO de usuario es: "+auxCod);
            String direccion = "jsp/home-paciente.jsp";
            response.sendRedirect(direccion);
        }
        else{
            String direccion = "index.jsp";
            response.sendRedirect(direccion);
        }
        
        
    }

    
}
