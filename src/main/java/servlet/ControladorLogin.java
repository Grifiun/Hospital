/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import conection_db.Consultar;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Este servlet recibe el codigo de usuario y la password
 * ingresada por el usuario, y se verifica si los datos son 
 * correctos.
 * @author grifiun
 */
@WebServlet(name = "ControladorLogin", urlPatterns = {"/ControladorLogin"})
public class ControladorLogin extends HttpServlet {

    /**
     * Metodo dePost, usada para recibir los datos
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codigo, password, usuarioRol = "";
        String[] tabla = {"PACIENTE","DOCTOR","LABORATORISTA","ADMIN"};//Se usara para identificar el usuario
        codigo = request.getParameter("codigo");
        password = request.getParameter("pass");
        
        Consultar cons = new Consultar();//instanciamos
        //preparamos los datos
        ArrayList<String> atributosAux = new ArrayList();
        atributosAux.add("codigo");
        atributosAux.add("password");
        ArrayList<String> datosAux = new ArrayList();
        datosAux.add(codigo);
        datosAux.add(password);
        System.out.println("codigo: "+codigo+"pass: " +password);
        for(int i = 0; i < tabla.length; i++){             
            if(cons.consultarExistenciaRegistro(tabla[i], atributosAux, datosAux)){//Verificamos si existe dicho usuario en la base de datos
                usuarioRol = tabla[i].toLowerCase();//se lo encuentra le asigna el rol al usuario
                break;//ceramos el ciclo
            }                
        }  
        
        switch(usuarioRol){
            case "": 
                //no encuentra al usuario
                System.out.println("SIN NADA");
                RequestDispatcher rd = request.getRequestDispatcher("/jsp/usuario-no-encontrado.jsp");
                rd.forward(request, response);  
                break;
            default:
                System.out.println("CON ROL");
                RequestDispatcher rd2 = request.getRequestDispatcher("/jsp/home-"+usuarioRol+".jsp");
                rd2.forward(request, response);
                break;
        }
    }

    /**
     * El servlet "ControladorLogin" tiene como funcion 
     * manejar el ingreso de los usuarios dentro del sistema.
     * 
     * Se encarga de verificar la existencia de los usuario dentro
     * de la base de datos así como revisar la contrasena     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
