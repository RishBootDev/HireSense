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

        <!--filter section start-->
        <div class="p-4 mb-4">
            <h5>Filter Users</h5>
            <form action="" method="get">
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
                    <tr>
                        <td>Mohnish</td>
                        <td>mohnish@gmail.com</td>
                        <td>Employer</td>
                        <td>Active</td>
                        <td>
                            <a href="#" class="btn btn-danger">Block</a>
                            <a href="#" class="btn btn-success">Unblock</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" class="text-center text-warning">No Users Found</td>
                    </tr>
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
                    <tr>
                        <td>Software developer</td>
                        <td>A2infotech</td>
                        <td>5</td>
                        <td>
                            <a href="#" class="btn btn-danger">Remove</a>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4" class="text-center text-warning">No jobs found</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <!--manage job listing table end-->
    </main>
<%@ include file="includes/footer.jsp" %>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>