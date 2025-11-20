<%@ page import="org.rishbootdev.hiresenseapplication.pojo.UserPojo" %>
<%@ page import="java.util.List" %>
<%@ page import="org.rishbootdev.hiresenseapplication.pojo.JobPojo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet">
</head>
<body>
<%@ include file="includes/header.jsp" %>

<main class="container py-5">
        <h2 class="mb-4">👑 Admin Dashboard</h2>

    <%
        String success = request.getParameter("success");
        String error = request.getParameter("error");
    %>

    <% if (success != null) { %>
    <div class="alert alert-success">
        <%= success %>
    </div>
    <% } %>

    <% if (error != null) { %>
    <div class="alert alert-danger">
        <%= error %>
    </div>
    <% } %>


    <!--filter section start-->
        <div class="p-4 mb-4">
            <h5>Filter Users</h5>
            <form action="AdminPanelServlet" method="get">
                <div class="row g-2">
                    <div class="col-md-4">
                        <input type="text" name="search" class="form-control" placeholder="Search by name or email" required>
                    </div>
                    <div class="col-md-3">
                         <select name="role" class="form-select">
                            <option value="">All roles</option>
                            <option value="employer">Employer</option>
                            <option value="user">User</option>
                         </select>
                    </div>
                    <div class="col-md-3">
                        <select name="status" class="form-select">
                            <option value="">All status</option>
                            <option value="active">Active</option>
                            <option value="blocked">Blocked</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-login">Apply Filters</button>
                    </div>
                </div>
            </form>
        </div>
        <!--filter section end-->

        <!--user table-->
        <div class="card p-4 mb-5">
            <h5>📄 Users</h5>
            <table class="table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<UserPojo> users = (List<UserPojo>) request.getAttribute("users");

                    if (users != null && !users.isEmpty()) {
                        for (UserPojo u : users) {
                %>
                <tr  id="user-row-<%= u.getId() %>">
                    <td><%= u.getName() %></td>
                    <td><%= u.getEmail() %></td>
                    <td class="text-capitalize"><%= u.getRole() %></td>
                    <td class="text-capitalize"><%= u.getStatus() %></td>


                    <td>
                        <% boolean isBlocked = u.getStatus().equals("blocked"); %>

                        <form action="UpdateUserStatusServlet" method="post" class="d-inline">
                            <input type="hidden" name="userId" value="<%= u.getId() %>">
                            <button type="submit"
                                    name="action"
                                    value="block"
                                    class="btn btn-danger btn-sm update-btn"
                                    data-userid="<%= u.getId() %>"
                                    <%= isBlocked ? "disabled" : "" %>>
                                Block
                            </button>
                        </form>

                        <form action="UpdateUserStatusServlet" method="post" class="d-inline">
                            <input type="hidden" name="userId" value="<%= u.getId() %>">
                            <button type="submit"
                                    name="action"
                                    value="unblock"
                                    class="btn btn-success btn-sm update-btn"
                                    data-userid="<%= u.getId() %>"
                                    <%= !isBlocked ? "disabled" : "" %>>
                                Unblock
                            </button>
                        </form>
                    </td>

                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="5" class="text-center text-warning">No Users Found</td>
                </tr>
                <% } %>
                </tbody>

            </table>
        </div>
        <!-- user table end-->

        <!--manage job listing table-->
        <div class="card p-5 mb-4">
            <h5>Manage Job Listing</h5>
            <table class="table">
                <thead>
                    <tr>
                        <th>Job Title</th>
                        <th>Company</th>
                        <th>Applicants</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<JobPojo> jobs = (List<JobPojo>) request.getAttribute("jobs");

                    if (jobs != null && !jobs.isEmpty()) {
                        for (JobPojo j : jobs) {
                %>
                <tr>
                    <td><%= j.getTitle() %></td>
                    <td><%= j.getCompany() %></td>
                    <td><%= j.getApplicantCount() %></td>
                    <td>
                        <form action="RemoveJobServlet" method="get">
                            <input type="hidden" name="jobId" value="<%= j.getId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="4" class="text-center text-warning">No jobs found</td>
                </tr>
                <% } %>
                </tbody>

            </table>
        </div>
        <!--manage job listing table end-->
    </main>
<%@ include file="includes/footer.jsp" %>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {

        const successAlert = document.querySelector(".alert-success");
        if (successAlert) {
            setTimeout(() => {
                successAlert.style.transition = "0.5s";
                successAlert.style.opacity = "0";
            }, 2500);
        }

        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has("success") && urlParams.get("success").includes("status")) {

            const lastUpdatedId = sessionStorage.getItem("lastUserUpdated");
            if (lastUpdatedId) {
                const row = document.querySelector(`#user-row-${lastUpdatedId}`);
                if (row) {
                    row.style.backgroundColor = "#e7ffe7";
                    row.style.transition = "background-color 1s";
                }
            }
        }

        document.querySelectorAll(".update-btn").forEach(btn => {
            btn.addEventListener("click", () => {
                sessionStorage.setItem("lastUserUpdated", btn.dataset.userid);
            });
        });
    });
</script>

</body>
</html>