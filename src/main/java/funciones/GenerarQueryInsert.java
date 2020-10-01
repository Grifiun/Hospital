/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package funciones;

import java.util.ArrayList;

/**
 * Clase encargada de generar un query de tipo insert
 * @author grifiun
 */
public class GenerarQueryInsert {
    ArrayList<String> identify;
    ArrayList<String> dato;
    
    /**
     * Constructor, recibe los parametros identify y dato de tipo arrayList
     * @param identify
     * @param dato 
     */
    public GenerarQueryInsert(ArrayList<String> identify, ArrayList<String> dato){
        this.dato = dato;
        this.identify = identify;
    }
    
    /**
     * genera y retorna un query
     * @return 
     */
    public String generar(){
        String query = "INSERT INTO "+identify.get(0);//se obtiene la tabla
        String identificador = " (";
        String valor = " VALUES (";
        /**
         * El arrayList identify tiene el nombre de la tabla en el espacio 0
         * y los atributos en los siguientes espacios
         * 
         * los datos son todos pertenecientes a los atributos
         */
         for(int i = 0; i < dato.size(); i++){
            if(i + 1 == dato.size()){ 
                identificador += identify.get(i + 1) + ")";
                valor += "?" + ")";
            }
            else{
                identificador += identify.get(i + 1) + ",";
                valor += "?" + ",";
            }            
        }   
         
        query += identificador + valor;
        System.out.println(query);
        return query;
    }
}
