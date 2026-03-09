package com.samarth.CRUDAPP.Auth;


public interface UserDao {
    User dologin(String userName , String password );
    void doRegister(User user);
    boolean isExist(String userName);
}
