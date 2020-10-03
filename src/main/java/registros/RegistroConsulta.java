/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package registros;

import java.util.ArrayList;
import conection_db.*;
import java.util.List;

/**
 *
 * @author grifiun
 */
public class RegistroConsulta{
    
    public void registrarConsultasSiNoExisten(ArrayList<String> especialidades){         
        for(int i = 0; i < especialidades.size(); i++){
            String auxEs = especialidades.get(i);            
            try{
                if(revisarExistenciaConsulta(auxEs) == false){//si no existe esa especialidad
                    //se registra
                    List<ArrayList<String>> datosAux = new ArrayList();//Paquete de datos                
                    ArrayList queryAux = new ArrayList();//querys
                    ArrayList datoAux = new ArrayList();//datos
                    queryAux.add("INSERT INTO CONSULTA VALUES (?, ?)");
                    datoAux.add(auxEs);//agregamos la especialidad en curso
                    datoAux.add("100");//agregamos un costo de consulta de 100 
                    datosAux.add(new ArrayList<String>(datoAux));//agregamos al super ArrayList
                    Registrar reg = new Registrar(datosAux, queryAux);
                    reg.realizarRegistro();//realizamos el registro
                }     
            }catch(Exception ex){
                System.out.println("Ex: "+ex);
                System.out.println(ex.getMessage());     
            }
            
            
                   
        }
    }
    
    /**
     * Se verifica si la especialidad ya existe dentro de la tabla CONSULTA
     * @param especialidad
     * @return 
     */
    public boolean revisarExistenciaConsulta(String especialidad){
        Consultar cons = new Consultar();
        ArrayList<String> auxRes = new ArrayList();
        auxRes.add("tipo");
        ArrayList<String> auxDato = new ArrayList();
        auxDato.add(especialidad);
        /**
         * Verificamkos la existencia del archivo en la tabla consulta 
         * si existe un dato igual a la especialidad mandada
         */
        return cons.consultarExistenciaRegistro("CONSULTA", new ArrayList<String>(auxRes), new ArrayList<String>(auxDato));
    }
}
