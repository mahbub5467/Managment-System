<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>PEL - CAAB Technical e-Library</title>

    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/pel.css">

</head>


<body>


<!-- =========================================================
     HEADER
========================================================= -->

<div class="header">

    <img
            src="${pageContext.request.contextPath}/resources/images/caab-logo.png"
            class="caab-logo"
            alt="CAAB Logo">


    <div class="header-title">

        <h1>
            Civil Aviation Authority of Bangladesh
        </h1>

        <h2>
            FSR
        </h2>

    </div>


    <div class="header-info">

        Logged on | Day Opened on: <span id="dayOpenedDate"></span> |
        Server Date: <span id="serverDate"></span>

        <br>

        Meteorological Data | Sunrise: | Sunset:

    </div>

</div>


<!-- =========================================================
     NAVBAR
========================================================= -->

<div class="navbar">


    <a
            href="${pageContext.request.contextPath}/library"
            class="home">

        <i class="fa-solid fa-house"></i>

        CAAB Technical e-Library

    </a>


    <div class="nav-right">

        <div class="circle-btn">

            <i class="fa-solid fa-bell"></i>

        </div>


        <div class="circle-btn">

            <i class="fa-solid fa-arrows-rotate"></i>

        </div>


        <form
                action="${pageContext.request.contextPath}/logout"
                method="post"
                style="margin:0;">

            <button
                    type="button"
                    class="logout"
                    onclick="window.location.href='${pageContext.request.contextPath}/logout';">

                <i class="fa-solid fa-power-off"></i>

                Logout

            </button>

        </form>
    </div>

</div>


<!-- =========================================================
     MAIN
========================================================= -->

<div class="main">


    <!-- =====================================================
         BREADCRUMB
    ===================================================== -->

    <div class="breadcrumb">

        <a
                href="${pageContext.request.contextPath}/library">

            CAAB Technical e-Library

        </a>

        <span>›</span>

        <span>PEL</span>

    </div>


    <!-- =====================================================
         PAGE HEADER
    ===================================================== -->
    <div class="page-header">

        <div>

            <h1 class="page-title">
                PEL - Personnel Licensing
            </h1>

            <div class="page-description">

                Manage and organize Personnel Licensing
                books, manuals, regulations and technical
                reference documents.

            </div>

        </div>


        <div class="page-header-actions">




            <!-- CREATE FOLDER -->
            <button
                    type="button"
                    class="create-folder-btn"
                    onclick="openFolderModal()">

                <i class="fa-solid fa-folder-plus"></i>

                Create Folder

            </button>
            <!-- BACK BUTTON -->
            <a
                    href="${pageContext.request.contextPath}/library"
                    class="back-btn">

                <i class="fa-solid fa-arrow-left"></i>

                Back

            </a>

        </div>

    </div>



    <!-- =====================================================
         SUCCESS MESSAGE
    ===================================================== -->

    <c:if test="${not empty success}">

        <div class="alert alert-success">

            <span>

                <i class="fa-solid fa-circle-check"></i>

                <c:out value="${success}"/>

            </span>


            <button
                    type="button"
                    class="alert-close"
                    onclick="this.parentElement.remove()">

                &times;

            </button>

        </div>

    </c:if>


    <!-- =====================================================
         ERROR MESSAGE
    ===================================================== -->

    <c:if test="${not empty error}">

        <div class="alert alert-error">

            <span>

                <i class="fa-solid fa-circle-exclamation"></i>

                <c:out value="${error}"/>

            </span>


            <button
                    type="button"
                    class="alert-close"
                    onclick="this.parentElement.remove()">

                &times;

            </button>

        </div>

    </c:if>


    <!-- =====================================================
         LIBRARY CARD
    ===================================================== -->

    <div class="library-card">


        <!-- CARD HEADER -->

        <div class="card-header">

            <div class="card-title">

                <i class="fa-solid fa-folder-tree"></i>

                PEL Library Folders

            </div>


            <div class="folder-count">

                <c:choose>

                    <c:when test="${not empty folders}">

                        ${folders.size()} Folder(s)

                    </c:when>

                    <c:otherwise>

                        0 Folder(s)

                    </c:otherwise>

                </c:choose>

            </div>

        </div>


        <!-- =================================================
             FOLDER CONTENT
        ================================================= -->

        <c:choose>


            <c:when test="${not empty folders}">

                <div class="folder-grid">


                    <c:forEach
                            var="folder"
                            items="${folders}">


                        <a
                                href="${pageContext.request.contextPath}/library/pel/folder/${folder.id}"
                                class="folder">


                            <!-- THREE DOT MENU -->

                            <button
                                    type="button"
                                    class="folder-menu"
                                    title="Folder Options"
                                    data-folder-id="${folder.id}"
                                    data-folder-name="<c:out value='${folder.name}'/>"
                                    onclick="event.preventDefault(); event.stopPropagation(); openFolderOptions(this);">

                                <i class="fa-solid fa-ellipsis-vertical"></i>

                            </button>


                            <!-- FOLDER OPTIONS MENU -->

                            <div class="folder-options-menu">


                                <!-- RENAME -->

                                <button
                                        type="button"
                                        class="rename-option"
                                        onclick="event.preventDefault(); event.stopPropagation(); renameFolderFromMenu(this);">

                                    <i class="fa-solid fa-pen"></i>

                                    Rename

                                </button>


                                <!-- DELETE -->

                                <button
                                        type="button"
                                        class="delete-option"
                                        onclick="event.preventDefault(); event.stopPropagation(); deleteFolderFromMenu(this);">

                                    <i class="fa-solid fa-trash"></i>

                                    Delete

                                </button>


                            </div>


                            <!-- FOLDER ICON -->

                            <div class="folder-icon">

                                <i class="fa-solid fa-folder"></i>

                            </div>


                            <!-- FOLDER NAME -->

                            <div class="folder-name">

                                <c:out
                                        value="${folder.name}"/>

                            </div>


                            <!-- FOLDER INFO -->

                            <div class="folder-info">

                                Folder

                            </div>


                        </a>


                    </c:forEach>


                </div>

            </c:when>


            <c:otherwise>


                <!-- EMPTY STATE -->

                <div class="empty-folder">


                    <div class="empty-folder-icon">

                        <i class="fa-solid fa-folder-open"></i>

                    </div>


                    <div class="empty-folder-title">

                        No Folders Found

                    </div>


                    <div class="empty-folder-text">

                        Create a new folder to organize
                        your PEL library documents.

                    </div>


                </div>


            </c:otherwise>


        </c:choose>


    </div>


</div>


<!-- =========================================================
     CREATE FOLDER MODAL
========================================================= -->

<div
        class="modal"
        id="folderModal">


    <div class="modal-box">


        <div class="modal-header">

            <h3>

                <i class="fa-solid fa-folder-plus"></i>

                Create New Folder

            </h3>


            <button
                    type="button"
                    class="close"
                    onclick="closeFolderModal()">

                &times;

            </button>

        </div>


        <form
                action="${pageContext.request.contextPath}/library/pel/folder/create"
                method="post">


            <div class="modal-body">

                <label for="folderName">

                    Folder Name

                </label>


                <input
                        type="text"
                        id="folderName"
                        name="folderName"
                        placeholder="Enter folder name"
                        maxlength="120"
                        autocomplete="off"
                        required>

            </div>


            <div class="modal-footer">

                <button
                        type="button"
                        class="cancel-btn"
                        onclick="closeFolderModal()">

                    Cancel

                </button>


                <button
                        type="submit"
                        class="save-btn">

                    <i class="fa-solid fa-check"></i>

                    Create Folder

                </button>

            </div>

        </form>

    </div>

</div>


<!-- =========================================================
     RENAME FOLDER MODAL
========================================================= -->

<div
        class="modal"
        id="renameFolderModal">


    <div class="modal-box">


        <div class="modal-header">

            <h3>

                <i class="fa-solid fa-pen"></i>

                Rename Folder

            </h3>


            <button
                    type="button"
                    class="close"
                    onclick="closeRenameModal()">

                &times;

            </button>

        </div>


        <form
                id="renameFolderForm"
                method="post">


            <div class="modal-body">

                <label for="renameFolderName">

                    Folder Name

                </label>


                <input
                        type="text"
                        id="renameFolderName"
                        name="folderName"
                        maxlength="120"
                        autocomplete="off"
                        required>

            </div>


            <div class="modal-footer">

                <button
                        type="button"
                        class="cancel-btn"
                        onclick="closeRenameModal()">

                    Cancel

                </button>


                <button
                        type="submit"
                        class="save-btn">

                    <i class="fa-solid fa-check"></i>

                    Rename

                </button>

            </div>

        </form>

    </div>

</div>


<!-- =========================================================
     DELETE FOLDER CONFIRMATION MODAL
========================================================= -->

<div
        id="deleteFolderModal"
        class="delete-modal">


    <!-- DARK OVERLAY -->

    <div class="delete-modal-overlay"></div>


    <!-- MODAL BOX -->

    <div class="delete-modal-box">


        <!-- DELETE ICON -->

        <div class="delete-modal-icon">

            <i class="fa-solid fa-trash-can"></i>

        </div>


        <!-- CONTENT -->

        <div class="delete-modal-content">


            <h3>

                Delete Folder?

            </h3>


            <p>

                Are you sure you want to delete
                this folder?

            </p>


            <!-- FOLDER NAME -->

            <div class="delete-folder-name">

                <i class="fa-solid fa-folder"></i>


                <span id="deleteFolderName">

                    Folder Name

                </span>

            </div>


            <!-- WARNING -->

            <div class="delete-warning">

                <i class="fa-solid fa-circle-exclamation"></i>

                This action cannot be undone.
                All files inside this folder may also
                be affected.

            </div>


        </div>


        <!-- BUTTONS -->

        <div class="delete-modal-actions">


            <!-- CANCEL -->

            <button
                    type="button"
                    class="modal-cancel-btn"
                    onclick="closeDeleteFolderModal()">

                <i class="fa-solid fa-xmark"></i>

                Cancel

            </button>


            <!-- DELETE -->

            <button
                    type="button"
                    class="modal-delete-btn"
                    onclick="confirmDeleteFolder()">

                <i class="fa-solid fa-trash"></i>

                Delete

            </button>


        </div>


    </div>

</div>


<!-- =========================================================
     FOOTER
========================================================= -->

<div class="footer">

    CAAB ICT & e-Governance Project Portal,
    version:0.2.1.1,
    Copyright © Civil Aviation Authority Bangladesh,
    2026 All rights reserved.

    <br>

    System Managed by Simec System Limited.
</div>


<script>
    window.contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/pel.js"></script>


</body>

</html>