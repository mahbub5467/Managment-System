package com.gpf.gpfcalculator.controller;

import com.gpf.gpfcalculator.model.PelTrainingRecord;
import com.gpf.gpfcalculator.service.PelTrainingRecordService;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;

@Controller
@RequestMapping("/training")
public class TrainingController {

    private final PelTrainingRecordService service;

    public TrainingController(PelTrainingRecordService service) {
        this.service = service;
    }

    // =====================================================
    // MAIN TRAINING PAGE
    // =====================================================
    @GetMapping
    public String trainingHome() {
        return "training";
    }

    // =====================================================
    // PEL PAGE
    // =====================================================
    @GetMapping("/training-pel")
    public String pelTraining() {
        return "training-pel";
    }

    // =====================================================
    // SAVE TRAINING RECORD (UPDATED FOR UNIFIED FORM & DEP_NAME)
    // URL Path: /training/pel/save
    // =====================================================
    @PostMapping(
            value = "/pel/save",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE
    )
    public String saveTrainingRecord(

            @RequestParam String employeeId,
            @RequestParam String employeeName,
            @RequestParam String designation,

            @RequestParam
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate joiningDate,

            // 👈 Division (depName) রিসিভ করা হচ্ছে (Default: PEL)
            @RequestParam(required = false, defaultValue = "PEL") String depName,

            @RequestParam String trainingType,
            @RequestParam String courseTitle,
            @RequestParam(required = false) String trainingProvider,

            @RequestParam
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate startDate,

            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate endDate,

            @RequestParam(required = false, defaultValue = "no") String certification,

            @RequestParam(required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
            LocalDate certificateDate,

            @RequestParam(required = false) MultipartFile certificateFile

    ) throws IOException {

        // =====================================================
        // BASIC VALIDATION
        // =====================================================
        if (employeeId == null || employeeId.isBlank()) {
            return "redirect:/training/training-pel?error=employee";
        }

        if (employeeName == null || employeeName.isBlank()) {
            return "redirect:/training/training-pel?error=name";
        }

        if (designation == null || designation.isBlank()) {
            return "redirect:/training/training-pel?error=designation";
        }

        if (joiningDate == null) {
            return "redirect:/training/training-pel?error=joiningDate";
        }

        if (trainingType == null || trainingType.isBlank()) {
            return "redirect:/training/training-pel?error=trainingType";
        }

        // =====================================================
        // CREATE UNIFIED RECORD
        // =====================================================
        PelTrainingRecord record = createBaseRecord(
                employeeId,
                employeeName,
                designation,
                joiningDate,
                trainingType
        );

        // 👈 Division (depName) মডেলে সেভ করা হচ্ছে
        record.setDepName(depName != null && !depName.isBlank() ? depName.trim() : "PEL");

        record.setCourseTitle(courseTitle != null ? courseTitle.trim() : "");

        if (trainingProvider != null) {
            record.setTrainingProvider(trainingProvider.trim());
        }

        // Date Set (Model Field Mapping)
        record.setInitialTrainingDate(startDate);
        record.setOjtDate(endDate);

        // Certification & File handling
        record.setCertification(certification);

        if ("yes".equalsIgnoreCase(certification)) {
            record.setCertificateDate(certificateDate);
        } else {
            record.setCertificateDate(null);
            certificateFile = null; // File will not be saved if certification is 'no'
        }

        // Save through Service
        service.saveRecord(record, certificateFile);

        // Success Redirect
        return "redirect:/training/training-pel?saved=true";
    }

    // =====================================================
    // VIEW CERTIFICATE
    // =====================================================
    @GetMapping("/certificate/{id}")
    @ResponseBody
    public ResponseEntity<byte[]> viewCertificate(@PathVariable Long id) {

        PelTrainingRecord record = service.getById(id);

        if (record == null || record.getCertificateData() == null || record.getCertificateData().length == 0) {
            return ResponseEntity.notFound().build();
        }

        MediaType mediaType = MediaType.APPLICATION_OCTET_STREAM;
        String contentType = record.getCertificateContentType();

        if (contentType != null && !contentType.isBlank()) {
            try {
                mediaType = MediaType.parseMediaType(contentType);
            } catch (Exception ignored) {
                mediaType = MediaType.APPLICATION_OCTET_STREAM;
            }
        }

        String fileName = record.getCertificateFileName();
        if (fileName == null || fileName.isBlank()) {
            fileName = "certificate";
        }

        return ResponseEntity.ok()
                .contentType(mediaType)
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"")
                .contentLength(record.getCertificateData().length)
                .body(record.getCertificateData());
    }

    // =====================================================
    // DOWNLOAD CERTIFICATE
    // =====================================================
    @GetMapping("/certificate/{id}/download")
    @ResponseBody
    public ResponseEntity<byte[]> downloadCertificate(@PathVariable Long id) {

        PelTrainingRecord record = service.getById(id);

        if (record == null || record.getCertificateData() == null || record.getCertificateData().length == 0) {
            return ResponseEntity.notFound().build();
        }

        String fileName = record.getCertificateFileName();
        if (fileName == null || fileName.isBlank()) {
            fileName = "certificate";
        }

        MediaType mediaType = MediaType.APPLICATION_OCTET_STREAM;
        String contentType = record.getCertificateContentType();

        if (contentType != null && !contentType.isBlank()) {
            try {
                mediaType = MediaType.parseMediaType(contentType);
            } catch (Exception ignored) {
                mediaType = MediaType.APPLICATION_OCTET_STREAM;
            }
        }

        return ResponseEntity.ok()
                .contentType(mediaType)
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                .contentLength(record.getCertificateData().length)
                .body(record.getCertificateData());
    }

    // =====================================================
    // CREATE BASE RECORD
    // =====================================================
    private PelTrainingRecord createBaseRecord(
            String employeeId,
            String employeeName,
            String designation,
            LocalDate joiningDate,
            String trainingType
    ) {

        PelTrainingRecord record = new PelTrainingRecord();
        record.setEmployeeId(employeeId.trim());
        record.setEmployeeName(employeeName.trim());
        record.setDesignation(designation.trim());
        record.setJoiningDate(joiningDate);
        record.setTrainingType(trainingType.trim());

        return record;
    }
}