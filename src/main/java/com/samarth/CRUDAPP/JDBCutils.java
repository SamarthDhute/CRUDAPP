package com.samarth.CRUDAPP;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCutils {
    private static String URL = "jdbc:postgresql://localhost:5432/cruddb";
    private static String USER = "postgres";
    private static String PASSWORD = "1234";
    
    static{
        try{
            Class.forName("org.postgresql.Driver");
        }catch(ClassNotFoundException cnfe){
            cnfe.getMessage();
        }
    }
    
    public static Connection fetchConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

