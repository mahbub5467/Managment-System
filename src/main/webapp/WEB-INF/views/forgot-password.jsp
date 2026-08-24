<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <title>Forgot Password</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card shadow">

                <div class="card-header bg-danger text-white">

                    <h3>Forgot Password</h3>

                </div>

                <div class="card-body">

                    <form action="/forgot-password" method="post">

                        <label>Email</label>

                        <input
                                type="email"
                                name="email"
                                class="form-control"
                                required>

                        <br>

                        <button
                                class="btn btn-danger w-100">

                            Send OTP

                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>