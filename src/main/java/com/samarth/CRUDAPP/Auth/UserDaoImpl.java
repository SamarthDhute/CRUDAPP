package com.samarth.CRUDAPP.Auth;

import com.samarth.CRUDAPP.Exception.DAOException;
import com.samarth.CRUDAPP.util.JDBCutils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDaoImpl implements UserDao{
    private static final String SEELCT_USER ="SELECT id,name,email,userName,password FROM users WHERE userName = ? and password =?";
    private static final String INSERT_USER= "INSERT INTO users(name,email,userName,password) values(?,?,?,?)";
    private static final String ISEXIST = "SELECT 1 FROM users WHERE userName = ?";
    @Override
    public User dologin(String userName, String password) {
        User user= null;
        try(Connection connection = JDBCutils.fetchConnection();
            PreparedStatement psmt = connection.prepareStatement(SEELCT_USER)){
            psmt.setString(1,userName);
            psmt.setString(2,password);

            ResultSet resultSet = psmt.executeQuery();
            if(resultSet.next()){
                user = new User();
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setUserName(resultSet.getString("userName"));
                user.setPassword(resultSet.getString("password"));
                return user;
            }

        }catch(SQLException sqle){
            throw new DAOException("FAILED TO GET USER RECORD",sqle);
        }
        return user;
    }

    @Override
    public void doRegister(User user) {
        try(Connection connection= JDBCutils.fetchConnection();
            PreparedStatement psmt = connection.prepareStatement(INSERT_USER)){

            psmt.setString(1,user.getName());
            psmt.setString(2, user.getEmail());
            psmt.setString(3, user.getUserName());
            psmt.setString(4, user.getPassword());

            psmt.executeUpdate();

        } catch (SQLException e) {
            throw new DAOException("FAILED TO INSERT USER RECORD",e);
        }

    }

    @Override
    public boolean isExist(String userName) {
        try(Connection connection = JDBCutils.fetchConnection();
            PreparedStatement psmt = connection.prepareStatement(ISEXIST)){

            psmt.setString(1,userName);
            try(ResultSet resultSet = psmt.executeQuery()){
                return resultSet.next();
            }

        }catch (SQLException e) {
            throw new DAOException("FAILED TO SEARCH EXISTANCE OF USER RECORD",e);
        }

    }
}
