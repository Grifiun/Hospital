/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import lector_archivo.LeerArchivo;

/**
 * Servlet encargado de realizar la carga del archivo, manda el archivo recibido
 * de la pagina web hacia una clase que realizara la lectura de dicho archivo
 * @author grifiun
 */
@MultipartConfig (maxFileSize = 16177215)//16MB
@WebServlet(name = "ControladorCargarArchivo", urlPatterns = {"/ControladorCargarArchivo"})
public class ControladorCargarArchivo extends HttpServlet {

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
        /**
         * Obtenemos el archivo desde el request
         */
        Part archivo = request.getPart("archivo");
        //instanciamos el objeto encargado de analizar el archivo
        LeerArchivo la = new LeerArchivo(archivo.getSubmittedFileName());       
        
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
