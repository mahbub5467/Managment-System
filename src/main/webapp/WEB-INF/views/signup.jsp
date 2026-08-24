<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>

<head>

    <title>Create Account</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container">

    <div class="row justify-content-center mt-5">

        <div class="col-md-6">

            <div class="card shadow">

                <div class="card-header bg-success text-white">

                    <h3>Create Account</h3>

                </div>

                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                                ${error}
                        </div>
                    </c:if>
                    <form action="/signup" method="post">

                        <div class="mb-3">

                            <label>Full Name</label>

                            <input
                                    type="text"
                                    name="fullName"
                                    class="form-control"
                                    required>

                        </div>

                        <div class="mb-3">

                            <label>Username</label>

                            <input
                                    type="text"
                                    name="username"
                                    class="form-control"
                                    required>

                        </div>

                        <div class="mb-3">

                            <label>Email</label>

                            <input
                                    type="email"
                                    name="email"
                                    class="form-control"
                                    required>

                        </div>

                        <div class="mb-3">

                            <label>Password</label>

                            <input
                                    type="password"
                                    name="password"
                                    class="form-control"
                                    required>

                        </div>

                        <div class="mb-3">

                            <label>Confirm Password</label>

                            <input
                                    type="password"
                                    name="confirmPassword"
                                    class="form-control"
                                    required>

                        </div>

                        <button
                                class="btn btn-success w-100">

                            Register

                        </button>

                    </form>

                    <hr>

                    <div class="text-center">

                        Already have an account?

                        <br><br>

                        <a href="/"

                           class="btn btn-outline-primary">

                            Login

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>