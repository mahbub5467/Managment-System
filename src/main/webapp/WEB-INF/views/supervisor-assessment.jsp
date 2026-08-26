<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Supervisor Assessment - CAAB Inspector Training Record</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/supervisor-assessment.css">
</head>

<body>

<!-- =====================================================
     HEADER
====================================================== -->
<header class="top-header">
    <div class="brand">
        <img src="${pageContext.request.contextPath}/resources/images/caab-logo.png" class="brand-logo" alt="CAAB Logo">
        <div>
            <div class="brand-title">Civil Aviation Authority of Bangladesh</div>
            <div class="brand-subtitle">FSR</div>
        </div>
    </div>

    <div class="header-right">
        Logged on | Day Opened on: <span id="dayOpenedDate"></span> | Server Date: <span id="serverDate"></span>
        <br>
        Meteorological Data | Sunrise: | Sunset:
    </div>
</header>

<!-- =====================================================
     NAVIGATION
====================================================== -->
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

<!-- =====================================================
     MAIN WRAPPER
====================================================== -->
<div class="main-wrapper">

    <aside class="sidebar no-print">
        <!-- ১. Always Blue Header Link -->
        <a href="${pageContext.request.contextPath}/training" class="sidebar-item">
            CAAB Inspector Training Records
        </a>

        <!-- ২. Active Link -->
        <a href="${pageContext.request.contextPath}/training/supervisor-assessment" class="sidebar-item active">
            Supervisor Assessment
        </a>

        <!-- ৩. Normal Link -->
        <a href="${pageContext.request.contextPath}/training/training-record" class="sidebar-item">
            Training Records
        </a>

        <!-- ৪. Normal Link -->
        <a href="${pageContext.request.contextPath}/training/training-records-report" class="sidebar-item">
            Training Records Report
        </a>
    </aside>

    <!-- CONTENT -->
    <main class="content">

        <h1 class="page-title">Supervisor Assessment</h1>

        <div class="page-description">
            Review submitted CAAB Inspector Training Records, verify supporting certificates and assess the submitted training information.
        </div>

        <!-- =================================================
             CONTENT CARD
        ================================================== -->
        <div class="content-card">

            <!-- CARD HEADER & FILTER AREA -->
            <div class="card-header" style="flex-direction: column; align-items: flex-start; gap: 15px;">

                <div style="display: flex; justify-content: space-between; width: 100%; align-items: center;">
                    <span class="card-header-title">Supervisor Assessment</span>

                    <!-- TABLE SEARCH -->
                    <div class="table-search">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" id="tableSearch" placeholder="Search records..." autocomplete="off">
                        <button type="button" class="search-clear" onclick="clearTableSearch()">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </div>

                <!-- TRAINING TYPE RADIO BUTTON FILTER -->
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

            <!-- =================================================
                 TABLE
            ================================================== -->
            <div class="table-wrapper">
                <table class="assessment-table" id="assessmentTable">

                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Employee ID</th>
                        <th>Employee Name</th>
                        <th>Designation</th>
                        <th>Training Type</th>
                        <th>Course</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Certificate</th>
                        <th>Assessment</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:choose>
                        <c:when test="${not empty records}">
                            <c:forEach var="record" items="${records}" varStatus="status">
                                <tr data-training-type="${record.trainingType}">

                                    <td>${status.index + 1}</td>

                                    <td>
                                        <span class="employee-id">
                                            <c:out value="${record.employeeId}"/>
                                        </span>
                                    </td>

                                    <td>
                                        <span class="employee-name">
                                            <c:out value="${record.employeeName}"/>
                                        </span>
                                    </td>

                                    <td>
                                        <c:out value="${record.designation}"/>
                                    </td>

                                    <td>
                                        <span class="training-type">
                                            <c:out value="${record.trainingType}"/>
                                        </span>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty record.courseTitle}">
                                                <c:out value="${record.courseTitle}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:out value="${record.trainingDescription}"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Start Date Column -->
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

                                    <!-- End Date Column -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty record.ojtDate}">
                                                <c:out value="${record.ojtDate}"/>
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Certificate View Column -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty record.certificateFileName}">
                                                <a href="${pageContext.request.contextPath}/training/supervisor-assessment/certificate/${record.id}"
                                                   target="_blank"
                                                   class="btn btn-certificate">
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

                                    <!-- Action Button -->
                                    <td>
                                        <button type="button" class="btn btn-assessment"
                                                onclick="openAssessmentModal('${record.id}', '${record.employeeId}', '${record.employeeName}')">
                                            <i class="fa-solid fa-clipboard-check"></i> Action
                                        </button>
                                    </td>

                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="10" class="empty">
                                    <div class="empty-icon"><i class="fa-solid fa-folder-open"></i></div>
                                    <div class="empty-title">No Training Records Found</div>
                                    <div class="empty-text">There are currently no submitted training records available for supervisor assessment.</div>
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

<!-- =====================================================
     FOOTER
====================================================== -->
<footer class="footer">
    CAAB ICT & e-Governance Project Portal, version:0.2.1.1, Copyright © Civil Aviation Authority Bangladesh, 2026 All rights reserved.<br>
    System Managed by Simec System Limited.
</footer>

<!-- =====================================================
     ASSESSMENT MODAL WITH DROPDOWN
====================================================== -->
<div id="assessmentModal" class="modal">
    <div class="modal-content">

        <!-- MODAL HEADER -->
        <div class="modal-header">
            <div class="modal-title">
                <i class="fa-solid fa-clipboard-check"></i> Supervisor Assessment
            </div>
            <button type="button" class="close" onclick="closeAssessmentModal()">&times;</button>
        </div>

        <!-- FORM -->
        <form id="assessmentForm" action="${pageContext.request.contextPath}/training/supervisor-assessment/save" method="post">
            <!-- 🎯 dynamically target ID pass করার জন্য Hidden Input -->
            <input type="hidden" id="modalRecordId" name="id" value="" />

            <div class="modal-body">

                <div class="modal-info">
                    <div class="modal-info-row">
                        <span class="modal-info-label">Employee ID</span>
                        <span id="modalEmployeeId" class="modal-info-value"></span>
                    </div>

                    <div class="modal-info-row">
                        <span class="modal-info-label">Employee Name</span>
                        <span id="modalEmployeeName" class="modal-info-value"></span>
                    </div>
                </div>

                <!-- REQUIRED DROPDOWN -->
                <div style="margin-bottom: 15px;">
                    <label for="assessmentStatus" style="display: block; font-weight: 600; margin-bottom: 5px; color: #334b5b;">
                        Assessment Status <span class="required" style="color: red;">*</span>
                    </label>
                    <select id="assessmentStatus" name="assessmentStatus" class="form-select" required style="width: 100%; height: 40px; padding: 5px 10px; border-radius: 6px; border: 1px solid #ccc;">
                        <option value="">-- Select Assessment Status --</option>
                        <option value="Satisfactory">Satisfactory</option>
                        <option value="Unsatisfactory">Unsatisfactory</option>
                        <option value="Needs Review">Needs Review</option>
                        <option value="Approved">Approved</option>

                    </select>
                </div>

                <!-- OPTIONAL REMARKS -->
                <label class="remarks-label" for="remarks" style="display: block; font-weight: 600; margin-bottom: 5px; color: #334b5b;">
                    Supervisor Remarks
                </label>
                <textarea name="comment" id="remarks" class="remarks" placeholder="Write your assessment remarks (Optional)..."></textarea>

            </div>

            <!-- MODAL FOOTER -->
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" onclick="closeAssessmentModal()">
                    <i class="fa-solid fa-xmark"></i> Cancel
                </button>
                <button type="submit" class="btn btn-approve">
                    <i class="fa-solid fa-check"></i> Submit Assessment
                </button>
            </div>
        </form>

    </div>
</div>

<!-- Context Path Script for JavaScript file -->
<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/supervisor-assessment.js"></script>

</body>
</html>