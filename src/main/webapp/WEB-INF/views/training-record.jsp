<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Training Record - CAAB</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- Training Record CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/training-record.css">
</head>

<body>

<!-- HEADER -->
<header class="top-header">
    <div class="brand">
        <img src="${pageContext.request.contextPath}/resources/images/caab-logo.png" class="brand-logo" alt="CAAB Logo">
        <div class="brand-text">
            <div class="brand-title">Civil Aviation Authority of Bangladesh</div>
            <div class="brand-subtitle">FSR</div>
        </div>
    </div>

    <div class="header-right">
        Logged on | Day Opened on: <span id="dayOpenedDate"></span> | Server Date: <span id="serverDate"></span>
        <br>
        Meteorological Data | Sunrise | Sunset
    </div>
</header>

<!-- NAVBAR -->
<nav class="nav-bar">
    <a href="${pageContext.request.contextPath}/" class="home-link">
        <span class="home-icon"><i class="fa-solid fa-house"></i></span>
        Home
    </a>

    <div class="nav-right">
        <div class="nav-circle"><i class="fa-solid fa-user"></i></div>
        <div class="nav-circle"><i class="fa-solid fa-rotate"></i></div>
        <div class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout';">
            <i class="fa-solid fa-right-from-bracket"></i>&nbsp;&nbsp;Logout
        </div>
    </div>
</nav>

<!-- MAIN WRAPPER -->
<div class="main-wrapper">

    <!-- SIDEBAR -->
    <aside class="sidebar no-print">
        <!-- ১. Always Blue (Home/Title Link) -->
        <a href="${pageContext.request.contextPath}/training" class="sidebar-item">
            CAAB Inspector Training Records
        </a>

        <!-- ২. বর্তমানে Active (Supervisor Assessment) -->
        <a href="${pageContext.request.contextPath}/training/supervisor-assessment" class="sidebar-item">
            Supervisor Assessment
        </a>

        <!-- ৩. Normal Link -->
        <a href="${pageContext.request.contextPath}/training/training-record" class="sidebar-item active">
            Training Records
        </a>

        <!-- ৪. Normal Link -->
        <a href="${pageContext.request.contextPath}/training/training-records-report" class="sidebar-item">
            Training Records Report
        </a>
    </aside>
    </aside>

    <!-- CONTENT -->
    <main class="content">


        <!-- CONTENT CARD -->
        <div class="content-card">

            <div class="card-header" style="flex-direction: column; align-items: flex-start; gap: 15px;">
                <div style="display: flex; justify-content: space-between; width: 100%; align-items: center;">
                    <span class="card-header-title">CAAB Inspector Training Records</span>

                    <!-- TABLE SEARCH -->
                    <div class="header-actions">
                        <div class="table-search">
                            <i class="fa-solid fa-magnifying-glass search-icon"></i>
                            <input type="text" id="tableSearch" class="search-input" placeholder="Search records..." autocomplete="off">
                            <button type="button" id="clearSearch" class="clear-search" onclick="clearTableSearch()" aria-label="Clear search">
                                <i class="fa-solid fa-xmark"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- RADIO BUTTON FILTER FOR TRAINING TYPE -->
                <div class="training-filter-radio-group" style="display: flex; gap: 15px; flex-wrap: wrap; align-items: center; font-size: 14px;">
                    <strong style="color: #334b5b;">Filter by Training Type:</strong>

                    <label style="cursor: pointer;"><input type="radio" name="trainingTypeFilter" value="all" checked onchange="filterTableByTrainingType(this.value)"> All</label>
                    <label style="cursor: pointer;"><input type="radio" name="trainingTypeFilter" value="initial" onchange="filterTableByTrainingType(this.value)"> Initial Training</label>
                    <label style="cursor: pointer;"><input type="radio" name="trainingTypeFilter" value="ojt" onchange="filterTableByTrainingType(this.value)"> OJT</label>
                    <label style="cursor: pointer;"><input type="radio" name="trainingTypeFilter" value="recurrent" onchange="filterTableByTrainingType(this.value)"> Recurrent Training</label>
                    <label style="cursor: pointer;"><input type="radio" name="trainingTypeFilter" value="specialized" onchange="filterTableByTrainingType(this.value)"> Specialized Training</label>
                    <label style="cursor: pointer;"><input type="radio" name="trainingTypeFilter" value="previous" onchange="filterTableByTrainingType(this.value)"> Previous Training</label>
                </div>
            </div>

            <!-- RECORD SUMMARY COUNTER -->
            <div class="record-summary">
                <div class="summary-left">
                    <i class="fa-solid fa-list-check"></i>
                    <span>Approved Training Records</span>
                </div>

                <span class="summary-count" id="recordCount">
                    <c:out value="${not empty records ? records.size() : 0}"/>
                </span>
            </div>

            <!-- TABLE WRAPPER -->
            <div class="table-wrapper">
                <table class="training-table" id="trainingTable">
                    <thead>
                    <tr>
                        <th class="col-sl">#</th>
                        <th>Employee ID</th>
                        <th>Employee Name</th>
                        <th>Designation</th>
                        <th>Training Type</th>
                        <th class="col-course">Course</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Certificate Date</th>
                        <th>Assessment Status</th>
                        <th>Supervisor Remarks</th>
                        <th>Certificate</th>
                        <th class="col-print">Print</th>
                    </tr>
                    </thead>

                    <tbody id="trainingTableBody">
                    <c:choose>
                        <c:when test="${not empty records}">
                            <c:forEach var="record" items="${records}" varStatus="status">
                                <tr class="training-row" data-training-type="${record.trainingType}">

                                    <td class="text-center row-number">${status.index + 1}</td>

                                    <td>
                                        <span class="employee-id"><c:out value="${record.employeeId}"/></span>
                                    </td>

                                    <td>
                                        <span class="employee-name"><c:out value="${record.employeeName}"/></span>
                                    </td>

                                    <td><c:out value="${record.designation}"/></td>

                                    <td>
                                        <span class="training-type"><c:out value="${record.trainingType}"/></span>
                                    </td>

                                    <!-- Course Title Column -->
                                    <td class="course-cell">
                                        <c:choose>
                                            <c:when test="${not empty record.courseTitle}">
                                                <c:out value="${record.courseTitle}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${record.trainingDescription}"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Start Date -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty record.initialTrainingDate}">
                                                <c:out value="${record.initialTrainingDate}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${record.trainingDate}"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- End Date -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty record.ojtDate}">
                                                <c:out value="${record.ojtDate}"/>
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Certificate Date -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty record.certificateDate}">
                                                <span class="certificate-date"><c:out value="${record.certificateDate}"/></span>
                                            </c:when>
                                            <c:otherwise><span class="muted">N/A</span></c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Assessment Status Column -->
                                    <td>
                                        <span class="status status-approved">
                                            <i class="fa-solid fa-circle-check"></i>
                                            <c:out value="${not empty record.assessmentStatus ? record.assessmentStatus : 'Approved'}"/>
                                        </span>
                                    </td>

                                    <!-- Supervisor Remarks Column -->
                                    <td class="remarks-cell">
                                        <c:choose>
                                            <c:when test="${not empty record.comment}">
                                                <c:out value="${record.comment}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="muted">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Certificate Link -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty record.certificateFileName}">
                                                <a href="${pageContext.request.contextPath}/certificate/${record.id}" target="_blank" class="btn btn-certificate">
                                                    <i class="fa-solid fa-file-pdf"></i> View
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="no-certificate">
                                                    <i class="fa-solid fa-file-circle-xmark"></i> No Certificate
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Print Button -->
                                    <td class="no-print text-center">
                                        <button type="button" class="btn btn-print" onclick="printRecord('${record.id}')">
                                            <i class="fa-solid fa-print"></i> Print
                                        </button>
                                    </td>

                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="13" class="empty">
                                    <div class="empty-icon"><i class="fa-solid fa-folder-open"></i></div>
                                    <div class="empty-title">No Approved Training Records Found</div>
                                    <div class="empty-text">There are currently no approved CAAB Inspector Training Records available.</div>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>

                    <tr id="noSearchResult" class="no-search-result" style="display:none;">
                        <td colspan="13" class="text-center" style="padding: 20px;">
                            <i class="fa-solid fa-magnifying-glass"></i> No matching training records found.
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>

    </main>

</div>

<!-- FOOTER -->
<footer class="footer">
    CAAB ICT &amp; e-Governance Project Portal, version:0.2.1.1, Copyright &copy; Civil Aviation Authority Bangladesh, 2026 All rights reserved.<br>
    System Managed by Simec System Limited.
</footer>

<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/training-record.js"></script>

</body>
</html>