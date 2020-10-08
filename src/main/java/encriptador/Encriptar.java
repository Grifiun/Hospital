/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package encriptador;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 * La clase Encriptar se encargara de encriptar las contrasenas
 * @author grifiun
 */
public class Encriptar {
    public String getEncriptPass(String pass){               
        /**
         * Retornamos el valor dado por la funcion
         */
        return encriptPass(pass);
    }
    
    /**
     * Funcion encargada de realizar la encriptacion
     * @param pass
     * @return 
     */
    private String encriptPass(String pass){
        String enPass = "";  
        
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("MD5");
            md.update(pass.getBytes());
             byte[] digest = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
            sb.append(String.format("%02x", b & 0xff));
            }
            enPass = sb.toString();
            return enPass;
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Encriptar.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return enPass;         
    }
}