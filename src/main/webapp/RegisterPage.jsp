<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Student Management System</title>

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
        }

        .register-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.2);
            border: none;
            max-width: 500px;
        }

        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 50px;
            font-weight: 600;
            padding: 0.75rem 2rem;
            transition: all 0.3s;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(102,126,234,0.4);
        }

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
            <div class="col-lg-6">

                <div class="card register-card shadow-lg">
                    <div class="card-body p-5">

                        <!-- Header -->
                        <div class="text-center mb-4">
                            <h2 class="fw-bold">Create Account</h2>
                            <p class="text-muted">Register to manage students</p>
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

                        <!-- Registration Form -->
                        <form action="user?action=doRegister" method="POST">

                            <!-- Full Name -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person-fill me-2 text-primary"></i>Full Name
                                </label>
                                <input type="text"
                                       name="name"
                                       class="form-control"
                                       placeholder="Enter full name"
                                       required>
                            </div>

                            <!-- Email -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-envelope-fill me-2 text-primary"></i>Email
                                </label>
                                <input type="email"
                                       name="email"
                                       class="form-control"
                                       placeholder="Enter email address"
                                       required>
                            </div>

                            <!-- Username -->
                            <div class="mb-3">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-person-badge-fill me-2 text-primary"></i>Username
                                </label>
                                <input type="text"
                                       name="userName"
                                       class="form-control"
                                       placeholder="Choose username"
                                       required>
                            </div>

                            <!-- Password -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <i class="bi bi-lock-fill me-2 text-primary"></i>Password
                                </label>
                                <input type="password"
                                       name="password"
                                       class="form-control"
                                       placeholder="Create password"
                                       required>
                            </div>

                            <!-- Submit Button -->
                            <button type="submit"
                                    class="btn btn-register btn-lg w-100 text-white mb-3">
                                <i class="bi bi-person-plus-fill me-2"></i>Create Account
                            </button>

                            <!-- Login Link -->
                            <div class="text-center">
                                <small class="text-muted">
                                    Already have an account?
                                    <a href="user?action=login"
                                       class="fw-semibold text-decoration-none text-primary">
                                        Sign In
                                    </a>
                                </small>
                            </div>

                        </form>

                    </div>
                </div>

            </div>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>