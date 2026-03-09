package com.samarth.CRUDAPP.util;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCutils {
    private static String JDBC_HOST = System.getenv("JDBC_HOST") != null ? System.getenv("JDBC_HOST") : "localhost";
    private static String JDBC_PORT = System.getenv("JDBC_PORT") != null ? System.getenv("JDBC_PORT") : "5432";
    private static String JDBC_DB = System.getenv("JDBC_DB") != null ? System.getenv("JDBC_DB") : "cruddb";
    private static String JDBC_USERNAME = System.getenv("JDBC_USERNAME") != null ? System.getenv("JDBC_USERNAME") : "postgres";
    private static String JDBC_PASSWORD = System.getenv("JDBC_PASSWORD") != null ? System.getenv("JDBC_PASSWORD") : "1234";

    private static String URL = "jdbc:postgresql://"+JDBC_HOST+":"+JDBC_PORT+"/"+JDBC_DB;

//    private static String JDBC_HOST =  "localhost";
//    private static String JDBC_PORT =  "5432";
//    private static String JDBC_DB =  "cruddb";
//    private static String JDBC_USERNAME =  "postgres";
//    private static String JDBC_PASSWORD =  "1234";

//    private static String URL = "jdbc:postgresql://"+JDBC_HOST+":"+JDBC_PORT+"/"+JDBC_DB;
    static{
        try{
            Class.forName("org.postgresql.Driver");
        }catch(ClassNotFoundException cnfe){
            cnfe.getMessage();
        }
    }
    
    public static Connection fetchConnection() throws SQLException {
        return DriverManager.getConnection(URL, JDBC_USERNAME, JDBC_PASSWORD);
    }
}

