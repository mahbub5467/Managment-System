/* =====================================================
   SUPERVISOR ASSESSMENT
===================================================== */

let selectedRecordId = null;


/* =====================================================
   GET CONTEXT PATH
===================================================== */

function getContextPath() {

    const body = document.body;

    if (
        body &&
        body.dataset &&
        typeof body.dataset.contextPath !== "undefined"
    ) {
        return body.dataset.contextPath || "";
    }

    /*
     * JSP body-তে data-context-path না থাকলে
     * current URL থেকে context path বের করার চেষ্টা।
     */
    const path = window.location.pathname;

    if (!path || path === "/") {
        return "";
    }

    /*
     * Common Spring Boot context path handling.
     * যদি application root-এ চলে, empty return করবে।
     */
    const parts = path.split("/").filter(Boolean);

    if (parts.length === 0) {
        return "";
    }

    /*
     * যদি তোমার application context path থাকে,
     * body data attribute ব্যবহার করাই সবচেয়ে reliable।
     */
    return "";
}


/* =====================================================
   OPEN ASSESSMENT MODAL
===================================================== */

function openAssessmentModal(
    id,
    employeeId,
    employeeName
) {

    selectedRecordId = id;

    const modal =
        document.getElementById("assessmentModal");

    const modalEmployeeId =
        document.getElementById("modalEmployeeId");

    const modalEmployeeName =
        document.getElementById("modalEmployeeName");

    const remarks =
        document.getElementById("remarks");


    if (!modal) {

        console.error(
            "Assessment modal not found."
        );

        return;
    }


    /* Employee ID */

    if (modalEmployeeId) {

        modalEmployeeId.textContent =
            employeeId || "";

    }


    /* Employee Name */

    if (modalEmployeeName) {

        modalEmployeeName.textContent =
            employeeName || "";

    }


    /* Clear remarks */

    if (remarks) {

        remarks.value = "";

    }


    /* Reset counter */

    updateRemarksCounter();


    /* Reset buttons */

    resetAssessmentButtons();


    /* Show modal */

    modal.style.display = "flex";

    document.body.style.overflow = "hidden";


    /* Focus remarks */

    if (remarks) {

        setTimeout(function () {

            remarks.focus();

        }, 100);

    }

}


/* =====================================================
   CLOSE ASSESSMENT MODAL
===================================================== */

function closeAssessmentModal() {

    const modal =
        document.getElementById("assessmentModal");


    if (modal) {

        modal.style.display = "none";

    }


    document.body.style.overflow = "";


    selectedRecordId = null;


    const remarks =
        document.getElementById("remarks");


    if (remarks) {

        remarks.value = "";

    }


    updateRemarksCounter();

    resetAssessmentButtons();

}


/* =====================================================
   RESET ASSESSMENT BUTTONS
===================================================== */

function resetAssessmentButtons() {

    const approveButton =
        document.querySelector(".btn-approve");

    const rejectButton =
        document.querySelector(".btn-reject");

    const cancelButton =
        document.querySelector(".btn-cancel");


    if (approveButton) {

        approveButton.disabled = false;

        approveButton.innerHTML =
            '<i class="fa-solid fa-circle-check"></i> Assess';

    }


    if (rejectButton) {

        rejectButton.disabled = false;

        rejectButton.innerHTML =
            '<i class="fa-solid fa-circle-xmark"></i> Reject';

    }


    if (cancelButton) {

        cancelButton.disabled = false;

    }

}


/* =====================================================
   SUBMIT ASSESSMENT
===================================================== */

function submitAssessment(action) {

    /* -------------------------------------------------
       Validate record
    ------------------------------------------------- */

    if (
        selectedRecordId === null ||
        selectedRecordId === undefined ||
        String(selectedRecordId).trim() === ""
    ) {

        alert("Invalid training record.");

        return;

    }


    /* -------------------------------------------------
       Validate action
    ------------------------------------------------- */

    if (
        action !== "approve" &&
        action !== "reject"
    ) {

        alert("Invalid assessment action.");

        return;

    }


    /* -------------------------------------------------
       Remarks
    ------------------------------------------------- */

    const remarks =
        document.getElementById("remarks");


    if (!remarks) {

        alert("Remarks field not found.");

        return;

    }


    const comment =
        remarks.value.trim();


    if (comment === "") {

        alert(
            "Please enter supervisor remarks."
        );

        remarks.focus();

        return;

    }


    /* -------------------------------------------------
       Confirmation
    ------------------------------------------------- */

    const actionText =
        action === "approve"
            ? "approve"
            : "reject";


    const confirmation =
        confirm(
            "Are you sure you want to "
            + actionText
            + " this training record?"
        );


    if (!confirmation) {

        return;

    }


    /* -------------------------------------------------
       Form
    ------------------------------------------------- */

    const form =
        document.getElementById("assessmentForm");


    if (!form) {

        alert("Assessment form not found.");

        return;

    }


    /* -------------------------------------------------
       Context path
    ------------------------------------------------- */

    const contextPath =
        getContextPath();


    /* -------------------------------------------------
       Assessment URL
    ------------------------------------------------- */

    const url =
        contextPath
        + "/supervisor-assessment/"
        + action
        + "/"
        + encodeURIComponent(
            selectedRecordId
        );


    /* -------------------------------------------------
       Make sure comment is submitted
    ------------------------------------------------- */

    let hiddenComment =
        document.getElementById(
            "assessmentRemarks"
        );


    /*
     * JSP-তে hidden input না থাকলেও
     * এখানে automatically create হবে।
     */

    if (!hiddenComment) {

        hiddenComment =
            document.createElement("input");

        hiddenComment.type = "hidden";

        hiddenComment.id =
            "assessmentRemarks";

        hiddenComment.name =
            "comment";

        form.appendChild(hiddenComment);

    }


    hiddenComment.value =
        comment;


    /* -------------------------------------------------
       Set form
    ------------------------------------------------- */

    form.action = url;

    form.method = "POST";


    /* -------------------------------------------------
       Disable buttons
    ------------------------------------------------- */

    const approveButton =
        document.querySelector(".btn-approve");

    const rejectButton =
        document.querySelector(".btn-reject");

    const cancelButton =
        document.querySelector(".btn-cancel");


    if (approveButton) {

        approveButton.disabled = true;

    }


    if (rejectButton) {

        rejectButton.disabled = true;

    }


    if (cancelButton) {

        cancelButton.disabled = true;

    }


    /* -------------------------------------------------
       Loading text
    ------------------------------------------------- */

    if (action === "approve") {

        if (approveButton) {

            approveButton.innerHTML =
                '<i class="fa-solid fa-spinner fa-spin"></i> Processing...';

        }

    } else {

        if (rejectButton) {

            rejectButton.innerHTML =
                '<i class="fa-solid fa-spinner fa-spin"></i> Processing...';

        }

    }


    /* -------------------------------------------------
       Submit
    ------------------------------------------------- */

    form.submit();

}


/* =====================================================
   TABLE SEARCH
===================================================== */

/*
 * JSP-তে search input:
 *
 * <input
 *     type="text"
 *     id="tableSearch"
 *     placeholder="Search..."
 * >
 *
 * থাকলেই এই search কাজ করবে।
 */

function initializeTableSearch() {

    const searchInput =
        document.getElementById("tableSearch");


    const table =
        document.querySelector(".assessment-table");


    if (!searchInput || !table) {

        return;

    }


    const tbody =
        table.querySelector("tbody");


    if (!tbody) {

        return;

    }


    const rows =
        Array.from(
            tbody.querySelectorAll("tr")
        );


    /*
     * Search event
     */

    searchInput.addEventListener(
        "input",
        function () {

            const searchValue =
                this.value
                    .trim()
                    .toLowerCase();


            let visibleCount = 0;


            rows.forEach(function (row) {

                /*
                 * Empty row / no-record row skip
                 */

                if (
                    row.classList.contains("search-empty-row")
                ) {

                    return;

                }


                const rowText =
                    row.textContent
                        .toLowerCase()
                        .replace(/\s+/g, " ")
                        .trim();


                const matched =
                    searchValue === ""
                    ||
                    rowText.includes(
                        searchValue
                    );


                if (matched) {

                    row.style.display = "";

                    visibleCount++;

                } else {

                    row.style.display = "none";

                }

            });


            updateSearchCount(
                visibleCount,
                searchValue,
                tbody
            );

        }
    );

}


/* =====================================================
   SEARCH COUNT
===================================================== */

function updateSearchCount(
    visibleCount,
    searchValue,
    tbody
) {

    const summaryCount =
        document.querySelector(".summary-count");


    if (summaryCount) {

        summaryCount.textContent =
            visibleCount;

    }


    /*
     * Existing "No Training Records Found"
     * row থাকলে search-এর জন্য আলাদা row তৈরি
     * করা হবে।
     */

    let emptySearchRow =
        tbody.querySelector(
            ".search-empty-row"
        );


    if (searchValue !== "" && visibleCount === 0) {

        if (!emptySearchRow) {

            emptySearchRow =
                document.createElement("tr");

            emptySearchRow.className =
                "search-empty-row";


            const td =
                document.createElement("td");

            const columnCount =
                document.querySelectorAll(
                    ".assessment-table thead th"
                ).length || 1;


            td.colSpan =
                columnCount;

            td.className =
                "empty";


            td.innerHTML =
                '<div class="empty-icon">' +
                '<i class="fa-solid fa-magnifying-glass"></i>' +
                '</div>' +

                '<div class="empty-title">' +
                'No Matching Records' +
                '</div>' +

                '<div class="empty-text">' +
                'No training record matches your search.' +
                '</div>';


            emptySearchRow.appendChild(td);

            tbody.appendChild(
                emptySearchRow
            );

        }


        emptySearchRow.style.display = "";

    } else {

        if (emptySearchRow) {

            emptySearchRow.style.display =
                "none";

        }

    }

}


/* =====================================================
   CLEAR TABLE SEARCH
===================================================== */

function clearTableSearch() {

    const searchInput =
        document.getElementById("tableSearch");


    if (searchInput) {

        searchInput.value = "";

        searchInput.dispatchEvent(
            new Event("input")
        );

        searchInput.focus();

    }

}


/* =====================================================
   REMARKS COUNTER
===================================================== */

function updateRemarksCounter() {

    const remarks =
        document.getElementById("remarks");


    const counter =
        document.querySelector(
            ".remarks-counter"
        );


    if (!remarks || !counter) {

        return;

    }


    counter.textContent =
        remarks.value.length
        + " / 1000 characters";

}


/* =====================================================
   INITIALIZATION
===================================================== */

document.addEventListener(
    "DOMContentLoaded",
    function () {


        /* ---------------------------------------------
           Modal closed by default
        --------------------------------------------- */

        const modal =
            document.getElementById(
                "assessmentModal"
            );


        if (modal) {

            modal.style.display = "none";

        }


        document.body.style.overflow = "";


        selectedRecordId = null;


        /* ---------------------------------------------
           Search
        --------------------------------------------- */

        initializeTableSearch();


        /* ---------------------------------------------
           Remarks counter
        --------------------------------------------- */

        const remarks =
            document.getElementById(
                "remarks"
            );


        if (remarks) {

            remarks.addEventListener(
                "input",
                updateRemarksCounter
            );

            updateRemarksCounter();

        }

    }
);


/* =====================================================
   CLOSE MODAL - OUTSIDE CLICK
===================================================== */

window.addEventListener(
    "click",
    function (event) {

        const modal =
            document.getElementById(
                "assessmentModal"
            );


        if (
            modal &&
            event.target === modal &&
            modal.style.display === "flex"
        ) {

            closeAssessmentModal();

        }

    }
);


/* =====================================================
   ESC KEY
===================================================== */

document.addEventListener(
    "keydown",
    function (event) {

        if (
            event.key === "Escape" ||
            event.key === "Esc"
        ) {

            const modal =
                document.getElementById(
                    "assessmentModal"
                );


            if (
                modal &&
                modal.style.display === "flex"
            ) {

                closeAssessmentModal();

            }

        }

    }
);


/* =====================================================
   CTRL + ENTER
===================================================== */

document.addEventListener(
    "keydown",
    function (event) {

        if (
            event.ctrlKey &&
            event.key === "Enter"
        ) {

            const modal =
                document.getElementById(
                    "assessmentModal"
                );


            if (
                modal &&
                modal.style.display === "flex"
            ) {

                const approveButton =
                    document.querySelector(
                        ".btn-approve"
                    );


                if (
                    approveButton &&
                    !approveButton.disabled
                ) {

                    submitAssessment(
                        "approve"
                    );

                }

            }

        }

    }
);