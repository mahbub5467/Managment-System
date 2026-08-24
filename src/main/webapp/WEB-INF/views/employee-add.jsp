<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>

    <title>${employee.employeeId == null ? 'Add Employee' : 'Update Employee'}</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">

            <h3>
                ${employee.employeeId == null ? 'Add Employee' : 'Update Employee'}
            </h3>

        </div>

        <div class="card-body">

            <form action="/employee/save" method="post">

                <!-- Hidden ID -->
                <input type="hidden"
                       name="employeeId"
                       value="${employee.employeeId}">

                <div class="row">

                    <!-- Employee Code -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Employee Code</label>

                        <input type="text"
                               name="employeeCode"
                               value="${employee.employeeCode}"
                               class="form-control"
                               required>

                    </div>

                    <!-- Employee Name -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Employee Name</label>

                        <input type="text"
                               name="employeeName"
                               value="${employee.employeeName}"
                               class="form-control"
                               required>

                    </div>

                    <!-- Father Name -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Father Name</label>

                        <input type="text"
                               name="fatherName"
                               value="${employee.fatherName}"
                               class="form-control">

                    </div>

                    <!-- Mother Name -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Mother Name</label>

                        <input type="text"
                               name="motherName"
                               value="${employee.motherName}"
                               class="form-control">

                    </div>

                    <!-- NID -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">NID</label>

                        <input type="text"
                               name="nid"
                               value="${employee.nid}"
                               class="form-control">

                    </div>

                    <!-- Designation -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Designation</label>

                        <input type="text"
                               name="designation"
                               value="${employee.designation}"
                               class="form-control">

                    </div>

                    <!-- Department -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Department</label>

                        <input type="text"
                               name="department"
                               value="${employee.department}"
                               class="form-control">

                    </div>

                    <!-- Joining Date -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Joining Date</label>

                        <input type="date"
                               name="joiningDate"
                               value="${employee.joiningDate}"
                               class="form-control">

                    </div>

                    <!-- Basic Salary -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Basic Salary</label>

                        <input type="number"
                               step="0.01"
                               name="basicSalary"
                               value="${employee.basicSalary}"
                               class="form-control">

                    </div>

                    <!-- Opening Balance -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Opening Balance</label>

                        <input type="number"
                               step="0.01"
                               name="openingBalance"
                               value="${employee.openingBalance}"
                               class="form-control">

                    </div>

                    <!-- Mobile -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Mobile</label>

                        <input type="text"
                               name="mobile"
                               value="${employee.mobile}"
                               class="form-control">

                    </div>

                    <!-- Email -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Email</label>

                        <input type="email"
                               name="email"
                               value="${employee.email}"
                               class="form-control">

                    </div>

                    <!-- Status -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">Status</label>

                        <select name="status" class="form-select">

                            <option value="Active"
                                    <c:if test="${employee.status=='Active'}">selected</c:if>>
                                Active
                            </option>

                            <option value="Inactive"
                                    <c:if test="${employee.status=='Inactive'}">selected</c:if>>
                                Inactive
                            </option>

                        </select>

                    </div>

                </div>

                <button type="submit" class="btn btn-success">

                    ${employee.employeeId == null ? 'Save Employee' : 'Update Employee'}

                </button>

                <a href="/employee/list" class="btn btn-secondary">

                    Employee List

                </a>

            </form>

        </div>

    </div>

</div>

</body>
</html>