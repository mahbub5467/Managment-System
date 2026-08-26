/* =====================================================
   SUPERVISOR ASSESSMENT MAIN JAVASCRIPT
===================================================== */

let selectedRecordId = null;

/* Context Path Helper */
function getContextPath() {
    return window.contextPath !== undefined ? window.contextPath : '';
}

/* =====================================================
   OPEN ASSESSMENT MODAL
===================================================== */
function openAssessmentModal(id, employeeId, employeeName) {
    selectedRecordId = id;

    const modal = document.getElementById("assessmentModal");
    const modalEmployeeId = document.getElementById("modalEmployeeId");
    const modalEmployeeName = document.getElementById("modalEmployeeName");
    const remarks = document.getElementById("remarks");
    const statusSelect = document.getElementById("assessmentStatus");
    const form = document.getElementById("assessmentForm");

    if (!modal) {
        console.error("Assessment modal not found.");
        return;
    }

    /* Set Modal Form Action URL */
    if (form) {
        form.action = getContextPath() + "/training/supervisor-assessment/save/" + encodeURIComponent(id);
    }

    /* Set Employee Info */
    if (modalEmployeeId) modalEmployeeId.textContent = employeeId || "";
    if (modalEmployeeName) modalEmployeeName.textContent = employeeName || "";

    /* Reset Fields */
    if (remarks) remarks.value = "";
    if (statusSelect) statusSelect.value = "";

    /* Show Modal & Disable Background Scroll */
    modal.style.display = "flex";
    document.body.style.overflow = "hidden";
}

/* =====================================================
   CLOSE ASSESSMENT MODAL
===================================================== */
function closeAssessmentModal() {
    const modal = document.getElementById("assessmentModal");

    if (modal) {
        modal.style.display = "none";
    }

    document.body.style.overflow = "";
    selectedRecordId = null;

    const remarks = document.getElementById("remarks");
    const statusSelect = document.getElementById("assessmentStatus");

    if (remarks) remarks.value = "";
    if (statusSelect) statusSelect.value = "";
}

/* =====================================================
   FILTER TABLE BY TRAINING TYPE (RADIO BUTTONS)
===================================================== */
function filterTableByTrainingType(selectedType) {
    const rows = document.querySelectorAll("#assessmentTable tbody tr");
    rows.forEach(function (row) {
        if (row.classList.contains("search-empty-row")) return;

        const rowType = row.getAttribute("data-training-type");
        if (!rowType) return;

        const sType = (selectedType || "").trim().toLowerCase();
        const rType = rowType.trim().toLowerCase();

        if (sType === "all" || rType === sType) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}

/* =====================================================
   TABLE SEARCH
===================================================== */
function initializeTableSearch() {
    const searchInput = document.getElementById("tableSearch");
    const table = document.querySelector(".assessment-table");

    if (!searchInput || !table) return;

    const tbody = table.querySelector("tbody");
    if (!tbody) return;

    const rows = Array.from(tbody.querySelectorAll("tr"));

    searchInput.addEventListener("input", function () {
        const searchValue = this.value.trim().toLowerCase();
        let visibleCount = 0;

        rows.forEach(function (row) {
            if (row.classList.contains("search-empty-row")) return;

            const rowText = row.textContent.toLowerCase().replace(/\s+/g, " ").trim();
            const matched = searchValue === "" || rowText.includes(searchValue);

            if (matched) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }
        });

        updateSearchCount(visibleCount, searchValue, tbody);
    });
}

/* =====================================================
   SEARCH COUNT & EMPTY RESULT MESSAGE
===================================================== */
function updateSearchCount(visibleCount, searchValue, tbody) {
    let emptySearchRow = tbody.querySelector(".search-empty-row");

    if (searchValue !== "" && visibleCount === 0) {
        if (!emptySearchRow) {
            emptySearchRow = document.createElement("tr");
            emptySearchRow.className = "search-empty-row";

            const td = document.createElement("td");
            const columnCount = document.querySelectorAll("#assessmentTable thead th").length || 10;

            td.colSpan = columnCount;
            td.className = "empty";
            td.innerHTML = `
                <div class="empty-icon"><i class="fa-solid fa-magnifying-glass"></i></div>
                <div class="empty-title">No Matching Records</div>
                <div class="empty-text">No training record matches your search.</div>
            `;

            emptySearchRow.appendChild(td);
            tbody.appendChild(emptySearchRow);
        }
        emptySearchRow.style.display = "";
    } else {
        if (emptySearchRow) {
            emptySearchRow.style.display = "none";
        }
    }
}

/* =====================================================
   CLEAR TABLE SEARCH
===================================================== */
function clearTableSearch() {
    const searchInput = document.getElementById("tableSearch");
    if (searchInput) {
        searchInput.value = "";
        searchInput.dispatchEvent(new Event("input"));
        searchInput.focus();
    }
}

/* =====================================================
   INITIALIZATION & EVENT LISTENERS
===================================================== */
document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("assessmentModal");

    if (modal) {
        modal.style.display = "none";
    }

    document.body.style.overflow = "";
    selectedRecordId = null;

    /* Initialize Table Search */
    initializeTableSearch();

    /* Apply initial filter */
    const selectedRadio = document.querySelector('input[name="trainingTypeFilter"]:checked');
    if (selectedRadio) {
        filterTableByTrainingType(selectedRadio.value);
    } else {
        filterTableByTrainingType("all");
    }

    /* Header Date Population */
    const todayStr = new Date().toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "short",
        year: "numeric"
    }).replace(/ /g, "-");

    const dayOpened = document.getElementById("dayOpenedDate");
    const serverDate = document.getElementById("serverDate");

    if (dayOpened) dayOpened.textContent = todayStr;
    if (serverDate) serverDate.textContent = todayStr;

    /* Form Validation before Submit */
    const form = document.getElementById("assessmentForm");
    if (form) {
        form.addEventListener("submit", function (e) {
            const statusSelect = document.getElementById("assessmentStatus");
            if (statusSelect && !statusSelect.value) {
                e.preventDefault();
                alert("Please select an Assessment Status.");
                statusSelect.focus();
            }
        });
    }
});

/* Close Modal on Outside Click */
window.addEventListener("click", function (event) {
    const modal = document.getElementById("assessmentModal");
    if (modal && event.target === modal && modal.style.display === "flex") {
        closeAssessmentModal();
    }
});

/* ESC Key to Close Modal */
document.addEventListener("keydown", function (event) {
    if (event.key === "Escape" || event.key === "Esc") {
        const modal = document.getElementById("assessmentModal");
        if (modal && modal.style.display === "flex") {
            closeAssessmentModal();
        }
    }
});
