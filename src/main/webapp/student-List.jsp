<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, com.samarth.CRUDAPP.Model.Student" %>
<!DOCTYPE html>
<html>
<head><title>Student List</title></head>
<body>
    <h1>MVC CRUD APPLICATION</h1>
    <h3>SERVLET + JSP + JDBC</h3>
    <%-- print Message on succesfully delete/update/insert --%>
    <%
       String message = request.getParameter("message");
       if(message != null){
    %>
      <p><%= message%></p>
    <%
       }
    %>


    <a href="student?action=add">Add Student</a>
    <table border="1">
        <thead>
            <tr>
               <th>#</th>
               <th>Name</th>
               <th>Email</th>
               <th>Mobile</th>
               <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Student> students = (List<Student>)request.getAttribute("studentlist");

            if(students != null && !students.isEmpty()) {
                int cnt = 1;
                for(Student student : students) {
        %>
            <tr>
                <td><%= cnt++ %></td>
                <td><%= student.getName() %></td>
                <td><%= student.getEmail() %></td>
                <td><%= student.getMobile() %></td>
                <td>
                    <a href="student?action=edit&id=<%= student.getId() %>">UPDATE</a>
                    <a href="student?action=delete&id=<%= student.getId() %>" onclick="return confirm('Are You Sure To Delete Record ?')">DELETE</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="5">No students found</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</body>
</html>
