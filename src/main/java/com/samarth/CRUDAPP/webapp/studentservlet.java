package com.samarth.CRUDAPP.webapp;


import com.samarth.CRUDAPP.DAO.StudentDAO;
import com.samarth.CRUDAPP.DAO.StudentDAOImpl;
import com.samarth.CRUDAPP.Exception.DAOException;
import com.samarth.CRUDAPP.Model.Student;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/","/students"})
public class studentservlet extends HttpServlet {
    StudentDAO DAO;

    @Override
    public void init(ServletConfig config) throws ServletException {
        DAO = new StudentDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");


        if (action == null) action = "list";

        try {
            switch (action) {
                case "add": showAddForm(req,resp);
                    break;
                case "edit": showEditForm(req,resp);
                    break;
                case "delete": deleteStudent(req,resp);
                    break;
                case "update": updateStudent(req,resp);
                    break;
                case "insert": insertStudent(req,resp);
                    break;
                default :
                            listStudent(req, resp);
                    break;
            }
        } catch (DAOException de) {
              System.out.println(de);
        }
    }

    private void listStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Student> studentlist = DAO.getAllStudent();
        req.setAttribute("studentlist",studentlist);
        req.getRequestDispatcher("student-List.jsp").forward(req,resp);
    }

    void deleteStudent(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        DAO.delete(id);

        resp.sendRedirect("students?action=list&message=RECORD DELETED SUCCESSFULLY");
    }

    void showAddForm(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("student-Form.jsp").forward(req,resp);
        //resp.sendRedirect("student-Form.jsp");
    }

    void insertStudent(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException{
        String name =req.getParameter("name");
        String email= req.getParameter("email");
        String mobile = req.getParameter("mobile");

        //Student student = new Student(name,email,mobile);

        DAO.insert(new Student(name.trim(),email.trim(),mobile.trim()));
        resp.sendRedirect("students?action=list&message=RECORD INSERTED SUCCESSFULLY");
    }

    void showEditForm(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException {
        int id  =Integer.parseInt(req.getParameter("id"));
        Student student = DAO.getStudentByID(id);

        req.setAttribute("student",student);
        req.getRequestDispatcher("student-Form.jsp").forward(req,resp);
    }

    void updateStudent(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String email =req.getParameter("email");
        String mobile =req.getParameter("mobile");

        DAO.update(new Student(id,name,email,mobile));
        resp.sendRedirect("students?action=list&message=RECORD UPDATED SUCCESSFULLY");

    }



}