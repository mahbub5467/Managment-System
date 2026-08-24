<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
<head>
    <title>Verify Login OTP</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card shadow">

                <div class="card-header bg-success text-white">

                    <h4>Login Verification</h4>

                </div>

                <div class="card-body">

                    <form action="/verify-login-otp" method="post">

                        <input type="hidden"
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

                        <button
                                class="btn btn-success w-100">

                            Verify OTP

                        </button>

                    </form>

                    <br>

                    <span class="text-danger">

                        ${error}

                    </span>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>