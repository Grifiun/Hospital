/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package funciones;

import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import conection_db.Consultar;
import java.util.ArrayList;
import java.util.Arrays;

/**
 *
 * @author grifiun
 */
public class GenerarCodigoAleatorio {
    /**
     * Genera un numero aleatorio hasta encontrar uno que no tenga
     * un pedido existente
     * @return 
     */
    public String generarCodAleatorio(String tabla, String prefix, int inicio, int fin){
        String codAux = "";        
        int auxNum;
        boolean finCiclo = false;
        do{
            Random random = new Random();
            auxNum = random.nextInt(fin) + inicio;//generamos un numero aleatorio entre 1000 y 2000
            codAux = prefix+Integer.toString(auxNum);//creanos el codigo con PREFIX00000 
            
            Consultar cons = new Consultar();
            //verificamos si existe en la tabla a ingresar el codigo
            boolean existencia = cons.consultarExistenciaRegistro(tabla, new ArrayList<>(Arrays.asList("codigo")), new ArrayList<>(Arrays.asList(codAux)));
            if(existencia == false){
                finCiclo = true;
                return codAux;
            }            
        }while(finCiclo != true);
        
        return codAux;
    }
}
