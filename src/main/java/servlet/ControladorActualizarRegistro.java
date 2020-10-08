/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import conection_db.Actualizar;
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
@WebServlet(name = "ControladorActualizarRegistro", urlPatterns = {"/ControladorActualizarRegistro"})
public class ControladorActualizarRegistro extends HttpServlet {

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
        //agregamos los identificadores
        String[] ident = String.valueOf(request.getSession().getAttribute("identificador")).split(",");
        
        ArrayList<String> identificador = new ArrayList<String>(Arrays.asList(ident));
        ArrayList<String> dato = new ArrayList<String>();
        String codigo = request.getParameter("codigo");//obtenemos el codigo del registro
        //obtenemos los datos
        for(int i = 1; i < identificador.size(); i++){
            if(identificador.get(i).equals("password")){   
                //encriptamos
                Encriptar encrpt = new Encriptar();
                //Class.forName("org.apache.commons.codec.Driver");
                String auxPass = request.getParameter(identificador.get(i));
                String auxEn = encrpt.getEncriptPass(auxPass);//encriptamos
                dato.add(auxEn);                
            }else{//si es un dato ordinario (a recibir del request)
                 dato.add(request.getParameter(identificador.get(i)));
            }
        }     
        String tabla = identificador.get(0);//agregamos la tabla
        identificador.remove(0);//removemos la tabla
        
        dato.add(codigo);//agregamos el codigo al final para agregar el valor de la restriccion
        //actualizamos
        Actualizar act = new Actualizar(tabla, //tabla
            new ArrayList<String>(identificador),//valores a modificar
            new ArrayList<String>(Arrays.asList("codigo")),//restriccion: modificar donde el codigo
            new ArrayList<String>(dato));//valores y valor restriccion
            act.actualizar();
            request.getSession().setAttribute("mensaje", "El registro se hizo con satisfaccion");
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
