<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PEL Training Records</title>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- Training CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/training-pel.css">
</head>

<body>

<div class="page-wrapper">

    <!-- HEADER -->
    <header class="top-header">
        <div class="header-left">
            <img src="${pageContext.request.contextPath}/resources/images/caab-logo.jpg" alt="CAAB Logo" class="caab-logo">
            <div class="header-title">
                <h1>Civil Aviation Authority of Bangladesh</h1>
                <h2>FSR</h2>
            </div>
        </div>

        <div class="header-right">
            Logged on | Day Opened on: <span id="dayOpenedDate"></span> | Server Date: <span id="serverDate"></span>
            <br>
            Meteorological Data | Sunrise: | Sunset:
        </div>
    </header>

    <!-- NAVBAR -->
    <nav class="main-navbar">
        <a href="${pageContext.request.contextPath}/" class="home-link">
            <i class="fa-solid fa-house"></i> Home
        </a>

        <div class="nav-right">
            <div class="nav-circle">
                <i class="fa-solid fa-bell"></i>
            </div>
            <div class="nav-circle">
                <i class="fa-solid fa-user"></i>
            </div>
            <button type="button" class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout';">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
            </button>
        </div>
    </nav>

    <!-- MAIN AREA -->
    <main class="main-area">
        <!-- SIDEBAR -->
        <aside class="sidebar no-print">
            <!-- ১. Always Blue Header Link -->
            <a href="${pageContext.request.contextPath}/training" class="sidebar-item">
                CAAB Inspector Training Records
            </a>

            <!-- ২. Supervisor Assessment -->
            <a href="${pageContext.request.contextPath}/training/supervisor-assessment" class="sidebar-item">
                Supervisor Assessment
            </a>

            <!-- ৩. Active Link (Training Records) -->
            <a href="${pageContext.request.contextPath}/training/training-record" class="sidebar-item">
                Training Records
            </a>

            <!-- ৪. Training Records Report -->
            <a href="${pageContext.request.contextPath}/training/training-records-report" class="sidebar-item">
                Training Records Report
            </a>
        </aside>

        <!-- CONTENT -->
        <section class="content">

            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/">Home</a>
                <i class="fa-solid fa-chevron-right"></i>
                <span>Training Records</span>
            </div>

            <!-- Page Title -->
            <div class="page-title-row">
                <div>
                    <h1 class="page-title">PEL Training Records</h1>
                    <div class="page-description">
                        Create and maintain Personnel Licensing inspector training records.
                    </div>
                </div>

                <a href="javascript:history.back()" class="back-btn">
                    <i class="fa-solid fa-arrow-left"></i> Back
                </a>
            </div>

            <!-- FORM START -->
            <form id="trainingForm" method="post" action="${pageContext.request.contextPath}/training/pel/save" enctype="multipart/form-data" novalidate>

                <!-- EMPLOYEE INFORMATION CARD -->
                <div class="card employee-card">
                    <div class="card-header">
                        <i class="fa-solid fa-user"></i> Employee Information
                    </div>

                    <div class="card-body">
                        <div class="form-grid">

                            <!-- Employee ID -->
                            <div class="form-group">
                                <label for="employeeId" class="form-label">
                                    EIIN <span class="required">*</span>
                                </label>
                                <div class="employee-search-wrapper">
                                    <input type="text" id="employeeId" name="employeeId" class="form-control" autocomplete="off" required>
                                    <button type="button" id="employeeSearchBtn" class="employee-search-btn" title="Search Employee">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>
                                </div>
                                <div id="employeeSearchStatus" class="employee-search-status"></div>
                            </div>

                            <!-- Name (Editable & Auto-Fillable) -->
                            <div class="form-group">
                                <label for="employeeName" class="form-label">
                                    Name <span class="required">*</span>
                                </label>
                                <input type="text" id="employeeName" name="employeeName" class="form-control" required>
                            </div>

                            <!-- Designation (Editable & Auto-Fillable) -->
                            <div class="form-group">
                                <label for="designation" class="form-label">
                                    Designation <span class="required">*</span>
                                </label>
                                <input type="text" id="designation" name="designation" class="form-control" required>
                            </div>

                            <!-- Joining Date (Editable & Auto-Fillable) -->
                            <div class="form-group">
                                <label for="joiningDate" class="form-label">
                                    Joining Date <span class="required">*</span>
                                </label>
                                <input type="date" id="joiningDate" name="joiningDate" class="form-control" required>
                            </div>

                        </div>
                    </div>
                </div>

                <!-- TRAINING INFORMATION CARD -->
                <div class="card training-card">
                    <div class="card-header">
                        <i class="fa-solid fa-layer-group"></i> Training Information
                    </div>

                    <div class="card-body">
                        <div class="record-description">
                            Select the type of training record you want to enter.
                        </div>

                        <!-- Department & Training Type Selection -->
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="depName" class="form-label">
                                    Division <span class="required">*</span>
                                </label>
                                <input type="text" id="depName" name="depName" class="form-control employee-auto-field" value="PEL" readonly>
                            </div>

                            <div class="form-group">
                                <label for="trainingType" class="form-label">
                                    Select Training Type <span class="required">*</span>
                                </label>
                                <select id="trainingType" name="trainingType" class="form-select" required>
                                    <option value="">-- Select Training Type --</option>
                                    <option value="initial">Initial Training</option>
                                    <option value="ojt">OJT</option>
                                    <option value="recurrent">Recurrent Training</option>
                                    <option value="specialized">Specialized Training</option>
                                    <option value="previous">Previous Training</option>
                                </select>
                            </div>
                        </div>

                        <!-- UNIFIED TRAINING ENTRY BLOCK -->
                        <div id="trainingEntryArea" class="training-entry-area training-details-block hidden">

                            <div class="training-entry-title">
                                <h3 id="dynamicSectionTitle">Training Details</h3>
                                <p id="dynamicSectionDesc">Enter training, provider, dates, and certification information.</p>
                            </div>

                            <div class="training-form-grid">

                                <!-- Course Title -->
                                <div class="training-form-group">
                                    <label for="courseTitle" class="training-form-label">
                                        Course Title <span class="required">*</span>
                                    </label>
                                    <input type="text" id="courseTitle" name="courseTitle" class="form-control" placeholder="Enter training title" required>
                                </div>

                                <!-- Training Provider -->
                                <div class="training-form-group">
                                    <label for="trainingProvider" class="training-form-label">
                                        Training Provider <span class="required">*</span>
                                    </label>
                                    <input type="text" id="trainingProvider" name="trainingProvider" class="form-control" placeholder="Enter training provider" required>
                                </div>

                                <!-- Start Date -->
                                <div class="training-form-group">
                                    <label for="startDate" class="training-form-label">
                                        Start Training Date <span class="required">*</span>
                                    </label>
                                    <input type="date" id="startDate" name="startDate" class="form-control" required>
                                </div>

                                <!-- End Date -->
                                <div class="training-form-group">
                                    <label for="endDate" class="training-form-label">
                                        End Date
                                    </label>
                                    <input type="date" id="endDate" name="endDate" class="form-control">
                                </div>

                                <!-- Certification Radio Buttons (Defaults to 'No') -->
                                <div class="training-form-group">
                                    <label class="training-form-label">
                                        Certification <span class="required">*</span>
                                    </label>
                                    <div class="certification-options">
                                        <label class="certification-option">
                                            <input type="radio" name="certification" value="yes" required>
                                            Yes
                                        </label>
                                        <label class="certification-option">
                                            <input type="radio" name="certification" value="no" checked>
                                            No
                                        </label>
                                    </div>
                                </div>

                                <!-- Certificate Date (Hidden by Default) -->
                                <div id="certificateDateGroup" class="training-form-group certificate-dependent hidden">
                                    <label for="certificateDate" class="training-form-label">
                                        Certificate Date
                                    </label>
                                    <input type="date" id="certificateDate" name="certificateDate" class="form-control" disabled>
                                </div>

                                <!-- Certificate File (Hidden by Default) -->
                                <div id="certificateFileGroup" class="training-form-group certificate-dependent hidden">
                                    <label for="certificateFile" class="training-form-label">
                                        Certificate File
                                    </label>
                                    <div style="width: 100%; max-width: 620px;">
                                        <input type="file" id="certificateFile" name="certificateFile" class="form-control certificate-upload" accept=".pdf,.jpg,.jpeg,.png" disabled>
                                        <span id="fileSelectedText" style="font-size: 12px; color: #64748b; margin-top: 5px; display: block;">
                                            Please select file
                                        </span>
                                    </div>
                                </div>

                            </div>

                            <!-- ACTION BUTTONS -->
                            <div id="trainingActions" class="bottom-actions">
                                <button type="button" class="btn btn-cancel" onclick="history.back();">
                                    <i class="fa-solid fa-arrow-left"></i> Cancel
                                </button>

                                <button type="submit" class="btn btn-save">
                                    <i class="fa-solid fa-floppy-disk"></i> Submit Training Record
                                </button>
                            </div>

                        </div>

                    </div>
                </div>

            </form>

        </section>
    </main>

    <!-- FOOTER -->
    <footer class="footer">
        CAAB ICT &amp; e-Governance Project Portal, version:0.2.1.1, Copyright &copy; Civil Aviation Authority Bangladesh, 2026 All rights reserved.<br>
        System Managed by Simec System Limited.
    </footer>

</div>

<!-- JS Context Path Helper & Main Script -->
<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/training-pel.js"></script>

</body>
</html>