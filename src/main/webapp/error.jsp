<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>

<html>
<head>
    <title>Error - HireSense</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="login-container">
    <div class="login-card" style="text-align: center; padding: 40px;">

        <h2 style="font-size: 2rem; margin-bottom: 15px;">Something Went Wrong!</h2>

        <p style="font-size: 1.1rem; margin-bottom: 20px;">
            An unexpected error occurred while processing your request.
            <br>Please try again later.
        </p>

        <!-- Optional Debug Info -->
        <div class="feature-card" style="margin-top: 20px; text-align: left; color: white; font-size: 0.9rem;">
            <strong>Error Details:</strong><br>
            <%= exception != null ? exception.getMessage() : "No additional information" %>
            <br><br>
            <strong>Timestamp:</strong> <%= new java.util.Date() %>
        </div>

        <br>

        <a href="login.jsp" class="btn-cta" style="display: inline-block; text-decoration: none; margin-top: 20px;">
            Go Back to Login
        </a>

    </div>
</div>

</body>
</html>
