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
         value="<%= (request.getParameter("name")!=null) ? request.getParameter("name") :(isEdit)? student.getName() : ""%>" required><br>


          <%String nameError = (String)request.getAttribute("nameError");%>
          <p class="text-danger"><%= (nameError != null ? nameError : "")%></p>

        <label>Email</label>
        <input type="email" name="email" placeholder="Enter Email "
        value = "<%= (request.getParameter("email")!=null) ? request.getParameter("email") :(isEdit)? student.getEmail() : "" %>"required><br>

         <%String emailError = (String)request.getAttribute("emailError");%>
         <p class="text-danger"><%= (emailError != null ? emailError : "")%></p>

        <label>Mobile</label>
        <input type="text" name="mobile" placeholder="Enter Mobile NO."
         value = "<%=(request.getParameter("mobile")!=null) ? request.getParameter("mobile") :(isEdit)? student.getMobile() : ""%>"required><br>

          <%String mobileError = (String)request.getAttribute("mobileError");%>
          <p class="text-danger"><%= (mobileError != null ? mobileError : "")%></p>

        <button type="submit">save</button>
        <a href="students">Cancel</a>
    </form>

</body>
</html>