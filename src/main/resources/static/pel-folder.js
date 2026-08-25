/* =========================================================
   CAAB Technical E-Library - PEL Folder Management
   Main JavaScript
   ========================================================= */

/* =========================================================
   SHOW SELECTED PDF
   ========================================================= */

function showSelectedFile() {
    const input = document.getElementById("fileInput");
    const selectedFile = document.getElementById("selectedFile");

    if (!input || !selectedFile) return;

    if (input.files.length === 0) {
        selectedFile.innerHTML = "No PDF file selected.";
        return;
    }

    const file = input.files[0];
    const fileName = file.name.toLowerCase();

    // Check Extension
    if (!fileName.endsWith(".pdf")) {
        alert("Only PDF files (.pdf) are allowed.");
        input.value = "";
        selectedFile.innerHTML = "No PDF file selected.";
        return;
    }

    // Check MIME Type (allow application/pdf or application/x-pdf)
    if (file.type && !file.type.includes("pdf")) {
        alert("Only PDF files are allowed.");
        input.value = "";
        selectedFile.innerHTML = "No PDF file selected.";
        return;
    }

    selectedFile.innerHTML =
        '<i class="fa-solid fa-file-pdf"></i> Selected: <strong>' +
        escapeHtml(file.name) +
        "</strong>";
}

/* =========================================================
   VALIDATE PDF BEFORE SUBMIT
   ========================================================= */

function validatePdfUpload() {
    const input = document.getElementById("fileInput");

    if (!input || input.files.length === 0) {
        alert("Please select a PDF file to upload.");
        return false;
    }

    const file = input.files[0];
    const fileName = file.name.toLowerCase();

    if (!fileName.endsWith(".pdf")) {
        alert("Only PDF files (.pdf) are allowed.");
        input.value = "";
        return false;
    }

    if (file.type && !file.type.includes("pdf")) {
        alert("Only PDF files are allowed.");
        input.value = "";
        return false;
    }

    return true;
}

/* =========================================================
   DELETE MODAL
   ========================================================= */

let deleteForm = null;

function openDeleteModal(button) {
    if (!button) return;

    deleteForm = button.closest(".delete-form");

    const fileName = button.getAttribute("data-file-name");
    const fileNameElement = document.getElementById("deleteFileName");

    if (fileNameElement) {
        fileNameElement.textContent = fileName || "Unknown file";
    }

    const modal = document.getElementById("deleteModal");
    if (!modal) return;

    modal.classList.add("show");
    document.body.style.overflow = "hidden";
}

function closeDeleteModal() {
    const modal = document.getElementById("deleteModal");
    if (modal) {
        modal.classList.remove("show");
    }

    document.body.style.overflow = "";
    deleteForm = null;
}

function confirmDelete() {
    if (!deleteForm) return;
    deleteForm.submit();
}

/* =========================================================
   GLOBAL MODAL EVENT LISTENERS
   ========================================================= */

// Close when clicking outside overlay
document.addEventListener("click", function (event) {
    const modal = document.getElementById("deleteModal");
    const overlay = document.querySelector(".delete-modal-overlay");

    if (modal && overlay && modal.classList.contains("show") && event.target === overlay) {
        closeDeleteModal();
    }
});

// ESC Key Close
document.addEventListener("keydown", function (event) {
    if (event.key !== "Escape") return;

    const modal = document.getElementById("deleteModal");
    if (modal && modal.classList.contains("show")) {
        closeDeleteModal();
    }
});

/* =========================================================
   HTML ESCAPE UTILITY
   ========================================================= */

function escapeHtml(value) {
    if (!value) return "";
    return value
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

/* =========================================================
   AUTO HIDE ALERT
   ========================================================= */

document.addEventListener("DOMContentLoaded", function () {
    setTimeout(function () {
        document.querySelectorAll(".alert").forEach(function (alert) {
            alert.style.transition = "opacity .4s ease";
            alert.style.opacity = "0";

            setTimeout(function () {
                alert.remove();
            }, 400);
        });
    }, 5000);

    /* Dynamic Date Population for Header */
    const todayStr = new Date().toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "short",
        year: "numeric"
    }).replace(/ /g, "-");

    const dayOpened = document.getElementById("dayOpenedDate");
    const serverDate = document.getElementById("serverDate");

    if (dayOpened) dayOpened.textContent = todayStr;
    if (serverDate) serverDate.textContent = todayStr;
});

/* =========================================================
   BOOK / PDF SEARCH
   ========================================================= */

document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("bookSearchInput");
    const clearButton = document.getElementById("clearBookSearch");
    const resultInfo = document.getElementById("searchResultInfo");
    const fileList = document.querySelector(".file-list");

    if (!searchInput) return;

    const fileRows = fileList ? Array.from(fileList.querySelectorAll(".file-row")) : [];
    const totalFiles = fileRows.length;

    function searchBooks() {
        const searchText = searchInput.value.trim().toLowerCase();
        let visibleCount = 0;

        if (totalFiles === 0) {
            if (resultInfo) resultInfo.textContent = "No PDF files available in this folder.";
            return;
        }

        fileRows.forEach(function (row) {
            const fileNameElement = row.querySelector(".file-name");
            const fileTypeElement = row.querySelector(".file-type");

            const fileName = fileNameElement ? fileNameElement.textContent.toLowerCase() : "";
            const fileType = fileTypeElement ? fileTypeElement.textContent.toLowerCase() : "";

            const matched = fileName.includes(searchText) || fileType.includes(searchText);

            if (matched) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }
        });

        /* Clear button toggle */
        if (clearButton) {
            if (searchText.length > 0) {
                clearButton.classList.add("show");
            } else {
                clearButton.classList.remove("show");
            }
        }

        /* Result message update */
        if (!resultInfo) return;

        if (searchText.length === 0) {
            resultInfo.textContent = "Showing all " + totalFiles + " PDF file(s).";
            removeNoResultMessage();
            return;
        }

        if (visibleCount === 0) {
            resultInfo.textContent = 'No PDF found for "' + searchInput.value + '".';
            showNoResultMessage();
        } else {
            resultInfo.textContent = "Found " + visibleCount + " PDF file(s).";
            removeNoResultMessage();
        }
    }

    function showNoResultMessage() {
        if (!fileList) return;
        let message = document.getElementById("noSearchResult");

        if (message) return;

        message = document.createElement("div");
        message.id = "noSearchResult";
        message.className = "no-search-result";
        message.innerHTML = `
            <i class="fa-solid fa-magnifying-glass"></i>
            <div class="no-search-result-title">No Matching PDF Found</div>
            <div class="no-search-result-text">Try searching with a different book or PDF name.</div>
        `;

        fileList.appendChild(message);
    }

    function removeNoResultMessage() {
        const message = document.getElementById("noSearchResult");
        if (message) message.remove();
    }

    /* Event Listeners for Search */
    searchInput.addEventListener("input", searchBooks);

    if (clearButton) {
        clearButton.addEventListener("click", function () {
            searchInput.value = "";
            searchBooks();
            searchInput.focus();
        });
    }

    searchInput.addEventListener("keydown", function (event) {
        if (event.key === "Escape") {
            searchInput.value = "";
            searchBooks();
        }
    });
});