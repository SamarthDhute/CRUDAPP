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
                    <a href="student?action=add" class="btn btn-light btn-xl px-5 py-3 shadow-lg border-0 fw-bold fs-5">
                        <i class="bi bi-plus-circle-fill me-3" style="font-size: 1.5rem;"></i>
                        Add New Student
                    </a>
                </div>
            </div>
        </div>
    </section>

    <div class="container">
        <!-- Success Message -->
        <%
            String message = request.getParameter("message");
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
                                <!-- FIXED: Email now FULLY VISIBLE -->
                                <td class="fw-medium text-break"><%= student.getEmail() %></td>
                                <td>
                                    <i class="bi bi-telephone-fill me-2 text-muted"></i>
                                    <%= student.getMobile() %>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <a href="student?action=edit&id=<%= student.getId() %>"
                                           class="btn btn-sm btn-outline-primary"
                                           title="Edit Student">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="student?action=delete&id=<%= student.getId() %>"
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
                                        <a href="student?action=add" class="btn btn-primary btn-lg px-4">
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

    <!-- Bootstrap 5.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
