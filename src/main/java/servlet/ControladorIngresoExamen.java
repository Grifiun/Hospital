/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import funciones.GenerarCodigoAleatorio;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "ControladorIngresoExamen", urlPatterns = {"/ControladorIngresoExamen"})
public class ControladorIngresoExamen extends HttpServlet {
    
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
        ArrayList<String> datos = new ArrayList();
        ArrayList<String> identificador = new ArrayList();
        //nombre tabla
        rrt.addToIdentificador("EXAMEN");
        //Atributos
        rrt.addToIdentificador("nombre");
        rrt.addToIdentificador("orden");
        rrt.addToIdentificador("descripcion");
        rrt.addToIdentificador("costo");
        rrt.addToIdentificador("informe");
        rrt.addToIdentificador("codigo");
        //obtenemos los datos
        for(int i = 1; i < rrt.getIdentificador().size() - 1; i++){
            rrt.addToDato(request.getParameter(rrt.getIdentificador().get(i)));
        }         
        //Creamos el codigo
        GenerarCodigoAleatorio genC = new GenerarCodigoAleatorio();
        String auxCod = genC.generarCodAleatorio("EXAMEN", "EXA", 1000, 9999);
        rrt.addToDato(auxCod);
        //registramos
        rrt.realizarRegistro();
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
