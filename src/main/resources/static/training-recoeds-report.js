document.addEventListener("DOMContentLoaded", function () {

    // Dynamic Context Path Helper
    const getContextPath = () => {
        return window.contextPath !== undefined ? window.contextPath : '';
    };

    // DOM Elements
    const reportForm = document.querySelector(".search-vertical-form");
    const employeeIdInput = document.getElementById("employeeId");
    const departmentSelect = document.getElementById("department");
    const searchBtn = reportForm ? reportForm.querySelector('button[type="submit"]') : null;

    // Header Date Auto-Population
    const todayStr = new Date().toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "short",
        year: "numeric"
    }).replace(/ /g, "-");

    const dayOpened = document.getElementById("dayOpenedDate");
    const serverDate = document.getElementById("serverDate");
    if (dayOpened) dayOpened.textContent = todayStr;
    if (serverDate) serverDate.textContent = todayStr;

    /* =====================================================
       1. FORM SUBMISSION & TRIM HANDLING
    ====================================================== */
    if (reportForm) {
        reportForm.addEventListener("submit", function (e) {
            // EIIN Inp Trimming
            if (employeeIdInput) {
                employeeIdInput.value = employeeIdInput.value.trim();
            }

            // Search UI State Activation
            if (searchBtn) {
                searchBtn.disabled = true;
                searchBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Searching...';
            }
        });
    }

    /* =====================================================
       2. PDF VIEW BUTTON SPINNER EFFECT
    ====================================================== */
    const pdfButtons = document.querySelectorAll('a[href*="/pdf/"]');
    pdfButtons.forEach(btn => {
        btn.addEventListener("click", function () {
            // Opens PDF in new tab while retaining original button UI
            const originalText = this.innerHTML;
            this.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Opening...';
            setTimeout(() => {
                this.innerHTML = originalText;
            }, 2500);
        });
    });

});