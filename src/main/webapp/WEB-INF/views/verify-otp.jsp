<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <title>Verify OTP</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card shadow">

                <div class="card-header bg-primary text-white">

                    <h3>Email Verification</h3>

                </div>

                <div class="card-body">

                    <form action="/verify-otp" method="post">

                        <input
                                type="hidden"
                                name="email"
                                value="${email}">

                        <div class="mb-3">

                            <label>Enter OTP</label>

                            <input
                                    type="text"
                                    name="otp"
                                    class="form-control"
                                    maxlength="6"
                                    required>

                        </div>

                        <button
                                class="btn btn-primary w-100">

                            Verify

                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>