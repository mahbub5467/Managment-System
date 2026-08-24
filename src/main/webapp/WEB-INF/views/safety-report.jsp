
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="en">

<head>


    <meta charset="UTF-8">

    <title>
        Civil Aviation Safety Report - CAAB Technical E-Library
    </title>

    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/safety-report.css">


</head>

<body>

<!-- =========================================================
     HEADER
========================================================= -->

<div class="header">


    <img
            src="${pageContext.request.contextPath}/resources/images/caab-logo.jpg"
            class="caab-logo"
            alt="CAAB Logo">


    <div class="header-title">

        <h1>
            Civil Aviation Authority of Bangladesh
        </h1>

        <h2>
            HEADQUARTERS(0001)
        </h2>

    </div>


    <div class="header-info">

        Logged on | Day Opened on: 11-Aug-2026 |
        Server Date: 11-Aug-2026

        <br>

        Meteorological Data | Sunrise: | Sunset:

    </div>


</div>

<!-- =========================================================
     NAVBAR
========================================================= -->

<div class="navbar">


    <a
            href="${pageContext.request.contextPath}/library"
            class="home">

        <i class="fa-solid fa-house"></i>

        CAAB (Technical) E-Library

    </a>


    <div class="nav-right">

        <div class="circle-btn">

            <i class="fa-solid fa-bell"></i>

        </div>


        <div class="circle-btn">

            <i class="fa-solid fa-arrows-rotate"></i>

        </div>


        <form
                action="${pageContext.request.contextPath}/logout"
                method="post"
                style="margin:0;">

            <button
                    type="button"
                    class="logout"
                    onclick="window.location.href='${pageContext.request.contextPath}/logout';">

                <i class="fa-solid fa-power-off"></i>

                Logout

            </button>

        </form>

    </div>


</div>

<!-- =========================================================
     MAIN
========================================================= -->

<div class="main">


    <!-- =====================================================
         BREADCRUMB
    ===================================================== -->

    <div class="breadcrumb">

        <a
                href="${pageContext.request.contextPath}/library">

            CAAB (Technical) E-Library

        </a>

        <span>›</span>

        <span>
        Civil Aviation Safety Report
    </span>

    </div>


    <!-- =====================================================
         PAGE HEADER
    ===================================================== -->

    <div class="page-header">

        <div>

            <h1 class="page-title">

                <i class="fa-solid fa-shield-halved"></i>

                Civil Aviation Safety Report

            </h1>


            <div class="page-description">

                Report an aviation safety incident, hazard,
                operational concern or other safety-related event.

            </div>

        </div>


        <a
                href="${pageContext.request.contextPath}/library"
                class="back-btn">

            <i class="fa-solid fa-arrow-left"></i>

            Back to E-Library

        </a>

    </div>


    <!-- =====================================================
         SUCCESS MESSAGE
    ===================================================== -->

    <c:if test="${not empty success}">

        <div class="alert alert-success">

        <span>

            <i class="fa-solid fa-circle-check"></i>

            <c:out value="${success}"/>

        </span>

        </div>

    </c:if>


    <!-- =====================================================
         ERROR MESSAGE
    ===================================================== -->

    <c:if test="${not empty error}">

        <div class="alert alert-error">

        <span>

            <i class="fa-solid fa-circle-exclamation"></i>

            <c:out value="${error}"/>

        </span>

        </div>

    </c:if>


    <!-- =====================================================
         INFORMATION
    ===================================================== -->

    <div class="info-box">

        <i class="fa-solid fa-circle-info"></i>

        <div>

            Please provide complete and accurate information
            about the safety event. The information submitted
            through this form will be used for aviation safety
            assessment, investigation and preventive action.

        </div>

    </div>


    <!-- =====================================================
         REPORT CARD
    ===================================================== -->

    <div class="report-card">


        <!-- CARD HEADER -->

        <div class="card-header">

            <div class="card-title">

                <i class="fa-solid fa-file-shield"></i>

                Safety Incident Report

            </div>

        </div>


        <!-- FORM -->

        <div class="form-content">

            <form
                    action="${pageContext.request.contextPath}/submitSafetyReport"
                    method="post"
                    onsubmit="return validateSafetyReport();">


                <!-- =================================================
                     SECTION 1
                ================================================= -->

                <div class="form-section">

                    <h3 class="section-title">

                        <i class="fa-solid fa-user"></i>

                        1. Reporter Information

                    </h3>


                    <div class="form-grid">


                        <!-- NAME -->

                        <div class="form-group">

                            <label for="reporterName">

                                Reporter Name
                                <span class="required">*</span>

                            </label>

                            <input
                                    type="text"
                                    id="reporterName"
                                    name="reporterName"
                                    class="form-control"
                                    placeholder="Enter full name"
                                    required>

                        </div>


                        <!-- EMPLOYEE ID -->

                        <div class="form-group">

                            <label for="employeeId">

                                Employee / ID Number

                            </label>

                            <input
                                    type="text"
                                    id="employeeId"
                                    name="employeeId"
                                    class="form-control"
                                    placeholder="Enter employee ID">

                        </div>


                        <!-- DEPARTMENT -->

                        <div class="form-group">

                            <label for="department">

                                Department / Organization

                                <span class="required">*</span>

                            </label>

                            <input
                                    type="text"
                                    id="department"
                                    name="department"
                                    class="form-control"
                                    placeholder="Enter department or organization"
                                    required>

                        </div>


                        <!-- CONTACT -->

                        <div class="form-group">

                            <label for="contact">

                                Contact Information

                                <span class="required">*</span>

                            </label>

                            <input
                                    type="text"
                                    id="contact"
                                    name="contact"
                                    class="form-control"
                                    placeholder="Phone number or email"
                                    required>

                        </div>

                    </div>

                </div>


                <!-- =================================================
                     SECTION 2
                ================================================= -->

                <div class="form-section">

                    <h3 class="section-title">

                        <i class="fa-solid fa-plane"></i>

                        2. Safety Event Information

                    </h3>


                    <div class="form-grid">


                        <!-- INCIDENT DATE -->

                        <div class="form-group">

                            <label for="incidentDate">

                                Incident Date
                                <span class="required">*</span>

                            </label>

                            <input
                                    type="date"
                                    id="incidentDate"
                                    name="incidentDate"
                                    class="form-control"
                                    required>

                        </div>


                        <!-- INCIDENT TIME -->

                        <div class="form-group">

                            <label for="incidentTime">

                                Incident Time

                            </label>

                            <input
                                    type="time"
                                    id="incidentTime"
                                    name="incidentTime"
                                    class="form-control">

                        </div>


                        <!-- LOCATION -->

                        <div class="form-group">

                            <label for="location">

                                Airport / Location
                                <span class="required">*</span>

                            </label>

                            <div class="input-with-icon">

                                <i class="fa-solid fa-location-dot"></i>

                                <input
                                        type="text"
                                        id="location"
                                        name="location"
                                        class="form-control"
                                        placeholder="Enter airport or location"
                                        required>

                            </div>

                        </div>


                        <!-- FLIGHT NUMBER -->

                        <div class="form-group">

                            <label for="flightNumber">

                                Flight Number

                            </label>

                            <div class="input-with-icon">

                                <i class="fa-solid fa-plane-departure"></i>

                                <input
                                        type="text"
                                        id="flightNumber"
                                        name="flightNumber"
                                        class="form-control"
                                        placeholder="e.g. BG-305">

                            </div>

                        </div>


                        <!-- AIRCRAFT -->

                        <div class="form-group">

                            <label for="aircraft">

                                Aircraft Registration / Type

                            </label>

                            <input
                                    type="text"
                                    id="aircraft"
                                    name="aircraft"
                                    class="form-control"
                                    placeholder="e.g. S2-ABC / Boeing 737">

                        </div>


                        <!-- INCIDENT TYPE -->

                        <div class="form-group">

                            <label for="incidentType">

                                Safety Event Type
                                <span class="required">*</span>

                            </label>

                            <select
                                    id="incidentType"
                                    name="incidentType"
                                    class="form-control"
                                    required>

                                <option value="">
                                    -- Select Event Type --
                                </option>

                                <option value="flight_safety">
                                    Flight Safety
                                </option>

                                <option value="airport_safety">
                                    Airport Safety
                                </option>

                                <option value="air_traffic">
                                    Air Traffic Control
                                </option>

                                <option value="maintenance">
                                    Aircraft Maintenance
                                </option>

                                <option value="runway">
                                    Runway / Taxiway
                                </option>

                                <option value="ground_operation">
                                    Ground Operation
                                </option>

                                <option value="equipment_failure">
                                    Equipment Failure
                                </option>

                                <option value="bird_strike">
                                    Bird Strike / Wildlife Hazard
                                </option>

                                <option value="security">
                                    Aviation Security
                                </option>

                                <option value="other">
                                    Other
                                </option>

                            </select>

                        </div>

                    </div>

                </div>


                <!-- =================================================
                     SECTION 3
                ================================================= -->

                <div class="form-section">

                    <h3 class="section-title">

                        <i class="fa-solid fa-triangle-exclamation"></i>

                        3. Risk Assessment

                    </h3>


                    <div class="form-group">

                        <label>

                            Assessed Risk Level
                            <span class="required">*</span>

                        </label>


                        <div class="risk-options">


                            <div class="risk-option risk-low">

                                <input
                                        type="radio"
                                        id="riskLow"
                                        name="riskLevel"
                                        value="LOW"
                                        required>

                                <label for="riskLow">

                                    <i class="fa-solid fa-circle-check"></i>

                                    Low

                                </label>

                            </div>


                            <div class="risk-option risk-medium">

                                <input
                                        type="radio"
                                        id="riskMedium"
                                        name="riskLevel"
                                        value="MEDIUM">

                                <label for="riskMedium">

                                    <i class="fa-solid fa-circle-exclamation"></i>

                                    Medium

                                </label>

                            </div>


                            <div class="risk-option risk-high">

                                <input
                                        type="radio"
                                        id="riskHigh"
                                        name="riskLevel"
                                        value="HIGH">

                                <label for="riskHigh">

                                    <i class="fa-solid fa-triangle-exclamation"></i>

                                    High

                                </label>

                            </div>


                            <div class="risk-option risk-critical">

                                <input
                                        type="radio"
                                        id="riskCritical"
                                        name="riskLevel"
                                        value="CRITICAL">

                                <label for="riskCritical">

                                    <i class="fa-solid fa-skull-crossbones"></i>

                                    Critical

                                </label>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- =================================================
                     SECTION 4
                ================================================= -->

                <div class="form-section">

                    <h3 class="section-title">

                        <i class="fa-solid fa-file-lines"></i>

                        4. Safety Event Description

                    </h3>


                    <div class="form-grid">


                        <!-- DESCRIPTION -->

                        <div class="form-group full">

                            <label for="description">

                                Incident / Hazard Description

                                <span class="required">*</span>

                            </label>

                            <textarea
                                    id="description"
                                    name="description"
                                    class="form-control"
                                    placeholder="Describe what happened, where it happened, sequence of events and any relevant circumstances..."
                                    required></textarea>

                        </div>


                        <!-- IMMEDIATE ACTION -->

                        <div class="form-group full">

                            <label for="immediateAction">

                                Immediate Action Taken

                            </label>

                            <textarea
                                    id="immediateAction"
                                    name="immediateAction"
                                    class="form-control"
                                    placeholder="Describe any immediate corrective, preventive or emergency action taken..."></textarea>

                        </div>


                        <!-- CONTRIBUTING FACTORS -->

                        <div class="form-group full">

                            <label for="contributingFactors">

                                Possible Contributing Factors

                            </label>

                            <textarea
                                    id="contributingFactors"
                                    name="contributingFactors"
                                    class="form-control"
                                    placeholder="Mention any equipment, human, environmental, operational or procedural factors that may have contributed..."></textarea>

                        </div>


                        <!-- RECOMMENDATION -->

                        <div class="form-group full">

                            <label for="recommendation">

                                Recommended Corrective / Preventive Action

                            </label>

                            <textarea
                                    id="recommendation"
                                    name="recommendation"
                                    class="form-control"
                                    placeholder="Provide recommendations to prevent recurrence of the safety event..."></textarea>

                        </div>

                    </div>

                </div>


                <!-- =================================================
                     DECLARATION
                ================================================= -->

                <div class="declaration">

                    <label>

                        <input
                                type="checkbox"
                                id="declaration"
                                name="declaration"
                                required>

                        <span>

                        I confirm that the information provided
                        in this safety report is accurate and
                        complete to the best of my knowledge.
                        I understand that the information may be
                        reviewed for aviation safety assessment
                        and investigation purposes.

                        <span class="required">*</span>

                    </span>

                    </label>

                </div>


                <!-- =================================================
                     ACTION BUTTONS
                ================================================= -->

                <div class="form-actions">


                    <button
                            type="reset"
                            class="btn btn-reset">

                        <i class="fa-solid fa-rotate-left"></i>

                        Clear Form

                    </button>


                    <button
                            type="submit"
                            class="btn btn-submit">

                        <i class="fa-solid fa-paper-plane"></i>

                        Submit Safety Report

                    </button>


                </div>


            </form>

        </div>

    </div>


</div>

<!-- =========================================================
     FOOTER
========================================================= -->

<div class="footer">


    CAAB ICT & e-Governance Project Portal,
    version:0.2.1.1,
    Copyright © Civil Aviation Authority Bangladesh,
    2026 All rights reserved.

    <br>

    System Managed by Simec System Limited.

</div>

<script src="/safety-report.js"></script>
</body>

</html>
