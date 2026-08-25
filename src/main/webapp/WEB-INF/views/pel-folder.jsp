<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ${folder.name} - PEL - CAAB Technical E-Library
    </title>

    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">


    <!-- Custom CSS -->
    <link rel="stylesheet" href="/pel-folder.css">

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


        <a
                href="${pageContext.request.contextPath}/library/pel">

            PEL

        </a>

        <span>›</span>


        <span>

            <c:out value="${folder.name}"/>

        </span>

    </div>


    <!-- =====================================================
         PAGE HEADER
    ===================================================== -->

    <div class="page-header">

        <div>

            <h1 class="page-title">

                <i class="fa-solid fa-folder-open"></i>

                <c:out value="${folder.name}"/>

            </h1>


            <div class="page-description">

                Manage and organize PDF documents,
                manuals, regulations and technical
                reference files in this folder.

            </div>

        </div>


        <a
                href="${pageContext.request.contextPath}/library/pel"
                class="back-btn">

            <i class="fa-solid fa-arrow-left"></i>

            Back

        </a>

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
         FILE LIBRARY CARD
    ===================================================== -->

    <div class="library-card">


        <!-- =================================================
             CARD HEADER
        ================================================= -->

        <div class="card-header">

            <div class="card-title">

                <i class="fa-solid fa-file-pdf"></i>

                PDF Files in

                <c:out value="${folder.name}"/>

            </div>


            <div class="file-count">

                <c:choose>

                    <c:when test="${not empty files}">

                        ${files.size()} File(s)

                    </c:when>

                    <c:otherwise>

                        0 File(s)

                    </c:otherwise>

                </c:choose>

            </div>

        </div>

        <!-- =================================================
     BOOK SEARCH
================================================= -->

        <div class="book-search-area">

            <div class="book-search-box">

                <i class="fa-solid fa-magnifying-glass search-icon"></i>

                <input
                        type="text"
                        id="bookSearchInput"
                        class="book-search-input"
                        placeholder="Search book / PDF name..."
                        autocomplete="off">

                <button
                        type="button"
                        id="clearBookSearch"
                        class="clear-search-btn"
                        title="Clear Search">

                    <i class="fa-solid fa-xmark"></i>

                </button>

            </div>

            <div
                    id="searchResultInfo"
                    class="search-result-info">

                Showing all PDF files

            </div>

        </div>


        <!-- =================================================
             PDF UPLOAD AREA
        ================================================= -->

        <div class="upload-area">

            <form
                    class="upload-form"
                    action="${pageContext.request.contextPath}/library/pel/folder/${folder.id}/upload"
                    method="post"
                    enctype="multipart/form-data"
                    onsubmit="return validatePdfUpload();">


                <div class="file-input-wrapper">

                    <input
                            type="file"
                            id="fileInput"
                            name="file"
                            class="file-input"
                            accept="application/pdf,.pdf"
                            required
                            onchange="showSelectedFile()">

                </div>


                <button
                        type="submit"
                        class="upload-btn">

                    <i class="fa-solid fa-file-pdf"></i>

                    Upload PDF

                </button>

            </form>


            <div
                    id="selectedFile"
                    class="selected-file">

                Please select file.

            </div>

        </div>


        <!-- =================================================
             FILE CONTENT
        ================================================= -->

        <c:choose>


            <c:when test="${not empty files}">

                <div class="file-list">


                    <c:forEach
                            var="file"
                            items="${files}">


                        <div class="file-row">


                            <!-- FILE INFORMATION -->

                            <div class="file-info">


                                <div class="file-icon">

                                    <i class="fa-solid fa-file-pdf"></i>

                                </div>


                                <div class="file-details">


                                    <div
                                            class="file-name"
                                            title="<c:out value='${file.fileName}'/>">

                                        <c:out
                                                value="${file.fileName}"/>

                                    </div>


                                    <div class="file-type">

                                        <c:choose>


                                            <c:when
                                                    test="${not empty file.contentType}">

                                                <c:out
                                                        value="${file.contentType}"/>

                                            </c:when>


                                            <c:otherwise>

                                                application/pdf

                                            </c:otherwise>


                                        </c:choose>

                                    </div>

                                </div>

                            </div>


                            <!-- FILE ACTIONS -->

                            <div class="file-actions">


                                <!-- VIEW

                                <a
                                        href="${pageContext.request.contextPath}/library/pel/file/${file.id}"
                                        target="_blank"
                                        class="file-action view-btn"
                                        title="View PDF">

                                    <i class="fa-solid fa-eye"></i>

                                </a>
                                -->

                                <!-- DOWNLOAD -->

                                <a
                                        href="${pageContext.request.contextPath}/library/pel/file/download/${file.id}"
                                        class="file-action download-btn"
                                        title="Download PDF">

                                    <i class="fa-solid fa-download"></i>

                                </a>


                                <!-- DELETE -->

                                <form
                                        class="delete-form"
                                        method="post"
                                        action="${pageContext.request.contextPath}/library/pel/file/delete/${file.id}">


                                    <button
                                            type="button"
                                            class="file-action delete-btn"
                                            title="Delete PDF"
                                            data-file-name="<c:out value='${file.fileName}'/>"
                                            onclick="openDeleteModal(this)">

                                        <i class="fa-solid fa-trash"></i>

                                    </button>

                                </form>


                            </div>

                        </div>


                    </c:forEach>

                </div>

            </c:when>


            <c:otherwise>


                <!-- EMPTY STATE -->

                <div class="empty-files">


                    <div class="empty-files-icon">

                        <i class="fa-solid fa-folder-open"></i>

                    </div>


                    <div class="empty-files-title">

                        No PDF Files Found

                    </div>


                    <div class="empty-files-text">

                        This folder is currently empty.
                        Select a PDF file above to upload it.

                    </div>

                </div>


            </c:otherwise>


        </c:choose>


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


<!-- =========================================================
     DELETE CONFIRMATION MODAL
========================================================= -->

<div
        id="deleteModal"
        class="delete-modal">


    <!-- OVERLAY -->

    <div class="delete-modal-overlay"></div>


    <!-- MODAL -->

    <div class="delete-modal-box">


        <!-- ICON -->

        <div class="delete-modal-icon">

            <i class="fa-solid fa-trash-can"></i>

        </div>


        <!-- CONTENT -->

        <div class="delete-modal-content">


            <h3>
                Delete PDF?
            </h3>


            <p>

                Are you sure you want to delete
                this file?

            </p>


            <!-- FILE NAME -->

            <div class="delete-file-name">

                <i class="fa-solid fa-file-pdf"></i>

                <span id="deleteFileName">

                    file.pdf

                </span>

            </div>


            <!-- WARNING -->

            <div class="delete-warning">

                <i class="fa-solid fa-circle-exclamation"></i>

                This action cannot be undone.

            </div>


        </div>


        <!-- BUTTONS -->

        <div class="delete-modal-actions">


            <!-- CANCEL -->

            <button
                    type="button"
                    class="modal-cancel-btn"
                    onclick="closeDeleteModal()">

                <i class="fa-solid fa-xmark"></i>

                Cancel

            </button>


            <!-- DELETE -->

            <button
                    type="button"
                    class="modal-delete-btn"
                    onclick="confirmDelete()">

                <i class="fa-solid fa-trash"></i>

                Delete

            </button>


        </div>


    </div>

</div>

<script src="/pel-folder.js"></script>

</body>

</html>