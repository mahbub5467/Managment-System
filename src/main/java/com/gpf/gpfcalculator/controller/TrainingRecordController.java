package com.gpf.gpfcalculator.controller;

import com.gpf.gpfcalculator.model.PelTrainingRecord;
import com.gpf.gpfcalculator.model.SupervisorAssessment;
import com.gpf.gpfcalculator.repository.PelTrainingRecordRepository;
import com.gpf.gpfcalculator.repository.SupervisorAssessmentRepository;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Controller
public class TrainingRecordController {

    private final PelTrainingRecordRepository
            trainingRecordRepository;

    private final SupervisorAssessmentRepository
            assessmentRepository;


    // =====================================================
    // CONSTRUCTOR
    // =====================================================

    public TrainingRecordController(

            PelTrainingRecordRepository
                    trainingRecordRepository,

            SupervisorAssessmentRepository
                    assessmentRepository) {

        this.trainingRecordRepository =
                trainingRecordRepository;

        this.assessmentRepository =
                assessmentRepository;
    }


    // =====================================================
    // TRAINING RECORD PAGE
    // ONLY APPROVED RECORDS
    // =====================================================

    @GetMapping("/training-record")
    public String trainingRecord(
            Model model) {

        List<SupervisorAssessment>
                approvedAssessments =

                assessmentRepository
                        .findByAssessmentStatusOrderByIdDesc(
                                "APPROVED"
                        );


        List<PelTrainingRecord> records =
                getApprovedTrainingRecords(
                        approvedAssessments
                );


        model.addAttribute(
                "records",
                records
        );


        return "training-record";
    }


    // =====================================================
    // SEARCH
    // =====================================================

    @GetMapping("/training-record/search")
    public String searchTrainingRecord(

            @RequestParam(
                    required = false
            )
            String employeeId,

            Model model) {


        List<PelTrainingRecord> records;


        // =================================================
        // EMPTY SEARCH
        // =================================================

        if (
                employeeId == null ||
                        employeeId.trim().isEmpty()
        ) {

            List<SupervisorAssessment>
                    approvedAssessments =

                    assessmentRepository
                            .findByAssessmentStatusOrderByIdDesc(
                                    "APPROVED"
                            );


            records =
                    getApprovedTrainingRecords(
                            approvedAssessments
                    );

        }


        // =================================================
        // SEARCH BY EMPLOYEE
        // =================================================

        else {

            String searchId =
                    employeeId.trim();


            List<SupervisorAssessment>
                    filteredAssessments =

                    assessmentRepository
                            .findByAssessmentStatusAndEmployeeIdOrderByIdDesc(
                                    "APPROVED",
                                    searchId
                            );


            records =
                    getApprovedTrainingRecords(
                            filteredAssessments
                    );
        }


        model.addAttribute(
                "records",
                records
        );


        model.addAttribute(
                "searchEmployeeId",
                employeeId
        );


        return "training-record";
    }


    // =====================================================
    // APPROVED RECORDS
    // =====================================================

    private List<PelTrainingRecord>
    getApprovedTrainingRecords(

            List<SupervisorAssessment>
                    assessments) {


        List<PelTrainingRecord> records =
                new ArrayList<>();


        for (
                SupervisorAssessment assessment :
                assessments
        ) {


            if (
                    assessment.getTrainingRecordId()
                            == null
            ) {

                continue;
            }


            trainingRecordRepository
                    .findById(
                            assessment.getTrainingRecordId()
                    )
                    .ifPresent(records::add);

        }


        return records;
    }


    // =====================================================
    // VIEW CERTIFICATE
    // =====================================================

    @GetMapping("/certificate/{id}")
    @ResponseBody
    public ResponseEntity<byte[]> viewCertificate(
            @PathVariable Long id) {


        PelTrainingRecord record =

                trainingRecordRepository
                        .findById(id)
                        .orElseThrow(() ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        "Training record not found"
                                )
                        );


        if (
                record.getCertificateData() == null ||
                        record.getCertificateData().length == 0
        ) {

            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND,
                    "Certificate not found"
            );
        }


        String contentType =
                record.getCertificateContentType();


        MediaType mediaType;


        try {

            mediaType =
                    contentType == null ||
                            contentType.isBlank()

                            ? MediaType.APPLICATION_OCTET_STREAM

                            : MediaType.parseMediaType(
                            contentType
                    );

        } catch (Exception e) {

            mediaType =
                    MediaType.APPLICATION_OCTET_STREAM;
        }


        String fileName =
                record.getCertificateFileName();


        if (
                fileName == null ||
                        fileName.isBlank()
        ) {

            fileName = "certificate";
        }


        fileName =
                fileName
                        .replace("\"", "")
                        .replace("\r", "")
                        .replace("\n", "");


        HttpHeaders headers =
                new HttpHeaders();


        headers.setContentType(
                mediaType
        );


        headers.set(
                HttpHeaders.CONTENT_DISPOSITION,
                "inline; filename=\"" +
                        fileName +
                        "\""
        );


        headers.setContentLength(
                record.getCertificateData().length
        );


        return new ResponseEntity<>(
                record.getCertificateData(),
                headers,
                HttpStatus.OK
        );
    }


    // =====================================================
    // PRINT
    // =====================================================

    @GetMapping("/training-record/print/{id}")
    public String printTrainingRecord(

            @PathVariable Long id,

            Model model) {


        PelTrainingRecord record =

                trainingRecordRepository
                        .findById(id)
                        .orElseThrow(() ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        "Training record not found"
                                )
                        );


        SupervisorAssessment assessment =

                assessmentRepository
                        .findByTrainingRecordId(id)
                        .orElseThrow(() ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        "Supervisor assessment not found"
                                )
                        );


        if (
                !"APPROVED".equalsIgnoreCase(
                        assessment.getAssessmentStatus()
                )
        ) {

            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN,
                    "Only approved records can be printed."
            );
        }


        model.addAttribute(
                "record",
                record
        );


        model.addAttribute(
                "assessment",
                assessment
        );


        return "training-record-print";
    }

}