<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Training Records Report - CAAB</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/training.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/training-records-report.css">
</head>

<body>

<!-- HEADER -->
<header class="top-header no-print">
    <img src="${pageContext.request.contextPath}/resources/images/caab-logo.png" class="caab-logo" alt="CAAB Logo">
    <div class="header-title">
        <h1>Civil Aviation Authority of Bangladesh</h1>
        <h2>FSR</h2>
    </div>
    <div class="header-right">
        Logged on | Day Opened on: <span id="dayOpenedDate"></span> | Server Date: <span id="serverDate"></span>
        <br>
        Meteorological Data | Sunrise: | Sunset:
    </div>
</header>

<!-- NAVIGATION -->
<nav class="main-navbar no-print">
    <a href="${pageContext.request.contextPath}/" class="home-link">
        <i class="fa-solid fa-house"></i>
        <span>Home</span>
    </a>

    <div class="nav-right">
        <div class="nav-circle"><i class="fa-solid fa-bell"></i></div>
        <div class="nav-circle"><i class="fa-solid fa-arrows-rotate"></i></div>
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="button" class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout';">
                <i class="fa-solid fa-power-off"></i> Logout
            </button>
        </form>
    </div>
</nav>

<!-- MAIN AREA -->
<div class="main-area">

    <!-- LEFT SIDEBAR -->
    <aside class="sidebar no-print">
        <a href="${pageContext.request.contextPath}/training" class="sidebar-item">
            CAAB Inspector Training Records
        </a>
        <a href="${pageContext.request.contextPath}/training/supervisor-assessment" class="sidebar-item">
            Supervisor Assessment
        </a>
        <a href="${pageContext.request.contextPath}/training/training-record" class="sidebar-item">
            Training Records
        </a>
        <a href="${pageContext.request.contextPath}/training/training-records-report" class="sidebar-item active">
            Training Records Report
        </a>
    </aside>

    <!-- CONTENT AREA -->
    <main class="content">

        <!-- PAGE TITLE -->
        <div class="content-header no-print">
            <div>
                <h1 class="page-title">CAAB Inspector Training Report</h1>
                <div class="page-description">
                    Filter by Employee ID or Divisions to view summary and download inspector training reports.
                </div>
            </div>
        </div>

        <!-- TWO SEARCH OPTIONS FORM -->
        <div class="panel p-4 mb-4 background-white border rounded no-print">
            <form action="${pageContext.request.contextPath}/training/training-records-report" method="get" class="search-vertical-form">

                <!-- 1. Employee ID (EIIN) Row (Optional) -->
                <div class="vertical-form-group">
                    <label for="employeeId" class="vertical-form-label">
                        EIIN
                    </label>
                    <div class="vertical-input-wrapper">
                        <input type="text" id="employeeId" name="employeeId" class="form-control"
                               value="${searchEmployeeId}">
                    </div>
                </div>

                <!-- 2. Divisions Row (Optional) -->
                <div class="vertical-form-group">
                    <label for="department" class="vertical-form-label">
                        Division
                    </label>
                    <div class="vertical-input-wrapper">
                        <select id="department" name="department" class="form-select">
                            <option value="">-- All --</option>
                            <option value="PEL" ${searchDepartment == 'PEL' ? 'selected' : ''}>PEL - Personnel Licensing</option>
                            <option value="OPS" ${searchDepartment == 'OPS' ? 'selected' : ''}>OPS - Flight Operations</option>
                            <option value="AIR" ${searchDepartment == 'AIR' ? 'selected' : ''}>AIR - Airworthiness</option>
                            <option value="ANS" ${searchDepartment == 'ANS' ? 'selected' : ''}>ANS - Air Navigation Services</option>
                            <option value="AGA" ${searchDepartment == 'AGA' ? 'selected' : ''}>AGA - Aerodromes & Ground Aids</option>
                            <option value="LEG" ${searchDepartment == 'LEG' ? 'selected' : ''}>LEG - Legal Documents</option>
                            <option value="ORG" ${searchDepartment == 'ORG' ? 'selected' : ''}>ORG - Organization</option>
                            <option value="SSP" ${searchDepartment == 'SSP' ? 'selected' : ''}>SSP - State Safety Programme</option>
                            <option value="AIG" ${searchDepartment == 'AIG' ? 'selected' : ''}>AIG - Accident Investigation</option>
                        </select>
                    </div>
                </div>

                <!-- Action Buttons Row -->
                <div class="vertical-form-group button-row">
                    <div class="vertical-form-label"></div>
                    <div class="vertical-input-wrapper d-flex gap-2 w-100">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-magnifying-glass"></i> Search
                        </button>

                        <c:if test="${not empty searchEmployeeId or not empty searchDepartment}">
                            <a href="${pageContext.request.contextPath}/training/training-records-report" class="btn btn-secondary">
                                Reset / Show All
                            </a>
                        </c:if>

                        <!-- 🎯 NEW: View ALL PDF Button (Aligned Right) -->
                        <a href="${pageContext.request.contextPath}/training/training-records-report/pdf/all?department=${not empty searchDepartment ? searchDepartment : ''}"
                           target="_blank"
                           class="btn btn-danger fw-bold ms-auto">
                            <i class="fa-solid fa-file-pdf"></i> View All Employee Report
                        </a>
                    </div>
                </div>

            </form>
        </div>

        <!-- INSPECTOR SUMMARY TABLE -->
        <div class="panel border rounded overflow-hidden background-white">
            <div class="table-responsive">
                <table class="table table-bordered table-hover mb-0 align-middle">
                    <thead class="table-primary text-nowrap">
                    <tr>
                        <th class="text-center" style="width: 60px;">SL</th>
                        <th style="width: 150px;">Employee ID</th>
                        <th>Employee Name</th>
                        <th>Designation</th>
                        <th class="text-center" style="width: 150px;">Total Records</th>
                        <th class="text-center" style="width: 180px;">Action / Report</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty inspectorList}">
                            <c:forEach var="emp" items="${inspectorList}" varStatus="status">
                                <tr>
                                    <td class="text-center">${status.index + 1}</td>
                                    <td><strong class="text-primary">${emp.employeeId}</strong></td>
                                    <td class="fw-bold">${emp.employeeName}</td>
                                    <td>${emp.designation}</td>
                                    <td class="text-center">
                                        <span class="badge bg-info text-dark font-size-12">${emp.totalRecords} Trainings</span>
                                    </td>
                                    <td class="text-center">
                                        <!-- Individual PDF View Link -->
                                        <a href="${pageContext.request.contextPath}/training/training-records-report/pdf/${emp.employeeId}"
                                           target="_blank"
                                           class="btn btn-sm btn-danger fw-bold">
                                            <i class="fa-solid fa-file-pdf"></i> View PDF
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">
                                    <i class="fa-solid fa-info-circle me-1"></i> No inspector records found for the selected search criteria.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

    </main>
</div>

<!-- FOOTER -->
<footer class="footer no-print">
    CAAB ICT & e-Governance Project Portal, version:0.2.1.1, Copyright © Civil Aviation Authority Bangladesh, 2026 All rights reserved.<br>
    System Managed by Simec System Limited.
</footer>

<script src="${pageContext.request.contextPath}/training-recordsreport.js"></script>
</body>
</html>