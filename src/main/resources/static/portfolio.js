/* =========================================================
   MAHBUB HASAN AKASH
   PORTFOLIO — MAIN JAVASCRIPT
========================================================= */

document.addEventListener("DOMContentLoaded", () => {

    "use strict";


    /* =====================================================
       01. SCROLL REVEAL
    ===================================================== */

    const revealElements = document.querySelectorAll(".reveal");

    if ("IntersectionObserver" in window) {

        const revealObserver = new IntersectionObserver(
            (entries, observer) => {

                entries.forEach((entry) => {

                    if (entry.isIntersecting) {

                        entry.target.classList.add("visible");

                        observer.unobserve(entry.target);

                    }

                });

            },
            {
                threshold: 0.12
            }
        );


        revealElements.forEach((element) => {
            revealObserver.observe(element);
        });

    } else {

        revealElements.forEach((element) => {
            element.classList.add("visible");
        });

    }


    /* =====================================================
       02. PATH CARDS
    ===================================================== */

    const pathCards = document.querySelectorAll(".path-card");

    pathCards.forEach((card) => {

        card.addEventListener("click", () => {

            const targetSelector = card.dataset.target;

            if (!targetSelector) {
                return;
            }

            let target = null;

            try {
                target = document.querySelector(targetSelector);
            } catch (error) {
                console.warn(
                    "Invalid path-card target:",
                    targetSelector
                );
                return;
            }

            if (target) {

                target.scrollIntoView({
                    behavior: "smooth",
                    block: "start"
                });

            }

        });

    });


    /* =====================================================
       03. TERMINAL
    ===================================================== */

    const terminalModal =
        document.getElementById("terminalModal");

    const openTerminalButton =
        document.getElementById("openTerminal");

    const closeTerminalButton =
        document.getElementById("closeTerminal");

    const terminalInput =
        document.getElementById("terminalInput");

    const terminalOutput =
        document.getElementById("terminalOutput");


    /* =====================================================
       TERMINAL COMMANDS
    ===================================================== */

    const commands = {

        help:
            "commands: about · experience · projects · research · skills · contact · github",

        about:
            "Md. Mahbub Hasan Akash — Software Developer & AI Researcher.",

        experience:
            "Software Support Engineer @ SIMEC System Ltd. — CAAB Enterprise ERP software.",

        projects:
            "Management System · Grading System · Pedestrian Crossing · Automatic Hand Sanitizer.",

        research:
            "Lightweight Vision Transformer-Based U-Net · Swin Transformer · PatchGAN · Medical AI · Computer Vision.",

        skills:
            "Java · Spring Boot · Python · PyTorch · Computer Vision · Microsoft SQL · JavaScript · C/C++",

        contact:
            "Use the Contact section to connect.",

        github:
            "https://github.com/mahbub5467",


    };


    /* =====================================================
       OPEN TERMINAL
    ===================================================== */

    function openTerminal() {

        if (!terminalModal) {
            return;
        }

        terminalModal.classList.add("open");

        terminalModal.setAttribute(
            "aria-hidden",
            "false"
        );

        document.body.style.overflow = "hidden";

        setTimeout(() => {

            if (terminalInput) {
                terminalInput.focus();
            }

        }, 100);

    }


    /* =====================================================
       CLOSE TERMINAL
    ===================================================== */

    function closeTerminal() {

        if (!terminalModal) {
            return;
        }

        terminalModal.classList.remove("open");

        terminalModal.setAttribute(
            "aria-hidden",
            "true"
        );

        document.body.style.overflow = "";

    }


    /* =====================================================
       TERMINAL OPEN BUTTON
    ===================================================== */

    if (openTerminalButton) {

        openTerminalButton.addEventListener(
            "click",
            (event) => {

                event.preventDefault();

                openTerminal();

            }
        );

    }


    /* =====================================================
       TERMINAL CLOSE BUTTON
    ===================================================== */

    if (closeTerminalButton) {

        closeTerminalButton.addEventListener(
            "click",
            (event) => {

                event.preventDefault();

                closeTerminal();

            }
        );

    }


    /* =====================================================
       TERMINAL BACKDROP
    ===================================================== */

    if (terminalModal) {

        terminalModal.addEventListener(
            "click",
            (event) => {

                if (event.target === terminalModal) {

                    closeTerminal();

                }

            }
        );

    }


    /* =====================================================
       PRINT TERMINAL COMMAND
    ===================================================== */

    function printCommand(command, response) {

        if (!terminalOutput) {
            return;
        }

        const wrapper = document.createElement("div");

        wrapper.className = "terminal-line";


        const commandLine = document.createElement("div");

        commandLine.className = "terminal-command";

        commandLine.textContent = `$ ${command}`;


        const responseLine = document.createElement("div");

        responseLine.className = "terminal-response";

        responseLine.textContent = response;


        wrapper.appendChild(commandLine);

        wrapper.appendChild(responseLine);

        terminalOutput.appendChild(wrapper);


        terminalOutput.scrollTop =
            terminalOutput.scrollHeight;

    }


    /* =====================================================
       TERMINAL INPUT
    ===================================================== */

    if (terminalInput) {

        terminalInput.addEventListener(
            "keydown",
            (event) => {

                if (event.key !== "Enter") {
                    return;
                }

                event.preventDefault();


                const query =
                    terminalInput.value
                        .trim()
                        .toLowerCase();


                if (!query) {
                    return;
                }


                /*
                 * Special GitHub command
                 */

                if (query === "github") {

                    printCommand(
                        query,
                        commands.github
                    );

                    terminalInput.value = "";

                    return;

                }

                /* =====================================================
                   TERMINAL COMMAND HANDLER
                ===================================================== */

                if (query === "clear") {

                    terminalOutput.innerHTML = "";

                    terminalInput.value = "";

                    return;
                }


                if (query === "cls") {

                    terminalOutput.innerHTML = "";

                    terminalInput.value = "";

                    return;
                }


                const response =
                    commands[query] ||
                    "Command not found. Type help.";


                printCommand(
                    query,
                    response
                );


                terminalInput.value = "";


            }
        );

    }


    /* =====================================================
       04. CERTIFICATE SYSTEM
    ===================================================== */

    const certificateModal =
        document.getElementById("certificateModal");

    const certificateImage =
        document.getElementById("certificateImage");

    const certificateTitle =
        document.getElementById("certificateModalTitle");

    const certificateCurrent =
        document.getElementById("certificateCurrent");

    const certificateTotal =
        document.getElementById("certificateTotal");

    const closeCertificateButton =
        document.getElementById("closeCertificate");

    const certificatePrev =
        document.getElementById("certificatePrev");

    const certificateNext =
        document.getElementById("certificateNext");


    /* =====================================================
       CERTIFICATE CARDS
    ===================================================== */

    let certificateItems =
        Array.from(
            document.querySelectorAll(
                ".certificate-item"
            )
        );


    /*
     * Fallback for .cert-card
     */

    if (certificateItems.length === 0) {

        certificateItems =
            Array.from(
                document.querySelectorAll(
                    ".cert-card"
                )
            );

    }


    let currentCertificate = 0;


    /* =====================================================
       GET CERTIFICATE DATA
    ===================================================== */

    function getCertificateData(card) {

        if (!card) {

            return {
                image: "",
                title: "Certificate"
            };

        }


        const image =
            card.dataset.image ||
            card.getAttribute("data-image") ||
            card.querySelector("img")?.getAttribute("src") ||
            "";


        const title =
            card.dataset.title ||
            card.getAttribute("data-title") ||
            card.querySelector("h3")?.textContent?.trim() ||
            card.querySelector("h4")?.textContent?.trim() ||
            "Certificate";


        return {
            image,
            title
        };

    }


    /* =====================================================
       UPDATE CERTIFICATE
    ===================================================== */

    function updateCertificate() {

        if (!certificateItems.length) {
            return;
        }


        const card =
            certificateItems[currentCertificate];


        const data =
            getCertificateData(card);


        /* ---------------------------------------------
           IMAGE
        --------------------------------------------- */

        if (certificateImage) {

            certificateImage.classList.remove("zoomed");

            certificateImage.style.opacity = "0";


            const newImage = new Image();


            newImage.onload = () => {

                certificateImage.src = data.image;

                certificateImage.alt = data.title;

                certificateImage.style.opacity = "1";

            };


            newImage.onerror = () => {

                certificateImage.src = data.image;

                certificateImage.alt = data.title;

                certificateImage.style.opacity = "1";

                console.warn(
                    "Certificate image could not be loaded:",
                    data.image
                );

            };


            newImage.src = data.image;

        }


        /* ---------------------------------------------
           TITLE
        --------------------------------------------- */

        if (certificateTitle) {

            certificateTitle.textContent =
                data.title;

        }


        /* ---------------------------------------------
           CURRENT NUMBER
        --------------------------------------------- */

        if (certificateCurrent) {

            certificateCurrent.textContent =
                String(
                    currentCertificate + 1
                ).padStart(2, "0");

        }


        /* ---------------------------------------------
           TOTAL NUMBER
        --------------------------------------------- */

        if (certificateTotal) {

            certificateTotal.textContent =
                String(
                    certificateItems.length
                ).padStart(2, "0");

        }

    }


    /* =====================================================
       OPEN CERTIFICATE
    ===================================================== */

    function openCertificate(index) {

        if (!certificateModal) {

            console.warn(
                "Certificate modal not found."
            );

            return;

        }


        if (!certificateItems.length) {

            console.warn(
                "No certificate cards found."
            );

            return;

        }


        currentCertificate =
            (
                index +
                certificateItems.length
            ) %
            certificateItems.length;


        updateCertificate();


        certificateModal.classList.add("open");

        certificateModal.classList.add("active");

        certificateModal.setAttribute(
            "aria-hidden",
            "false"
        );


        document.body.classList.add(
            "certificate-modal-open"
        );


        document.body.style.overflow = "hidden";

    }


    /* =====================================================
       CLOSE CERTIFICATE
    ===================================================== */

    function closeCertificateViewer() {

        if (!certificateModal) {
            return;
        }


        certificateModal.classList.remove("open");

        certificateModal.classList.remove("active");

        certificateModal.setAttribute(
            "aria-hidden",
            "true"
        );


        document.body.classList.remove(
            "certificate-modal-open"
        );


        document.body.style.overflow = "";

    }


    /* =====================================================
       NEXT CERTIFICATE
    ===================================================== */

    function nextCertificate() {

        if (!certificateItems.length) {
            return;
        }


        currentCertificate =
            (
                currentCertificate + 1
            ) %
            certificateItems.length;


        updateCertificate();

    }


    /* =====================================================
       PREVIOUS CERTIFICATE
    ===================================================== */

    function previousCertificate() {

        if (!certificateItems.length) {
            return;
        }


        currentCertificate =
            (
                currentCertificate -
                1 +
                certificateItems.length
            ) %
            certificateItems.length;


        updateCertificate();

    }


    /* =====================================================
       CERTIFICATE CARD EVENTS
    ===================================================== */

    certificateItems.forEach(
        (card, index) => {

            /*
             * Accessibility
             */

            if (!card.hasAttribute("tabindex")) {

                card.setAttribute(
                    "tabindex",
                    "0"
                );

            }


            /*
             * Click
             */

            card.addEventListener(
                "click",
                (event) => {

                    const clickedButton =
                        event.target.closest(
                            `
                            .cert-view,
                            .view-certificate,
                            [data-certificate],
                            a,
                            button
                            `
                        );


                    if (clickedButton) {
                        return;
                    }


                    openCertificate(index);

                }
            );


            /*
             * Keyboard
             */

            card.addEventListener(
                "keydown",
                (event) => {

                    if (
                        event.key === "Enter" ||
                        event.key === " "
                    ) {

                        event.preventDefault();

                        openCertificate(index);

                    }

                }
            );

        }
    );


    /* =====================================================
       VIEW CERTIFICATE BUTTON
    ===================================================== */

    const viewCertificateButtons =
        document.querySelectorAll(
            `
            .cert-view,
            .view-certificate,
            [data-certificate]
            `
        );


    viewCertificateButtons.forEach(
        (button) => {

            button.addEventListener(
                "click",
                (event) => {

                    event.preventDefault();

                    event.stopPropagation();


                    const card =
                        button.closest(
                            `
                            .certificate-item,
                            .cert-card
                            `
                        );


                    if (!card) {

                        console.warn(
                            "Certificate card not found."
                        );

                        return;

                    }


                    const index =
                        certificateItems.indexOf(card);


                    if (index !== -1) {

                        openCertificate(index);

                    }

                }
            );

        }
    );


    /* =====================================================
       CLOSE CERTIFICATE BUTTON
    ===================================================== */

    if (closeCertificateButton) {

        closeCertificateButton.addEventListener(
            "click",
            (event) => {

                event.preventDefault();

                event.stopPropagation();

                closeCertificateViewer();

            }
        );

    }


    /* =====================================================
       CERTIFICATE BACKDROP
    ===================================================== */

    if (certificateModal) {

        certificateModal.addEventListener(
            "click",
            (event) => {

                if (
                    event.target ===
                    certificateModal
                ) {

                    closeCertificateViewer();

                }

            }
        );

    }


    /* =====================================================
       OPTIONAL BACKDROP
    ===================================================== */

    const certificateBackdrop =
        document.querySelector(
            ".certificate-modal-backdrop"
        );


    if (certificateBackdrop) {

        certificateBackdrop.addEventListener(
            "click",
            (event) => {

                event.preventDefault();

                closeCertificateViewer();

            }
        );

    }


    /* =====================================================
       NEXT BUTTON
    ===================================================== */

    if (certificateNext) {

        certificateNext.addEventListener(
            "click",
            (event) => {

                event.preventDefault();

                event.stopPropagation();

                nextCertificate();

            }
        );

    }


    /* =====================================================
       PREVIOUS BUTTON
    ===================================================== */

    if (certificatePrev) {

        certificatePrev.addEventListener(
            "click",
            (event) => {

                event.preventDefault();

                event.stopPropagation();

                previousCertificate();

            }
        );

    }


    /* =====================================================
       CERTIFICATE IMAGE ZOOM
    ===================================================== */

    if (certificateImage) {

        certificateImage.addEventListener(
            "click",
            () => {

                certificateImage.classList.toggle(
                    "zoomed"
                );

            }
        );

    }


    /* =====================================================
       05. ESCAPE / KEYBOARD CONTROLS
    ===================================================== */

    document.addEventListener(
        "keydown",
        (event) => {

            /*
             * ESC
             */

            if (event.key === "Escape") {

                if (
                    terminalModal &&
                    terminalModal.classList.contains("open")
                ) {

                    closeTerminal();

                }


                if (
                    certificateModal &&
                    (
                        certificateModal.classList.contains("open") ||
                        certificateModal.classList.contains("active")
                    )
                ) {

                    closeCertificateViewer();

                }

            }


            /*
             * Certificate navigation
             */

            if (
                certificateModal &&
                (
                    certificateModal.classList.contains("open") ||
                    certificateModal.classList.contains("active")
                )
            ) {

                if (event.key === "ArrowRight") {

                    nextCertificate();

                }


                if (event.key === "ArrowLeft") {

                    previousCertificate();

                }

            }

        }
    );


    /* =====================================================
       06. CUSTOM CURSOR
    ===================================================== */

    const cursor =
        document.querySelector(".cursor");

    const cursorRing =
        document.querySelector(".cursor-ring");


    if (cursor && cursorRing) {

        let mouseX = 0;
        let mouseY = 0;

        let ringX = 0;
        let ringY = 0;


        document.addEventListener(
            "mousemove",
            (event) => {

                mouseX = event.clientX;

                mouseY = event.clientY;


                cursor.style.left =
                    `${mouseX}px`;

                cursor.style.top =
                    `${mouseY}px`;

            }
        );


        function animateCursor() {

            ringX +=
                (mouseX - ringX) * 0.15;


            ringY +=
                (mouseY - ringY) * 0.15;


            cursorRing.style.left =
                `${ringX}px`;

            cursorRing.style.top =
                `${ringY}px`;


            requestAnimationFrame(
                animateCursor
            );

        }


        animateCursor();

    }


    /* =====================================================
       07. CURSOR HOVER EFFECT
    ===================================================== */

    const interactiveElements =
        document.querySelectorAll(
            `
            a,
            button,
            .path-card,
            .project-card,
            .cert-card,
            .certificate-item
            `
        );


    interactiveElements.forEach(
        (element) => {

            element.addEventListener(
                "mouseenter",
                () => {

                    document.body.classList.add(
                        "cursor-hover"
                    );

                }
            );


            element.addEventListener(
                "mouseleave",
                () => {

                    document.body.classList.remove(
                        "cursor-hover"
                    );

                }
            );

        }
    );


    /* =====================================================
       08. ACTIVE NAVIGATION
    ===================================================== */

    const navLinks =
        document.querySelectorAll(
            ".main-nav a"
        );


    const sections =
        document.querySelectorAll(
            "section[id]"
        );


    if (
        navLinks.length &&
        sections.length &&
        "IntersectionObserver" in window
    ) {

        const navObserver =
            new IntersectionObserver(
                (entries) => {

                    entries.forEach(
                        (entry) => {

                            if (
                                !entry.isIntersecting
                            ) {

                                return;

                            }


                            const id =
                                entry.target.id;


                            navLinks.forEach(
                                (link) => {

                                    link.classList.remove(
                                        "active"
                                    );


                                    const href =
                                        link.getAttribute(
                                            "href"
                                        );


                                    if (
                                        href ===
                                        `#${id}`
                                    ) {

                                        link.classList.add(
                                            "active"
                                        );

                                    }

                                }
                            );

                        }
                    );

                },
                {
                    threshold: 0.25,

                    rootMargin:
                        "-20% 0px -60% 0px"
                }
            );


        sections.forEach(
            (section) => {

                navObserver.observe(
                    section
                );

            }
        );

    }


    /* =====================================================
       09. SMOOTH ANCHOR LINKS
    ===================================================== */

    document.querySelectorAll(
        'a[href^="#"]'
    ).forEach(
        (link) => {

            link.addEventListener(
                "click",
                (event) => {

                    const href =
                        link.getAttribute(
                            "href"
                        );


                    if (
                        !href ||
                        href === "#"
                    ) {

                        return;

                    }


                    let target = null;

                    try {

                        target =
                            document.querySelector(
                                href
                            );

                    } catch (error) {

                        return;

                    }


                    if (target) {

                        event.preventDefault();


                        target.scrollIntoView({
                            behavior: "smooth",
                            block: "start"
                        });

                    }

                }
            );

        }
    );


    /* =====================================================
       10. CERTIFICATE IMAGE ERROR
    ===================================================== */

    if (certificateImage) {

        certificateImage.addEventListener(
            "error",
            () => {

                console.warn(
                    "Certificate image could not be loaded:",
                    certificateImage.src
                );

                certificateImage.style.opacity =
                    "1";

            }
        );

    }


    /* =====================================================
       11. BODY READY
    ===================================================== */

    document.body.classList.add(
        "js-ready"
    );


    /* =====================================================
       12. DEBUG
    ===================================================== */

    console.log(
        "================================="
    );

    console.log(
        "Portfolio JavaScript Loaded"
    );

    console.log(
        `Certificates Found: ${certificateItems.length}`
    );

    console.log(
        `Terminal: ${
            terminalModal
                ? "Available"
                : "Not Found"
        }`
    );

    console.log(
        "================================="
    );

});