<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login |<%=application.getAttribute("appName")%></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <style>
        #loadingOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(10, 10, 15, 0.92);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            backdrop-filter: blur(3px);
        }

        /* Futuristic neon loader */
        .neon-loader {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            position: relative;
            box-shadow: 0 0 20px #2575fc;
            animation: pulseGlow 1.3s infinite ease-in-out;
        }

        .neon-loader::before {
            content: "";
            position: absolute;
            inset: 0;
            border-radius: 50%;
            border: 6px solid transparent;
            border-top-color: #00d2ff;
            border-right-color: #007bff;
            animation: rotateNeon 0.8s linear infinite;
        }

        @keyframes rotateNeon {
            100% {
                transform: rotate(360deg);
            }
        }

        @keyframes pulseGlow {
            0% { transform: scale(0.95); box-shadow: 0 0 10px #005eff; }
            50% { transform: scale(1.05); box-shadow: 0 0 25px #00d5ff; }
            100% { transform: scale(0.95); box-shadow: 0 0 10px #005eff; }
        }
    </style>

</head>
<body>
<%@ include file="includes/header.jsp" %>

<!-- Loading overlay -->
<div id="loadingOverlay">
    <div class="neon-loader"></div>
</div>

<div class="login-container">
    <div class="login-card shadow">
        <h3 class="text-center mb-4">Welcome Back</h3>
        <%
            String error=(String)request.getAttribute("error");
            if(error!=null){%>
        <div class="alert alert-danger text-center py-1"><%=error %></div>
        <%}
            String reg=request.getParameter("registered");
            if("true".equals(reg)){%>
        <div class="alert alert-success text-center py-1">✔ Registration successful</div>
        <%}%>

        <form id="loginForm" action="LoginServlet" method="post">
            <div class="mb-3">
                <input type="email" name="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>
            <button type="submit" id="loginBtn" class="btn btn-login mt-2">Login</button>

            <div class="text-center mt-3">
                <small>Don't have an account <a href="register.jsp" class="text-warning">Register</a></small>
            </div>
        </form>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>

<script>
    document.getElementById("loginForm").addEventListener("submit", function() {
        document.getElementById("loadingOverlay").style.display = "flex";
        document.getElementById("loginBtn").disabled = true;
    });
</script>

</body>
</html>
