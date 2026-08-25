package com.gpf.gpfcalculator.controller;

import com.gpf.gpfcalculator.model.PelTrainingRecord;
import com.gpf.gpfcalculator.model.SupervisorAssessment;
import com.gpf.gpfcalculator.repository.PelTrainingRecordRepository;
import com.gpf.gpfcalculator.service.PelTrainingRecordService;
import com.gpf.gpfcalculator.service.SupervisorAssessmentService;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;

import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/training/supervisor-assessment")
public class SupervisorAssessmentController {

    private final PelTrainingRecordService trainingRecordService;
    private final PelTrainingRecordRepository trainingRecordRepository;
    private final SupervisorAssessmentService assessmentService;

    public SupervisorAssessmentController(
            PelTrainingRecordService trainingRecordService,
            PelTrainingRecordRepository trainingRecordRepository,
            SupervisorAssessmentService assessmentService) {

        this.trainingRecordService = trainingRecordService;
        this.trainingRecordRepository = trainingRecordRepository;
        this.assessmentService = assessmentService;
    }

    // =========================================================
    // ১. SUPERVISOR ASSESSMENT MAIN PAGE
    // URL: /training/supervisor-assessment
    // =========================================================
    @GetMapping
    public String supervisorAssessment(Model model) {
        List<PelTrainingRecord> allRecords = trainingRecordService.getAllRecords();
        List<PelTrainingRecord> pendingRecords = getPendingRecords(allRecords);

        model.addAttribute("records", pendingRecords);
        return "supervisor-assessment";
    }

    // =========================================================
    // ২. EMPLOYEE SEARCH
    // URL: /training/supervisor-assessment/search
    // =========================================================
    @GetMapping("/search")
    public String searchEmployee(
            @RequestParam(required = false) String employeeId,
            Model model) {

        List<PelTrainingRecord> records;

        if (employeeId == null || employeeId.trim().isEmpty()) {
            records = trainingRecordService.getAllRecords();
        } else {
            records = trainingRecordService.getByEmployeeId(employeeId.trim());
        }

        List<PelTrainingRecord> pendingRecords = getPendingRecords(records);

        model.addAttribute("records", pendingRecords);
        model.addAttribute("searchEmployeeId", employeeId);

        return "supervisor-assessment";
    }

    // =========================================================
    // ৩. VIEW ATTACHED CERTIFICATE
    // URL: /training/supervisor-assessment/certificate/{id}
    // =========================================================
    @GetMapping("/certificate/{id}")
    public ResponseEntity<byte[]> viewCertificate(@PathVariable Long id) {

        PelTrainingRecord record = trainingRecordRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Training record not found"
                ));

        if (record.getCertificateData() == null || record.getCertificateData().length == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Certificate not found");
        }

        String contentType = record.getCertificateContentType();
        if (contentType == null || contentType.isBlank()) {
            contentType = "application/pdf";
        }

        String fileName = record.getCertificateFileName();
        if (fileName == null || fileName.isBlank()) {
            fileName = "certificate.pdf";
        }

        HttpHeaders headers = new HttpHeaders();
        try {
            headers.setContentType(MediaType.parseMediaType(contentType));
        } catch (Exception e) {
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        }

        headers.set(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileName + "\"");
        headers.setContentLength(record.getCertificateData().length);

        return new ResponseEntity<>(record.getCertificateData(), headers, HttpStatus.OK);
    }

    // =========================================================
    // ৪. SAVE SUPERVISOR ASSESSMENT (FIXED REDIRECT URL)
    // URL: /training/supervisor-assessment/save/{id}
    // =========================================================
    @PostMapping("/save/{id}")
    public String saveAssessment(
            @PathVariable Long id,
            @RequestParam("assessmentStatus") String assessmentStatus,
            @RequestParam(value = "comment", required = false) String remarks) {

        String supervisorName = "Supervisor";

        assessmentService.saveAssessment(id, supervisorName, remarks, assessmentStatus);

        // 🎯 Redirect URL Fixed to correct path /training/supervisor-assessment
        return "redirect:/training/supervisor-assessment?assessed=true";
    }

    // =========================================================
    // HELPER METHOD: GET ONLY PENDING RECORDS
    // =========================================================
    private List<PelTrainingRecord> getPendingRecords(List<PelTrainingRecord> records) {

        List<PelTrainingRecord> pendingRecords = new ArrayList<>();

        if (records == null || records.isEmpty()) {
            return pendingRecords;
        }

        for (PelTrainingRecord record : records) {
            SupervisorAssessment assessment = assessmentService.getByTrainingRecordId(record.getId());

            if (assessment == null) {
                pendingRecords.add(record);
                continue;
            }

            String status = assessment.getAssessmentStatus();

            if (status == null || "PENDING".equalsIgnoreCase(status)) {
                pendingRecords.add(record);
            }
        }

        return pendingRecords;
    }
}