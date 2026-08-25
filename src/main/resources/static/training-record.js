/* =====================================================
   TRAINING RECORD MAIN JAVASCRIPT
===================================================== */

/* Context Path Helper */
function getContextPath() {
    return window.contextPath !== undefined ? window.contextPath : '';
}

/* =====================================================
   PRINT RECORD
===================================================== */
function printRecord(id) {
    if (!id) {
        alert("Invalid training record.");
        return;
    }

    const contextPath = getContextPath();

    window.open(
        contextPath + "/training-record/print/" + encodeURIComponent(id),
        "_blank"
    );
}

/* =====================================================
   RADIO BUTTON FILTER (TRAINING TYPE)
===================================================== */
function filterTableByTrainingType(selectedType) {
    filterTable();
}

/* =====================================================
   UNIFIED SEARCH & FILTER FUNCTION
===================================================== */
function filterTable() {
    const searchInput = document.getElementById("tableSearch");
    const clearButton = document.getElementById("clearSearch");
    const noSearchResult = document.getElementById("noSearchResult");
    const recordCount = document.getElementById("recordCount");
    const rows = document.querySelectorAll(".training-row");

    const searchText = searchInput ? searchInput.value.trim().toLowerCase() : "";
    const selectedRadio = document.querySelector('input[name="trainingTypeFilter"]:checked');
    const selectedType = selectedRadio ? selectedRadio.value.toLowerCase() : "all";

    let visibleCount = 0;

    rows.forEach(function (row) {
        const rowType = (row.getAttribute("data-training-type") || "").toLowerCase();
        const searchData = row.textContent.trim().toLowerCase();

        const matchesType = (selectedType === "all" || rowType === selectedType);
        const matchesSearch = (searchText === "" || searchData.includes(searchText));

        if (matchesType && matchesSearch) {
            row.style.display = "";
            visibleCount++;
        } else {
            row.style.display = "none";
        }
    });

    /* Update Count */
    if (recordCount) {
        recordCount.textContent = visibleCount;
    }

    /* Toggle No Search Result Row */
    if (noSearchResult) {
        if (visibleCount === 0 && rows.length > 0) {
            noSearchResult.style.display = "table-row";
        } else {
            noSearchResult.style.display = "none";
        }
    }

    /* Toggle Clear Button */
    if (clearButton) {
        if (searchText !== "") {
            clearButton.classList.add("show");
        } else {
            clearButton.classList.remove("show");
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
        searchInput.focus();
    }

    /* Reset Radio Filter to 'All' */
    const allRadio = document.querySelector('input[name="trainingTypeFilter"][value="all"]');
    if (allRadio) {
        allRadio.checked = true;
    }

    filterTable();
}

/* =====================================================
   DOM READY
===================================================== */
document.addEventListener("DOMContentLoaded", function () {

    const searchInput = document.getElementById("tableSearch");

    /* Populate Header Dates */
    const todayStr = new Date().toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "short",
        year: "numeric"
    }).replace(/ /g, "-");

    const dayOpened = document.getElementById("dayOpenedDate");
    const serverDate = document.getElementById("serverDate");

    if (dayOpened) dayOpened.textContent = todayStr;
    if (serverDate) serverDate.textContent = todayStr;

    /* Initialize Filter on Load */
    filterTable();

    /* Search Input Listener */
    if (searchInput) {
        searchInput.addEventListener("input", function () {
            filterTable();
        });

        /* Escape Key Support */
        searchInput.addEventListener("keydown", function (event) {
            if (event.key === "Escape" || event.key === "Esc") {
                clearTableSearch();
            }
        });
    }

});