/* =========================================================
   CAAB Technical E-Library - PEL
   Main JavaScript
   ========================================================= */

/* Context Path safety fallback (JSP-তে window.contextPath না থাকলে fallback dynamic context path নিবে) */
const getContextPath = () => {
    return window.contextPath !== undefined ? window.contextPath : '';
};


/* =========================================================
   CREATE FOLDER MODAL
   ========================================================= */

function openFolderModal() {
    const modal = document.getElementById("folderModal");
    const input = document.getElementById("folderName");

    if (!modal) return;

    modal.style.display = "flex";

    if (input) {
        input.value = "";
        setTimeout(function () {
            input.focus();
        }, 100);
    }
}

function closeFolderModal() {
    const modal = document.getElementById("folderModal");
    if (!modal) return;
    modal.style.display = "none";
}


/* =========================================================
   RENAME FOLDER MODAL
   ========================================================= */

function renameFolderFromMenu(button) {
    if (!button) return;

    const folderMenu = button.closest(".folder-options-menu");
    if (!folderMenu) return;

    const folder = folderMenu.closest(".folder");
    if (!folder) return;

    const menuButton = folder.querySelector(".folder-menu");
    if (!menuButton) return;

    const id = menuButton.getAttribute("data-folder-id");
    const name = menuButton.getAttribute("data-folder-name");

    if (!id) {
        console.error("Folder ID not found.");
        return;
    }

    /* Close three-dot menu */
    folderMenu.style.display = "none";

    renameFolder(id, name);
}

function renameFolder(id, name) {
    const modal = document.getElementById("renameFolderModal");
    const input = document.getElementById("renameFolderName");
    const form = document.getElementById("renameFolderForm");

    if (!modal || !input || !form) {
        console.error("Rename modal elements not found.");
        return;
    }

    input.value = name || "";

    form.action = getContextPath() + "/library/pel/folder/rename/" + encodeURIComponent(id);

    modal.style.display = "flex";

    setTimeout(function () {
        input.focus();
        input.select();
    }, 100);
}

function closeRenameModal() {
    const modal = document.getElementById("renameFolderModal");
    if (!modal) return;
    modal.style.display = "none";
}


/* =========================================================
   FOLDER THREE DOT MENU
   ========================================================= */

function openFolderOptions(button) {
    if (!button) return;

    const menu = button.nextElementSibling;
    if (!menu) return;

    const isCurrentlyOpen = menu.style.display === "block";

    /* Close all open folder menus */
    document.querySelectorAll(".folder-options-menu").forEach(function (m) {
        m.style.display = "none";
    });

    /* Toggle current menu */
    if (!isCurrentlyOpen) {
        menu.style.display = "block";
    }
}


/* =========================================================
   DELETE FOLDER
   ========================================================= */

let deleteFolderId = null;
let deleteFolderNameValue = null;

function deleteFolderFromMenu(button) {
    if (!button) return;

    const optionsMenu = button.closest(".folder-options-menu");
    if (!optionsMenu) return;

    const folder = optionsMenu.closest(".folder");
    if (!folder) return;

    const menuButton = folder.querySelector(".folder-menu");
    if (!menuButton) return;

    deleteFolderId = menuButton.getAttribute("data-folder-id");
    deleteFolderNameValue = menuButton.getAttribute("data-folder-name");

    if (!deleteFolderId) {
        console.error("Folder ID not found.");
        return;
    }

    const deleteName = document.getElementById("deleteFolderName");
    if (deleteName) {
        deleteName.textContent = deleteFolderNameValue || "Unknown Folder";
    }

    /* Close options menu */
    optionsMenu.style.display = "none";

    /* Open delete modal */
    const deleteModal = document.getElementById("deleteFolderModal");
    if (!deleteModal) return;

    deleteModal.classList.add("show");
    document.body.style.overflow = "hidden";
}

function closeDeleteFolderModal() {
    const modal = document.getElementById("deleteFolderModal");
    if (!modal) return;

    modal.classList.remove("show");
    document.body.style.overflow = "";

    deleteFolderId = null;
    deleteFolderNameValue = null;
}

function confirmDeleteFolder() {
    if (!deleteFolderId) {
        console.error("No folder selected for deletion.");
        return;
    }

    const form = document.createElement("form");
    form.method = "POST";
    form.action = getContextPath() + "/library/pel/folder/delete/" + encodeURIComponent(deleteFolderId);

    document.body.appendChild(form);
    form.submit();
}


/* =========================================================
   GLOBAL EVENT LISTENERS
   ========================================================= */

/* Click outside modals to close */
window.addEventListener("click", function (event) {
    const createModal = document.getElementById("folderModal");
    if (createModal && event.target === createModal) {
        closeFolderModal();
    }

    const renameModal = document.getElementById("renameFolderModal");
    if (renameModal && event.target === renameModal) {
        closeRenameModal();
    }
});

/* Delete Modal overlay click */
document.addEventListener("click", function (event) {
    const modal = document.getElementById("deleteFolderModal");
    const overlay = document.querySelector(".delete-modal-overlay");

    if (modal && overlay && modal.classList.contains("show") && event.target === overlay) {
        closeDeleteFolderModal();
    }
});

/* Close folder options when clicking anywhere outside */
document.addEventListener("click", function (event) {
    if (event.target.closest(".folder-menu") || event.target.closest(".folder-options-menu")) {
        return;
    }

    document.querySelectorAll(".folder-options-menu").forEach(function (menu) {
        menu.style.display = "none";
    });
});

/* ESC Key support */
document.addEventListener("keydown", function (event) {
    if (event.key !== "Escape") return;

    closeFolderModal();
    closeRenameModal();
    closeDeleteFolderModal();

    document.querySelectorAll(".folder-options-menu").forEach(function (menu) {
        menu.style.display = "none";
    });
});

/* Auto hide alerts */
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
});function updateDates() {
    const now = new Date();

    const options = {
        timeZone: 'Asia/Dhaka',
        day: '2-digit',
        month: 'short',
        year: 'numeric'
    };

    const currentDate = now
        .toLocaleDateString('en-GB', options)
        .replace(/ /g, '-');

    document.getElementById('dayOpenedDate').textContent = currentDate;
    document.getElementById('serverDate').textContent = currentDate;
}

updateDates();