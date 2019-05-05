/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import java.sql.*;


/**
 *
 * @author USUARIO
 */
public class Conexion {
    static Connection connection;
    static Statement st;
    
    
    

    public static Connection conexion(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/countries-reto?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","zeus246*");
            st = connection.createStatement();

        }
        catch(Exception e){
            System.out.println(e);
        }
        return connection;
    }

    public static Statement stm(){
        return st;
    }

    public static void close(){
        try{
            connection.close();
        }
        catch(Exception e){
            System.out.println(e);
        }


    }

    static int getLastId(String table_name, String idName){
        int i=1;
        try{
            connection = Conexion.conexion();
            st = Conexion.stm();
            String sql2 = "select count("+idName +") AS total from " + table_name ;
            
            ResultSet rs = st.executeQuery(sql2);
            if (rs.next()) i = rs.getInt("total");
            i= i+1;
            System.out.println(i);
        }
        catch(Exception e){
            System.out.println(e);
        }

        return i;
    }




}
