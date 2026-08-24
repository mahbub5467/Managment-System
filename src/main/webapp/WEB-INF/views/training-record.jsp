<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Training Record - CAAB</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/training-record.css">

</head>


<body>


<header class="top-header">

    <div class="brand">

        <img
                src="${pageContext.request.contextPath}/resources/images/caab-logo.jpg"
                class="brand-logo"
                alt="CAAB Logo">

        <div class="brand-text">

            <div class="brand-title">
                Civil Aviation Authority of Bangladesh
            </div>

            <div class="brand-subtitle">
                HEADQUARTERS(0001)
            </div>

        </div>

    </div>


    <div class="header-right">

        Logged on | Server Date

        <br>

        Meteorological Data | Sunrise | Sunset

    </div>

</header>



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



<div class="main-wrapper">


    <aside class="sidebar">

        <div class="sidebar-title">

            CAAB Inspector Training
            <br>
            Record

        </div>


        <a
                href="${pageContext.request.contextPath}/supervisor-assessment"
                class="sidebar-item">

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



    <main class="content">

        <h1 class="page-title">
            Training Record
        </h1>


        <div class="page-description">

            Approved CAAB Inspector Training Records.

        </div>



        <div class="content-card">


            <div class="card-header">

                <div class="card-header-left">



                    <span class="card-header-title">

                        Approved CAAB Inspector Training Records

                    </span>

                </div>


                <div class="header-actions">

                    <div class="table-search">

                        <i class="fa-solid fa-magnifying-glass search-icon"></i>

                        <input
                                type="text"
                                id="tableSearch"
                                class="search-input"
                                placeholder="Search records..."
                                autocomplete="off">

                        <button
                                type="button"
                                id="clearSearch"
                                class="clear-search"
                                onclick="clearTableSearch()"
                                aria-label="Clear search">

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



            <div class="record-summary">

                <div class="summary-left">

                    <i class="fa-solid fa-list-check"></i>

                    <span>
                        Approved Training Records
                    </span>

                </div>


                <span
                        class="summary-count"
                        id="recordCount">

                    0

                </span>

            </div>



            <div class="table-wrapper">

                <table class="training-table">

                    <thead>

                    <tr>

                        <th class="col-sl">#</th>

                        <th>Employee ID</th>

                        <th>Employee Name</th>

                        <th>Designation</th>

                        <th>Training Type</th>

                        <th>Course</th>

                        <th>Training Date</th>

                        <th>Certificate Date</th>

                        <th>Certification</th>

                        <th>Certificate</th>

                        <th class="col-print">Print</th>

                    </tr>

                    </thead>


                    <tbody id="trainingTableBody">

                    <c:choose>

                        <c:when test="${not empty records}">

                            <c:forEach
                                    var="record"
                                    items="${records}"
                                    varStatus="status">

                                <tr class="training-row">

                                    <td class="text-center row-number">
                                            ${status.index + 1}
                                    </td>


                                    <td>

                                        <span class="employee-id">

                                            <c:out
                                                    value="${record.employeeId}"/>

                                        </span>

                                    </td>


                                    <td>

                                        <span class="employee-name">

                                            <c:out
                                                    value="${record.employeeName}"/>

                                        </span>

                                    </td>


                                    <td>

                                        <c:out
                                                value="${record.designation}"/>

                                    </td>


                                    <td>

                                        <span class="training-type">

                                            <c:out
                                                    value="${record.trainingType}"/>

                                        </span>

                                    </td>


                                    <td class="course-cell">

                                        <c:out
                                                value="${record.courseTitle}"/>

                                    </td>


                                    <td>

                                        <c:out
                                                value="${record.trainingDate}"/>

                                    </td>


                                    <td>

                                        <c:choose>

                                            <c:when
                                                    test="${not empty record.certificateDate}">

                                                <span class="certificate-date">

                                                    <c:out
                                                            value="${record.certificateDate}"/>

                                                </span>

                                            </c:when>

                                            <c:otherwise>

                                                <span class="muted">
                                                    N/A
                                                </span>

                                            </c:otherwise>

                                        </c:choose>

                                    </td>


                                    <td>

                                        <span class="status status-approved">

                                            <i class="fa-solid fa-circle-check"></i>

                                            APPROVED

                                        </span>

                                    </td>


                                    <td>

                                        <c:choose>

                                            <c:when
                                                    test="${not empty record.certificateFileName}">

                                                <a
                                                        href="${pageContext.request.contextPath}/certificate/${record.id}"
                                                        target="_blank"
                                                        class="btn btn-certificate">

                                                    <i class="fa-solid fa-file-pdf"></i>

                                                    View Certificate

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


                                    <td class="no-print text-center">

                                        <button
                                                type="button"
                                                class="btn btn-print"
                                                onclick="printRecord('${record.id}')">

                                            <i class="fa-solid fa-print"></i>

                                            Print

                                        </button>

                                    </td>

                                </tr>

                            </c:forEach>

                        </c:when>


                        <c:otherwise>

                            <tr>

                                <td
                                        colspan="11"
                                        class="empty">

                                    <div class="empty-icon">

                                        <i class="fa-solid fa-folder-open"></i>

                                    </div>


                                    <div class="empty-title">

                                        No Approved Training Records Found

                                    </div>


                                    <div class="empty-text">

                                        There are currently no approved
                                        CAAB Inspector Training Records
                                        available.

                                    </div>

                                </td>

                            </tr>

                        </c:otherwise>

                    </c:choose>


                    <tr
                            id="noSearchResult"
                            class="no-search-result"
                            style="display:none;">

                        <td colspan="11">

                            <i class="fa-solid fa-magnifying-glass"></i>

                            No matching training records found.

                        </td>

                    </tr>

                    </tbody>

                </table>

            </div>

        </div>

    </main>

</div>



<footer class="footer">

    CAAB ICT &amp; e-Governance Project Portal,
    version:0.2.1.1,
    Copyright &copy; Civil Aviation Authority Bangladesh,
    2026 All rights reserved.

    <br>

    System Managed by Simec System Limited.

</footer>

<script
        src="${pageContext.request.contextPath}/training-record.js">
</script>




</body>

</html>