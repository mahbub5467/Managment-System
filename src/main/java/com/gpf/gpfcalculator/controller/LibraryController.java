package com.gpf.gpfcalculator.controller;

import com.gpf.gpfcalculator.model.PelFile;
import com.gpf.gpfcalculator.model.PelFolder;
import com.gpf.gpfcalculator.repository.PelFileRepository;
import com.gpf.gpfcalculator.repository.PelFolderRepository;

import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/library")
public class LibraryController {

    // =========================================================
    // REPOSITORIES
    // =========================================================

    private final PelFolderRepository folderRepository;

    private final PelFileRepository fileRepository;


    // =========================================================
    // CONSTRUCTOR
    // =========================================================

    public LibraryController(
            PelFolderRepository folderRepository,
            PelFileRepository fileRepository) {

        this.folderRepository = folderRepository;

        this.fileRepository = fileRepository;
    }


    // =========================================================
    // MAIN E-LIBRARY
    // GET /library
    // =========================================================

    @GetMapping
    public String library() {

        return "library";
    }


    // =========================================================
    // SAFETY REPORT
    // GET /library/safety-report
    // =========================================================

    @GetMapping("/safety-report")
    public String safetyReport() {

        return "safety-report";
    }


    // =========================================================
    // PEL DASHBOARD
    // GET /library/pel
    // =========================================================

    @GetMapping("/pel")
    public String pel(Model model) {

        model.addAttribute(
                "folders",
                folderRepository.findAll()
        );

        return "pel";
    }


    // =========================================================
    // OPEN PEL FOLDER
    // GET /library/pel/folder/{id}
    // =========================================================

    @GetMapping("/pel/folder/{id}")
    public String openPelFolder(
            @PathVariable("id") Long id,
            Model model,
            RedirectAttributes flash) {

        PelFolder folder =
                folderRepository
                        .findById(id)
                        .orElse(null);


        // Folder not found
        if (folder == null) {

            flash.addFlashAttribute(
                    "error",
                    "Folder not found."
            );

            return "redirect:/library/pel";
        }


        // Folder
        model.addAttribute(
                "folder",
                folder
        );


        // Files inside folder
        model.addAttribute(
                "files",
                fileRepository.findByFolderId(id)
        );


        return "pel-folder";
    }


    // =========================================================
    // CREATE PEL FOLDER
    // POST /library/pel/folder/create
    // =========================================================

    @PostMapping("/pel/folder/create")
    public String createPelFolder(
            @RequestParam("folderName") String folderName,
            RedirectAttributes flash) {

        String name =
                normalizedName(folderName);


        // Validate name
        if (name == null) {

            flash.addFlashAttribute(
                    "error",
                    "Folder name must be between 1 and 120 characters."
            );

            return "redirect:/library/pel";
        }


        // Check duplicate folder
        if (folderRepository.existsByNameIgnoreCase(name)) {

            flash.addFlashAttribute(
                    "error",
                    "A folder with this name already exists."
            );

            return "redirect:/library/pel";
        }


        // Create folder
        PelFolder folder =
                new PelFolder();

        folder.setName(name);

        folderRepository.save(folder);


        flash.addFlashAttribute(
                "success",
                "Folder '" + name +
                        "' created successfully."
        );


        return "redirect:/library/pel";
    }


    // =========================================================
    // RENAME PEL FOLDER
    // POST /library/pel/folder/{id}/rename
    // =========================================================

    @PostMapping({
            "/pel/folder/rename/{id}",
            "/pel/folder/{id}/rename"
    })
    public String renamePelFolder(
            @PathVariable("id") Long id,
            @RequestParam("folderName") String folderName,
            RedirectAttributes flash) {

        PelFolder folder =
                folderRepository
                        .findById(id)
                        .orElse(null);


        // Folder not found
        if (folder == null) {

            flash.addFlashAttribute(
                    "error",
                    "Folder not found."
            );

            return "redirect:/library/pel";
        }


        String name =
                normalizedName(folderName);


        // Validate name
        if (name == null) {

            flash.addFlashAttribute(
                    "error",
                    "Folder name must be between 1 and 120 characters."
            );

            return "redirect:/library/pel";
        }


        // Check if name changed
        boolean nameChanged =
                !folder.getName()
                        .equalsIgnoreCase(name);


        // Check duplicate
        if (nameChanged &&
                folderRepository
                        .existsByNameIgnoreCase(name)) {

            flash.addFlashAttribute(
                    "error",
                    "A folder with this name already exists."
            );

            return "redirect:/library/pel";
        }


        // Rename
        folder.setName(name);

        folderRepository.save(folder);


        flash.addFlashAttribute(
                "success",
                "Folder renamed successfully."
        );


        return "redirect:/library/pel";
    }


    // =========================================================
    // DELETE PEL FOLDER
    // POST /library/pel/folder/delete/{id}
    // =========================================================

    @PostMapping({
            "/pel/folder/delete/{id}",
            "/pel/folder/{id}/delete"
    })
    public String deletePelFolder(
            @PathVariable("id") Long id,
            RedirectAttributes flash) {

        PelFolder folder =
                folderRepository
                        .findById(id)
                        .orElse(null);


        // Folder not found
        if (folder == null) {

            flash.addFlashAttribute(
                    "error",
                    "Folder not found."
            );

            return "redirect:/library/pel";
        }


        // -----------------------------------------------------
        // Delete files inside folder first
        // -----------------------------------------------------

        fileRepository
                .findByFolderId(id)
                .forEach(file -> {

                    fileRepository.delete(file);

                });


        // -----------------------------------------------------
        // Delete folder
        // -----------------------------------------------------

        folderRepository.delete(folder);


        flash.addFlashAttribute(
                "success",
                "Folder deleted successfully."
        );


        return "redirect:/library/pel";
    }


    // =========================================================
    // UPLOAD PDF FILE
    // POST /library/pel/folder/{folderId}/upload
    // =========================================================

    @PostMapping("/pel/folder/{folderId}/upload")
    public String uploadPelFile(
            @PathVariable("folderId") Long folderId,
            @RequestParam("file") MultipartFile file,
            RedirectAttributes flash) {

        try {

            // -------------------------------------------------
            // 1. Check file selected
            // -------------------------------------------------

            if (file == null ||
                    file.isEmpty()) {

                flash.addFlashAttribute(
                        "error",
                        "Please select a PDF file."
                );

                return "redirect:/library/pel/folder/"
                        + folderId;
            }


            // -------------------------------------------------
            // 2. Check folder
            // -------------------------------------------------

            PelFolder folder =
                    folderRepository
                            .findById(folderId)
                            .orElse(null);


            if (folder == null) {

                flash.addFlashAttribute(
                        "error",
                        "Folder not found."
                );

                return "redirect:/library/pel";
            }


            // -------------------------------------------------
            // 3. Get original file name
            // -------------------------------------------------

            String fileName =
                    file.getOriginalFilename();


            if (fileName == null ||
                    fileName.trim().isEmpty()) {

                flash.addFlashAttribute(
                        "error",
                        "Invalid file name."
                );

                return "redirect:/library/pel/folder/"
                        + folderId;
            }


            fileName =
                    fileName.trim();


            // -------------------------------------------------
            // 4. Check PDF extension
            // -------------------------------------------------

            if (!fileName
                    .toLowerCase()
                    .endsWith(".pdf")) {

                flash.addFlashAttribute(
                        "error",
                        "Only PDF files are allowed."
                );

                return "redirect:/library/pel/folder/"
                        + folderId;
            }


            // -------------------------------------------------
            // 5. Check MIME type
            // -------------------------------------------------

            String contentType =
                    file.getContentType();


            if (contentType == null ||
                    !contentType
                            .equalsIgnoreCase(
                                    "application/pdf")) {

                flash.addFlashAttribute(
                        "error",
                        "Only PDF files are allowed."
                );

                return "redirect:/library/pel/folder/"
                        + folderId;
            }


            // -------------------------------------------------
            // 6. Read file data
            // -------------------------------------------------

            byte[] fileData =
                    file.getBytes();


            if (fileData.length == 0) {

                flash.addFlashAttribute(
                        "error",
                        "The selected PDF file is empty."
                );

                return "redirect:/library/pel/folder/"
                        + folderId;
            }


            // -------------------------------------------------
            // 7. Create PelFile
            // -------------------------------------------------

            PelFile pelFile =
                    new PelFile();


            pelFile.setFileName(
                    fileName
            );


            pelFile.setContentType(
                    "application/pdf"
            );


            pelFile.setFileData(
                    fileData
            );


            pelFile.setFolder(
                    folder
            );


            // -------------------------------------------------
            // 8. Save PDF to database
            // -------------------------------------------------

            fileRepository.save(
                    pelFile
            );


            // -------------------------------------------------
            // 9. Success message
            // -------------------------------------------------

            flash.addFlashAttribute(
                    "success",
                    "PDF file '" +
                            fileName +
                            "' uploaded successfully."
            );


        } catch (Exception e) {

            e.printStackTrace();

            flash.addFlashAttribute(
                    "error",
                    "Failed to upload PDF file: "
                            + e.getMessage()
            );
        }


        // -----------------------------------------------------
        // 10. Return to same folder
        // -----------------------------------------------------

        return "redirect:/library/pel/folder/"
                + folderId;
    }


    // =========================================================
    // DELETE PDF FILE
    // POST /library/pel/file/delete/{id}
    // =========================================================

    @PostMapping("/pel/file/delete/{id}")
    public String deleteFile(
            @PathVariable("id") Long id,
            RedirectAttributes flash) {

        PelFile file =
                fileRepository
                        .findById(id)
                        .orElse(null);


        // File not found
        if (file == null) {

            flash.addFlashAttribute(
                    "error",
                    "File not found."
            );

            return "redirect:/library/pel";
        }


        // Parent folder
        Long folderId =
                file.getFolder()
                        .getId();


        String fileName =
                file.getFileName();


        // Delete file
        fileRepository.delete(file);


        flash.addFlashAttribute(
                "success",
                "File '" +
                        fileName +
                        "' deleted successfully."
        );


        // Return to same folder
        return "redirect:/library/pel/folder/"
                + folderId;
    }


    // =========================================================
    // VIEW / OPEN PDF
    // GET /library/pel/file/{id}
    // =========================================================

    @GetMapping("/pel/file/{id}")
    @ResponseBody
    public ResponseEntity<byte[]> viewFile(
            @PathVariable("id") Long id) {

        PelFile file =
                fileRepository
                        .findById(id)
                        .orElse(null);


        // File not found
        if (file == null) {

            return ResponseEntity
                    .notFound()
                    .build();
        }


        // Always serve as PDF
        MediaType mediaType =
                MediaType.APPLICATION_PDF;


        HttpHeaders headers =
                new HttpHeaders();


        headers.setContentType(
                mediaType
        );


        headers.setContentDisposition(
                ContentDisposition
                        .inline()
                        .filename(
                                file.getFileName()
                        )
                        .build()
        );


        return new ResponseEntity<>(
                file.getFileData(),
                headers,
                HttpStatus.OK
        );
    }
    // =========================================================
// DOWNLOAD PDF
// GET /library/pel/file/download/{id}
// =========================================================

    @GetMapping("/pel/file/download/{id}")
    @ResponseBody
    public ResponseEntity<byte[]> downloadFile(
            @PathVariable("id") Long id) {

        PelFile file =
                fileRepository
                        .findById(id)
                        .orElse(null);

        if (file == null) {

            return ResponseEntity
                    .notFound()
                    .build();
        }

        HttpHeaders headers =
                new HttpHeaders();

        headers.setContentType(
                MediaType.APPLICATION_PDF
        );

        headers.setContentDisposition(
                ContentDisposition
                        .attachment()
                        .filename(file.getFileName())
                        .build()
        );

        return new ResponseEntity<>(
                file.getFileData(),
                headers,
                HttpStatus.OK
        );
    }


    // =========================================================
    // NORMALIZE FOLDER NAME
    // =========================================================

    private String normalizedName(
            String rawName) {

        if (rawName == null) {

            return null;
        }


        String name =
                rawName.trim();


        if (name.isBlank()) {

            return null;
        }


        if (name.length() > 120) {

            return null;
        }


        return name;
    }


}
