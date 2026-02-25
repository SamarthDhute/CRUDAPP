<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Student Management System</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; padding: 20px 0; }
        .error-container { max-width: 800px; margin: 0 auto; }
        .error-header { background: linear-gradient(135deg, #dc3545, #ff6b6b); color: white; }
        pre { background: #f8f9fa; border: 1px solid #dee2e6; border-radius: 0.375rem; }
    </style>
</head>
<body>
    <div class="container error-container">
        <!-- Header matching student list -->
        <div class="row mb-4">
            <div class="col-12 text-center error-header py-4 rounded-top">
                <h1 class="mb-2">⚠️ ERROR OCCURRED</h1>
                <h3>MVC CRUD APPLICATION</h3>
                <small class="opacity-75">SERVLET + JSP + JDBC</small>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <!-- Success/Error Message -->
                <%
                    String message = (String) request.getAttribute("ERROR MESSAGE");
                    if (message != null && !message.trim().isEmpty()) {
                %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error:</strong> <%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% } %>

                <!-- Root Cause / Exception Display -->
                <%
                    Throwable errorCause = (Throwable) request.getAttribute("ERROR CAUSE");
                    Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception");
                %>

                <div class="card shadow">
                    <div class="card-header bg-danger text-white">
                        <h5 class="mb-0"><i class="bi bi-bug-fill me-2"></i>Technical Details</h5>
                    </div>
                    <div class="card-body">
                        <% if (errorCause != null) { %>
                            <div class="mb-3">
                                <h6 class="text-danger fw-bold">🔍 Root Cause</h6>
                                <pre class="p-3 overflow-auto" style="max-height: 300px;"><%= errorCause.toString() %></pre>
                            </div>
                        <% } else if (exception != null) { %>
                            <div class="mb-3">
                                <h6 class="text-danger fw-bold">💥 Main Exception</h6>
                                <pre class="p-3 overflow-auto" style="max-height: 300px;"><%= exception.toString() %></pre>
                            </div>
                        <% } else { %>
                            <div class="alert alert-info text-center py-4">
                                <h5>ℹ️ No Technical Error Found</h5>
                                <p class="mb-0">Please check your input or contact administrator.</p>
                            </div>
                        <% } %>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="row mt-4">
                    <div class="col-md-6">
                        <a href="student" class="btn btn-primary w-100">
                            <i class="bi bi-list-ul me-2"></i>Back to Student List
                        </a>
                    </div>
                    <div class="col-md-6">
                        <a href="student?action=add" class="btn btn-success w-100">
                            <i class="bi bi-plus-circle me-2"></i>Add New Student
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
