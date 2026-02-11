<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*, com.samarth.CRUDAPP.Model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Form</title>
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
                        <i class="bi bi-person-plus-fill me-3"></i>
                        <%= (request.getAttribute("student") != null ? "Edit" : "Add") %> Student
                    </h1>
                    <h2 class="display-6 fw-normal opacity-90 mb-4">
                        <%= (request.getAttribute("student") != null ? "Update student information" : "Create a new student record") %>
                    </h2>
                    <p class="lead mb-0">
                        Built with <strong>SERVLET + JSP + JDBC</strong>
                    </p>
                </div>
                <div class="col-lg-4 text-center text-lg-end">
                    <a href="students" class="btn btn-outline-light btn-xl px-5 py-3 shadow-lg border-2 fw-bold fs-5">
                        <i class="bi bi-list-ul me-3"></i>
                        View All Students
                    </a>
                </div>
            </div>
        </div>
    </section>

    <div class="container">
        <%
            Student student = (Student)request.getAttribute("student");
            boolean isEdit = (student != null);
        %>

        <!-- Students Form -->
        <div class="card shadow-lg border-0">
            <div class="card-header bg-gradient py-4" style="background: linear-gradient(135deg, #0d6efd 0%, #6610f2 100%); color: white;">
                <h3 class="mb-0 fw-bold">
                    <i class="bi bi-file-earmark-text me-2"></i>
                    <%= (isEdit ? "Edit" : "New") %> Student Information
                </h3>
            </div>
            <div class="card-body p-5">
                <form action="students?action=<%= (isEdit)? "update" : "insert" %>" method="POST">
                    <%
                        if(isEdit){
                    %>
                        <input type="hidden" name="id" value="<%= student.getId() %>">
                    <%
                        }
                    %>

                    <!-- Name Field -->
                    <div class="row mb-4">
                        <div class="col-md-8">
                            <label for="name" class="form-label fw-bold fs-6">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-person-fill text-primary"></i>
                                </span>
                                <input type="text"
                                       class="form-control form-control-lg <%= (request.getAttribute("nameError") != null ? "is-invalid" : "") %>"
                                       id="name"
                                       name="name"
                                       placeholder="Enter full name"
                                       value="<%= (request.getParameter("name")!=null) ? request.getParameter("name") :(isEdit)? student.getName() : ""%>"
                                       required>
                            </div>
                            <% String nameError = (String)request.getAttribute("nameError"); %>
                            <% if(nameError != null) { %>
                                <div class="invalid-feedback d-block"><%= nameError %></div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Email Field -->
                    <div class="row mb-4">
                        <div class="col-md-8">
                            <label for="email" class="form-label fw-bold fs-6">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-envelope-fill text-success"></i>
                                </span>
                                <input type="email"
                                       class="form-control form-control-lg <%= (request.getAttribute("emailError") != null ? "is-invalid" : "") %>"
                                       id="email"
                                       name="email"
                                       placeholder="Enter email address"
                                       value="<%= (request.getParameter("email")!=null) ? request.getParameter("email") :(isEdit)? student.getEmail() : "" %>"
                                       required>
                            </div>
                            <% String emailError = (String)request.getAttribute("emailError"); %>
                            <% if(emailError != null) { %>
                                <div class="invalid-feedback d-block"><%= emailError %></div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Mobile Field -->
                    <div class="row mb-5">
                        <div class="col-md-8">
                            <label for="mobile" class="form-label fw-bold fs-6">Mobile Number</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-telephone-fill text-warning"></i>
                                </span>
                                <input type="tel"
                                       class="form-control form-control-lg <%= (request.getAttribute("mobileError") != null ? "is-invalid" : "") %>"
                                       id="mobile"
                                       name="mobile"
                                       placeholder="Enter mobile number"
                                       value="<%= (request.getParameter("mobile")!=null) ? request.getParameter("mobile") :(isEdit)? student.getMobile() : ""%>"
                                       required>
                            </div>
                            <% String mobileError = (String)request.getAttribute("mobileError"); %>
                            <% if(mobileError != null) { %>
                                <div class="invalid-feedback d-block"><%= mobileError %></div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-grid gap-3 d-md-flex justify-content-md-between">
                        <button type="submit" class="btn btn-primary btn-xl px-5 py-3 shadow-lg border-0 fw-bold">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <%= (isEdit ? "Update" : "Save") %> Student
                        </button>
                        <a href="students" class="btn btn-outline-secondary btn-xl px-5 py-3 shadow-lg fw-bold">
                            <i class="bi bi-arrow-left me-2"></i>
                            Cancel & Return
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5.3 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

