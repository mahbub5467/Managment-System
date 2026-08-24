
    function openFolderModal() {

    const modal =
    document.getElementById("folderModal");

    const input =
    document.getElementById("folderName");


    modal.style.display = "flex";


    input.value = "";


    setTimeout(function () {

    input.focus();

}, 100);

}


    function closeFolderModal() {

    const modal =
    document.getElementById("folderModal");


    modal.style.display = "none";

}


    // =========================================================
    // RENAME FOLDER MODAL
    // =========================================================

    function renameFolderFromMenu(button) {

    const folderMenu =
    button.closest(".folder-options-menu");


    const folder =
    folderMenu.closest(".folder");


    const menuButton =
    folder.querySelector(".folder-menu");


    const id =
    menuButton.getAttribute("data-folder-id");


    const name =
    menuButton.getAttribute("data-folder-name");


    renameFolder(id, name);


    folderMenu.style.display = "none";

}


    function renameFolder(id, name) {

    const modal =
    document.getElementById(
    "renameFolderModal"
    );


    const input =
    document.getElementById(
    "renameFolderName"
    );


    const form =
    document.getElementById(
    "renameFolderForm"
    );


    input.value = name;


    form.action =
    "${pageContext.request.contextPath}/library/pel/folder/rename/"
    + id;


    modal.style.display = "flex";


    setTimeout(function () {

    input.focus();

    input.select();

}, 100);

}


    function closeRenameModal() {

    const modal =
    document.getElementById(
    "renameFolderModal"
    );


    modal.style.display = "none";

}


    // =========================================================
    // FOLDER THREE DOT MENU
    // =========================================================

    function openFolderOptions(button) {

    /*
     * Close every other folder menu first.
     */

    document
        .querySelectorAll(
            ".folder-options-menu"
        )
        .forEach(function (menu) {

            menu.style.display = "none";

        });


    const menu =
    button.nextElementSibling;


    if (!menu) {

    return;

}


    if (
    menu.style.display === "block"
    ) {

    menu.style.display = "none";

} else {

    menu.style.display = "block";

}

}


    // =========================================================
    // DELETE FOLDER - OPEN MODAL
    // =========================================================

    let deleteFolderId = null;

    let deleteFolderNameValue = null;


    function deleteFolderFromMenu(button) {

    const optionsMenu =
    button.closest(
    ".folder-options-menu"
    );


    const folder =
    optionsMenu.closest(".folder");


    const menuButton =
    folder.querySelector(
    ".folder-menu"
    );


    /*
     * Get folder ID.
     */

    deleteFolderId =
    menuButton.getAttribute(
    "data-folder-id"
    );


    /*
     * Get folder name.
     */

    deleteFolderNameValue =
    menuButton.getAttribute(
    "data-folder-name"
    );


    /*
     * Put folder name inside modal.
     */

    document
    .getElementById(
    "deleteFolderName"
    )
    .textContent =
    deleteFolderNameValue ||
    "Unknown Folder";


    /*
     * Close options menu.
     */

    optionsMenu.style.display =
    "none";


    /*
     * Open delete modal.
     */

    document
    .getElementById(
    "deleteFolderModal"
    )
    .classList.add("show");


    /*
     * Disable background scrolling.
     */

    document.body.style.overflow =
    "hidden";

}


    // =========================================================
    // CLOSE DELETE MODAL
    // =========================================================

    function closeDeleteFolderModal() {

    const modal =
    document.getElementById(
    "deleteFolderModal"
    );


    modal.classList.remove("show");


    /*
     * Restore scrolling.
     */

    document.body.style.overflow =
    "";


    deleteFolderId = null;

    deleteFolderNameValue = null;

}


    // =========================================================
    // CONFIRM DELETE FOLDER
    // =========================================================

    function confirmDeleteFolder() {

    if (!deleteFolderId) {

    return;

}


    /*
     * Create POST form dynamically.
     */

    const form =
    document.createElement("form");


    form.method = "POST";


    form.action =
    "${pageContext.request.contextPath}/library/pel/folder/delete/"
    + deleteFolderId;


    /*
     * Add form to document.
     */

    document.body.appendChild(form);


    /*
     * Submit.
     */

    form.submit();

}


    // =========================================================
    // CLICK OUTSIDE CREATE MODAL
    // =========================================================

    window.addEventListener(
    "click",
    function (event) {

    const createModal =
    document.getElementById(
    "folderModal"
    );


    if (
    event.target === createModal
    ) {

    closeFolderModal();

}


    const renameModal =
    document.getElementById(
    "renameFolderModal"
    );


    if (
    event.target === renameModal
    ) {

    closeRenameModal();

}

}
    );


    // =========================================================
    // DELETE MODAL OVERLAY CLICK
    // =========================================================

    document.addEventListener(
    "click",
    function (event) {

    const modal =
    document.getElementById(
    "deleteFolderModal"
    );


    const overlay =
    document.querySelector(
    ".delete-modal-overlay"
    );


    if (
    modal.classList.contains("show") &&
    event.target === overlay
    ) {

    closeDeleteFolderModal();

}

}
    );


    // =========================================================
    // CLOSE FOLDER OPTIONS WHEN CLICKING OUTSIDE
    // =========================================================

    document.addEventListener(
    "click",
    function (event) {

    if (
    !event.target.closest(
    ".folder-menu"
    ) &&
    !event.target.closest(
    ".folder-options-menu"
    )
    ) {

    document
    .querySelectorAll(
    ".folder-options-menu"
    )
    .forEach(function (menu) {

    menu.style.display =
    "none";

});

}

}
    );


    // =========================================================
    // ESC KEY
    // =========================================================

    document.addEventListener(
    "keydown",
    function (event) {

    if (
    event.key !== "Escape"
    ) {

    return;

}


    /*
     * Close create modal.
     */

    const createModal =
    document.getElementById(
    "folderModal"
    );


    if (
    createModal.style.display ===
    "flex"
    ) {

    closeFolderModal();

}


    /*
     * Close rename modal.
     */

    const renameModal =
    document.getElementById(
    "renameFolderModal"
    );


    if (
    renameModal.style.display ===
    "flex"
    ) {

    closeRenameModal();

}


    /*
     * Close delete modal.
     */

    const deleteModal =
    document.getElementById(
    "deleteFolderModal"
    );


    if (
    deleteModal.classList.contains(
    "show"
    )
    ) {

    closeDeleteFolderModal();

}


    /*
     * Close folder option menus.
     */

    document
    .querySelectorAll(
    ".folder-options-menu"
    )
    .forEach(function (menu) {

    menu.style.display =
    "none";

});

}
    );


    // =========================================================
    // AUTO HIDE ALERT
    // =========================================================

    setTimeout(
    function () {

    document
        .querySelectorAll(".alert")
        .forEach(function (alert) {

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

        });

},
    5000
    );

