<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login |<%=application.getAttribute("appName")%></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
</head>
<body>
<%@ include file="includes/header.jsp" %>

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

            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                </div>
                <div class="mb-3">
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>
                <button type="submit" class="btn btn-login mt-2">Login</button>

                <div class="text-center mt-3">
                    <small>Don;t have an account <a href="register.jsp" class="text-warning">Register</a></small>
                </div>
            </form>
        </div>
   </div>

<%@ include file="includes/footer.jsp" %>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>