document.addEventListener("DOMContentLoaded", function () {

    // Dynamic Context Path Helper
    const getContextPath = () => {
        return window.contextPath !== undefined ? window.contextPath : '';
    };

    // DOM Elements
    const trainingType = document.getElementById("trainingType");
    const trainingEntryArea = document.getElementById("trainingEntryArea");
    const dynamicTitle = document.getElementById("dynamicSectionTitle");

    // Certification Elements
    const certRadios = document.querySelectorAll('input[name="certification"]');
    const certDateGroup = document.getElementById("certificateDateGroup");
    const certFileGroup = document.getElementById("certificateFileGroup");
    const certDateInput = document.getElementById("certificateDate");
    const certFileInput = document.getElementById("certificateFile");
    const fileSelectedText = document.getElementById("fileSelectedText");

    // Employee Elements
    const employeeId = document.getElementById("employeeId");
    const employeeName = document.getElementById("employeeName");
    const designation = document.getElementById("designation");
    const joiningDate = document.getElementById("joiningDate");
    const employeeSearchBtn = document.getElementById("employeeSearchBtn");
    const employeeSearchStatus = document.getElementById("employeeSearchStatus");

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
       1. TRAINING TYPE CHANGE (SHOW BLOCK & DYNAMIC TITLE)
    ====================================================== */
    if (trainingType && trainingEntryArea) {
        trainingType.addEventListener("change", function () {
            const selectedValue = this.value;

            if (selectedValue) {
                const selectedText = this.options[this.selectedIndex].text;
                if (dynamicTitle) {
                    dynamicTitle.textContent = selectedText + " Details";
                }
                trainingEntryArea.classList.remove("hidden");
            } else {
                trainingEntryArea.classList.add("hidden");
            }
        });
    }

    /* =====================================================
       2. CERTIFICATION TOGGLE LOGIC (DEFAULT 'NO')
    ====================================================== */
    function toggleCertificationFields(isYes) {
        if (isYes) {
            if (certDateGroup) certDateGroup.classList.remove("hidden");
            if (certFileGroup) certFileGroup.classList.remove("hidden");
            if (certDateInput) certDateInput.disabled = false;
            if (certFileInput) certFileInput.disabled = false;
        } else {
            if (certDateGroup) certDateGroup.classList.add("hidden");
            if (certFileGroup) certFileGroup.classList.add("hidden");
            if (certDateInput) {
                certDateInput.disabled = true;
                certDateInput.value = "";
            }
            if (certFileInput) {
                certFileInput.disabled = true;
                certFileInput.value = "";
                if (fileSelectedText) fileSelectedText.textContent = "Please select file";
            }
        }
    }

    certRadios.forEach(function (radio) {
        radio.addEventListener("change", function () {
            toggleCertificationFields(this.value === "yes");
        });
    });

    // Initial check (Defaults to No)
    const checkedCert = document.querySelector('input[name="certification"]:checked');
    toggleCertificationFields(checkedCert && checkedCert.value === "yes");

    /* =====================================================
       3. FILE VALIDATION & TEXT UPDATE
    ====================================================== */
    if (certFileInput) {
        certFileInput.addEventListener("change", function () {
            const file = this.files[0];

            if (!file) {
                if (fileSelectedText) fileSelectedText.textContent = "Please select file";
                return;
            }

            const allowed = [".pdf", ".jpg", ".jpeg", ".png"];
            const fileName = file.name.toLowerCase();

            const valid = allowed.some(function (ext) {
                return fileName.endsWith(ext);
            });

            if (!valid) {
                alert("Only PDF, JPG, JPEG and PNG files are allowed.");
                this.value = "";
                if (fileSelectedText) fileSelectedText.textContent = "Please select file";
                return;
            }

            if (file.size > 10 * 1024 * 1024) {
                alert("Certificate file size must not exceed 10 MB.");
                this.value = "";
                if (fileSelectedText) fileSelectedText.textContent = "Please select file";
                return;
            }

            if (fileSelectedText) {
                fileSelectedText.textContent = "Selected: " + file.name;
            }
        });
    }

    /* =====================================================
       4. EMPLOYEE SEARCH LOGIC (AUTO-LOAD & EDITABLE)
    ====================================================== */
    function formatDate(dateValue) {
        if (!dateValue) return "";
        if (typeof dateValue === "string" && /^\d{4}-\d{2}-\d{2}$/.test(dateValue)) {
            return dateValue;
        }

        const date = new Date(dateValue);
        if (isNaN(date.getTime())) return "";

        return (
            date.getFullYear() + "-" +
            String(date.getMonth() + 1).padStart(2, "0") + "-" +
            String(date.getDate()).padStart(2, "0")
        );
    }

    let isSearching = false;

    async function searchEmployee() {
        if (!employeeId || isSearching) return;
        const id = employeeId.value.trim();

        if (!id) {
            if (employeeSearchStatus) {
                employeeSearchStatus.textContent = "Please enter Employee ID.";
                employeeSearchStatus.className = "employee-search-status error";
            }
            return;
        }

        isSearching = true;

        if (employeeSearchBtn) {
            employeeSearchBtn.disabled = true;
            employeeSearchBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i>';
        }

        if (employeeSearchStatus) {
            employeeSearchStatus.textContent = "Searching employee...";
            employeeSearchStatus.className = "employee-search-status loading";
        }

        try {
            const response = await fetch(
                getContextPath() + "/employee/search/" + encodeURIComponent(id),
                {
                    method: "GET",
                    headers: { "Accept": "application/json" }
                }
            );

            if (!response.ok) {
                throw new Error("Employee not found in database. You can fill out the details manually.");
            }

            const data = await response.json();

            if (employeeName && (data.name || data.employeeName)) {
                employeeName.value = data.name || data.employeeName;
            }
            if (designation && (data.designation || data.employeeDesignation)) {
                designation.value = data.designation || data.employeeDesignation;
            }
            if (joiningDate && (data.joiningDate || data.joinDate)) {
                joiningDate.value = formatDate(data.joiningDate || data.joinDate);
            }

            if (employeeSearchStatus) {
                employeeSearchStatus.textContent = "Employee information loaded successfully! You can edit if needed.";
                employeeSearchStatus.className = "employee-search-status success";
            }
        } catch (error) {
            if (employeeSearchStatus) {
                employeeSearchStatus.textContent = error.message || "Employee not found. You can enter details manually.";
                employeeSearchStatus.className = "employee-search-status error";
            }
        } finally {
            isSearching = false;
            if (employeeSearchBtn) {
                employeeSearchBtn.disabled = false;
                employeeSearchBtn.innerHTML = '<i class="fa-solid fa-magnifying-glass"></i>';
            }
        }
    }

    if (employeeSearchBtn) {
        employeeSearchBtn.addEventListener("click", searchEmployee);
    }

    if (employeeId) {
        employeeId.addEventListener("keydown", function (event) {
            if (event.key === "Enter") {
                event.preventDefault();
                searchEmployee();
            }
        });
    }

    /* =====================================================
       5. FORM SUBMIT VALIDATION
    ====================================================== */
    const trainingForm = document.getElementById("trainingForm");

    if (trainingForm) {
        trainingForm.addEventListener("submit", function (event) {
            if (trainingType && !trainingType.value) {
                event.preventDefault();
                alert("Please select Training Type.");
                trainingType.focus();
                return;
            }

            if (!trainingForm.checkValidity()) {
                event.preventDefault();
                trainingForm.reportValidity();
                return;
            }
        });
    }

});