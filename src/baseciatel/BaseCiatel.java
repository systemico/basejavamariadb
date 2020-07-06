/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package baseciatel;

import basedatos.conexion.ConexionBD;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 *
 * @author systemicodev
 */
public class BaseCiatel {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        String sql = "SELECT * FROM proyectos";
        JsonArray json = ConexionBD.getConeccion(ConexionBD.MYSQL).selectJsonArray(sql);
        System.out.println("Datos "+json);
    }
    
}
