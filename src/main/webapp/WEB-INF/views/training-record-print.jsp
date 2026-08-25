<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Training Record Print - CAAB</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- CAAB CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/training-record-print.css">
</head>

<body>

<div class="page">

    <!-- ================= HEADER ================= -->
    <div class="header">
        <img src="${pageContext.request.contextPath}/resources/images/caab-logo.png" class="logo" alt="CAAB Logo">

        <div class="header-text">
            <div class="header-title">Civil Aviation Authority of Bangladesh</div>
            <div class="header-subtitle">FSR</div>
        </div>
    </div>

    <!-- ================= TITLE ================= -->
    <div class="document-title">
        <h1>Inspector Training Record</h1>
        <p>Approved Training Record</p>
    </div>

    <!-- ================= STATUS ================= -->
    <div class="status-area">
        <span class="approved">
            <c:out value="${not empty assessment.assessmentStatus ? assessment.assessmentStatus : 'APPROVED'}"/>
        </span>
    </div>

    <!-- ================= EMPLOYEE INFORMATION ================= -->
    <div class="section-title">
        Employee Information
    </div>

    <table class="info-table">
        <tr>
            <td class="label">Employee ID</td>
            <td class="value"><c:out value="${record.employeeId}"/></td>

            <td class="label">Employee Name</td>
            <td class="value"><c:out value="${record.employeeName}"/></td>
        </tr>
        <tr>
            <td class="label">Designation</td>
            <td class="value"><c:out value="${record.designation}"/></td>

            <td class="label">Training Type</td>
            <td class="value"style=" text-transform: uppercase;"><c:out value="${record.trainingType}"/></td>
        </tr>
    </table>

    <!-- ================= TRAINING INFORMATION ================= -->
    <div class="section-title">
        Training Information
    </div>

    <table class="info-table">
        <tr>
            <td class="label">Course Title / Description</td>
            <td class="value" colspan="3">
                <c:choose>
                    <c:when test="${not empty record.courseTitle}">
                        <c:out value="${record.courseTitle}"/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${record.trainingDescription}"/>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td class="label">Start Date</td>
            <td class="value">
                <c:choose>
                    <c:when test="${not empty record.initialTrainingDate}">
                        <c:out value="${record.initialTrainingDate}"/>
                    </c:when>
                    <c:otherwise>
                        <c:out value="${record.trainingDate}"/>
                    </c:otherwise>
                </c:choose>
            </td>

            <td class="label">End Date</td>
            <td class="value">
                <c:choose>
                    <c:when test="${not empty record.ojtDate}">
                        <c:out value="${record.ojtDate}"/>
                    </c:when>
                    <c:otherwise>N/A</c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td class="label">Certification</td>
            <td class="value">
                <c:choose>
                    <c:when test="${record.certification eq 'yes'}">Yes</c:when>
                    <c:when test="${record.certification eq 'no'}">No</c:when>
                    <c:otherwise><c:out value="${record.certification}"/></c:otherwise>
                </c:choose>
            </td>

            <td class="label">Certificate Date</td>
            <td class="value">
                <c:choose>
                    <c:when test="${not empty record.certificateDate}">
                        <c:out value="${record.certificateDate}"/>
                    </c:when>
                    <c:otherwise>N/A</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

    <!-- ================= SUPERVISOR ASSESSMENT INFORMATION ================= -->
    <div class="section-title">
        Supervisor Assessment Details
    </div>

    <table class="info-table">
        <tr>
            <td class="label">Assessment Status</td>
            <td class="value">
                <c:out value="${not empty assessment.assessmentStatus ? assessment.assessmentStatus : 'N/A'}"/>
            </td>

        </tr>
        <tr>
            <td class="label">Supervisor Remarks</td>
            <td class="value" colspan="3">
                <c:choose>
                    <c:when test="${not empty assessment.remarks}">
                        <c:out value="${assessment.remarks}"/>
                    </c:when>
                    <c:otherwise>N/A</c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>

    <!-- ================= SIGNATURE ================= -->
    <div class="signature-area">


        <div class="signature">
            <div class="signature-line"></div>
            <div class="signature-text">Supervisor</div>
        </div>

        <div class="signature">
            <div class="signature-line"></div>
            <div class="signature-text">Authorized Officer</div>
        </div>
    </div>

    <!-- ================= BUTTONS ================= -->
    <div class="print-buttons">
        <button type="button" class="btn btn-print" onclick="window.print()">
            Print
        </button>
        <a href="${pageContext.request.contextPath}/training-record" class="btn-back">
            Back
        </a>
    </div>

</div>

</body>
</html>