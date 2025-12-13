<%@ page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*, com.samarth.CRUDAPP.Model.Student" %>
<html lang="en">
<head>
    <title>STUDENT-FORM</title>
</head>
<body>
    <h1>MVC CRUD APPLICATION</h1>
    <h3>SERVLET + JSP + JDBC</h3>

   <%
       Student student = (Student)request.getAttribute("student");
       boolean isEdit = (student != null);
   %>
   <h4><%= (isEdit ? "EDIT" : "ADD") %> Student</h4>


    <form action="students?action=<%= (isEdit)? "update" : "insert" %>" method="POST">

                <%
                    if(isEdit){
                %>
                    <input type="hidden" name="id" value="<%= student.getId() %>">
                <%
                    }
                %>

        <label>Name</label>
        <input type="text" name="name" placeholder="Enter Name"
         value="<%=(isEdit)? student.getName() : ""%>" required><br>

        <label>Email</label>
        <input type="email" name="email" placeholder="Enter Email "
        value = "<%= (isEdit)? student.getEmail() : "" %>"required><br>

        <label>Mobile</label>
        <input type="text" name="mobile" placeholder="Enter Mobile NO."
         value = "<%=(isEdit)? student.getMobile() : ""%>"required><br>

        <button type="submit">save</button>
        <a href="students">Cancel</a>
    </form>

</body>
</html>