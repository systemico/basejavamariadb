/*
 * Tabla.java
 *
 * Created on 18 de mayo de 2007, 10:17 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package basedatos.conexion;

import java.util.Vector;
/*
 * Author@ Edwin Alonso Aiza Cáceres
 * Ingeniero de Sistemas
 * SysteMiCo Software
 */
public class Tabla {
    private int filas=0;
    private int columnas=0;
    private Vector datos=null;
    public Tabla() {

    }
    /***/
    public void setDatos(Vector datos){
        this.datos=datos;
    }

    /***/
    public Vector getDatos(){
        return this.datos;
    }
    /***/
    public int getColumnas(){
        return this.columnas;
    }
    /***/
    public int getFilas(){
        return this.filas;
    }
    /***/
    public void setColumnas(int columnas){
        this.columnas=columnas;
    }
    /***/
    public void setFilas(int filas){
        this.filas=filas;
    }
     /***/
    public int getNumeroFilas(){
        return this.filas;
    }
}
