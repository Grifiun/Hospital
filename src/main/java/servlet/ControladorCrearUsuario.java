/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import conection_db.Registrar;
import funciones.GenerarQueryInsert;
import java.io.IOException;
import funciones.GenerarCodigoAleatorio;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
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
        ArrayList<String> datos = new ArrayList();
        ArrayList<String> identificador = new ArrayList();
        //nombre tabla
        rrt.addToIdentificador("PACIENTE");
        //Atributos
        rrt.addToIdentificador("nombre");
        rrt.addToIdentificador("sexo");
        rrt.addToIdentificador("birth");
        rrt.addToIdentificador("dpi");
        rrt.addToIdentificador("telefono");
        rrt.addToIdentificador("peso");
        rrt.addToIdentificador("sangre");
        rrt.addToIdentificador("correo");
        rrt.addToIdentificador("password");
        rrt.addToIdentificador("codigo");
        //obtenemos los datos
        for(int i = 1; i < identificador.size() - 1; i++){
            rrt.addToDato(request.getParameter(identificador.get(i)));
        }         
        //Creamos el codigo
        GenerarCodigoAleatorio genC = new GenerarCodigoAleatorio();
        rrt.addToDato(genC.generarCodAleatorio("PACIENTE", "PAC", 1000, 9999));
        //registramos
        rrt.realizarRegistro();
    }

    
}
