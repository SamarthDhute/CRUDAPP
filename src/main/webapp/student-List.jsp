<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*, com.samarth.CRUDAPP.Model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List</title>
    <!-- Bootstrap 5.3 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            color: white;
            padding: 4rem 0;
            margin-bottom: 3rem;
            border-radius: 20px;
            position: relative;
            overflow: hidden;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.1);
            z-index: 1;
        }
        .hero-section > * {
            position: relative;
            z-index: 2;
        }
        .avatar-placeholder {
            background: linear-gradient(135deg, #667eea, #764ba2);
        }
    </style>
</head>
<body class="bg-light min-vh-100">
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center gy-4">
                <div class="col-lg-8 text-center text-lg-start">
                    <h1 class="display-4 fw-bold mb-3">
                        <i class="bi bi-people-fill me-3"></i>
                        MVC CRUD Application
                    </h1>
                    <h2 class="display-6 fw-normal opacity-90 mb-4">
                        Manage Your Student Records
                    </h2>
                    <p class="lead mb-0">
                        Built with <strong>SERVLET + JSP + JDBC</strong>
                    </p>
                </div>
                <div class="col-lg-4 text-center text-lg-end">
                    <a href="students?action=add" class="btn btn-light btn-xl px-5 py-3 shadow-lg border-0 fw-bold fs-5">
                        <i class="bi bi-plus-circle-fill me-3" style="font-size: 1.5rem;"></i>
                        Add New Student
                    </a>
                </div>
            </div>

        </div>
    </section>

 <jsp:include page="header.jsp"/>

    <div class="container">
        <!-- Success Message -->
        <%
            String message = request.getParameter("message");
            int totalPages = (int) request.getAttribute("totalPages");
            int currentPage =(int) request.getAttribute("currentPage");

            String param = request.getParameter("pagesize");
            int pagesize = (param != null) ? Integer.parseInt(param) : (int)request.getAttribute("pageSize");

            if(message != null && !message.isEmpty()){
        %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>



        <!-- Students Table -->
        <div class="card shadow-lg border-0">

            <div class="card-header bg-gradient py-4" style="background: linear-gradient(135deg, #0d6efd 0%, #6610f2 100%); color: white;">
                <div class="row align-items-center">
                    <div class="col">
                        <h3 class="mb-0 fw-bold">
                            <i class="bi bi-list-ul me-2"></i>
                            Student Directory
                        </h3>
                        <small class="opacity-75">
                            <%
                                List<Student> students = (List<Student>)request.getAttribute("studentlist");
                                int totalStudents = (students != null) ? students.size() : 0;
                            %>
                            <%= totalStudents %> student<%= (totalStudents != 1) ? "s" : "" %> found
                        </small>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark sticky-top">
                            <tr>
                                <th scope="col" class="ps-4">#</th>
                                <th scope="col">Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Mobile</th>
                                <th scope="col" class="text-center" style="width: 140px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="table-group-divider">
                        <%
                            if(students != null && !students.isEmpty()) {
                                int cnt = 1;
                                for(Student student : students) {
                        %>
                            <tr>
                                <td class="fw-semibold ps-4"><%= cnt++ %></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-placeholder rounded-circle text-white d-flex align-items-center justify-content-center me-3"
                                             style="width: 40px; height: 40px; font-size: 0.9rem; font-weight: 600;">
                                            <%= String.valueOf(student.getName().charAt(0)).toUpperCase() %>
                                        </div>
                                        <div>
                                            <div class="fw-bold"><%= student.getName() %></div>
                                        </div>
                                    </div>
                                </td>
                                <td class="fw-medium text-break"><%= student.getEmail() %></td>
                                <td>
                                    <i class="bi bi-telephone-fill me-2 text-muted"></i>
                                    <%= student.getMobile() %>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <a href="students?action=edit&id=<%= student.getId() %>"
                                           class="btn btn-sm btn-outline-primary"
                                           title="Edit Student">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="students?action=delete&id=<%= student.getId() %>"
                                           class="btn btn-sm btn-outline-danger"
                                           onclick="return confirm('Are you sure you want to delete <%= student.getName() %>?')"
                                           title="Delete Student">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="5" class="text-center py-5">
                                    <div class="text-muted">
                                        <i class="bi bi-people display-1 mb-4 d-block"></i>
                                        <h4 class="mb-3">No students found</h4>
                                        <p class="mb-4">Get started by adding your first student above.</p>
                                        <a href="students?action=add" class="btn btn-primary btn-lg px-4">
                                            <i class="bi bi-plus-circle me-2"></i>Add First Student
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


    <div>
    <!-- GO TO PAGE FORM -->
      <div class="d-flex align-items-center justify-content-between mb-3">
        <div class="container mt-4 mb-1">
            <div class=" ms-1">
                <div class="col-md-6 col-lg-4 text-center">
                    <form action="students" method="POST" class="d-flex align-items-center gap-1 p-1 bg-white shadow-sm border rounded-2 mx-auto" style="max-width: 180px;">
                        <label class="form-label mb-0 fw-semibold text-muted small">GO</label>
                        <input type="number"
                               name="page"
                               class="form-control form-control-sm px-3 py-1"
                               min="1"
                               max="<%= totalPages %>"
                               value="<%= currentPage %>"
                               style="width: 65px; font-size: 0.85rem;"
                               required>
                        <button type="submit" class="btn btn-primary btn-sm px-2 py-1 fw-bold">
                            <i class="fas fa-arrow-right me-1"></i>GO
                        </button>
                    </form>
                </div>
            </div>

        </div>
             <div class="ms-4 mt-3">  <!-- ms-4 = 24px left margin -->
                 <form action="students?page=<%= currentPage%>" method="GET" class="d-flex align-items-center ms-4 mt-3gap-2 p-2 bg-white border rounded-3 shadow-sm" style="max-width: 280px;">
                     <span class="text-muted fw-semibold small">Show</span>
                     <select name="pagesize" class="form-select form-select-sm border-primary shadow-none"
                             onchange="this.form.submit()" style="width: 80px;">
                         <option value="5" <%= (pagesize==5) ? "selected" : "" %>>5</option>
                         <option value="10" <%= (pagesize==10) ? "selected" : "" %>>10</option>
                         <option value="20" <%= (pagesize==20) ? "selected" : "" %>>20</option>
                         <option value="50" <%= (pagesize==50) ? "selected" : "" %>>50</option>
                         <option value="100" <%= (pagesize==100) ? "selected" : "" %>>100</option>
                         <option value="200" <%= (pagesize==200) ? "selected" : "" %>>200</option>
                     </select>
                     <span class="text-muted fw-semibold small">entries</span>
                 </form>
             </div>


      </div>



        <!-- PAGINATION -->
        <div class="container">
            <nav aria-label="Page navigation example" class="mt-3 mb-5">
                <ul class="pagination justify-content-center">
                    <!-- First Page -->
                    <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                        <a class="page-link" href="students?page=1&pagesize=<%=pagesize%>">
                            <i class="fas fa-angle-double-left me-1"></i>First
                        </a>
                    </li>

                    <!-- Previous Page -->
                    <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                        <a class="page-link" href=" students?page=<%= currentPage - 1%>&pagesize=<%= pagesize %>">
                            <i class="fas fa-chevron-left me-1"></i>
                        </a>
                    </li>

                    <!-- Page Numbers -->
                    <% for(int i=1; i<=totalPages; i++) { %>
                        <li class="page-item <%= i==currentPage ? "active" : "" %>">
                            <a class="page-link" href="students?page=<%= i %>&pagesize=<%= pagesize %>"><%= i %></a>
                        </li>
                    <% } %>

                    <!-- Next Page -->
                    <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
                        <a class="page-link" href="students?page=<%= currentPage + 1%>&pagesize=<%= pagesize  %>">
                            <i class="fas fa-chevron-right me-1"></i>
                        </a>
                    </li>

                    <!-- Last Page -->
                    <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
                        <a class="page-link" href="students?page=<%= totalPages%>&pagesize=<%= pagesize  %>">
                            Last <i class="fas fa-angle-double-right ms-1"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>

    </div>


    <!-- Bootstrap 5.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
