/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package funciones;

import java.util.ArrayList;

/**
 *
 * @author grifiun
 */
public class GenerarStringIdentificador {
    
    /**
     * Se genera un string de forma
     * inicio+ datos enviados separadas por el simbolo (separador) + fin
     * @param inicio
     * @param fin
     * @param separador
     * @param identificador
     * @return 
     */
    public String generarStringIdentificador(String inicio, String fin, String separador, ArrayList<String> identificador){
        String aux = "";
        for(int i = 0; i < identificador.size(); i++){
            if(i == 0)
                aux += inicio;
            if((i + 1) == identificador.size()) //ultima iteracion
                aux += identificador.get(i) + fin;
            else
                aux += identificador.get(i) + separador;
        }
        return aux;
    }
}
