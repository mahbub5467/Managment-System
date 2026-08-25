<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>CAAB Inspector Training Record</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/training.css">
</head>

<body>

<!-- =====================================================
     HEADER
===================================================== -->
<header class="top-header">
    <!-- CAAB Logo -->
    <img src="${pageContext.request.contextPath}/resources/images/caab-logo.png" class="caab-logo" alt="CAAB Logo">

    <div class="header-title">
        <h1>Civil Aviation Authority of Bangladesh</h1>
        <h2>FSR</h2>
    </div>

    <div class="header-right">
        Logged on | Day Opened on: <span id="dayOpenedDate"></span> |
        Server Date: <span id="serverDate"></span>
        <br>
        Meteorological Data | Sunrise: | Sunset:
    </div>
</header>

<!-- =====================================================
     NAVIGATION
===================================================== -->
<nav class="main-navbar">
    <a href="/" class="home-link">
        <i class="fa-solid fa-house"></i>
        <span>Home</span>
    </a>

    <div class="nav-right">
        <div class="nav-circle">
            <i class="fa-solid fa-bell"></i>
        </div>

        <div class="nav-circle">
            <i class="fa-solid fa-arrows-rotate"></i>
        </div>

        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <button type="button" class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout';">
                <i class="fa-solid fa-power-off"></i>
                Logout
            </button>
        </form>
    </div>
</nav>

<!-- =====================================================
     MAIN AREA
===================================================== -->
<div class="main-area">

    <!-- SIDEBAR -->
    <aside class="sidebar no-print">
        <!-- ১. Always Blue (Home/Title Link) -->
        <a href="${pageContext.request.contextPath}/training" class="sidebar-item active">
            CAAB Inspector Training Records
        </a>

        <!-- ২. Supervisor Assessment -->
        <a href="${pageContext.request.contextPath}/training/supervisor-assessment" class="sidebar-item">
            Supervisor Assessment
        </a>

        <!-- ৩. Training Records -->
        <a href="${pageContext.request.contextPath}/training/training-record" class="sidebar-item">
            Training Records
        </a>

        <!-- ৪. Training Records Report -->
        <a href="${pageContext.request.contextPath}/training/training-records-report" class="sidebar-item">
            Training Records Report
        </a>
    </aside>

    <!-- CONTENT -->
    <main class="content">

        <!-- PAGE TITLE -->
        <div class="content-header">
            <div>
                <h1 class="page-title">CAAB Inspector Training Records</h1>
                <div class="page-description">
                    CAAB Inspector Training Records.
                    Access inspector training records, courses, certificates,
                    <br>
                    training schedules, and related training information for CAAB inspectors.
                </div>
            </div>
        </div>

        <!-- DEPARTMENT FOLDERS -->
        <div class="panel department-panel">
            <div class="section-title">
                <i class="fa-solid fa-building"></i>
                Divisions
            </div>

            <div class="department-grid">

                <!-- PEL -->
                <a href="${pageContext.request.contextPath}/training/training-pel" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">PEL</div>
                        <div class="department-description">Personnel Licensing</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

                <!-- OPS -->
                <a href="${pageContext.request.contextPath}/library/ops" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">OPS</div>
                        <div class="department-description">Flight Operations</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

                <!-- AIR -->
                <a href="${pageContext.request.contextPath}/library/air" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">AIR</div>
                        <div class="department-description">Airworthiness</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

                <!-- ANS -->
                <a href="${pageContext.request.contextPath}/library/ans" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">ANS</div>
                        <div class="department-description">Air Navigation Services</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

                <!-- AGA -->
                <a href="${pageContext.request.contextPath}/library/aga" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">AGA</div>
                        <div class="department-description">Aerodromes & Ground Aids</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

                <!-- LEG -->
                <a href="${pageContext.request.contextPath}/library/leg" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">LEG</div>
                        <div class="department-description">Legal Documents</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

                <!-- ORG -->
                <a href="${pageContext.request.contextPath}/library/org" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">ORG</div>
                        <div class="department-description">Organization</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

                <!-- SSP -->
                <a href="${pageContext.request.contextPath}/library/ssp" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">SSP</div>
                        <div class="department-description">State Safety Programme</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

                <!-- AIG -->
                <a href="${pageContext.request.contextPath}/library/aig" class="department-folder">
                    <div class="folder-icon">
                        <i class="fa-solid fa-folder"></i>
                    </div>
                    <div>
                        <div class="department-name">AIG</div>
                        <div class="department-description">Accident Investigation</div>
                    </div>
                    <i class="fa-solid fa-chevron-right folder-arrow"></i>
                </a>

            </div>
        </div>

    </main>
</div>

<!-- =====================================================
     FOOTER
===================================================== -->
<footer class="footer">
    CAAB ICT & e-Governance Project Portal,
    version:0.2.1.1,
    Copyright © Civil Aviation Authority Bangladesh,
    2026 All rights reserved.
    <br>
    System Managed by Simec System Limited.
</footer>

<script src="${pageContext.request.contextPath}/training.js"></script>
</body>
</html>