<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Management System</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            color: white;
            padding: 6rem 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.15);
            z-index: 1;
        }
        .hero-section > * { position: relative; z-index: 2; }

        .login-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.2);
            border: none;
            max-width: 420px;
        }
        .avatar-placeholder {
            background: linear-gradient(135deg, #667eea, #764ba2);
            width: 70px; height: 70px; font-size: 1.8rem; font-weight: 700;
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none; border-radius: 50px; font-weight: 600;
            padding: 0.75rem 2rem; transition: all 0.3s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(102,126,234,0.4);
        }
        .input-group-text { background: #f8f9fa; border-right: 0; }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102,126,234,0.25);
        }
    </style>
</head>

<body class="bg-light">

<section class="hero-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-xl-5">
                <div class="card login-card shadow-lg">
                    <div class="card-body p-5">

                        <!-- Header -->
                        <div class="text-center mb-5">
                            <div class="avatar-placeholder rounded-circle text-white d-flex align-items-center justify-content-center mx-auto mb-4">
                                <i class="bi bi-shield-lock-fill"></i>
                            </div>
                            <h1 class="h3 fw-bold mb-2">Welcome Back</h1>
                            <p class="lead opacity-90 mb-0">Sign in to manage students</p>
                        </div>

                        <!-- Error Message -->
                        <%
                            String error = (String)request.getAttribute("error");
                            if(error != null && !error.isEmpty()) {
                        %>
                        <div class="alert alert-danger alert-dismissible fade show">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <%= error %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>

                        <!-- Success Message -->
                        <%
                            String success = request.getParameter("success");
                            if(success != null && !success.isEmpty()) {
                        %>
                        <div class="alert alert-success alert-dismissible fade show">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <%= success %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>

                        <!-- Login Form -->
                        <form action="user?action=doLogin" method="POST">

                            <div class="mb-4">
                                <label class="form-label fw-semibold mb-3">
                                    <i class="bi bi-person-fill me-2 text-primary"></i>Username
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person-fill text-muted"></i>
                                    </span>
                                    <!-- FIXED name -->
                                    <input type="text"
                                           class="form-control border-start-0 ps-3"
                                           name="userName"
                                           placeholder="Enter username"
                                           autocomplete="userName"
                                           required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-semibold mb-3">
                                    <i class="bi bi-lock-fill me-2 text-primary"></i>Password
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock-fill text-muted"></i>
                                    </span>
                                    <input type="password"
                                           class="form-control border-start-0 ps-3"
                                           name="password"
                                           placeholder="Enter password"
                                           autocomplete="current-password"
                                           required>
                                </div>
                            </div>

                            <!-- Submit -->
                            <button type="submit" class="btn btn-login btn-lg w-100 text-white mb-3">
                                <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
                            </button>

                            <!-- Register Option -->
                            <div class="text-center">
                                <small class="text-muted">
                                    Don’t have an account?
                                    <a href="user?action=register"
                                       class="fw-semibold text-decoration-none text-primary">
                                        Register Here
                                    </a>
                                </small>
                            </div>

                        </form>

                        <!-- Footer -->
                        <div class="text-center pt-4 border-top mt-4">
                            <small class="text-muted">
                                Built with <i class="fas fa-heart text-danger"></i>
                                SERVLET + JSP + PostgreSQL
                            </small>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>