<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <title>Reset Password</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card shadow">

                <div class="card-header bg-warning">

                    <h3>Reset Password</h3>

                </div>

                <div class="card-body">

                    <form action="/reset-password" method="post">

                        <input
                                type="hidden"
                                name="email"
                                value="${email}">

                        <div class="mb-3">

                            <label>OTP</label>

                            <input
                                    type="text"
                                    name="otp"
                                    class="form-control"
                                    required>

                        </div>

                        <div class="mb-3">

                            <label>New Password</label>

                            <input
                                    type="password"
                                    name="password"
                                    class="form-control"
                                    required>

                        </div>

                        <button
                                class="btn btn-warning w-100">

                            Reset Password

                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>