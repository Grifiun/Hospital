/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conection_db;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Se retorna un preparedStatement con la orden y los datos dados, se ajustan
 * los datos enviados al query
 * @author grifiun
 */
public class CrearDeclaracionPreparada {

        
    /**
     * Funcion encargada de crear y retornar una declaracion preparada con la
     * orden "orden" de tipo String, con los datos dados en el arrayList
     * de tipo ArrayList<String> y en la conexion "conexion" de tipo 
     * java.sql.Connection
     * @param datos
     * @param orden
     * @return 
     */
    public PreparedStatement crearDeclaracionPreparada(ArrayList<String> datos, String auxQuery) {
        try { 
            PreparedStatement dp = null;             
            ConectionJDBC.crearEnlaceJDBC();   
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
            System.out.println("\nERROR SQLL: "+ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(CrearDeclaracionPreparada.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(CrearDeclaracionPreparada.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
