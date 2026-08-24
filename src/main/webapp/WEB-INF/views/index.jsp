
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>

<head>

    <title>Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">


<!-- ================= NAVBAR ================= -->

<nav class="navbar navbar-dark bg-primary">

    <div class="container-fluid">

        <span class="navbar-brand">
            Management System

        </span>

        <a href="/" class="btn btn-light">

            Logout

        </a>

    </div>

</nav>


<!-- ================= DASHBOARD ================= -->

<div class="container mt-5">

    <div class="row">


        <!-- ================= EMPLOYEE ================= -->

        <div class="col-md-4 mb-4">

            <div class="card shadow text-center h-100">

                <div class="card-body">

                    <i class="fa-solid fa-users fa-4x text-primary"></i>

                    <h4 class="mt-3">

                        Employee

                    </h4>

                    <a href="/employee/list"
                       class="btn btn-primary">

                        Open

                    </a>

                </div>

            </div>

        </div>


        <!-- ================= GPF CALCULATOR ================= -->

        <div class="col-md-4 mb-4">

            <div class="card shadow text-center h-100">

                <div class="card-body">

                    <i class="fa-solid fa-calculator fa-4x text-success"></i>

                    <h4 class="mt-3">

                        GPF Calculator

                    </h4>

                    <a href="/gpf/calculator"
                       class="btn btn-success">

                        Calculate

                    </a>

                </div>

            </div>

        </div>


        <!-- ================= SUBSCRIPTION ================= -->

        <div class="col-md-4 mb-4">

            <div class="card shadow text-center h-100">

                <div class="card-body">

                    <i class="fa-solid fa-money-bill fa-4x text-warning"></i>

                    <h4 class="mt-3">

                        Subscription

                    </h4>

                    <button class="btn btn-warning">

                        Coming Soon

                    </button>

                </div>

            </div>

        </div>


        <!-- ================= INTEREST ================= -->

        <div class="col-md-4 mb-4">

            <div class="card shadow text-center h-100">

                <div class="card-body">

                    <i class="fa-solid fa-chart-line fa-4x text-danger"></i>

                    <h4 class="mt-3">

                        Interest

                    </h4>

                    <button class="btn btn-danger">

                        Coming Soon

                    </button>

                </div>

            </div>

        </div>


        <!-- ================= REPORTS ================= -->

        <div class="col-md-4 mb-4">

            <div class="card shadow text-center h-100">

                <div class="card-body">

                    <i class="fa-solid fa-file fa-4x text-info"></i>

                    <h4 class="mt-3">

                        Reports

                    </h4>

                    <button class="btn btn-info">

                        Coming Soon

                    </button>

                </div>

            </div>

        </div>


        <!-- ================= LIBRARY ================= -->

        <div class="col-md-4 mb-4">

            <div class="card shadow text-center h-100">

                <div class="card-body">

                    <i class="fa-solid fa-book-open fa-4x text-secondary"></i>

                    <h4 class="mt-3">

                        Library

                    </h4>

                    <a href="/library"
                       class="btn btn-secondary">

                        Open Library

                    </a>

                </div>

            </div>

        </div>
        <!-- ================= Training ================= -->

        <div class="col-md-4 mb-4">

            <div class="card shadow text-center h-100">

                <div class="card-body">

                    <i class="fa-solid fa-graduation-cap fa-4x text-primary"></i>

                    <h4 class="mt-3">

                        Training

                    </h4>

                    <a href="/training"
                       class="btn btn-info">

                        Training

                    </a>

                </div>

            </div>



    </div>
        <div class="col-md-4 mb-4">

            <div class="card shadow text-center h-100">

                <div class="card-body">

                    <i class="fa-solid fa-graduation-cap fa-4x text-primary"></i>

                    <h4 class="mt-3">

                        Training

                    </h4>

                    <a href="/portfolio"
                       class="btn btn-info">

                        Portfolio
                    </a>

                </div>

            </div>

        </div>
</div>


<!-- ================= BOOTSTRAP JS ================= -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>

