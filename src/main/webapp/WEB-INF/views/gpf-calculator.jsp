<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="bn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>GPF Calculator</title>

    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/gpf.css">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-success text-white">
            <h3>GPF Calculator</h3>
        </div>

        <div class="card-body">

            <h4 class="text-center text-secondary">
                GPF Calculation Module
            </h4>

            <!-- ================= Basic Information ================= -->
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5>Basic Information</h5>
                </div>

                <div class="card-body">
                    <div class="row">

                        <div class="col-md-4">
                            <label class="form-label">Fiscal Year</label>
                            <select id="fiscalYear" class="form-select"></select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Opening Balance</label>
                            <input type="number"
                                   id="openingBalance"
                                   class="form-control"
                                   value="0">
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Current Interest Rate</label>

                            <div id="openingRateDisplay"
                                 class="alert alert-info mb-1">
                                --
                            </div>

                            <div id="contribRateDisplay"
                                 class="alert alert-secondary py-1 px-2 mb-0 rate-display">
                                --
                            </div>
                        </div>

                    </div>
                </div>
            </div>


            <!-- ================= Interest Slab ================= -->
            <div class="card mb-4">

                <div class="card-header bg-success text-white">
                    <h5>Interest Slab Configuration</h5>
                </div>

                <div class="card-body">

                    <div class="row" id="slabInputs">

                        <div class="col-md-2 mb-3">
                            <label class="form-label">Tier 1 Cap</label>
                            <input type="number"
                                   id="tier1Cap"
                                   class="form-control"
                                   value="1500000">
                        </div>

                        <div class="col-md-2 mb-3">
                            <label class="form-label">Tier 1 Rate %</label>
                            <input type="number"
                                   id="tier1Rate"
                                   class="form-control"
                                   step="0.01"
                                   value="13">
                        </div>

                        <div class="col-md-2 mb-3">
                            <label class="form-label">Tier 2 Cap</label>
                            <input type="number"
                                   id="tier2Cap"
                                   class="form-control"
                                   value="1500000">
                        </div>

                        <div class="col-md-2 mb-3">
                            <label class="form-label">Tier 2 Rate %</label>
                            <input type="number"
                                   id="tier2Rate"
                                   class="form-control"
                                   step="0.01"
                                   value="12">
                        </div>

                        <div class="col-md-2 mb-3">
                            <label class="form-label">Tier 3 Rate %</label>
                            <input type="number"
                                   id="tier3Rate"
                                   class="form-control"
                                   step="0.01"
                                   value="11">
                        </div>

                    </div>

                </div>
            </div>


            <!-- ================= Slab Breakdown ================= -->
            <div class="card mb-4">

                <div class="card-header bg-warning">
                    <h5>Slab Breakdown</h5>
                </div>

                <div class="card-body">
                    <div id="slabBreakdown"></div>
                </div>

            </div>


            <!-- ================= Monthly Contribution ================= -->
            <div class="card mb-4">

                <div class="card-header bg-info text-white">
                    <h5>Monthly Contribution</h5>
                </div>

                <div class="card-body">

                    <div class="mb-3">

                        <div class="form-check form-check-inline">

                            <input class="form-check-input"
                                   type="radio"
                                   name="contribMode"
                                   id="sameContribution"
                                   value="same"
                                   checked>

                            <label class="form-check-label"
                                   for="sameContribution">
                                Same Contribution Every Month
                            </label>

                        </div>


                        <div class="form-check form-check-inline">

                            <input class="form-check-input"
                                   type="radio"
                                   name="contribMode"
                                   id="differentContribution"
                                   value="different">

                            <label class="form-check-label"
                                   for="differentContribution">
                                Different Contribution
                            </label>

                        </div>

                    </div>


                    <!-- Same Contribution -->
                    <div id="sameContribField">

                        <div class="row">

                            <div class="col-md-4">

                                <label class="form-label">
                                    Monthly Contribution Amount
                                </label>

                                <input type="number"
                                       id="sameContribAmount"
                                       class="form-control"
                                       value="0">

                            </div>

                        </div>

                    </div>


                    <!-- Different Contribution -->
                    <div id="diffContribFields"
                         class="row hidden">
                    </div>

                </div>
            </div>


            <!-- ================= Loan Information ================= -->
            <div class="card mb-4">

                <div class="card-header bg-danger text-white">
                    <h5>Loan Information</h5>
                </div>

                <div class="card-body">

                    <div class="table-responsive">

                        <table class="table table-bordered table-hover">

                            <thead class="table-dark">

                            <tr>
                                <th>Year</th>
                                <th>Month</th>
                                <th>Loan Type</th>
                                <th>Loan Amount</th>
                                <th>Installments</th>
                                <th width="100">Action</th>
                            </tr>

                            </thead>

                            <tbody id="loanTableBody"></tbody>

                        </table>

                    </div>


                    <button type="button"
                            id="addLoanBtn"
                            class="btn btn-success">
                        + Add Loan
                    </button>

                </div>
            </div>


            <!-- ================= Recovery Section ================= -->
            <div class="card mb-4">

                <div class="card-header bg-secondary text-white">
                    <h5>Loan Recovery</h5>
                </div>

                <div class="card-body">

                    <div class="row">

                        <div class="col-md-12 mb-3">

                            <div class="form-check form-check-inline">

                                <input class="form-check-input"
                                       type="radio"
                                       name="recoveryMode"
                                       id="autoNext"
                                       value="auto_next"
                                       checked>

                                <label class="form-check-label"
                                       for="autoNext">
                                    Auto Recovery (Next Month)
                                </label>

                            </div>


                            <div class="form-check form-check-inline">

                                <input class="form-check-input"
                                       type="radio"
                                       name="recoveryMode"
                                       id="autoSame"
                                       value="auto_same">

                                <label class="form-check-label"
                                       for="autoSame">
                                    Auto Recovery (Same Month)
                                </label>

                            </div>


                            <div class="form-check form-check-inline">

                                <input class="form-check-input"
                                       type="radio"
                                       name="recoveryMode"
                                       id="manualRecovery"
                                       value="manual">

                                <label class="form-check-label"
                                       for="manualRecovery">
                                    Manual Recovery
                                </label>

                            </div>

                        </div>

                    </div>


                    <!-- Auto Recovery View -->
                    <div id="recoveryAutoView"
                         class="alert alert-success">

                        Monthly recovery will be generated automatically
                        based on the refundable loan amount and installment.

                    </div>


                    <!-- Manual Recovery -->
                    <div id="recoveryManualView"
                         class="row hidden">
                    </div>

                </div>
            </div>


            <!-- ================= Action Buttons ================= -->
            <div class="card mb-4">

                <div class="card-body text-center">

                    <button id="calcBtn"
                            type="button"
                            class="btn btn-success btn-lg">
                        Calculate GPF
                    </button>


                    <button id="resetBtn"
                            type="button"
                            class="btn btn-warning btn-lg">
                        Reset
                    </button>


                    <button id="printBtn"
                            type="button"
                            class="btn btn-primary btn-lg">
                        Print
                    </button>


                    <a href="/index"
                       class="btn btn-danger btn-lg">
                        Back Dashboard
                    </a>

                </div>

            </div>


            <!-- ================= Output Panel ================= -->
            <div id="panel-output" class="hidden">


                <!-- Print-only Header -->
                <div class="print-only report-header">

                    <h2>
                        সাধারণ ভবিষ্য তহবিল (জিপিএফ) হিসাব বিবরণী
                    </h2>

                    <div class="office-name">
                        GPF Calculation Statement
                    </div>

                    <div class="report-meta">

                        <span>
                            অর্থবছর:
                            <strong id="printFiscalYear">--</strong>
                        </span>

                        <span>
                            প্রারম্ভিক স্থিতি:
                            <strong id="printOpeningBalance">--</strong>
                        </span>

                        <span>
                            প্রস্তুতের তারিখ:
                            <strong id="printGeneratedDate">--</strong>
                        </span>

                    </div>

                </div>


                <!-- ================= Summary ================= -->
                <div class="card mt-4">

                    <div class="card-header bg-success text-white">
                        <h4>Calculation Summary</h4>
                    </div>

                    <div class="card-body">

                        <div id="summaryGrid"
                             class="row g-3">
                        </div>

                    </div>

                </div>


                <!-- ================= Opening Balance Tracking ================= -->
                <div class="card mt-4">

                    <div class="card-header bg-primary text-white">
                        <h4>Opening Balance Interest Tracking</h4>
                    </div>

                    <div class="card-body">

                        <div class="table-responsive">

                            <table class="table table-bordered table-striped">

                                <thead class="table-dark">

                                <tr>
                                    <th>Month</th>
                                    <th>Opening Balance</th>
                                    <th>Loan Deduction</th>
                                    <th>Interest Balance</th>
                                    <th>Rate %</th>
                                    <th>Interest</th>
                                    <th>Closing Balance</th>
                                </tr>

                                </thead>

                                <tbody id="openingBalanceTrackTableBody">
                                </tbody>

                            </table>

                        </div>

                    </div>
                </div>


                <!-- ================= Monthly Interest ================= -->
                <div class="card mt-4">

                    <div class="card-header bg-info text-white">
                        <h4>Monthly Contribution &amp; Interest</h4>
                    </div>

                    <div class="card-body">

                        <div class="table-responsive">

                            <table class="table table-bordered table-hover">

                                <thead class="table-dark">

                                <tr>
                                    <th>Month</th>
                                    <th>Contribution</th>
                                    <th>Recovery</th>
                                    <th>Eligible Amount</th>
                                    <th>Rate</th>
                                    <th>Interest Month</th>
                                    <th>Interest</th>
                                </tr>

                                </thead>

                                <tbody id="monthlyTableBody">
                                </tbody>

                            </table>

                        </div>

                    </div>
                </div>


                <!-- ================= Loan Details ================= -->
                <div class="card mt-4">

                    <div class="card-header bg-danger text-white">
                        <h4>Loan Details</h4>
                    </div>

                    <div class="card-body">

                        <div class="table-responsive">

                            <table class="table table-bordered">

                                <thead class="table-dark">

                                <tr>
                                    <th>Loan Month</th>
                                    <th>Type</th>
                                    <th>Loan Amount</th>
                                    <th>Interest</th>
                                    <th>Status</th>
                                </tr>

                                </thead>

                                <tbody id="loanDetailTableBody">
                                </tbody>

                            </table>

                        </div>

                    </div>
                </div>


                <!-- ================= Closing Statement ================= -->
                <div class="card mt-4 mb-5">

                    <div class="card-header bg-dark text-white">
                        <h4>Closing Balance Statement</h4>
                    </div>

                    <div class="card-body">

                        <div class="table-responsive">

                            <table class="table table-bordered">

                                <thead class="table-dark">

                                <tr>
                                    <th>Description</th>
                                    <th>Amount</th>
                                </tr>

                                </thead>

                                <tbody id="closingTableBody">
                                </tbody>

                            </table>

                        </div>

                    </div>
                </div>


                <!-- Print-only Footer -->
                <div class="print-only report-footer">

                    <div class="sig-box">
                        প্রস্তুতকারীর স্বাক্ষর
                    </div>

                    <div class="sig-box">
                        যাচাইকারীর স্বাক্ষর
                    </div>

                </div>

            </div>


            <a href="/index"
               class="btn btn-primary">
                Back Dashboard
            </a>

        </div>

    </div>

</div>


<!-- JavaScript -->
<script src="/script.js"></script>

</body>
</html>