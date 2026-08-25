<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${isAllRecords}">All Inspectors Training History Report - CAAB</c:when>
            <c:otherwise>Inspector Training History Report (${employeeId}) - CAAB</c:otherwise>
        </c:choose>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- CAAB Shared Print & Custom PDF CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/training-record-print.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/training-report-pdf.css">

    <style>
        /* Multi-Row Table Styles Override for Print/PDF */
        @page {
            size: A4 landscape;
            margin: 12mm 15mm;
        }

        .report-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            table-layout: fixed;
        }

        .report-table th,
        .report-table td {
            border: 1px solid #d4dde2;
            padding: 9px 8px;
            font-size: 11px;
            line-height: 1.3;
            vertical-align: middle;
            word-wrap: break-word;
        }

        .report-table th {
            background: #176fa3 !important;
            color: #ffffff !important;
            font-weight: bold;
            text-transform: uppercase;
            text-align: center;
            font-size: 10px;
        }

        .report-table tbody tr:nth-child(even) {
            background: #f8fafc;
        }

        .text-center { text-align: center; }
        .text-left { text-align: left; }

        @media print {
            .print-buttons {
                display: none !important;
            }
        }
    </style>
</head>

<body>

<div class="page" style="width: 100%; max-width: 100%; margin: 0 auto; box-shadow: none; border: none; padding: 20px 30px;">

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
        <h1>
            <c:choose>
                <c:when test="${isAllRecords}">All Inspectors Training History Report</c:when>
                <c:otherwise>Inspector Training History Report</c:otherwise>
            </c:choose>
        </h1>
        <p>CAAB Inspector Training Summary</p>
    </div>

    <!-- ================= SUMMARY / EMPLOYEE INFORMATION ================= -->
    <c:if test="${not empty records}">
        <div class="section-title">
            <c:choose>
                <c:when test="${isAllRecords}">Report Summary</c:when>
                <c:otherwise>Employee Information</c:otherwise>
            </c:choose>
        </div>

        <table class="info-table">
            <c:choose>
                <%-- ১. সব এমপ্লয়ির একসাথে রিপোর্টের জন্য হেডার --%>
                <c:when test="${isAllRecords}">
                    <tr>
                        <td class="label">Report Scope</td>
                        <td class="value">All Inspectors Training Report</td>

                        <td class="label">Total Records Found</td>
                        <td class="value"><strong><c:out value="${records.size()}"/></strong></td>
                    </tr>
                </c:when>

                <%-- ২. একক নির্দিষ্ট এমপ্লয়ির রিপোর্টের জন্য হেডার --%>
                <c:otherwise>
                    <tr>
                        <td class="label">Employee ID</td>
                        <td class="value"><c:out value="${employeeId}"/></td>

                        <td class="label">Employee Name</td>
                        <td class="value"><c:out value="${records[0].employeeName}"/></td>
                    </tr>
                    <tr>
                        <td class="label">Designation</td>
                        <td class="value"><c:out value="${records[0].designation}"/></td>

                        <td class="label">Total Training Records</td>
                        <td class="value"><strong><c:out value="${records.size()}"/></strong></td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </table>
    </c:if>

    <!-- ================= TRAINING DETAILS TABLE ================= -->
    <div class="section-title">
        Training Details History
    </div>

    <table class="report-table">
        <thead>
        <tr>
            <th style="width: 4%;">#</th>
            <th style="width: 8%;">Emp ID</th>
            <th style="width: 13%;">Inspector Name</th>
            <th style="width: 12%;">Designation</th>
            <th style="width: 8%;">Division</th>
            <th style="width: 18%;">Course Title</th>
            <th style="width: 10%;">Training Type</th>
            <th style="width: 9%;">Date</th>
            <th style="width: 7%;">Status</th>
            <th style="width: 11%;">Supervisor Remarks</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty records}">
                <c:forEach var="record" items="${records}" varStatus="status">
                    <tr>
                        <td class="text-center">${status.index + 1}</td>
                        <td class="text-center"><c:out value="${record.employeeId}"/></td>
                        <td class="text-left"><c:out value="${record.employeeName}"/></td>
                        <td class="text-left"><c:out value="${record.designation}"/></td>

                        <td class="text-center">
                            <c:choose>
                                <c:when test="${not empty record.depName}">
                                    <c:out value="${record.depName}"/>
                                </c:when>
                                <c:otherwise>PEL</c:otherwise>
                            </c:choose>
                        </td>

                        <td class="text-left">
                            <c:choose>
                                <c:when test="${not empty record.courseTitle}">
                                    <c:out value="${record.courseTitle}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${record.trainingDescription}"/>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td class="text-center" style="text-transform: uppercase;">
                            <c:out value="${record.trainingType}"/>
                        </td>

                        <td class="text-center">
                            <c:choose>
                                <c:when test="${not empty record.initialTrainingDate}">
                                    <c:out value="${record.initialTrainingDate}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${record.trainingDate}"/>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td class="text-center">
                            <c:choose>
                                <c:when test="${not empty record.assessmentStatus}">
                                    <c:out value="${record.assessmentStatus}"/>
                                </c:when>
                                <c:otherwise>PENDING</c:otherwise>
                            </c:choose>
                        </td>

                        <td class="text-left">
                            <c:choose>
                                <c:when test="${not empty record.comment}">
                                    <c:out value="${record.comment}"/>
                                </c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="10" class="text-center" style="padding: 15px; color: #666;">
                        No training records found.
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>


    <!-- ================= PRINT & BACK BUTTONS ================= -->
    <div class="print-buttons">
        <button type="button" class="btn btn-print" onclick="window.print()">
            Print / Save PDF
        </button>
        <button type="button" class="btn-back" onclick="window.close()">
            Close
        </button>
    </div>

</div>



</body>
</html>