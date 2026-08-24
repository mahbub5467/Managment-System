/* =====================================================
   PRINT RECORD
===================================================== */

function printRecord(id) {

    if (!id) {
        alert("Invalid training record.");
        return;
    }

    const contextPath = "${pageContext.request.contextPath}";

    window.open(
        contextPath + "/training-record/print/" + id,
        "_blank"
    );
}


/* =====================================================
   DOM READY
===================================================== */

document.addEventListener("DOMContentLoaded", function () {

    const searchInput =
        document.getElementById("tableSearch");

    const clearButton =
        document.getElementById("clearSearch");

    const tableBody =
        document.getElementById("trainingTableBody");

    const noSearchResult =
        document.getElementById("noSearchResult");

    const recordCount =
        document.getElementById("recordCount");


    /*
     * IMPORTANT:
     * JSP uses:
     *
     * <tr class="training-row">
     *
     * So JS must use .training-row
     */

    const rows =
        document.querySelectorAll(".training-row");


    /* =================================================
       UPDATE RECORD COUNT
    ================================================= */

    function updateRecordCount(count) {

        if (recordCount) {
            recordCount.textContent = count;
        }

    }


    /* =================================================
       INITIAL COUNT
    ================================================= */

    updateRecordCount(rows.length);


    /* =================================================
       SEARCH INPUT NOT FOUND
    ================================================= */

    if (!searchInput) {
        return;
    }


    /* =================================================
       SEARCH
    ================================================= */

    searchInput.addEventListener("input", function () {

        const searchText =
            searchInput.value
                .trim()
                .toLowerCase();


        let visibleCount = 0;


        /* ---------------------------------------------
           LOOP THROUGH RECORDS
        --------------------------------------------- */

        rows.forEach(function (row) {

            /*
             * Search entire row text.
             *
             * This means user can search:
             * Employee ID
             * Employee Name
             * Designation
             * Training Type
             * Course
             * Training Date
             * Certificate Date
             * Approved
             * etc.
             */

            const searchData =
                row.textContent
                    .trim()
                    .toLowerCase();


            /* -----------------------------------------
               MATCH
            ----------------------------------------- */

            if (
                searchText === "" ||
                searchData.includes(searchText)
            ) {

                row.style.display = "";

                visibleCount++;

            } else {

                row.style.display = "none";

            }

        });


        /* =================================================
           UPDATE COUNT
        ================================================= */

        updateRecordCount(visibleCount);


        /* =================================================
           NO SEARCH RESULT
        ================================================= */

        if (noSearchResult) {

            if (
                searchText !== "" &&
                visibleCount === 0
            ) {

                noSearchResult.style.display = "table-row";

            } else {

                noSearchResult.style.display = "none";

            }

        }


        /* =================================================
           CLEAR BUTTON
        ================================================= */

        if (clearButton) {

            if (searchText !== "") {

                clearButton.classList.add("show");

            } else {

                clearButton.classList.remove("show");

            }

        }

    });


    /* =================================================
       ESCAPE KEY
    ================================================= */

    searchInput.addEventListener("keydown", function (event) {

        if (
            event.key === "Escape" ||
            event.key === "Esc"
        ) {

            clearTableSearch();

        }

    });


});


/* =====================================================
   CLEAR TABLE SEARCH
===================================================== */

function clearTableSearch() {

    const searchInput =
        document.getElementById("tableSearch");

    const clearButton =
        document.getElementById("clearSearch");

    const noSearchResult =
        document.getElementById("noSearchResult");

    const recordCount =
        document.getElementById("recordCount");


    /*
     * IMPORTANT:
     * Same class as JSP:
     *
     * <tr class="training-row">
     */

    const rows =
        document.querySelectorAll(".training-row");


    /* =================================================
       CLEAR INPUT
    ================================================= */

    if (searchInput) {

        searchInput.value = "";

        searchInput.focus();

    }


    /* =================================================
       SHOW ALL RECORDS
    ================================================= */

    rows.forEach(function (row) {

        row.style.display = "";

    });


    /* =================================================
       UPDATE COUNT
    ================================================= */

    if (recordCount) {

        recordCount.textContent = rows.length;

    }


    /* =================================================
       HIDE NO RESULT
    ================================================= */

    if (noSearchResult) {

        noSearchResult.style.display = "none";

    }


    /* =================================================
       HIDE CLEAR BUTTON
    ================================================= */

    if (clearButton) {

        clearButton.classList.remove("show");

    }

}