<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        Supervisor Assessment - CAAB Inspector Training Record
    </title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/supervisor-assessment.css">

</head>


<body>


<!-- =====================================================
     HEADER
====================================================== -->

<header class="top-header">

    <div class="brand">

        <img
                src="${pageContext.request.contextPath}/resources/images/caab-logo.jpg"
                class="brand-logo"
                alt="CAAB Logo">

        <div>

            <div class="brand-title">
                Civil Aviation Authority of Bangladesh
            </div>

            <div class="brand-subtitle">
                HEADQUARTERS(0001)
            </div>

        </div>

    </div>


    <div class="header-right">

        Logged on | Day Opened on: 11-Aug-2026 |
        Server Date: 11-Aug-2026

        <br>

        Meteorological Data | Sunrise: | Sunset:

    </div>

</header>



<!-- =====================================================
     NAVIGATION
====================================================== -->

<nav class="nav-bar">

    <a
            href="${pageContext.request.contextPath}/"
            class="home-link">

        <span class="home-icon">

            <i class="fa-solid fa-house"></i>

        </span>

        Home

    </a>


    <div class="nav-right">

        <div class="nav-circle">

            <i class="fa-solid fa-user"></i>

        </div>


        <div class="nav-circle">

            <i class="fa-solid fa-rotate"></i>

        </div>


        <div
                class="logout"
                onclick="window.location.href='${pageContext.request.contextPath}/logout';">

            <i class="fa-solid fa-right-from-bracket"></i>

            &nbsp;&nbsp;

            Logout

        </div>

    </div>

</nav>



<!-- =====================================================
     MAIN
====================================================== -->

<div class="main-wrapper">


    <!-- =================================================
         SIDEBAR
    ================================================== -->

    <aside class="sidebar">

        <div class="sidebar-title">

            CAAB Inspector Training

            <br>

            Record

        </div>


        <a
                href="${pageContext.request.contextPath}/supervisor-assessment"
                class="sidebar-item active">

            <i class="fa-solid fa-user-check"></i>

            Supervisor Assessment

        </a>

        <a
                href="${pageContext.request.contextPath}/training-record"
                class="sidebar-item active">

            <i class="fa-solid fa-clipboard-list"></i>

            Training Record

        </a>

    </aside>



    <!-- =================================================
         CONTENT
    ================================================== -->

    <main class="content">


        <h1 class="page-title">

            Supervisor Assessment

        </h1>


        <div class="page-description">

            Review submitted CAAB Inspector Training Records,
            verify supporting certificates and assess the submitted
            training information.

        </div>



        <!-- =================================================
             CONTENT CARD
        ================================================== -->

        <div class="content-card">


            <!-- =================================================
                 CARD HEADER
            ================================================== -->
            <div class="card-header">

                <div class="card-header-left">



                    <span class="card-header-title">
            Supervisor Assessment
        </span>

                </div>


                <div class="card-header-actions">

                    <div class="table-search">

                        <i class="fa-solid fa-magnifying-glass"></i>

                        <input
                                type="text"
                                id="tableSearch"
                                placeholder="Search records..."
                                autocomplete="off">

                        <button
                                type="button"
                                class="search-clear"
                                onclick="clearTableSearch()">

                            <i class="fa-solid fa-xmark"></i>

                        </button>

                    </div>


<%--                    <a--%>
<%--                            href="${pageContext.request.contextPath}/training"--%>
<%--                            class="back-btn">--%>

<%--                        <i class="fa-solid fa-arrow-left"></i>--%>

<%--                        Back--%>

<%--                    </a>--%>

                </div>

            </div>



            <!-- =================================================
                 TABLE
            ================================================== -->

            <div class="table-wrapper">

                <table class="assessment-table">


                    <thead>

                    <tr>

                        <th>
                            #
                        </th>


                        <th>
                            Employee ID
                        </th>


                        <th>
                            Employee Name
                        </th>


                        <th>
                            Designation
                        </th>


                        <th>
                            Training Type
                        </th>


                        <th>
                            Course
                        </th>


                        <th>
                            Training Date
                        </th>


                        <!-- NEW -->
                        <th>
                            Certificate
                        </th>


                        <th>
                            Certification
                        </th>


                        <th>
                            Certificate Date
                        </th>


                        <th>
                            Assessment
                        </th>

                    </tr>

                    </thead>


                    <tbody>

                    <c:choose>

                        <c:when test="${not empty records}">

                            <c:forEach var="record"
                                       items="${records}"
                                       varStatus="status">

                                <tr>

                                    <td>
                                            ${status.index + 1}
                                    </td>

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

                                            <c:when test="${record.trainingType eq 'initial'}">
                                                <c:out value="${record.courseTitle}"/>
                                            </c:when>

                                            <c:otherwise>
                                                <c:out value="${record.trainingDescription}"/>
                                            </c:otherwise>

                                        </c:choose>
                                    </td>

                                    <td>

                                        <c:choose>

                                            <c:when test="${record.trainingType eq 'initial'}">
                                                <c:out value="${record.initialTrainingDate}"/>
                                            </c:when>

                                            <c:otherwise>
                                                <c:out value="${record.trainingDate}"/>
                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td>

                                        <c:choose>

                                            <c:when test="${record.certification eq 'yes'}">

                            <span class="status status-approved">
                                YES
                            </span>

                                            </c:when>

                                            <c:when test="${record.certification eq 'no'}">

                            <span class="status status-rejected">
                                NO
                            </span>

                                            </c:when>

                                            <c:otherwise>

                            <span class="status status-pending">
                                <c:out value="${record.certification}"/>
                            </span>

                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td>

                                        <c:choose>

                                            <c:when test="${not empty record.certificateFileName}">

                                                <a
                                                        href="${pageContext.request.contextPath}/supervisor-assessment/certificate/${record.id}"
                                                        target="_blank"
                                                        class="btn btn-certificate">

                                                    <i class="fa-solid fa-file-pdf"></i>
                                                    View

                                                </a>

                                            </c:when>

                                            <c:otherwise>

                            <span class="no-certificate">

                                <i class="fa-solid fa-file-circle-xmark"></i>
                                No Certificate

                            </span>

                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td>

                                        <c:choose>

                                            <c:when test="${not empty record.certificateDate}">

                            <span class="certificate-date">
                                <c:out value="${record.certificateDate}"/>
                            </span>

                                            </c:when>

                                            <c:otherwise>

                            <span class="no-certificate-date">
                                N/A
                            </span>

                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td>

                                        <button
                                                type="button"
                                                class="btn btn-assessment"
                                                onclick="openAssessmentModal(
                                                        '${record.id}',
                                                        '${record.employeeId}',
                                                        '${record.employeeName}'
                                                        )">

                                            <i class="fa-solid fa-clipboard-check"></i>
                                            Action

                                        </button>

                                    </td>

                                </tr>

                            </c:forEach>

                        </c:when>

                        <c:otherwise>

                            <tr>

                                <td colspan="11" class="empty">

                                    <div class="empty-icon">
                                        <i class="fa-solid fa-folder-open"></i>
                                    </div>

                                    <div class="empty-title">
                                        No Training Records Found
                                    </div>

                                    <div class="empty-text">
                                        There are currently no submitted
                                        training records available for
                                        supervisor assessment.
                                    </div>

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

    CAAB ICT & e-Governance Project Portal,
    version:0.2.1.1,
    Copyright © Civil Aviation Authority Bangladesh,
    2026 All rights reserved.

    <br>

    System Managed by Simec System Limited.

</footer>



<!-- =====================================================
     ASSESSMENT MODAL
====================================================== -->

<div
        id="assessmentModal"
        class="modal">


    <div class="modal-content">


        <!-- =================================================
             MODAL HEADER
        ================================================== -->

        <div class="modal-header">


            <div class="modal-title">

                <i
                        class="fa-solid fa-clipboard-check">
                </i>

                Supervisor Assessment

            </div>


            <button
                    type="button"
                    class="close"
                    onclick="closeAssessmentModal()">

                &times;

            </button>


        </div>



        <!-- =================================================
             FORM
        ================================================== -->

        <form
                id="assessmentForm"
                method="post">


            <!-- =================================================
                 MODAL BODY
            ================================================== -->

            <div class="modal-body">


                <div class="modal-info">


                    <!-- EMPLOYEE ID -->

                    <div class="modal-info-row">

                        <span class="modal-info-label">

                            Employee ID

                        </span>


                        <span
                                id="modalEmployeeId"
                                class="modal-info-value">

                        </span>

                    </div>



                    <!-- EMPLOYEE NAME -->

                    <div class="modal-info-row">

                        <span class="modal-info-label">

                            Employee Name

                        </span>


                        <span
                                id="modalEmployeeName"
                                class="modal-info-value">

                        </span>

                    </div>


                </div>



                <!-- =================================================
                     REMARKS
                ================================================== -->

                <label
                        class="remarks-label"
                        for="remarks">

                    Supervisor Remarks

                    <span class="required">

                        *

                    </span>

                </label>


                <textarea
                        name="comment"
                        id="remarks"
                        class="remarks"
                        placeholder="Write your assessment remarks..."
                        required></textarea>


            </div>



            <!-- =================================================
                 MODAL FOOTER
            ================================================== -->

            <div class="modal-footer">


                <button
                        type="button"
                        class="btn btn-cancel"
                        onclick="closeAssessmentModal()">

                    <i
                            class="fa-solid fa-xmark">
                    </i>

                    Cancel

                </button>

                <button
                        type="button"
                        class="btn btn-approve"
                        onclick="submitAssessment('approve')">

                    <i
                            class="fa-solid fa-check">
                    </i>

                    Assest

                </button>


            </div>


        </form>


    </div>

</div>



<!-- =====================================================
     JAVASCRIPT
====================================================== -->

<script
        src="${pageContext.request.contextPath}/supervisor-assessment.js">
</script>


</body>

</html>