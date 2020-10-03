/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conection_db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Clase encargada de crear, retornar o cerrar 
 * la conexion con MySQL
 * @author grifiun
 */
public class ConectionJDBC {
    static String USER = "root";
    static String PASS = "123@MySQL";
    static String STRING_CONECTION = "jdbc:mysql://localhost:3306/HOSPITAL";
    static Connection conexion = null;
    
    /**
     * Funcion que crea la conexion con la DB
     * @return
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException 
     */
    public static void crearEnlaceJDBC() throws ClassNotFoundException, InstantiationException, IllegalAccessException{
        try {
            Class.forName("com.mysql.jdbc.Driver");            
            Connection conection = DriverManager.getConnection(STRING_CONECTION, USER, PASS);
                System.out.println("exitosamente");
                setConexion(conection);//establecemos la conexion               
            
        } catch (SQLException ex) {
            System.out.println(ex);
            System.out.println("error en la conexion con la DB");            
        }
    }
    
    /**
     * Obtenemos la conexion
     * revisa si la conexion esta abierta
     * si esta cerrada inicia una nueva conexion
     * @return 
     */
    public static Connection getConexion() throws ClassNotFoundException {
        try {
            if(conexion.isClosed() == true){
                crearEnlaceJDBC();
            }
        } catch (SQLException ex) {
            System.out.println("Error:"+ex.getMessage());
        } catch (InstantiationException ex) {       
            System.out.println("Error:"+ex.getMessage());
        } catch (IllegalAccessException ex) {
            System.out.println("Error:"+ex.getMessage());
        }
        
        return conexion;
    }

    /**
     * establecemos la conexion
     * @param conexion 
     */
    public static void setConexion(Connection conexion) {
        ConectionJDBC.conexion = conexion;
    }

    /**
     * Cerramos la conexion si esta abierta
     */
    public static void cerrarConexion() {
        try {
            if(conexion.isClosed() == false){
                conexion.close();       
            }
        } catch (SQLException ex) {
            System.out.println("Error:"+ex.getMessage());
        }
    }
}
