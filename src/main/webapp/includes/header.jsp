<!--navbar code start here-->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a href="./index.jsp" class="navbar-brand fw-bold"><%= application.getAttribute("appName") %></a>

            <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#mynav">
                <span class="navbar-toggler-icon"></span>
            </button>


            <div class="collapse navbar-collapse" id="mynav">
                <ul class="navbar-nav ms-auto">
                <%
                    String role=(String)session.getAttribute("userRole");
                if(role==null){
                %>
                    <li class="nav-item">
                        <a href="./login.jsp" class="nav-link">Login</a>
                    </li>
                    <li class="nav-item">
                        <a href="./register.jsp" class="nav-link">Register</a>
                    </li>
                    <%
                    }else if(role.equals("user")){
                    %>

                    <!--hiring person links-->
                    <li class="nav-item">
                        <a href="./UserDashboardServlet" class="nav-link">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="./LogoutServlet" class="nav-link">Logout</a>
                    </li>
                    <!--hiring person links end-->
                    <%
                    }else if(role.equals("employer")){
                    %>

                    <!--employer links-->
                    <li class="nav-item">
                        <a href="./EmployerDashboardServlet" class="nav-link">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="./LogoutServlet" class="nav-link">Logout</a>
                    </li>
                    <!--employer links end-->
                    <%
                    }else if(role.equals("admin")){
                    %>
                    
                    <!--admin links-->
                    <li class="nav-item">
                        <a href="./AdminPanelServlet" class="nav-link">Admin Panel</a>
                    </li>
                    <li class="nav-item">
                        <a href="./LogoutServlet" class="nav-link">Logout</a>
                    </li>
                    <!--admin links end-->
                    <%
                    }
                    %>
                </ul>
            </div>

        </div>
    </nav>
    <!--navbar code ends here-->