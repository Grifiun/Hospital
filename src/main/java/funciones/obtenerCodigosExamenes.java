/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package funciones;

import conection_db.Consultar;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *  Clase que nos obtiene los codigos de los examenes siempre y cuando ,la fecha ingresada
 * sea un día habil para el laboratorista
 * @author grifiun
 */
public class obtenerCodigosExamenes {
    private String msg = "";
    public String getNombreExamen(String codigoLaboratorista, String fecha){
        Consultar cons = new Consultar();      
        String examen = "";
        boolean diaLaboral = false;
        //Obtenemos si el laboratorista trabaja ese dia
        String query = "SELECT LOWER(dia) AS dia, DAYNAME(?) AS dia2 FROM TRABAJO WHERE codigo = ?";
        List<ArrayList<String>> listaDiasTrabajoLaboratorista = cons.obtenerRegistros(query, //datos a obtener
                new ArrayList<String>(Arrays.asList("dia", "dia2")), //rget atributo
                new ArrayList<String>(Arrays.asList(fecha, codigoLaboratorista))); //valor a cumplor
        
        try{
            String auxDia2 = listaDiasTrabajoLaboratorista.get(0).get(1).toLowerCase();
                switch(auxDia2){
                    case "monday":
                        auxDia2 = "lunes";
                        break;
                    case "thuesday":
                        auxDia2 = "martes";
                        break;
                    case "wednesday":
                        auxDia2 = "miercoles";
                        break;
                    case "thursday":
                        auxDia2 = "jueves";
                        break;
                    case "friday":
                        auxDia2 = "viernes";
                        break;    
                    case "saturday":
                        auxDia2 = "sabado";
                        break;
                    case "sunday":
                        auxDia2 = "domingo";
                        break;                          
                }
            for(int i = 0; i < listaDiasTrabajoLaboratorista.size(); i++){
                String auxDia1 = listaDiasTrabajoLaboratorista.get(i).get(0);
                if(auxDia1.equalsIgnoreCase(auxDia2)){
                    diaLaboral = true;
                    msg = "El laboratorista trabaja pero no hay registros";
                    break;
                }else
                     msg = "El laboratorista no trabaja ese dia";
            }
            
        } catch(Exception ex){       
        
        }
        String nombreExamen = "";
        //Si si trabaja entonces obtenemos el tipo
        if(diaLaboral){
            query = "SELECT examen FROM LABORATORISTA WHERE codigo = ?";
            List<ArrayList<String>> listaAuxNombreEx = cons.obtenerRegistros(query, //datos a obtener
                new ArrayList<String>(Arrays.asList("examen")), //rget atributo
                new ArrayList<String>(Arrays.asList(codigoLaboratorista))); //valor a cumplor
            if(listaAuxNombreEx.isEmpty() == false){
                nombreExamen = listaAuxNombreEx.get(0).get(0);
                msg = "Seleccione una reservacion de cita";
            }           
        }
        
        return nombreExamen;
    }

    public String getMsg() {
        return msg;
    }
    
    
}
