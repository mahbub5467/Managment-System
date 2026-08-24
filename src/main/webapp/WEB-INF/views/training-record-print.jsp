<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Training Record Print - CAAB</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">


    <!-- CAAB CSS -->
    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/training-record-print.css">

</head>

<body>

<div class="page">

    <!-- ================= HEADER ================= -->

    <div class="header">

        <img
                src="${pageContext.request.contextPath}/resources/images/caab-logo.jpg"
                class="logo"
                alt="CAAB Logo">

        <div class="header-text">

            <div class="header-title">
                Civil Aviation Authority of Bangladesh
            </div>

            <div class="header-subtitle">
                HEADQUARTERS(0001)
            </div>

        </div>

    </div>


    <!-- ================= TITLE ================= -->

    <div class="document-title">

        <h1>
            Inspector Training Record
        </h1>

        <p>
            Approved Training Record
        </p>

    </div>


    <!-- ================= STATUS ================= -->

    <div class="status-area">

        <span class="approved">
            APPROVED
        </span>

    </div>


    <!-- ================= EMPLOYEE INFORMATION ================= -->

    <div class="section-title">
        Employee Information
    </div>

    <table class="info-table">

        <tr>

            <td class="label">
                Employee ID
            </td>

            <td class="value">
                ${record.employeeId}
            </td>

            <td class="label">
                Employee Name
            </td>

            <td class="value">
                ${record.employeeName}
            </td>

        </tr>

        <tr>

            <td class="label">
                Designation
            </td>

            <td class="value">
                ${record.designation}
            </td>

            <td class="label">
                Training Type
            </td>

            <td class="value">
                ${record.trainingType}
            </td>

        </tr>

    </table>


    <!-- ================= TRAINING INFORMATION ================= -->

    <div class="section-title">
        Training Information
    </div>

    <table class="info-table">

        <tr>

            <td class="label">
                Course
            </td>

            <td class="value">
                ${record.courseTitle}
            </td>

            <td class="label">
                Training Date
            </td>

            <td class="value">
                ${record.trainingDate}
            </td>

        </tr>

        <tr>

            <td class="label">
                Certification
            </td>

            <td class="value">

                <c:choose>

                    <c:when test="${record.certification == 'yes'}">
                        Yes
                    </c:when>

                    <c:when test="${record.certification == 'no'}">
                        No
                    </c:when>

                    <c:otherwise>
                        ${record.certification}
                    </c:otherwise>

                </c:choose>

            </td>

            <td class="label">
                Assessment Status
            </td>

            <td class="value">
                APPROVED
            </td>

        </tr>

    </table>




    <!-- ================= SIGNATURE ================= -->

    <div class="signature-area">

        <div class="signature">

            <div class="signature-line"></div>

            <div class="signature-text">
                Training Officer
            </div>

        </div>


        <div class="signature">

            <div class="signature-line"></div>

            <div class="signature-text">
                Supervisor
            </div>

        </div>


        <div class="signature">

            <div class="signature-line"></div>

            <div class="signature-text">
                Authorized Officer
            </div>

        </div>

    </div>


    <!-- ================= BUTTONS ================= -->

    <div class="print-buttons">

        <button
                type="button"
                class="btn btn-print"
                onclick="window.print()">

            Print

        </button>

        <a
                href="${pageContext.request.contextPath}/training-record"
                class="btn-back">

            Back

        </a>

    </div>

</div>

</body>

</html>