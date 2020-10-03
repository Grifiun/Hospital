/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import conection_db.Registrar;
import funciones.GenerarQueryInsert;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        //creamos un AL para guardar los datos        
        ArrayList<String> datos = new ArrayList();
        ArrayList<String> identificador = new ArrayList<>();
        //nombre tabla
        identificador.add("PACIENTE");
        //Atributos
        identificador.add("nombre");
        identificador.add("sexo");
        identificador.add("birth");
        identificador.add("dpi");
        identificador.add("telefono");
        identificador.add("peso");
        identificador.add("sangre");
        identificador.add("correo");
        identificador.add("password");
        identificador.add("codigo");
        //obtenemos los datos
        for(int i = 1; i < identificador.size() - 1; i++){
            datos.add(request.getParameter(identificador.get(i)));
        }          
        datos.add("PAC-2123");
        //registramos
        registrar(identificador, datos);
    }

    /**
     * Funcion que registra los datos enviados
     * @param identificador
     * @param datos 
     */
    private void registrar(ArrayList<String> identificador, ArrayList<String> datos){
        ArrayList<String> queryList = new ArrayList();//ArrayList que contendra nuestra query
        List<ArrayList<String>> datoQuery = new ArrayList();//ArrayList de arraylist que contrendra nuestro listado de querys
        GenerarQueryInsert auxGenQ = new GenerarQueryInsert(identificador, datos, datoQuery, queryList);
        datoQuery = new ArrayList<ArrayList<String>> (auxGenQ.getDatoQuery());//obtenemos los datos
        queryList = new ArrayList<String> (auxGenQ.getQueryList());//obtenemos los querys
        Registrar reg = new Registrar(new ArrayList<ArrayList<String>> (datoQuery), new ArrayList<String>(queryList));
        reg.realizarRegistro();//registramos
    }
    
}
