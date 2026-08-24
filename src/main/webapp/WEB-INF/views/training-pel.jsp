<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0">

    <title>PEL Training Records</title>


    <!-- Font Awesome -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">


    <!-- Training CSS -->
    <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/training-pel.css">

</head>


<body>


<div class="page-wrapper">


    <!-- =====================================================
         HEADER
    ====================================================== -->

    <header class="top-header">

        <div class="header-left">

            <!-- If you have CAAB logo, keep this -->
            <img
                    src="${pageContext.request.contextPath}/resources/images/caab-logo.jpg"
                    alt="CAAB Logo"
                    class="caab-logo">


            <div class="header-title">

                <h1>
                    Civil Aviation Authority of Bangladesh
                </h1>

                <h2>
                    Personnel Licensing Department
                </h2>

            </div>

        </div>


        <div class="header-right">

            <div>
                Personnel Licensing System
            </div>

            <div>
                Training Records Management
            </div>

        </div>

    </header>



    <!-- =====================================================
         NAVBAR
    ====================================================== -->

    <nav class="main-navbar">

        <a
                href="${pageContext.request.contextPath}/"
                class="home-link">

            <i class="fa-solid fa-house"></i>

            Home

        </a>


        <div class="nav-right">

            <div class="nav-circle">

                <i class="fa-solid fa-bell"></i>

            </div>


            <div class="nav-circle">

                <i class="fa-solid fa-user"></i>

            </div>


            <button
                    type="button"
                    class="logout">

                <i class="fa-solid fa-right-from-bracket"></i>

                Logout

            </button>

        </div>

    </nav>



    <!-- =====================================================
         MAIN
    ====================================================== -->

    <main class="main-area">


        <!-- =================================================
             SIDEBAR
        ================================================== -->

        <aside class="sidebar">

            <div class="sidebar-title">

                <i class="fa-solid fa-bars"></i>

                Personnel Licensing

            </div>





            <a
                    href="#"
                    class="sidebar-item active">

                <i class="fa-solid fa-layer-group"></i>

                Training Records

            </a>




        </aside>



        <!-- =================================================
             CONTENT
        ================================================== -->

        <section class="content">


            <!-- Breadcrumb -->

            <div class="breadcrumb">

                <a href="${pageContext.request.contextPath}/">
                    Home
                </a>

                <i class="fa-solid fa-chevron-right"></i>

                <span>
                    Training Records
                </span>

            </div>



            <!-- Page title -->

            <div class="page-title-row">

                <div>

                    <h1 class="page-title">
                        PEL Training Records
                    </h1>

                    <div class="page-description">
                        Create and maintain Personnel Licensing inspector
                        training records.
                    </div>

                </div>


                <a
                        href="javascript:history.back()"
                        class="back-btn">

                    <i class="fa-solid fa-arrow-left"></i>

                    Back

                </a>

            </div>



            <!-- =================================================
                 FORM
            ================================================== -->

            <form
                    id="trainingForm"
                    method="post"
                    action="${pageContext.request.contextPath}/training/pel/save"
                    enctype="multipart/form-data"
                    novalidate>



                <!-- =================================================
                     EMPLOYEE INFORMATION
                ================================================== -->

                <div class="card employee-card">


                    <div class="card-header">

                        <i class="fa-solid fa-user"></i>

                        Employee Information

                    </div>


                    <div class="card-body">

                        <div class="form-grid">


                            <!-- Employee ID -->

                            <div class="form-group">

                                <label
                                        for="employeeId"
                                        class="form-label">

                                    Employee ID

                                    <span class="required">
                                        *
                                    </span>

                                </label>


                                <div
                                        class="employee-search-wrapper">

                                    <input
                                            type="text"
                                            id="employeeId"
                                            name="employeeId"
                                            class="form-control"
                                            placeholder="Enter Employee ID"
                                            autocomplete="off"
                                            required>


                                    <button
                                            type="button"
                                            id="employeeSearchBtn"
                                            class="employee-search-btn"
                                            title="Search Employee">

                                        <i class="fa-solid fa-magnifying-glass"></i>

                                    </button>

                                </div>


<%--                                <div--%>
<%--                                        id="employeeSearchStatus"--%>
<%--                                        class="employee-search-status">--%>
<%--                                </div>--%>

                            </div>



                            <!-- Name -->

                            <div class="form-group">

                                <label
                                        for="employeeName"
                                        class="form-label">

                                    Name

                                    <span class="required">
                                        *
                                    </span>

                                </label>


                                <input
                                        type="text"
                                        id="employeeName"
                                        name="employeeName"
                                        class="form-control employee-auto-field"
                                        placeholder="Employee Name"
                                        readonly
                                        required>

                            </div>



                            <!-- Designation -->

                            <div class="form-group">

                                <label
                                        for="designation"
                                        class="form-label">

                                    Designation

                                    <span class="required">
                                        *
                                    </span>

                                </label>


                                <input
                                        type="text"
                                        id="designation"
                                        name="designation"
                                        class="form-control employee-auto-field"
                                        placeholder="Designation"
                                        readonly
                                        required>

                            </div>



                            <!-- Joining Date -->

                            <div class="form-group">

                                <label
                                        for="joiningDate"
                                        class="form-label">

                                    Joining Date

                                    <span class="required">
                                        *
                                    </span>

                                </label>


                                <input
                                        type="date"
                                        id="joiningDate"
                                        name="joiningDate"
                                        class="form-control employee-auto-field"
                                        readonly
                                        required>

                            </div>


                        </div>

                    </div>

                </div>



                <!-- =================================================
                     DEPARTMENT
                ================================================== -->

<%--                <div class="card department-card">--%>

<%--                    <div class="department-body">--%>

<%--                        <span class="department-label">--%>
<%--                            Department :--%>
<%--                        </span>--%>

<%--                        <span--%>
<%--                                id="departmentName"--%>
<%--                                class="department-name">--%>

<%--                            PEL--%>

<%--                        </span>--%>

<%--                    </div>--%>

<%--                </div>--%>



                <!-- =================================================
                     TRAINING INFORMATION
                ================================================== -->

                <div class="card training-card">


                    <div class="card-header">

                        <i class="fa-solid fa-layer-group"></i>

                        Training Information

                    </div>


                    <div class="card-body">


                        <div class="record-description">

                            Select the type of training record you want
                            to enter.

                        </div>



                        <!-- =================================================
                             TRAINING TYPE
                        ================================================== -->

                        <div class="form-grid">

                            <div class="form-group">

                                <label
                                        for="employeeName"
                                        class="form-label">

                                  Department

                                    <span class="required">
                                        *
                                    </span>

                                </label>


                                <input
                                        type="text"
                                        id="depName"
                                        name="depName"
                                        class="form-control employee-auto-field"
                                        value="PEL"
                                        readonly
                                        >

                            </div>


                            <div class="form-group">

                                <label
                                        for="trainingType"
                                        class="form-label">

                                    Select Training Type

                                    <span class="required">
                                        *
                                    </span>

                                </label>


                                <select
                                        id="trainingType"
                                        name="trainingType"
                                        class="form-select"
                                        required>

                                    <option value="">
                                        -- Select Training Type --
                                    </option>

                                    <option value="initial">
                                        Initial Training, OJT &amp; Certification
                                    </option>

                                    <option value="recurrent">
                                        Recurrent Training
                                    </option>

                                    <option value="specialized">
                                        Specialized Training
                                    </option>

                                    <option value="previous">
                                        Previous Training
                                    </option>

                                </select>

                            </div>

                        </div>



                        <!-- =================================================
                             TRAINING ENTRY AREA
                             Hidden until Training Type selected
                        ================================================== -->

                        <div
                                id="trainingEntryArea"
                                class="training-entry-area hidden">



                            <!-- =================================================
                                 INITIAL TRAINING
                            ================================================== -->

                            <div
                                    id="initialSection"
                                    class="training-section hidden">


                                <div class="training-entry-title">

                                    <h3>
                                        Initial Training, OJT &amp; Certification
                                    </h3>

                                    <p>
                                        Enter initial training, OJT and
                                        certification information.
                                    </p>

                                </div>


                                <div class="training-form-grid">


                                    <!-- Course -->

                                    <div class="training-form-group">

                                        <label
                                                for="initialCourse"
                                                class="training-form-label">

                                            Course / Training Title

                                            <span class="required">
                                                *
                                            </span>

                                        </label>


                                        <input
                                                type="text"
                                                id="initialCourse"
                                                name="initialCourse"
                                                class="form-control"
                                                placeholder="Enter training title"
                                                required>

                                    </div>



                                    <!-- Initial Training Date -->

                                    <div class="training-form-group">

                                        <label
                                                for="initialTrainingDate"
                                                class="training-form-label">

                                            Initial Training Date

                                            <span class="required">
                                                *
                                            </span>

                                        </label>


                                        <input
                                                type="date"
                                                id="initialTrainingDate"
                                                name="initialTrainingDate"
                                                class="form-control"
                                                required>

                                    </div>



                                    <!-- OJT Date -->

                                    <div class="training-form-group">

                                        <label
                                                for="ojtDate"
                                                class="training-form-label">

                                            OJT Date

                                        </label>


                                        <input
                                                type="date"
                                                id="ojtDate"
                                                name="ojtDate"
                                                class="form-control">

                                    </div>



                                    <!-- Certification -->

                                    <div class="training-form-group">

                                        <label
                                                class="training-form-label">

                                            Certification

                                            <span class="required">
                                                *
                                            </span>

                                        </label>


                                        <div
                                                class="certification-options">

                                            <label
                                                    class="certification-option">

                                                <input
                                                        type="radio"
                                                        name="initialCertification"
                                                        value="yes"
                                                        required>

                                                Yes

                                            </label>


                                            <label
                                                    class="certification-option">

                                                <input
                                                        type="radio"
                                                        name="initialCertification"
                                                        value="no">

                                                No

                                            </label>

                                        </div>

                                    </div>



                                    <!-- Certificate Date -->

                                    <div
                                            id="initialCertificateDateGroup"
                                            class="training-form-group certificate-dependent hidden">

                                        <label
                                                for="initialCertificateDate"
                                                class="training-form-label">

                                            Certificate Date

                                        </label>


                                        <input
                                                type="date"
                                                id="initialCertificateDate"
                                                name="initialCertificateDate"
                                                class="form-control"
                                                disabled>

                                    </div>



                                    <!-- Certificate File -->

                                    <div
                                            id="initialCertificateFileGroup"
                                            class="training-form-group certificate-dependent hidden">

                                        <label
                                                for="initialCertificate"
                                                class="training-form-label">

                                            Certificate File

                                        </label>


                                        <input
                                                type="file"
                                                id="initialCertificate"
                                                name="initialCertificate"
                                                class="form-control certificate-upload"
                                                accept=".pdf,.jpg,.jpeg,.png"
                                                disabled>

                                    </div>


                                </div>

                            </div>



                            <!-- =================================================
                                 OTHER TRAINING
                            ================================================== -->

                            <div
                                    id="otherSection"
                                    class="training-section hidden">


                                <div class="training-entry-title">

                                    <h3 id="otherTrainingTitle">
                                        Training Information
                                    </h3>

                                    <p id="otherTrainingDescription">
                                        Enter training information.
                                    </p>

                                </div>


                                <div class="training-form-grid">


                                    <!-- Training Title -->

                                    <div class="training-form-group">

                                        <label
                                                for="trainingDescription"
                                                class="training-form-label">

                                            <span id="otherTypeHeader">
                                                Type of Training
                                            </span>

                                            <span class="required">
                                                *
                                            </span>

                                        </label>


                                        <input
                                                type="text"
                                                id="trainingDescription"
                                                name="trainingDescription"
                                                class="form-control"
                                                placeholder="Enter training type">

                                    </div>



                                    <!-- Course -->

                                    <div class="training-form-group">

                                        <label
                                                for="otherCourse"
                                                class="training-form-label">

                                            Course / Training Title

                                            <span class="required">
                                                *
                                            </span>

                                        </label>


                                        <input
                                                type="text"
                                                id="otherCourse"
                                                name="otherCourse"
                                                class="form-control"
                                                placeholder="Enter training title">

                                    </div>



                                    <!-- Provider -->

                                    <div class="training-form-group">

                                        <label
                                                for="trainingProvider"
                                                class="training-form-label">

                                            Training Provider

                                            <span class="required">
                                                *
                                            </span>

                                        </label>


                                        <input
                                                type="text"
                                                id="trainingProvider"
                                                name="trainingProvider"
                                                class="form-control"
                                                placeholder="Enter training provider">

                                    </div>



                                    <!-- Training Date -->

                                    <div class="training-form-group">

                                        <label
                                                for="trainingDate"
                                                class="training-form-label">

                                            Training Date

                                            <span class="required">
                                                *
                                            </span>

                                        </label>


                                        <input
                                                type="date"
                                                id="trainingDate"
                                                name="trainingDate"
                                                class="form-control">

                                    </div>



                                    <!-- Certification -->

                                    <div class="training-form-group">

                                        <label
                                                class="training-form-label">

                                            Certification

                                            <span class="required">
                                                *
                                            </span>

                                        </label>


                                        <div
                                                class="certification-options">

                                            <label
                                                    class="certification-option">

                                                <input
                                                        type="radio"
                                                        name="otherCertification"
                                                        value="yes">

                                                Yes

                                            </label>


                                            <label
                                                    class="certification-option">

                                                <input
                                                        type="radio"
                                                        name="otherCertification"
                                                        value="no">

                                                No

                                            </label>

                                        </div>

                                    </div>



                                    <!-- Certificate Date -->

                                    <div
                                            id="otherCertificateDateGroup"
                                            class="training-form-group certificate-dependent hidden">

                                        <label
                                                for="otherCertificateDate"
                                                class="training-form-label">

                                            Certificate Date

                                        </label>


                                        <input
                                                type="date"
                                                id="otherCertificateDate"
                                                name="otherCertificateDate"
                                                class="form-control"
                                                disabled>

                                    </div>



                                    <!-- Certificate File -->

                                    <div
                                            id="otherCertificateFileGroup"
                                            class="training-form-group certificate-dependent hidden">

                                        <label
                                                for="otherCertificate"
                                                class="training-form-label">

                                            Certificate File

                                        </label>


                                        <input
                                                type="file"
                                                id="otherCertificate"
                                                name="otherCertificate"
                                                class="form-control certificate-upload"
                                                accept=".pdf,.jpg,.jpeg,.png"
                                                disabled>

                                    </div>


                                </div>

                            </div>



                            <!-- =================================================
                                 BUTTONS
                                 Hidden initially
                            ================================================== -->

                            <div
                                    id="trainingActions"
                                    class="bottom-actions hidden">


                                <button
                                        type="button"
                                        class="btn btn-cancel"
                                        onclick="history.back();">

                                    <i class="fa-solid fa-arrow-left"></i>

                                    Cancel

                                </button>


                                <button
                                        type="submit"
                                        class="btn btn-save">

                                    <i class="fa-solid fa-floppy-disk"></i>

                                    Submit Training Record

                                </button>

                            </div>


                        </div>

                    </div>

                </div>


            </form>

        </section>

    </main>



    <!-- =====================================================
         FOOTER
    ====================================================== -->

    <footer class="footer">

        <div>
            Civil Aviation Authority of Bangladesh
        </div>

        <div>
            Personnel Licensing Department
        </div>

    </footer>


</div>


<script
        src="${pageContext.request.contextPath}/training-pel.js">
</script>


</body>

</html>