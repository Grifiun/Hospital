/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lector_archivo;

import conection_db.Registrar;
import encriptador.Encriptar;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import funciones.GenerarQueryInsert;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

/**
 *
 * @author grifiun
 */
public class LeerArchivo {
    private File archivo = null;
    //Uso: guarda los identificadores de la tabla principal
    private ArrayList<String> identificador = new ArrayList();
    //Uso: guarda los datos de la tabla principal
    private ArrayList<String> dato = new ArrayList();
    //Uso: guarda los identificadores de la subtabla en curso
    private ArrayList<String> identificadorSubTabla = new ArrayList();
    //Uso: guarda los datos de la subtabla en curso
    private ArrayList<String> datoSubTabla = new ArrayList();
    //Querys actuales    
    private ArrayList<String> queryList = new ArrayList();
    private List<ArrayList<String>> datoQuery = new ArrayList();    
    
    private String path;
    public LeerArchivo(String path){
        //this.archivo = archivo;
        this.path =path;
        System.out.println(path);
        leerArchivo();        
    }    
    
    private void leerArchivo(){
        try{///se lee el archivo
            FileReader fr = new FileReader(path);
            BufferedReader br = new BufferedReader(fr);
            String aux = "";
            //Leemos y analizamos todaas las lineas de texto del archivo (linea por linea)
            while(aux != null){//cuando el auxiliar no sea nulo el while sigue, sera nulo cuando se termine de leer el archivo
                aux = br.readLine();//con el ReadLine procedemos a leer la siguiente linea
                analizar(aux);
                if(aux == null){//si aux es null entonces significa que ya se termino de leer el archivo
                    break;
                }
                                
            }
            
            //substring(0, auxMat.length() - 1) hace que se remueva el ultimo caracter agregado, que seria un "*"                         
        }catch(Exception e){            
            System.out.println("FIN LECTURA");   
        } 
    
    }
    /**
     * Analizamos la linea
     * @param linea 
     */
    private void analizar(String linea){
        //Tambien le removeremos los espacios en blanco al inicio y al final con trim
        linea = linea.trim();
        //Aux es un String que no tendrá los signos < y >
        String aux = linea.replace("<", "").replace(">", "");
        //Aux2 servira para analizar si la linea contiene datos o solo una etiqueta
        String aux2 = linea.substring(0, linea.indexOf(">") + 1);
        //si el substring de <identify> es igual a la linea entera significa que ya no contiene datos y por ende es un identificador
        //de lo contrario es un atributo
        boolean isEtiqueta = aux2.equals(linea);
        //Si contiene la palabra hospital y es el inicio del archivo
        if(linea.contains("<?xml"))
            System.out.println("Inici lectura archivo XML");
        else if(isEtiqueta && aux.equals("hospital"))
            System.out.println("DATABASE INICIO");//Imprimimos la DB
        else if(isEtiqueta && aux.equals("/hospital"))//si es el fin del hospital
            System.out.println("DATABASE FIN");//se imprime que es el fin
        else if(isEtiqueta && identificador.size() == 0){//Si no hay ningun identificador y es una etiqueta se considera como una tabla
            System.out.print("  INICIO TABLA:");//se imprime el inicio de tabla
            identificador.add(aux.toUpperCase());//se agrega el primer identificador que corresponde a la tabla
            System.out.println(identificador.get(0));
        }else if(isEtiqueta && aux.equalsIgnoreCase("/"+identificador.get(0))){//Si es un identificador y ademas contiene la contradiagonal es fin de tabla
            System.out.println("    FIN TABLA");
            //Terminamos de ingresar la tabla y limpiamos los datos
                       
            //GENERAMOS QUERY
            //instanciamos
            GenerarQueryInsert auxGenQ = new GenerarQueryInsert(identificador, dato, datoQuery, queryList);
            //Obtenemos los listados actualizados
            this.datoQuery = new ArrayList<ArrayList<String>> (auxGenQ.getDatoQuery());
            this.queryList = new ArrayList<String> (auxGenQ.getQueryList());
            //Registramos
            Registrar reg = new Registrar(new ArrayList<ArrayList<String>> (datoQuery), new ArrayList<String>(queryList));
            reg.realizarRegistro();
            //limpiamos despues de ingresar los datos
            datoQuery.clear();
            queryList.clear();
            
            identificador.clear();
            dato.clear();
        }else if(isEtiqueta && identificador.size() > 0 && identificadorSubTabla.size() == 0){
            /**
             * si es una etiqueta y ya haya un identificador se crea una subtabla
             * ademas de que aun no haya un identificador para la subtabla (identificadorSubTabla)
             */
            System.out.print("      INICIO SUBTABLA:");//se imprime el inicio de subtabla            
            identificadorSubTabla.add(aux.toUpperCase());//se agrega el primer identificador que corresponde a la subtabla  
            System.out.println(identificadorSubTabla.get(0));
            /**
             * Todas las subtablas se conectan con la tabla principal a través de
             * su codigo, con lo cual obtendremos el codigo de la tabla principal
             */
            identificadorSubTabla.add("codigo");//agregamos el identificador de codigo, referente a la tabla principal
            //el codigo se obtiene del arraylist de dato y se encuentra en un numero menor al del identificador debido que el identificador posee el nombre de la tabla
            datoSubTabla.add(dato.get(identificador.indexOf("codigo") - 1));
            
        }else if(isEtiqueta && identificador.size() > 0 && identificadorSubTabla.size() > 0 && aux.equalsIgnoreCase("/"+identificadorSubTabla.get(0))){
            /**
             * si ya existe una subtabla y se encuentra ael identificador para finalizar la subtabla 
             * entonces limpiamos los arrayList
             */
            System.out.println("      FIN SUBTABLA:");//se imprime el inicio de subtabla
            //GENERAMOS QUERY
            //instanciamos
            GenerarQueryInsert auxGenQ = new GenerarQueryInsert(identificadorSubTabla, datoSubTabla, datoQuery, queryList);
            //Obtenemos los listados actualizados            
            datoQuery = new ArrayList<ArrayList<String>> (auxGenQ.getDatoQuery());
            queryList = new ArrayList<String> (auxGenQ.getQueryList());            
            
            identificadorSubTabla.clear();
            datoSubTabla.clear();
        }else{//si no corresponde a ninguno de los anteriores entonces la linea corresonde a un atributo y un dato
            //Encontramos el identificador del valor
            //que corresponde del inicio ignorando el 0 (<) y el final (>)
            String auxIdentify = linea.substring(0,linea.indexOf(">")).replace("<", "");
            //encontramos el fin del identificador
            //ignoramos los primeros dos espacios (</) y el > del final, razond e la suma de 2 y resta de 1
            String auxIdentifyFin = linea.substring(linea.lastIndexOf("</") + 2,linea.length() - 1);               
            //el valor es aquel que no contiene al identificador 
            /**
             * lo obtendremos de un substring que inicia desde LARGO IDENTIFICADOR + 2 (que corresponden a < y >)
             * hasta LARGO DE LA LINEA MENOS LARGO (IDENTIFICADOR FIN + 3 que corresponde a </>)
             */
            String auxValor = linea.substring(auxIdentify.length() + 2, linea.length() - (auxIdentifyFin.length() + 3));
            //System.out.println("IDENT: "+auxIdentify);
            //System.out.println("IDENT_FIN: "+auxIdentifyFin);
            //System.out.println("VALOR: "+auxValor);
            
            //agregamos el valor a los arrayList
            //si los identificadores coinciden entonces agregamos los valores
            if(auxIdentify.equals(auxIdentifyFin)){
                //si no se esta trabajando en una subtabla se agregan los valores a los arrayList principales
                if(identificadorSubTabla.size() == 0){
                    System.out.println("            IDENT TAB:"+auxIdentify.toLowerCase());
                    System.out.println("            VALOR TAB: "+auxValor);
                    
                    if(auxIdentify.toLowerCase().equals("password")){//si es una contrasena
                        Encriptar encrpt = new Encriptar();
                        identificador.add(auxIdentify.toLowerCase());//agregamos el identificador, todo en minusculas
                        dato.add(encrpt.getEncriptPass(auxValor));//encriptamos la pass
                    }else{
                        identificador.add(auxIdentify.toLowerCase());//agregamos el identificador, todo en minusculas
                        dato.add(auxValor);//agregamos el valor                   
                    }                    
                    
                }else{//de lo contrario agregaremos los datos en la subtabla
                    identificadorSubTabla.add(auxIdentify.toLowerCase());//agregamos el identificador de la subtabla
                    datoSubTabla.add(auxValor);//agregamos el dato en la subtabla
                    System.out.println("            IDENT SUBTAB: "+auxIdentify.toLowerCase());
                    System.out.println("            VALOR SUBTAB: "+auxValor);
                }
            }else//de lo contrario imprimiremos que hay un error
                System.out.println("ERROR, LOS IDENTIFICADORES NO SON IGUALES\nLinea: "+linea);
        }
        
    }
}
