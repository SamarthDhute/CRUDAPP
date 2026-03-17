package com.samarth.CRUDAPP.webapp;


import com.samarth.CRUDAPP.DAO.StudentDAO;
import com.samarth.CRUDAPP.DAO.StudentDAOImpl;
import com.samarth.CRUDAPP.Exception.DAOException;
import com.samarth.CRUDAPP.Model.Student;
import com.samarth.CRUDAPP.Model.Pagination;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

import static java.lang.Math.*;

@WebServlet(urlPatterns = {"/students"})
public class studentservlet extends HttpServlet {
    StudentDAO DAO;
    String search;

    @Override
    public void init() throws ServletException {
        DAO = new StudentDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        search = (String) req.getParameter("search");


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
            req.setAttribute("ERROR MESSAGE",de.getMessage());
            req.setAttribute("ERROR CAUSE",de.getCause());
            req.setAttribute("exception",de);

            req.getRequestDispatcher("errorPage.jsp").forward(req,resp);
        }
    }

    private void listStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pagenumber = 1;
        int pagesize = 5;
        List<Student> studentlist;



        if(req.getParameter("page") != null) {
            pagenumber = Integer.parseInt(req.getParameter("page"));
        }

        if(req.getParameter("pagesize") != null) {
            pagesize = Integer.parseInt(req.getParameter("pagesize"));
        }
        Pagination pagination = new Pagination(pagenumber,pagesize);

        int totalRecords =DAO.getToatalRecords();
        int totalPages =  (int) ceil((double) totalRecords/pagesize);

        if(pagenumber<1)
            pagination.setPagenumber(1);
        if(pagenumber> totalPages)
            pagination.setPagenumber(totalPages);

        if (search != null && !search.trim().isEmpty()) {
            String type= detectSearchType(search);
            studentlist = DAO.searchStudents(search.trim(),type,pagination); // smart search

             totalRecords =DAO.getSearchedTotalRecords(search,type); //TOTAL RECORDS ( SEARCHED RESULT )
             totalPages =  (int) ceil((double) totalRecords/pagesize);

        } else {
            studentlist= DAO.getSelectedStudent(pagination);
        }

        req.setAttribute("totalPages",totalPages);
        req.setAttribute("studentlist",studentlist);
        req.setAttribute("currentPage",pagenumber);
        req.setAttribute("pageSize",pagesize);


        req.getRequestDispatcher("student-List.jsp").forward(req,resp);
    }

    void deleteStudent(HttpServletRequest req,HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        DAO.delete(id);

        resp.sendRedirect("students?action=list&message=RECORD DELETED SUCCESSFULLY");
    }

    void showAddForm(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException {

        //req.getRequestDispatcher("student-Form.jsp").forward(req,resp);
        //req.getRequestDispatcher("student-Form.jsp").forward(req, resp);
        resp.sendRedirect("student-Form.jsp");
    }

    void insertStudent(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException{
        String name =req.getParameter("name");
        String email= req.getParameter("email");
        String mobile = req.getParameter("mobile");

        //Student student = new Student(name,email,mobile);

        if(!validate(req,name,email,mobile)){
            req.getRequestDispatcher("student-Form.jsp").forward(req,resp);
            return;
        }

        DAO.insert(new Student(name.trim(),email.trim(),mobile.trim()));
        resp.sendRedirect("students?action=list&message=RECORD INSERTED SUCCESSFULLY");
    }

    void showEditForm(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException {
        int id  =Integer.parseInt(req.getParameter("id"));
        Student student = DAO.getStudentByID(id);

        req.setAttribute("student",student);
        req.getRequestDispatcher("student-Form.jsp").forward(req,resp);
    }

    void updateStudent(HttpServletRequest req,HttpServletResponse resp) throws IOException, ServletException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String email =req.getParameter("email");
        String mobile =req.getParameter("mobile");

        if(!validate(req,name,email,mobile)){
            req.setAttribute("student",new Student(id,name,email,mobile));
            req.getRequestDispatcher("student-Form.jsp").forward(req,resp);
            return;
        }

        DAO.update(new Student(id,name,email,mobile));
        resp.sendRedirect("students?action=list&message=RECORD UPDATED SUCCESSFULLY");

    }

    private boolean validate(HttpServletRequest req,String name,String email,String mobile){
        boolean isValid = true;

        if(name==null || !Pattern.matches("^[A-Za-z ]{3,50}$",name.trim())){
            isValid = false;
            req.setAttribute("nameError","Name should be at least 3 to 50 characters");
        }

        if(email==null || !Pattern.matches("^[A-Za-z0-9_.-]+@(.+)$",email.trim())){
            isValid = false;
            req.setAttribute("emailError","Invalid Email ID");
        }

        if(mobile==null || !Pattern.matches("^[0-9]{10}$",mobile.trim())){
            isValid = false;
            req.setAttribute("mobileError","Mobile Number should be of 10 digits");
        }

        return isValid;
    }

    public static String detectSearchType(String keyword) {

        // @ → EMAIL
        if (keyword.contains("@")) {
            return "email";
        }

        //  all digits AND length between 7–15 → MOBILE
        // (phone numbers are purely numeric, 7 to 15 digits worldwide)
        if (keyword.matches("\\d{7,15}")) {
            return "mobile";
        }

        //  starts with + followed by digits → MOBILE (+91 9876543210)
        if (keyword.matches("\\+\\d{1,15}")) {
            return "mobile";
        }

        // partial digits (less than 7) → still MOBILE partial search
        // e.g. user types "98765" to find numbers starting with that
        if (keyword.matches("\\d{4,6}")) {
            return "mobile";
        }

        //  everything else → NAME
        return "name";
    }



}