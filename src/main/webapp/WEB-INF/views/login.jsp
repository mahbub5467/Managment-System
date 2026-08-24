<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

    <title>GPF Management System - Login</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

    <style>

        body{
            background: linear-gradient(135deg,#0d6efd,#20c997);
            height:100vh;
        }

        .login-card{
            border:none;
            border-radius:15px;
        }

        .logo{
            width:80px;
            height:80px;
            background:white;
            border-radius:50%;
            display:flex;
            align-items:center;
            justify-content:center;
            margin:auto;
            font-size:35px;
            color:#0d6efd;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="row justify-content-center align-items-center vh-100">

        <div class="col-md-5">

            <div class="card login-card shadow-lg">

                <div class="card-body p-5">

                    <div class="logo mb-3">
                        <i class="fa-solid fa-landmark"></i>
                    </div>

                    <h3 class="text-center fw-bold">
                        Management System
                    </h3>

                    <p class="text-center text-muted">
                        Government
                    </p>

                    <hr>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success">
                                ${success}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                                ${error}
                        </div>
                    </c:if>

                    <form action="/login" method="post">

                        <div class="mb-3">
                            <label class="form-label">Username / Email</label>
                            <input type="text"
                                   name="username"
                                   class="form-control"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password"
                                   name="password"
                                   class="form-control"
                                   required>
                        </div>

                        <button type="submit"
                                class="btn btn-primary w-100">

                            <i class="fa-solid fa-right-to-bracket"></i>

                            Login

                        </button>

                    </form>

                    <hr>

                    <div class="text-center">

                        Don't have an account?

                        <br><br>

                        <a href="/signup"
                           class="btn btn-outline-success">

                            Create Account

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>