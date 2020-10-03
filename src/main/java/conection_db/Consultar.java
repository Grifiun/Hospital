/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conection_db;

import funciones.GenerarStringIdentificador;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Clase encarga de realizar las consultas dentro de mysql
 * es decir, se devolveran valores.
 * @author grifiun
 */
public class Consultar {
  
    
    /**
     * Consulta si existe dicho registro en la tabla enviada
     * donde el atributo enviado sea igual al dato enviado
     * Si existe el registro se retorna true, si no existe
     * se retorna false
     * @param tabla
     * @param atributo
     * @param dato
     * @return 
     */
    public boolean consultarExistenciaRegistro(String tabla, ArrayList<String> atributoRestriccion, ArrayList<String> dato){
        try {
            ArrayList<String> atributoRespuestaAux = new ArrayList();
            atributoRespuestaAux.add("*");//Obtendremos todos los datos del registro
            String queryAux = getQueryRSRegistros(tabla, atributoRespuestaAux, atributoRestriccion);
            ResultSet rs = crearResultSet(dato, queryAux);
            if (rs != null && rs.next())
                return true;
            else
                return false;
        } catch (SQLException ex) {
            System.out.println("ERROR: "+ex);
        }
        return false;
    }      
    
    /**
     * Obtenemos el resultSet de todos los registros inidicados 
     * se buscan los atributos del ArrayList "atributoRespuesta"
     * en la tabla "tabla"
     * donde los identificadores de las restricciones sean iguales a los datos de las restricciones
     * en los ArrayList "atributoRestriccion" y "datoRestriccion" respectivamente
     * @param tabla
     * @param atributoRespuesta
     * @param atributoRestriccion
     * @param datoRestriccion
     * @return 
     */
    public String getQueryRSRegistros(String tabla, ArrayList<String> atributoRespuesta, ArrayList<String> atributoRestriccion){
        GenerarStringIdentificador gsi = new GenerarStringIdentificador();
        /**
         * Sin caracter de inicio ni final, separador de datos (,)
         */
        String respuesta = gsi.generarStringIdentificador("", "", ",", atributoRespuesta);
        /**
         * Sin caracter de inicio ni final, separador de datos (= ? AND)
         */
        String restriccion = gsi.generarStringIdentificador("", " = ?", " = ? AND ", atributoRestriccion);
        //armamos la query
        String queryOrden = "SELECT "+respuesta+" FROM "+tabla+" WHERE "+restriccion;
        return queryOrden;//retornamos el RS
    }
    
    /**
     * Se crea un resultset y se devuelve
     * @param datos
     * @param orden
     * @return 
     */
    private ResultSet crearResultSet(ArrayList<String> datos, String orden){
        ResultSet rsPrueba = null;
        try {          
            CrearDeclaracionPreparada cdp = new CrearDeclaracionPreparada();
            rsPrueba = cdp.crearDeclaracionPreparada(datos, orden).executeQuery(); //realizamos la consulta de la orden dada        
            return rsPrueba;
        } catch (SQLException ex) {
            System.out.println("Error al realizar la consulta: "+ex.getMessage());
        }
        return null;
    }
}
