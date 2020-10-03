/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conection_db;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Clase encargada de realizar registros dentro de la DB
 * @author grifiun
 */
public class Registrar {
    List<ArrayList<String>> queryDato;
    ArrayList<String> query;
    /**
     * Contructor de la clase registrar
     * recibe los parametros de:
     * List<ArrayList<String>> queryDato;
     * ArrayList<String> query;
     */
    public Registrar(List<ArrayList<String>> queryDato, ArrayList<String> query){
        this.queryDato = queryDato;
        this.query = query;
        try {
            ConectionJDBC.crearEnlaceJDBC();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Registrar.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(Registrar.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(Registrar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * realizamos los registros
     */
    public void realizarRegistro(){ 
        System.out.println("REGISTROS");
        for(int i = query.size() - 1; i >= 0; i--){   
            try {
                //Registramos las ordenes
                //Query.get(i)
                //y los datos
                //queryDato.get(i)                
                crearDeclaracionPreparada(queryDato.get(i), query.get(i)).executeUpdate();
            } catch (SQLException ex) {
                System.out.println("error: "+ ex.getMessage());
            }
        }
    }
    
    /**
     * Funcion encargada de crear y retornar una declaracion preparada con la
     * orden "orden" de tipo String, con los datos dados en el arrayList
     * de tipo ArrayList<String> y en la conexion "conexion" de tipo 
     * java.sql.Connection
     * @param datos
     * @param orden
     * @return 
     */
    private PreparedStatement crearDeclaracionPreparada(ArrayList<String> datos, String auxQuery) {
        try { 
            PreparedStatement dp = null;
            dp = ConectionJDBC.getConexion().prepareStatement(auxQuery);//asignamos el select que trae el String orden 
            for(int i = 1; i <= datos.size(); i++){//asignamos los valores del arrayList datos en cada campo del select
                String aux = null;                   
                aux = datos.get(i - 1);
                dp.setString(i, aux);    
               
            }  
            return dp;
        } catch (SQLException ex) {
            System.out.println("\nERROR SQLL: "+ex.getSQLState()); //Imprimimos el error en consola en caso de fallar  
            System.out.println("\nERROR SQLL: "+ex.getMessage());
        } catch (ClassNotFoundException ex) {
            System.out.println("\nERROR SQLL: "+ex.getMessage());
        }
        return null;
    }
}
