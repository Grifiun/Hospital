/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package registros;

import conection_db.Registrar;
import funciones.GenerarQueryInsert;
import java.util.ArrayList;
import java.util.List;

/**
 * Esta clase realiza registros de las tablas
 * @author grifiun
 */
public class RealizarRegistroTabla{
    private ArrayList<String> identificador = new ArrayList();
    private ArrayList<String> datos = new ArrayList();
    
    /**
     * Agregamos un dato al arrayList datro
     */
    public void addToDato(String dato){
        //Removemos saltos de linea
        this.datos.add(dato);
    }
    
    /**
     * Agregamos un dato al arrayList identificador
     */
    public void addToIdentificador(String ident){
        this.identificador.add(ident);
    }

    
    /**
     * Funcion que registra los datos enviados
     * @param identificador
     * @param datos 
     */
    public void realizarRegistro(){
        //CONTENEDORES GENERALES
        ArrayList<String> queryList = new ArrayList();//ArrayList que contendra nuestra query
        List<ArrayList<String>> datoQuery = new ArrayList();//ArrayList de arraylist que contrendra nuestro listado de querys
        //GENERAMOS EL QUERY
        GenerarQueryInsert auxGenQ = new GenerarQueryInsert(identificador, datos, datoQuery, queryList);
        datoQuery = new ArrayList<ArrayList<String>> (auxGenQ.getDatoQuery());//obtenemos los datos de las querys
        queryList = new ArrayList<String> (auxGenQ.getQueryList());//obtenemos los querys
        //REGISTRAMOS
        Registrar reg = new Registrar(new ArrayList<ArrayList<String>> (datoQuery), new ArrayList<String>(queryList));
        reg.realizarRegistro();//registramos
    }

    public ArrayList<String> getIdentificador() {
        return identificador;
    }

    public void setIdentificador(ArrayList<String> identificador) {
        this.identificador = identificador;
    }

    public ArrayList<String> getDatos() {
        return datos;
    }

    public void setDatos(ArrayList<String> datos) {
        this.datos = datos;
    }
    
    
    
}
