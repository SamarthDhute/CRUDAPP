package com.samarth.CRUDAPP.Auth;

import com.samarth.CRUDAPP.Exception.DAOException;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet(urlPatterns = {"/","/user"})
public class UserServlet extends HttpServlet {

    UserDao Dao;

    @Override
    public void init(){
         Dao = new UserDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          doGet(request,response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if(action == null){ action="login";}
        try {
            switch(action){
                case "login": login(request,response);
                break;
                case "doLogin" : doLogin(request,response);
                break;
                case "register" : register(request,response);
                break;
                case "doRegister" : doRegister(request,response);
                break;
                case "logout" : logout(request,response);
                break;
            }

        } catch (DAOException de) {
            request.setAttribute("ERROR MESSAGE",de.getMessage());
            request.setAttribute("ERROR CAUSE",de.getCause());
            request.setAttribute("exception",de);

            request.getRequestDispatcher("errorPage.jsp").forward(request,response);
        }

    }

    private void login(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("LoginPage.jsp");
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException,IOException{

        req.getSession().invalidate();
        resp.sendRedirect("user");
    }

    private void doLogin(HttpServletRequest request , HttpServletResponse reaponse) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        User user = Dao.dologin(userName,password);

        if(user == null){
           request.setAttribute("error","INVALID CREDENTIALS");
           request.getRequestDispatcher("LoginPage.jsp").forward(request,reaponse);
        }

        request.getSession().setAttribute("user",user);
        reaponse.sendRedirect("students");

    }

    private void register(HttpServletRequest request,HttpServletResponse response) throws IOException {
        response.sendRedirect("RegisterPage.jsp");
    }

    private void doRegister(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        if(Dao.isExist(userName)){
            request.setAttribute("error","USER ALREADY EXIST");
            request.getRequestDispatcher("user?action=register").forward(request,response);
            return;
        }

        Dao.doRegister(new User(name,email,userName,password));
        request.setAttribute("success","REGISTERATION SUCCESSFULL");
        request.getRequestDispatcher("user?action=login").forward(request,response);
    }






}
