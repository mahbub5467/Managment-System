<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>

  <title>Employee List</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

  <div class="card shadow">

    <div class="card-header bg-success text-white d-flex justify-content-between">

      <h3>Employee List</h3>

      <a href="/employee/add" class="btn btn-light">
        Add Employee
      </a>

    </div>

    <div class="card-body">

      <table class="table table-bordered table-striped table-hover">

        <thead class="table-dark">

        <tr>

          <th>ID</th>
          <th>Code</th>
          <th>Name</th>
          <th>Department</th>
          <th>Designation</th>
          <th>Basic Salary</th>
          <th>Status</th>
          <th width="180">Action</th>

        </tr>

        </thead>

        <tbody>

        <c:forEach items="${employees}" var="emp">

          <tr>

            <td>${emp.employeeId}</td>

            <td>${emp.employeeCode}</td>

            <td>${emp.employeeName}</td>

            <td>${emp.department}</td>

            <td>${emp.designation}</td>

            <td>${emp.basicSalary}</td>

            <td>${emp.status}</td>

            <td>

              <a href="/employee/edit/${emp.employeeId}"
                 class="btn btn-warning btn-sm">

                Edit

              </a>

              <a href="/employee/delete/${emp.employeeId}"
                 class="btn btn-danger btn-sm"
                 onclick="return confirm('Are you sure you want to delete this employee?')">

                Delete

              </a>

            </td>

          </tr>

        </c:forEach>

        </tbody>

      </table>

    </div>

  </div>

</div>

</body>
</html>