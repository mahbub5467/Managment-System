<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <meta name="description"
          content="Md. Mahbub Hasan Akash — Software Developer & AI Researcher">

    <meta name="author"
          content="Md. Mahbub Hasan Akash">

    <title>
        Md. Mahbub Hasan Akash | Software Developer & AI Researcher
    </title>


    <!-- =====================================================
         GOOGLE FONTS
    ====================================================== -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@400;500;600;700&display=swap"
          rel="stylesheet">


    <!-- =====================================================
         FONT AWESOME
    ====================================================== -->

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">


    <!-- =====================================================
         PORTFOLIO CSS
    ====================================================== -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/portfolio.css">

</head>


<body>


<!-- =====================================================
     GLOBAL BACKGROUND
===================================================== -->

<div class="noise"></div>

<div class="bg-grid"></div>

<div class="glow g1"></div>

<div class="glow g2"></div>


<!-- =====================================================
     CUSTOM CURSOR
===================================================== -->

<div class="cursor"></div>

<div class="cursor-ring"></div>


<!-- =====================================================
     HEADER
===================================================== -->

<header class="site-header">

    <a href="#home" class="brand">

        <span class="brand-mark">
            MH
        </span>

        <span class="brand-info">

            <strong>
                Md. Mahbub Hasan Akash
            </strong>

            <small>
                Software Developer · AI Researcher
            </small>

        </span>

    </a>


    <nav class="main-nav">

        <a href="#home" class="active">
            Home
        </a>

        <a href="#about">
            About
        </a>

        <a href="#experience">
            Experience
        </a>

        <a href="#projects">
            Projects
        </a>

        <a href="#research">
            Research
        </a>

        <a href="#skills">
            Skills
        </a>

        <a href="#certificates">
            Certificates
        </a>

        <a href="#contact">
            Contact
        </a>

    </nav>


    <button class="terminal-btn"
            id="openTerminal"
            type="button">

        <i class="fa-solid fa-terminal"></i>

        Terminal

    </button>

</header>


<!-- =====================================================
     MAIN
===================================================== -->

<main>


    <!-- =====================================================
         HERO
    ====================================================== -->

    <section id="home"
             class="hero">


        <!-- HERO BACKGROUND VIDEO -->

        <video class="hero-bg-video"
               autoplay
               muted
               loop
               playsinline
               preload="auto">

            <source
                    src="${pageContext.request.contextPath}/resources/videos/animate.mp4"
                    type="video/mp4">

            Your browser does not support video.

        </video>


        <!-- VIDEO OVERLAY -->

        <div class="hero-video-overlay"></div>


        <!-- CINEMATIC GLOW -->

        <div class="hero-cinematic"></div>


        <!-- =================================================
             HERO LEFT
        ================================================== -->

        <div class="hero-left reveal">


            <div class="eyebrow">

                <span class="status-dot"></span>

                SOFTWARE DEVELOPER · AI RESEARCHER

            </div>


            <h1>

                Building
                <br>

                software.

                <br>

                <span class="gradient-text">
                    Teaching machines.
                </span>

            </h1>


            <p class="hero-description">

                Software developer working on enterprise
                systems and exploring intelligent solutions
                through computer vision, deep learning
                and research.

            </p>


            <!-- HERO BUTTONS -->

            <div class="buttons">

                <a href="#projects"
                   class="btn light">

                    Explore my work

                    <span>
                        ↗
                    </span>

                </a>


                <a href="${pageContext.request.contextPath}/resources/files/Mahbub_Hasan_Akash_CV.pdf"
                   class="btn outline"
                   download>

                    <i class="fa-solid fa-download"></i>

                    Download CV

                </a>

            </div>


            <!-- SOCIAL ICONS -->

            <div class="socials hero-socials">


                <a href="https://github.com/mahbub5467"
                   target="_blank"
                   rel="noopener noreferrer"
                   title="GitHub">

                    <i class="fa-brands fa-github"></i>

                </a>


                <a href="https://www.linkedin.com/in/mahbub-hasan-003841395/"
                   target="_blank"
                   rel="noopener noreferrer"
                   title="LinkedIn">

                    <i class="fa-brands fa-linkedin-in"></i>

                </a>


                <a href="https://scholar.google.com/citations?user=KeUB7-0AAAAJ&hl=en&oi=ao"
                   target="_blank"
                   rel="noopener noreferrer"
                   title="Google Scholar">

                    <i class="fa-solid fa-graduation-cap"></i>

                </a>


                <a href="https://www.researchgate.net/profile/Md-Akash-25"
                   target="_blank"
                   rel="noopener noreferrer"
                   title="ResearchGate">

                    <i class="fa-brands fa-researchgate"></i>

                </a>


                <a href="https://www.facebook.com/mahbub.akash546/"
                   target="_blank"
                   rel="noopener noreferrer"
                   title="Facebook">

                    <i class="fa-brands fa-facebook-f"></i>

                </a>

            </div>

        </div>


        <!-- =================================================
             HERO RIGHT
        ================================================== -->

        <div class="hero-right reveal delay">


            <div class="portrait">


                <div class="profile-header">

                    <span>
                        PROFILE SCAN
                    </span>

                    <b>
                        100%
                    </b>

                </div>


                <div class="photo-placeholder">

                    <img src="${pageContext.request.contextPath}/resources/images/profile.jpg"
                         alt="Md. Mahbub Hasan Akash"
                         class="profile-image">

                </div>


                <div class="scan"></div>


                <span class="corner c-tl"></span>
                <span class="corner c-tr"></span>
                <span class="corner c-bl"></span>
                <span class="corner c-br"></span>


                <div class="data-card data-one">

                    <small>
                        SOFTWARE
                    </small>

                    <strong>
                        ENGINEERING
                    </strong>

                </div>


                <div class="data-card data-two">

                    <small>
                        AI / CV
                    </small>

                    <strong>
                        RESEARCH
                    </strong>

                </div>


                <div class="profile-bottom">

                    <span>
                        SYSTEM STATUS
                    </span>

                    <strong>
                        ● ONLINE
                    </strong>

                </div>

            </div>

        </div>

    </section>


    <!-- =====================================================
         JOURNEY
    ====================================================== -->

    <section class="journey section"
             id="about">


        <div class="journey-intro reveal">

            <div class="kicker">
                THE JOURNEY
            </div>

            <h2>
                Code
                <span>→</span>
                Intelligence
            </h2>

            <p>
                From software engineering to artificial
                intelligence and research.
            </p>

        </div>


        <div class="journey-grid">


            <button class="path-card reveal"
                    type="button"
                    data-target="#experience">

                <div class="path-number">
                    01
                </div>

                <div class="path-icon">
                    <i class="fa-solid fa-code"></i>
                </div>

                <div>

                    <small>
                        ENGINEERING
                    </small>

                    <h3>
                        Software Engineering
                    </h3>

                    <p>
                        Building enterprise software,
                        backend systems and scalable
                        solutions.
                    </p>

                </div>

                <span class="path-arrow">
                    →
                </span>

            </button>


            <button class="path-card reveal"
                    type="button"
                    data-target="#research">

                <div class="path-number">
                    02
                </div>

                <div class="path-icon ai">
                    <i class="fa-solid fa-brain"></i>
                </div>

                <div>

                    <small>
                        INTELLIGENCE
                    </small>

                    <h3>
                        AI & Computer Vision
                    </h3>

                    <p>
                        Deep learning, computer vision,
                        medical imaging and intelligent
                        systems.
                    </p>

                </div>

                <span class="path-arrow">
                    →
                </span>

            </button>

        </div>

    </section>


    <!-- =====================================================
         ABOUT
    ====================================================== -->

    <section class="section split"
             id="about-details">


        <div class="reveal">

            <div class="kicker">
                ABOUT ME
            </div>

            <h2>

                Software engineer
                <br>

                <em>
                    with a research mindset.
                </em>

            </h2>

        </div>


        <div class="about-content reveal">

            <p class="copy">

                I am Md. Mahbub Hasan Akash, a software
                developer and AI researcher interested in
                building practical software systems and
                intelligent solutions.

            </p>


            <p class="copy">

                Currently working as a Software Support
                Engineer at SIMEC System Ltd., where I am
                directly connected with the development and
                support of the Civil Aviation Authority
                Bangladesh enterprise ERP ecosystem.

            </p>


            <div class="chips">

                <span>Java</span>
                <span>Spring Boot</span>
                <span>Python</span>
                <span>PyTorch</span>
                <span>Computer Vision</span>
                <span>Machine Learning</span>
                <span>SQL</span>
                <span>JavaScript</span>

            </div>

        </div>

    </section>


    <!-- =====================================================
         EXPERIENCE
    ====================================================== -->

    <section class="section"
             id="experience">


        <div class="section-head reveal">

            <div>

                <div class="kicker">
                    EXPERIENCE
                </div>

                <h2>
                    Where I work.
                </h2>

            </div>

            <div class="live">

                <i></i>

                CURRENTLY WORKING

            </div>

        </div>


        <div class="experience-card reveal">


            <div class="exp-date">

                Feb, 2026
                <span>—</span>
                PRESENT

            </div>


            <div class="exp-main">

                <small>
                    SIMEC SYSTEM LTD.
                </small>

                <h3>
                    Software Support Engineer
                </h3>

                <label>
                    Civil Aviation Authority Bangladesh
                    Enterprise ERP
                </label>

                <p>

                    Directly connected with the development,
                    support and operational ecosystem of a
                    large-scale enterprise ERP solution used
                    across CAAB.

                </p>


                <div class="chips">

                    <span>Enterprise ERP</span>
                    <span>Java</span>
                    <span>Spring Boot</span>
                    <span>Database</span>
                    <span>Software Support</span>

                </div>

            </div>


            <div class="architecture">

                <span>
                    USERS
                </span>

                <b>
                    ↓
                </b>

                <span>
                    ERP
                </span>

                <b>
                    ↓
                </b>

                <span>
                    SYSTEM
                </span>

            </div>

        </div>

    </section>


    <!-- =====================================================
         PROJECTS
    ====================================================== -->

    <section class="section"
             id="projects">


        <div class="section-head reveal">

            <div>

                <div class="kicker">
                    SELECTED WORK
                </div>

                <h2>
                    Things I've built.
                </h2>

            </div>

            <div class="live">
                SOFTWARE · SYSTEMS · AUTOMATION
            </div>

        </div>


        <div class="projects-grid">


            <!-- GPF -->

            <article class="project-card project-featured reveal">

                <div class="project-art gpf-art">

                    <span class="project-label">
                        JAVA · SPRING BOOT
                    </span>

                    <div class="terminal-art">

                        <div>
                            <span class="green">
                                $
                            </span>

                            java -jar gpf-system.jar
                        </div>

                        <small>
                            Initializing modules...
                        </small>

                        <small>
                            Loading database...
                        </small>

                        <small class="success">
                            System ready.
                        </small>

                    </div>

                </div>


                <div class="project-body">

                    <small>
                        01 / SOFTWARE
                    </small>

                    <h3>
                        Management System
                    </h3>

                    <p>

                        A comprehensive web application for
                        managing Government Provident Fund Calculator.
                        CAAB (Technical) E-library.
                        Training Module.

                    </p>


                    <div class="chips">

                        <span>Java</span>
                        <span>Spring Boot</span>
                        <span>Spring Security</span>
                        <span>Microsoft SQL Server</span>

                    </div>


                    <a href="https://github.com/mahbub5467"
                       target="_blank"
                       rel="noopener noreferrer"
                       class="project-link">

                        View on GitHub
                        →

                    </a>

                </div>

            </article>


            <!-- GRADING -->

            <article class="project-card reveal">

                <div class="project-art grading-art">

                    <span class="big-symbol">
                        A+
                    </span>

                    <div class="code-lines">

                        GPA = 3.85
                        <br>

                        Grade = A+
                        <br>

                        Result = PASS

                    </div>

                </div>


                <div class="project-body">

                    <small>
                        02 / SOFTWARE
                    </small>

                    <h3>
                        Grading System
                    </h3>

                    <p>
                        A console-based system to manage
                        student grades and calculate GPA.
                    </p>

                    <div class="chips">

                        <span>C</span>
                        <span>Algorithms</span>
                        <span>File Handling</span>

                    </div>
                    <a href="https://github.com/mahbub5467?tab=repositories"
                       target="_blank"
                       rel="noopener noreferrer"
                       class="project-link">

                        View on GitHub
                        →

                    </a>
                </div>

            </article>


            <!-- PEDESTRIAN -->

            <article class="project-card reveal">

                <div class="project-art crossing-art">

                    <div class="traffic-light">

                        <i class="red"></i>
                        <i class="yellow"></i>
                        <i class="green"></i>

                    </div>

                    <div class="road"></div>

                </div>


                <div class="project-body">

                    <small>
                        03 / EMBEDDED SYSTEM
                    </small>

                    <h3>
                        Pedestrian Crossing
                    </h3>

                    <p>

                        Smart pedestrian crossing system
                        using Arduino with automatic signal
                        control.

                    </p>

                    <div class="chips">

                        <span>Arduino</span>
                        <span>C++</span>
                        <span>Sensors</span>

                    </div>
                    <a href="https://github.com/mahbub5467?tab=repositories"
                       target="_blank"
                       rel="noopener noreferrer"
                       class="project-link">

                        View on GitHub
                        →

                    </a>
                </div>

            </article>


            <!-- SANITIZER -->

            <article class="project-card reveal">

                <div class="project-art sanitizer-art">

                    <i class="fa-solid fa-pump-medical"></i>

                    <span>
                        SENSOR ACTIVE
                    </span>

                </div>


                <div class="project-body">

                    <small>
                        04 / AUTOMATION
                    </small>

                    <h3>
                        Automatic Hand Sanitizer
                    </h3>

                    <p>

                        Touchless hand sanitizer dispenser
                        using IR sensor and automatic liquid
                        control.

                    </p>

                    <div class="chips">

                        <span>Arduino</span>
                        <span>C++</span>
                        <span>IR Sensor</span>

                    </div>
                    <a href="https://github.com/mahbub5467?tab=repositories"
                       target="_blank"
                       rel="noopener noreferrer"
                       class="project-link">

                        View on GitHub
                        →

                    </a>
                </div>

            </article>

            <!-- SCHOOL MANAGEMENT SYSTEM -->

            <article class="project-card reveal">

                <div class="project-art school-art">

        <span class="project-label">
            SCHOOL · MANAGEMENT
        </span>

                    <div class="school-dashboard">

                        <div class="dashboard-line">
                            <span>Students</span>
                            <strong>1280</strong>
                        </div>

                        <div class="dashboard-line">
                            <span>Teachers</span>
                            <strong>86</strong>
                        </div>

                        <div class="dashboard-line">
                            <span>Classes</span>
                            <strong>32</strong>
                        </div>

                        <div class="dashboard-status">
                            SYSTEM ONLINE
                        </div>

                    </div>

                </div>


                <div class="project-body">

                    <small>
                        05 / SOFTWARE
                    </small>

                    <h3>
                        School Management System
                    </h3>

                    <p>
                        A school management application designed to
                        simplify academic and administrative operations,
                        including student, teacher and school-related
                        information management.
                    </p>


                    <div class="chips">

                        <span>full-stack web applications</span>
                        <span> Express.jst</span>
                        <span>React.js</span>
                        <span>Node.js</span>
                        <span>Mongo</span>

                    </div>


                    <a href="https://github.com/mahbub5467?tab=repositories"
                       target="_blank"
                       rel="noopener noreferrer"
                       class="project-link">

                        View on GitHub
                        →

                    </a>

                </div>

            </article>

        </div>

    </section>


    <!-- =====================================================
         RESEARCH
    ====================================================== -->

    <section class="section"
             id="research">


        <div class="section-head reveal">

            <div>

                <div class="kicker">
                    RESEARCH & PUBLICATIONS
                </div>

                <h2>
                    Exploring intelligence.
                </h2>

            </div>


            <div class="research-links">

                <a href="https://scholar.google.com/citations?user=KeUB7-0AAAAJ&hl=en&oi=ao"
                   target="_blank"
                   rel="noopener noreferrer">

                    Google Scholar
                    ↗

                </a>


                <a href="https://www.researchgate.net/profile/Md-Akash-25"
                   target="_blank"
                   rel="noopener noreferrer">

                    ResearchGate
                    ↗

                </a>

            </div>

        </div>


        <!-- FEATURED PAPER -->

        <article class="featured-paper reveal">


            <div class="paper-visual">

                <div class="mri-grid">

                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>

                </div>

                <b>
                    MRI / AI
                </b>

            </div>


            <div class="paper-content">

                <small>
                    BECITHCON 2026 · ACCEPTED
                </small>

                <h3>

                    Lightweight Vision
                    Transformer-Based U-Net
                    for Brain Tumor Segmentation
                    from MRI

                </h3>

                <p>

                    Lightweight transformer-based U-Net
                    architecture for brain tumor segmentation
                    from MRI images.

                </p>


                <div class="chips">

                    <span>
                        Vision Transformer
                    </span>

                    <span>
                        U-Net
                    </span>

                    <span>
                        Deep Learning
                    </span>

                    <span>
                        Medical AI
                    </span>

                </div>

            </div>


            <div class="paper-year">
                2026
            </div>

        </article>


        <!-- OTHER PUBLICATIONS -->

        <div class="papers-grid">


            <article class="paper-card reveal">

                <span class="paper-index">
                    02
                </span>

                <small>
                    2025 · CONFERENCE PAPER
                </small>

                <h3>

                    Underwater Image Reconstruction
                    Using a Swin Transformer-Based
                    Generator and PatchGAN Discriminator

                </h3>

                <p>

                    Transformer-based underwater image
                    reconstruction using Swin Transformer
                    and PatchGAN.

                </p>

                <div class="chips">

                    <span>
                        Swin Transformer
                    </span>

                    <span>
                        PatchGAN
                    </span>

                    <span>
                        Deep Learning
                    </span>

                </div>

            </article>


            <article class="paper-card reveal">

                <span class="paper-index">
                    03
                </span>

                <small>
                    JOURNAL · 2025
                </small>

                <h3>

                    Robotics, Artificial Intelligence,
                    and Computer Vision in Dental
                    Implant Surgery

                </h3>

                <p>

                    Systematic review of accuracy,
                    efficiency and future directions.

                </p>

                <div class="chips">

                    <span>
                        Robotics
                    </span>

                    <span>
                        AI
                    </span>

                    <span>
                        Computer Vision
                    </span>

                </div>

            </article>


            <article class="paper-card reveal">

                <span class="paper-index">
                    04
                </span>

                <small>
                    DATA IN BRIEF · 2026
                </small>

                <h3>

                    A Novel Dataset of North-Eastern
                    Indian Coins for Machine Learning-Based
                    Classification

                </h3>

                <p>

                    Dataset focused on machine learning
                    based coin classification.

                </p>

                <div class="chips">

                    <span>
                        Dataset
                    </span>

                    <span>
                        Machine Learning
                    </span>

                    <span>
                        Classification
                    </span>

                </div>

            </article>


        </div>

    </section>


    <!-- =====================================================
         SKILLS
    ====================================================== -->

    <section class="section"
             id="skills">


        <div class="section-head reveal">

            <div>

                <div class="kicker">
                    SKILLS & TECHNOLOGIES
                </div>

                <h2>
                    My technical stack.
                </h2>

            </div>

        </div>


        <div class="skills-layout">


            <div class="skill-panel reveal">

                <small>
                    LANGUAGES
                </small>

                <div class="skill-chips">

                    <span>Java</span>
                    <span>C</span>
                    <span>C++</span>
                    <span>JavaScript</span>
                    <span>SQL</span>

                </div>

            </div>


            <div class="skill-panel reveal">

                <small>
                    FRAMEWORKS & LIBRARIES
                </small>

                <div class="skill-chips">

                    <span>Spring Boot</span>
                    <span>Spring MVC</span>
                    <span>Spring Data JPA</span>
                    <span>Spring Security</span>
                    <span>Hibernate</span>
                    <span>Bootstrap</span>
                    <span>jQuery</span>
                    <span>TensorFlow</span>
                    <span>PyTorch</span>

                </div>

            </div>


            <div class="skill-panel reveal">

                <small>
                    TOOLS & PLATFORMS
                </small>

                <div class="skill-chips">

                    <span>Git</span>
                    <span>GitHub</span>
                    <span>MySQL</span>
                    <span>VS Code</span>
                    <span>Postman</span>
                    <span>Arduino IDE</span>
                    <span>Google Colab</span>

                </div>

            </div>


            <div class="skill-panel reveal">

                <small>
                    CORE COMPETENCIES
                </small>

                <div class="competencies">

                    <div>
                        <i class="fa-solid fa-puzzle-piece"></i>
                        Problem Solving
                    </div>

                    <div>
                        <i class="fa-solid fa-layer-group"></i>
                        System Design
                    </div>

                    <div>
                        <i class="fa-solid fa-brain"></i>
                        AI & ML
                    </div>

                    <div>
                        <i class="fa-solid fa-flask"></i>
                        Research
                    </div>

                </div>

            </div>


        </div>

    </section>


    <!-- =====================================================
         CERTIFICATES
    ====================================================== -->

    <section class="section"
             id="certificates">


        <div class="section-head reveal">

            <div>

                <div class="kicker">
                    CERTIFICATIONS
                </div>

                <h2>
                    Learning continuously.
                </h2>

                <p class="section-description">
                    Click any certificate to view it in full size.
                </p>

            </div>

        </div>


        <!-- =================================================
             CERTIFICATE GRID
        ================================================== -->

        <div class="cert-grid">


            <!-- CERTIFICATE 01 -->

            <article class="cert-card reveal certificate-item"
                     tabindex="0"
                     role="button"
                     aria-label="View Introduction to Data Science certificate"
                     data-certificate="0"
                     data-title="Introduction to Data Science"
                     data-image="${pageContext.request.contextPath}/resources/images/data-science.png">

                <div class="cert-number">
                    01
                </div>

                <div class="cert-icon">

                    <i class="fa-solid fa-database"></i>

                </div>

                <div class="cert-content">

                    <small>
                        CERTIFICATE
                    </small>

                    <h3>
                        Introduction to Data Science
                    </h3>

                    <p>
                        Simplilearn SkillUp
                    </p>

                </div>

                <div class="cert-view">

                    <i class="fa-solid fa-expand"></i>

                    View Certificate

                </div>

            </article>


            <!-- CERTIFICATE 02 -->

            <article class="cert-card reveal certificate-item"
                     tabindex="0"
                     role="button"
                     aria-label="View Databricks SQL Analytics certificate"
                     data-certificate="1"
                     data-title="Get Started with SQL Analytics and BI on Databricks"
                     data-image="${pageContext.request.contextPath}/resources/images/databricks.png">

                <div class="cert-number">
                    02
                </div>

                <div class="cert-icon">

                    <i class="fa-solid fa-chart-line"></i>

                </div>

                <div class="cert-content">

                    <small>
                        CERTIFICATE
                    </small>

                    <h3>
                        SQL Analytics & BI on Databricks
                    </h3>

                    <p>
                        Databricks · Simplilearn SkillUp
                    </p>

                </div>

                <div class="cert-view">

                    <i class="fa-solid fa-expand"></i>

                    View Certificate

                </div>

            </article>


            <!-- CERTIFICATE 03 -->

            <article class="cert-card reveal certificate-item"
                     tabindex="0"
                     role="button"
                     aria-label="View Full Stack Developer certificate"
                     data-certificate="2"
                     data-title="Free Full Stack Developer Course"
                     data-image="${pageContext.request.contextPath}/resources/images/full-stack.png">

                <div class="cert-number">
                    03
                </div>

                <div class="cert-icon">

                    <i class="fa-solid fa-code"></i>

                </div>

                <div class="cert-content">

                    <small>
                        CERTIFICATE
                    </small>

                    <h3>
                        Full Stack Developer
                    </h3>

                    <p>
                        Simplilearn SkillUp
                    </p>

                </div>

                <div class="cert-view">

                    <i class="fa-solid fa-expand"></i>

                    View Certificate

                </div>

            </article>


            <!-- CERTIFICATE 04 -->

            <article class="cert-card reveal certificate-item"
                     tabindex="0"
                     role="button"
                     aria-label="View Software Development certificate"
                     data-certificate="3"
                     data-title="What is Software Development?"
                     data-image="${pageContext.request.contextPath}/resources/images/software-development.png">

                <div class="cert-number">
                    04
                </div>

                <div class="cert-icon">

                    <i class="fa-solid fa-laptop-code"></i>

                </div>

                <div class="cert-content">

                    <small>
                        CERTIFICATE
                    </small>

                    <h3>
                        Software Development
                    </h3>

                    <p>
                        Simplilearn SkillUp
                    </p>

                </div>

                <div class="cert-view">

                    <i class="fa-solid fa-expand"></i>

                    View Certificate

                </div>

            </article>


        </div>

    </section>


    <!-- =====================================================
         CONTACT
    ====================================================== -->

    <section class="section contact"
             id="contact">


        <div class="contact-inner reveal">

            <div class="kicker">
                LET'S CONNECT
            </div>


            <h2>

                Have an idea?

                <br>

                <em>
                    Let's build it.
                </em>

            </h2>


            <p>

                Open to software engineering,
                AI research and interesting
                technology projects.

            </p>

            <a
                    href="https://mail.google.com/mail/?view=cm&fs=1&to=mahbub.akashp@gmail.com&su=Portfolio%20Contact&body=Hello%20Mahbub%2C%0A%0AI%20would%20like%20to%20get%20in%20touch."
                    target="_blank"
                    rel="noopener noreferrer"
                    class="btn light big"
            >
                Get in touch
                <span>↗</span>
            </a>

            <div class="socials footer-socials">


                <a href="https://github.com/mahbub5467"
                   target="_blank"
                   rel="noopener noreferrer">

                    <i class="fa-brands fa-github"></i>

                    GitHub

                </a>


                <a href="https://www.linkedin.com/in/mahbub-hasan-003841395/"
                   target="_blank"
                   rel="noopener noreferrer">

                    <i class="fa-brands fa-linkedin"></i>

                    LinkedIn

                </a>


                <a href="https://scholar.google.com/citations?user=KeUB7-0AAAAJ&hl=en&oi=ao"
                   target="_blank"
                   rel="noopener noreferrer">

                    <i class="fa-solid fa-graduation-cap"></i>

                    Scholar

                </a>


                <a href="https://www.researchgate.net/profile/Md-Akash-25"
                   target="_blank"
                   rel="noopener noreferrer">

                    <i class="fa-brands fa-researchgate"></i>

                    ResearchGate

                </a>

            </div>

        </div>

    </section>


</main>


<!-- =====================================================
     FOOTER
===================================================== -->

<footer>

    <span>
        © 2026 Md. Mahbub Hasan Akash
    </span>

    <span>
        CODE → INTELLIGENCE
    </span>

</footer>


<!-- =====================================================
     CERTIFICATE VIEWER MODAL
===================================================== -->

<div class="certificate-modal"
     id="certificateModal"
     aria-hidden="true">


    <div class="certificate-modal-backdrop"></div>


    <div class="certificate-modal-window"
         role="dialog"
         aria-modal="true"
         aria-labelledby="certificateModalTitle">


        <!-- CLOSE -->

        <button class="certificate-close"
                id="closeCertificate"
                type="button"
                aria-label="Close certificate viewer">

            <i class="fa-solid fa-xmark"></i>

        </button>


        <!-- HEADER -->

        <div class="certificate-modal-header">

            <div>

                <small>
                    CERTIFICATE
                </small>

                <h3 id="certificateModalTitle">
                    Certificate
                </h3>

            </div>


            <div class="certificate-counter">

                <span id="certificateCurrent">
                    01
                </span>

                <span>
                    /
                </span>

                <span id="certificateTotal">
                    04
                </span>

            </div>

        </div>


        <!-- IMAGE AREA -->

        <div class="certificate-viewer">


            <!-- PREVIOUS -->

            <button class="certificate-nav certificate-prev"
                    id="certificatePrev"
                    type="button"
                    aria-label="Previous certificate">

                <i class="fa-solid fa-chevron-left"></i>

            </button>


            <!-- IMAGE -->

            <div class="certificate-image-container">

                <img id="certificateImage"
                     src=""
                     alt="Certificate"
                     class="certificate-full-image">

            </div>


            <!-- NEXT -->

            <button class="certificate-nav certificate-next"
                    id="certificateNext"
                    type="button"
                    aria-label="Next certificate">

                <i class="fa-solid fa-chevron-right"></i>

            </button>


        </div>


        <!-- FOOTER -->

        <div class="certificate-modal-footer">

            <span>
                <i class="fa-solid fa-magnifying-glass-plus"></i>
                Click image to zoom
            </span>

            <span>
                ESC to close
            </span>

        </div>

    </div>

</div>


<!-- =====================================================

     TERMINAL MODAL
===================================================== -->

<div
        class="terminal-modal"
        id="terminalModal"
        aria-hidden="true"
        role="dialog"
        aria-modal="true"
        aria-label="Interactive Terminal"
>

    <div class="terminal-window">

        <!-- Close Button -->
        <button
                id="closeTerminal"
                class="terminal-close"
                aria-label="Close terminal"
                type="button"
        >
            ×
        </button>


        <!-- Terminal Header -->
        <div class="terminal-head">

            <div class="terminal-title">

                <span class="terminal-dot"></span>

                <span>
                    mahbub@portfolio:~$
                </span>

            </div>

            <small>
                interactive terminal
            </small>

        </div>


        <!-- Terminal Output -->
        <div
                id="terminalOutput"
                class="terminal-output"
                aria-live="polite"
        >

            <p class="terminal-welcome">

                Welcome to Mahbub's portfolio.

                <br>

                Type
                <b>help</b>
                to see available commands.

            </p>

        </div>


        <!-- Terminal Input -->
        <div class="terminal-input">

            <span
                    class="terminal-prompt"
                    aria-hidden="true"
            >
                $
            </span>

            <input
                    id="terminalInput"
                    type="text"
                    autocomplete="off"
                    autocapitalize="off"
                    spellcheck="false"
                    placeholder="type a command..."
                    aria-label="Terminal command"
            >

        </div>

    </div>

</div>

<!-- =====================================================
     PORTFOLIO JAVASCRIPT
===================================================== -->

<script src="${pageContext.request.contextPath}/portfolio.js"></script>


</body>

</html>