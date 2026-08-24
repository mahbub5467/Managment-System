
    // =========================================================
    // SHOW SELECTED PDF
    // =========================================================

    function showSelectedFile() {

    const input =
    document.getElementById("fileInput");

    const selectedFile =
    document.getElementById("selectedFile");


    if (input.files.length === 0) {

    selectedFile.innerHTML =
    "No PDF file selected.";

    return;
}


    const file =
    input.files[0];


    const fileName =
    file.name.toLowerCase();


    // CHECK EXTENSION

    if (!fileName.endsWith(".pdf")) {

    alert("Only PDF files are allowed.");

    input.value = "";

    selectedFile.innerHTML =
    "No PDF file selected.";

    return;
}


    // CHECK MIME TYPE

    if (
    file.type &&
    file.type !== "application/pdf"
    ) {

    alert("Only PDF files are allowed.");

    input.value = "";

    selectedFile.innerHTML =
    "No PDF file selected.";

    return;
}


    selectedFile.innerHTML =
    '<i class="fa-solid fa-file-pdf"></i> ' +
    'Selected: <strong>' +
    escapeHtml(file.name) +
    '</strong>';

}


    // =========================================================
    // VALIDATE PDF BEFORE SUBMIT
    // =========================================================

    function validatePdfUpload() {

    const input =
    document.getElementById("fileInput");


    if (input.files.length === 0) {

    alert("Please select a PDF file.");

    return false;
}


    const file =
    input.files[0];


    const fileName =
    file.name.toLowerCase();


    // CHECK EXTENSION

    if (!fileName.endsWith(".pdf")) {

    alert("Only PDF files are allowed.");

    input.value = "";

    return false;
}


    // CHECK MIME TYPE

    if (
    file.type &&
    file.type !== "application/pdf"
    ) {

    alert("Only PDF files are allowed.");

    input.value = "";

    return false;
}


    return true;

}


    // =========================================================
    // DELETE MODAL
    // =========================================================

    let deleteForm = null;


    // =========================================================
    // OPEN DELETE MODAL
    // =========================================================

    function openDeleteModal(button) {

    deleteForm =
        button.closest(".delete-form");


    const fileName =
    button.getAttribute("data-file-name");


    const fileNameElement =
    document.getElementById(
    "deleteFileName"
    );


    fileNameElement.textContent =
    fileName || "Unknown file";


    const modal =
    document.getElementById(
    "deleteModal"
    );


    modal.classList.add("show");


    // STOP BACKGROUND SCROLLING

    document.body.style.overflow =
    "hidden";

}


    // =========================================================
    // CLOSE DELETE MODAL
    // =========================================================

    function closeDeleteModal() {

    const modal =
    document.getElementById(
    "deleteModal"
    );


    modal.classList.remove("show");


    // ENABLE SCROLLING

    document.body.style.overflow =
    "";


    deleteForm = null;

}


    // =========================================================
    // CONFIRM DELETE
    // =========================================================

    function confirmDelete() {

    if (!deleteForm) {

    return;

}


    // SUBMIT ORIGINAL DELETE FORM

    deleteForm.submit();

}


    // =========================================================
    // CLOSE WHEN CLICKING OUTSIDE
    // =========================================================

    document.addEventListener(
    "click",
    function (event) {

    const modal =
    document.getElementById(
    "deleteModal"
    );


    const overlay =
    document.querySelector(
    ".delete-modal-overlay"
    );


    if (
    modal.classList.contains("show") &&
    event.target === overlay
    ) {

    closeDeleteModal();

}

}
    );


    // =========================================================
    // ESC KEY CLOSE
    // =========================================================

    document.addEventListener(
    "keydown",
    function (event) {

    if (event.key !== "Escape") {

    return;

}


    const modal =
    document.getElementById(
    "deleteModal"
    );


    if (
    modal.classList.contains("show")
    ) {

    closeDeleteModal();

}

}
    );


    // =========================================================
    // HTML ESCAPE
    // =========================================================

    function escapeHtml(value) {

    return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");

}


    // =========================================================
    // AUTO HIDE ALERT
    // =========================================================

    setTimeout(
    function () {

    document
        .querySelectorAll(".alert")
        .forEach(
            function (alert) {

                alert.style.transition =
                    "opacity .4s ease";

                alert.style.opacity =
                    "0";


                setTimeout(
                    function () {

                        alert.remove();

                    },
                    400
                );

            }
        );

},
    5000
    );
    /* =========================================================
       BOOK / PDF SEARCH
    ========================================================= */

    document.addEventListener("DOMContentLoaded", function () {

        const searchInput =
            document.getElementById("bookSearchInput");

        const clearButton =
            document.getElementById("clearBookSearch");

        const resultInfo =
            document.getElementById("searchResultInfo");

        const fileList =
            document.querySelector(".file-list");


        if (!searchInput || !fileList) {
            return;
        }


        const fileRows =
            Array.from(fileList.querySelectorAll(".file-row"));


        const totalFiles =
            fileRows.length;


        function searchBooks() {

            const searchText =
                searchInput.value
                    .trim()
                    .toLowerCase();


            let visibleCount = 0;


            fileRows.forEach(function (row) {

                const fileNameElement =
                    row.querySelector(".file-name");


                const fileTypeElement =
                    row.querySelector(".file-type");


                const fileName =
                    fileNameElement
                        ? fileNameElement.textContent.toLowerCase()
                        : "";


                const fileType =
                    fileTypeElement
                        ? fileTypeElement.textContent.toLowerCase()
                        : "";


                const matched =
                    fileName.includes(searchText) ||
                    fileType.includes(searchText);


                if (matched) {

                    row.style.display = "";

                    visibleCount++;

                } else {

                    row.style.display = "none";

                }

            });


            /* Clear button */

            if (searchText.length > 0) {

                clearButton.classList.add("show");

            } else {

                clearButton.classList.remove("show");

            }


            /* Result message */

            if (searchText.length === 0) {

                resultInfo.textContent =
                    "Showing all " +
                    totalFiles +
                    " PDF file(s).";

                removeNoResultMessage();

                return;
            }


            if (visibleCount === 0) {

                resultInfo.textContent =
                    "No PDF found for \"" +
                    searchInput.value +
                    "\".";

                showNoResultMessage();

            } else {

                resultInfo.textContent =
                    "Found " +
                    visibleCount +
                    " PDF file(s).";

                removeNoResultMessage();

            }

        }


        /* =====================================================
           SHOW NO RESULT
        ===================================================== */

        function showNoResultMessage() {

            let message =
                document.getElementById("noSearchResult");


            if (message) {
                return;
            }


            message =
                document.createElement("div");


            message.id =
                "noSearchResult";


            message.className =
                "no-search-result";


            message.innerHTML = `

            <i class="fa-solid fa-magnifying-glass"></i>

            <div class="no-search-result-title">
                No Matching PDF Found
            </div>

            <div class="no-search-result-text">
                Try searching with a different book or PDF name.
            </div>

        `;


            fileList.appendChild(message);

        }


        /* =====================================================
           REMOVE NO RESULT
        ===================================================== */

        function removeNoResultMessage() {

            const message =
                document.getElementById("noSearchResult");


            if (message) {

                message.remove();

            }

        }


        /* =====================================================
           SEARCH INPUT
        ===================================================== */

        searchInput.addEventListener(
            "input",
            searchBooks
        );


        /* =====================================================
           CLEAR SEARCH
        ===================================================== */

        clearButton.addEventListener(
            "click",
            function () {

                searchInput.value = "";

                searchBooks();

                searchInput.focus();

            }
        );


        /* =====================================================
           ESC KEY
        ===================================================== */

        searchInput.addEventListener(
            "keydown",
            function (event) {

                if (event.key === "Escape") {

                    searchInput.value = "";

                    searchBooks();

                }

            }
        );

    });


