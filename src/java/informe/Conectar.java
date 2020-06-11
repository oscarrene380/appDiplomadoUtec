/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package informe;

/**
 *
 * @author Oscar Durán
 */
import java.sql.Connection;
import java.sql.DriverManager;

public class Conectar 
{
    //La url para conectar a la base de datos     
    private static  final String url = "jdbc:mysql://servicetimeutec.mysql.database.azure.com/bd_colegio";
    private static  final String url2 = "jdbc:mysql://servicetimeutec.mysql.database.azure.com/pruebareportes";
    //El usuario de la base de datos    
    private static final String user = "admintrador@servicetimeutec";   
    //La clave del usuario de la base de datos      
    private static final String password = "Utec2020!";
    //Metodo para obtener la conexion con la base de datos 
    public static synchronized Connection getConexion(int bd) 
    {
        Connection cn = null;
        try 
        {
            //Cargamos el driver y le decimos que vamos a usar             
            //una conexion con mysql             
            Class.forName("com.mysql.jdbc.Driver");
            //Obtenemos la conexion           
            if(bd == 1)
            {
                cn = DriverManager.getConnection(url, user, password);
            }
            else if(bd == 2)
            {
                cn = DriverManager.getConnection(url2, user, password);
            }
        } 
        catch (Exception e) 
        {
            cn = null;
        } 
        finally 
        {
            return cn;
        }
    }

    //Metodo utilizado para cerrar la conexion    
    public static synchronized void cerrarConexion(Connection cn) 
    {
        try 
        {
            cn.close();
        } 
        catch (Exception e) 
        {
            System.out.println("Error: "+e.getMessage());
        }
    }
}
