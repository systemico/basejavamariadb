package basedatos.conexion;

import com.google.gson.Gson;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import javax.swing.JOptionPane;
import java.util.ArrayList;
/*
 * Author@ Edwin Alonso Aiza Cáceres
 * Ingeniero de Sistemas
 * SysteMiCo Software
 */
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * CLASE SINGLETON
 */
public class ConexionBD
{
    /**
     * Variable para almecenar la conexion a la base de datos
     */
    private static Connection connection=null;
    private static String url=null;
    private static String driver=null;
    public static final int MYSQL=1;
    public static final int ORACLE=2;
    public static final int POSTGRESQL=3;
    public static final int SQLSERVER=4;
    private static ConexionBD conector;

    private ConexionBD(int base){
        switch (base) {
            case ConexionBD.ORACLE:
                url="jdbc:oracle:thin:@"+Configuracion.host+":1521:"+Configuracion.basedatos;
                driver="oracle.jdbc.driver.OracleDriver";
                break;
            case ConexionBD.MYSQL:
                driver= "com.mysql.jdbc.Driver";
                url="jdbc:mysql://"+Configuracion.hostMySQL+"/"+Configuracion.baseDatosMySQL+"";
                break;
            case ConexionBD.POSTGRESQL:
                driver= "org.postgresql.Driver";
                url="jdbc:postgresql://"+Configuracion.hostPostgreSQL+"/"+Configuracion.baseDatosPostgreSQL+"";
                break;
            case ConexionBD.SQLSERVER:
                driver= "com.microsoft.sqlserver.jdbc.SQLServerDriver";
                url="jdbc:sqlserver://"+Configuracion.hostSQLSERVER+"/"+Configuracion.baseDatosSQLSERVER+"";
                break;
            default:
                break;
        }
        ConexionBD.connection=conectorBaseDatos(base);
    }

    /**
    * @return */
    public Connection getConnection(){
        return connection;
    }

    /**
    * @param base*/
    public static ConexionBD getConeccion(int base){
            if(ConexionBD.conector==null){
                ConexionBD.conector=new ConexionBD(base);
            }
            return ConexionBD.conector;
    }

    /***/
    private  Connection conectorBaseDatos(int base){
            if(connection==null){
                    try {
                            Class.forName(driver);				
                            if(base==ConexionBD.MYSQL) {
                                System.out.println("Driver MYSQL Cargado");
                                connection=DriverManager.getConnection(url,Configuracion.usuarioMySQL,Configuracion.claveMySQL);
                                System.out.println("Conectado al servidor MYSQL");
                            }
                            else if(base==ConexionBD.POSTGRESQL) {
                                System.out.println("Driver POSTGRESQL Cargado");
                                connection=DriverManager.getConnection(url,Configuracion.usuarioPostgreSQL,Configuracion.clavePostgreSQL);
                                System.out.println("Conectado al servidor POSTGRESQL");
                            }
                    }catch(ClassNotFoundException | SQLException e){
                            e.printStackTrace();
    //			JOptionPane.showMessageDialog(null,"Error de conexion.");
    //			System.exit(0);
                            System.out.println("Error de conexion.");
                    }
                    return connection;
            }
            //RETORNAMOS LA CONEXION EXISTENTE
            return connection;
    }

    /**
 * @param sql
     * @return */
    
    public com.google.gson.JsonArray selectJsonArray(String sql){
        ResultSet resultado = null;
        com.google.gson.JsonArray jsonArray = new com.google.gson.JsonArray();
        try
        {
            Statement sta=ConexionBD.connection.createStatement();
            resultado= sta.executeQuery(sql);
            while (resultado.next()) {
            int total_columns = resultado.getMetaData().getColumnCount();
            com.google.gson.JsonObject obj = new com.google.gson.JsonObject();
                for (int i = 0; i < total_columns; i++) {
                    obj.addProperty(resultado.getMetaData().getColumnLabel(i + 1).toUpperCase(), resultado.getString(i + 1));
                }
                jsonArray.add(obj);
            }            
            
        } catch (SQLException s) {
            s.printStackTrace();
            System.out.println("Error al Conectar al Servidor, Consulte con su administrador");
        }
        return jsonArray;
    }
    
    public com.google.gson.JsonArray selectJsonArray2(String sql){
        ResultSet resultado = null;
        com.google.gson.JsonArray jsonArray = new com.google.gson.JsonArray();
        try
        {
            Statement sta=ConexionBD.connection.createStatement();
            resultado= sta.executeQuery(sql);
            while (resultado.next()) {
            int total_columns = resultado.getMetaData().getColumnCount();
            com.google.gson.JsonObject obj = new com.google.gson.JsonObject();
                for (int i = 0; i < total_columns; i++) {
                    obj.addProperty(resultado.getMetaData().getColumnLabel(i + 1), resultado.getString(i + 1));
                }
                jsonArray.add(obj);
            }            
            
        } catch (SQLException s) {
            s.printStackTrace();
            System.out.println("Error al Conectar al Servidor, Consulte con su administrador");
        }
        return jsonArray;
    }
    
    public  Tabla select(String sql){
        Vector datos= new Vector();
        Tabla tabla= new Tabla();
        int columnas=0;
        try
        {
            Statement sta=ConexionBD.connection.createStatement();
            ResultSet resultado= sta.executeQuery(sql);
            ResultSetMetaData metadatos= resultado.getMetaData();
            columnas=metadatos.getColumnCount();
            tabla.setColumnas(columnas);
            int i=1;
            int filas=0;
            while(resultado.next())
            {
                while(i<=columnas)
                {
                    if(resultado.getString(i)==null)
                    {
                        //datos.add(resultado.getString(""); <-- antes estaba de esta forma
                        datos.add("");
                    }
                    else{
                            datos.add(resultado.getString(i));
                    }
                    i++;
                }
                i=1;
                filas++;
            }
            tabla.setFilas(filas);
            tabla.setDatos(datos);
        } catch (SQLException s) {
            s.printStackTrace();
            System.out.println("Error al Conectar al Servidor, Consulte con su administrador");
        }
        return tabla;
    }

    /**
 * @param sql*/
    public void delete(String sql){
        try {
            Statement sta=ConexionBD.connection.createStatement();
            sta.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
//        cerrarSesion();
    }

    /**
 * @param sql*/
    public void editar(String sql){
            try {
                Statement sta=ConexionBD.connection.createStatement();
                sta.executeUpdate(sql);
            } catch (SQLException e) {
                e.printStackTrace();
            }
    }

    /**
 * @param sql*/
    public String insert(String sql){
        String id=null;
        try {
            Statement sta=ConexionBD.connection.createStatement();
            sta.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS );
            ResultSet rs=sta.getGeneratedKeys();
            while(rs.next()){
                id=rs.getString(1);
                break;
            }

        } catch (SQLException e) {
            System.out.println("-->"+sql);
            e.printStackTrace();
        }

//        cerrarSesion();

        return id;
    }

    /**
 * @param sql*/
    public String update(String sql){
        String id=null;
        try {
            Statement sta=ConexionBD.connection.createStatement();
            sta.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS );
            ResultSet rs=sta.getGeneratedKeys();
            while(rs.next()){
                id=rs.getString(1);
                break;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

//        cerrarSesion();
        return id;
    }

    // update para la base de datos prueba sigor. version postgres no admite return
    // para insert y update
    public int update2(String sql) {
        int n=0;
        try {
            PreparedStatement pst = ConexionBD.connection.prepareStatement(sql);// con esta sentencia se insertan los datos en la base de datos
            n = pst.executeUpdate();//valida si se guardaron los datos; si pst>0 entonces se guardaron
        } catch (Exception e) {
            e.printStackTrace();
        }
        return n;
    }



    /**
     * Cerrar Sesion
     */
    public void cerrarSesion(){
        try{
            ConexionBD.connection.close();
            ConexionBD.connection = null;
            ConexionBD.conector = null;
        }catch(SQLException se){
            System.out.println("Error al [ cerrar ] la conexión.");
            se.printStackTrace();
        }

    }

    /**
    * Metodo select
    * @param sentencia
    */
    public ArrayList select2(String sentencia){

            ArrayList lista = new ArrayList();
            int i=1;
            try{
                    Statement s =  connection.createStatement();
                    ResultSet rs = s.executeQuery(sentencia);
                    ResultSetMetaData metadatos = rs.getMetaData();
                    int numCol = metadatos.getColumnCount();
                    String xxx = "";
                    while (rs.next()){
                            for( i=1; i<= numCol; i++)
                            {
                              xxx = rs.getString(i);
                              lista.add(xxx);
                            }
                    }
            }catch(SQLException e){
                    System.out.println(e.getMessage());
                    e.printStackTrace();
//                    JOptionPane.showMessageDialog(null," Problemas con el Select :\n" + sentencia, "Error", JOptionPane.ERROR_MESSAGE);
            }

//            cerrarSesion();

            return lista;
    }

    /**
     * Metodo select
 * @param sentencia
 * @return 
     */
    public int select3(String sentencia){

        int xxx = 0;
        try{
            Statement s =  connection.createStatement();
            ResultSet rs = s.executeQuery(sentencia);
            ResultSetMetaData metadatos = rs.getMetaData();
            int numCol = metadatos.getColumnCount();
            while (rs.next()){
                for(int i=1; i<= numCol; i++)
                {
                    xxx = rs.getInt(i);
                }
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            JOptionPane.showMessageDialog(null," Problemas con el Select :\n" + sentencia, "Error", JOptionPane.ERROR_MESSAGE);
        }

//            cerrarSesion();

        return xxx;
    }

    public String encriptarTexto(String texto){
        String sql = "SELECT MD5('"+texto+"')";
        ArrayList a = this.select2(sql);
        System.out.println("TIME: " + a.get(0).toString());
        System.out.println("SHA: " + a.get(1).toString());
        return a.get(0).toString();
    }

    public void guardarImagen(String sql, String pathImagen){
        if(sql.indexOf("?")>-1){
            try {
            PreparedStatement ps = connection.prepareStatement(sql);
            {
                FileInputStream fis = null;
                try {
                    connection.setAutoCommit(false);
                    File file = new File(pathImagen);
                    fis = new FileInputStream(file);
                    ps.setBinaryStream(1, fis, (int) file.length());
                    ps.executeUpdate();
                    connection.commit();
                } catch (FileNotFoundException ex) {
                    Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
                } finally {
                    ps.close();
                    try {
                        fis.close();
                    } catch (IOException ex) {
                        Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
            } catch (SQLException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        }else{
            System.out.println("Hay un error con la sentencia enviada!");
        }

        ConexionBD.conector.cerrarSesion();

    }

    public static Vector<Vector> convertirEnVectorDeVectores(Tabla datos){
        int i = 0;
        Vector<Vector> tabla = new Vector<Vector>();
        Vector fila;

        while (i < datos.getNumeroFilas())
        {
            fila = new Vector();
            int i2 = 0;
            while (i2 < datos.getColumnas())
            {
                fila.add(datos.getDatos().get((i * datos.getColumnas()) + i2));
                i2++;
            }

            tabla.add(fila);
            i++;
        }

        return tabla;
    }

}