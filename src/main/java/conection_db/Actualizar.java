package conection_db;

import funciones.GenerarStringIdentificador;
import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Clase para actualizar datos
 * Recibe en arrayList los atributos a modificar, los nuevos datos a registrar y las restricciones
 * @author grifiun
 */
public class Actualizar{
    private String tabla;
    private ArrayList<String> atributoModificar;
    private ArrayList<String> atributoRestriccion;
    private ArrayList<String> dato;

    public Actualizar(String tabla, ArrayList<String> atributoModificar, ArrayList<String> atributoRestriccion, ArrayList<String> dato) {
        this.tabla = tabla;
        this.atributoModificar = atributoModificar;
        this.atributoRestriccion = atributoRestriccion;
        this.dato = dato;
    }  
    /**
     * Ejecutamos la actualizacion
     */
    public void actualizar(){
        //Creamos las variables auxiliares que pide la clase registro
        List<ArrayList<String>> datoQueryAux = new ArrayList();
        ArrayList<String> queryAux = new ArrayList();
        
        //Agregamos la query
        queryAux.add(getQueryUpdateRegistros());
        //Agregamos los datos
        datoQueryAux.add(dato);
        Registrar reg = new Registrar(datoQueryAux, queryAux);
        reg.realizarRegistro();
    }
    
    /**
     * Nos construye la query del update
     * @return 
     */
    public String getQueryUpdateRegistros(){
        
        GenerarStringIdentificador gsi = new GenerarStringIdentificador();
        /**
         * Sin caracter de inicio ni final, separador de datos (,)
         */
        String modificacion = gsi.generarStringIdentificador("", " = ?", "= ?,", atributoModificar);
        /**
         * Sin caracter de inicio ni final, separador de datos (= ? AND)
         */
        String restriccion = gsi.generarStringIdentificador(" WHERE ", " = ?", " = ? AND ", atributoRestriccion);
        //armamos la query
        String queryOrden = "UPDATE "+tabla+" SET "+modificacion+ restriccion;
        System.out.println(queryOrden);
        return queryOrden;//retornamos el RS        
    }
    
    
}
