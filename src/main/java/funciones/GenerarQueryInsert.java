/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package funciones;

import conection_db.Consultar;
import java.util.ArrayList;
import java.util.List;
import registros.RegistroConsulta;

/**
 * Clase encargada de generar un query de tipo insert
 * @author grifiun
 */
public class GenerarQueryInsert {
    ArrayList<String> identify;
    ArrayList<String> dato;
    List<ArrayList<String>> datoQuery;
    ArrayList<String> queryList;
    
    /**
     * Constructor, recibe los parametros identify y dato de tipo arrayList
     * @param identify
     * @param dato 
     */
    public GenerarQueryInsert(ArrayList<String> identify, ArrayList<String> dato, List<ArrayList<String>> datoQuery, ArrayList<String> query){
        this.dato = dato;
        this.identify = identify;
        
        this.datoQuery = new ArrayList<ArrayList<String>> (datoQuery);
        this.queryList = new ArrayList<String> (query);
        generar();
    }
    
    /**
     * genera y retorna un query
     * @return 
     */
    public void generar(){
        switch(identify.get(0)){
            case "ESPECIALIDAD":                
                RegistroConsulta rc = new RegistroConsulta();
                ArrayList<String> datoAux = new ArrayList(dato);
                datoAux.remove(0);//removemos el codigo y quedan solo las especialidades
                rc.registrarConsultasSiNoExisten(new ArrayList<String>(datoAux));//Registramos las consultas si no existen
                //Generamos querys repetidas para ingresar todas las especialidades
                generarQueryRepetida();
                break;
            case "TRABAJO":
                //Generamos querys repetidas para ingresar todas los dias de trabajo
                generarQueryRepetida();
                break;
            default:
                //Generamos una sola query para ingresar todos los datos enviados
                generarUsoTotalDato(identify, dato);
        } 
    }
    
   /**
    * Se genera una query para una tabla ordinaria, que usa todos los datos
    * Ej: 
    * Tabla: Horario
    * atributo: inicio
    * atributo: fin
    */   
    public void generarUsoTotalDato(ArrayList<String> auxIdentify, ArrayList<String> auxDato){
        String query = "INSERT INTO "+auxIdentify.get(0);//se obtiene la tabla
        String identificador = " (";
        String valor = " VALUES (";
        /**
         * El arrayList identify tiene el nombre de la tabla en el espacio 0
         * y los atributos en los siguientes espacios
         * 
         * los datos son todos pertenecientes a los atributos
         */
         for(int i = 0; i < auxDato.size(); i++){
            if(i + 1 == auxDato.size()){ 
                identificador += auxIdentify.get(i + 1) + ")";
                valor += "?" + ")";
            }
            else{
                identificador += auxIdentify.get(i + 1) + ",";
                valor += "?" + ",";
            }            
        }            
        query += identificador + valor;
        this.queryList.add(query);//Agregamos la query al arrayLust general
        this.datoQuery.add(new ArrayList<String> (auxDato));//agregamos el dato auxiliar al arrayList general        
    }
    
    /**
     * Genera querys de forma repetida,
     * se usa para datos como especialidad
     * Ej: 
     * Tabla: Especialidad
     * atributo: titulo1
     * Tabla: Especialidad
     * atributo: titulo2
     */
    public void generarQueryRepetida(){
        ArrayList<String> auxIdent = new ArrayList();
        ArrayList<String> auxDato = new ArrayList();        
                
        /**
         * Se repetira hasta crear todas las querys por cada dato
         */
        for(int j = 2; j < identify.size(); j++){
            auxIdent.add(identify.get(0));//Agregamos la tabla al identificador
            auxIdent.add(identify.get(1));//agregamos el identificador del codigo
            auxIdent.add(identify.get(j));//agregamos el codigo del ident en curso
            
            auxDato.add(dato.get(0));//Agregamos el codigo en curso
            auxDato.add(dato.get(j - 1));//Agregamos el valor en curso
            //GENERAMOS LA QUERY Y AGREGAMOS DATO
            generarUsoTotalDato(auxIdent, auxDato);
            //limpiamos
            auxIdent.clear();
            auxDato.clear();
        }
    }    
    
    public List<ArrayList<String>> getDatoQuery() {
        return datoQuery;
    }

    public ArrayList<String> getQueryList() {
        return queryList;
    }  
}
