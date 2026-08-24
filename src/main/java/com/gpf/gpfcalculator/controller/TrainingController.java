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
import java.util.List;

@Controller
@RequestMapping("/training")
public class TrainingController {

    private final PelTrainingRecordService service;


    public TrainingController(
            PelTrainingRecordService service) {

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
    // SUPERVISOR ASSESSMENT
    // =====================================================

    @GetMapping("/supervisor-assessment")
    public String supervisorAssessment() {

        return "supervisor-assessment";
    }


    // =====================================================
    // TRAINING RECORD
    // =====================================================

    @GetMapping("/training-record")
    public String trainingRecord() {

        return "training-record";
    }


    // =====================================================
    // SAVE TRAINING RECORD
    // =====================================================

    @PostMapping(
            value = "/save",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE
    )
    public String saveTrainingRecord(

            @RequestParam String employeeId,

            @RequestParam String employeeName,

            @RequestParam String designation,

            @RequestParam
            @DateTimeFormat(
                    iso = DateTimeFormat.ISO.DATE
            )
            LocalDate joiningDate,

            @RequestParam String trainingType,


            // =================================================
            // INITIAL TRAINING
            // =================================================

            @RequestParam(
                    value = "initialCourse[]",
                    required = false
            )
            List<String> initialCourse,

            @RequestParam(
                    value = "initialTrainingDate[]",
                    required = false
            )
            List<String> initialTrainingDate,

            @RequestParam(
                    value = "ojtDate[]",
                    required = false
            )
            List<String> ojtDate,


            // =================================================
            // INITIAL CERTIFICATION
            // =================================================

            @RequestParam(
                    value = "initialCertification",
                    required = false
            )
            String initialCertification,


            // =================================================
            // INITIAL CERTIFICATE DATE
            // =================================================

            @RequestParam(
                    value = "initialCertificateDate[]",
                    required = false
            )
            List<String> initialCertificateDates,


            // =================================================
            // INITIAL CERTIFICATE FILE
            // =================================================

            @RequestParam(
                    value = "initialCertificate[]",
                    required = false
            )
            List<MultipartFile> initialCertificates,


            // =================================================
            // OTHER TRAINING
            // =================================================

            @RequestParam(
                    value = "trainingDescription",
                    required = false
            )
            String trainingDescription,

            @RequestParam(
                    value = "trainingProvider",
                    required = false
            )
            String trainingProvider,

            @RequestParam(
                    value = "trainingDate",
                    required = false
            )
            String trainingDate,


            @RequestParam(
                    value = "otherCertification",
                    required = false
            )
            String otherCertification,


            // =================================================
            // OTHER CERTIFICATE DATE
            // =================================================

            @RequestParam(
                    value = "otherCertificateDate",
                    required = false
            )
            String otherCertificateDate,


            // =================================================
            // OTHER CERTIFICATE FILE
            // =================================================

            @RequestParam(
                    value = "otherCertificate[]",
                    required = false
            )
            List<MultipartFile> otherCertificates

    ) throws IOException {


        // =====================================================
        // BASIC VALIDATION
        // =====================================================

        if (employeeId == null ||
                employeeId.isBlank()) {

            return "redirect:/training/training-pel?error=employee";
        }


        if (employeeName == null ||
                employeeName.isBlank()) {

            return "redirect:/training/training-pel?error=name";
        }


        if (designation == null ||
                designation.isBlank()) {

            return "redirect:/training/training-pel?error=designation";
        }


        if (joiningDate == null) {

            return "redirect:/training/training-pel?error=joiningDate";
        }


        if (trainingType == null ||
                trainingType.isBlank()) {

            return "redirect:/training/training-pel?error=trainingType";
        }


        // =====================================================
        // INITIAL TRAINING
        // =====================================================

        if ("initial".equalsIgnoreCase(trainingType)) {


            if (initialCourse != null &&
                    !initialCourse.isEmpty()) {


                for (int i = 0;
                     i < initialCourse.size();
                     i++) {


                    String course =
                            get(
                                    initialCourse,
                                    i
                            );


                    // Empty course row skip

                    if (course == null ||
                            course.isBlank()) {

                        continue;
                    }


                    // =================================================
                    // CREATE RECORD
                    // =================================================

                    PelTrainingRecord record =
                            createBaseRecord(
                                    employeeId,
                                    employeeName,
                                    designation,
                                    joiningDate,
                                    trainingType
                            );


                    // =================================================
                    // COURSE
                    // =================================================

                    record.setCourseTitle(
                            course.trim()
                    );


                    // =================================================
                    // INITIAL TRAINING DATE
                    // =================================================

                    record.setInitialTrainingDate(
                            parseDate(
                                    get(
                                            initialTrainingDate,
                                            i
                                    )
                            )
                    );


                    // =================================================
                    // OJT DATE
                    // =================================================

                    record.setOjtDate(
                            parseDate(
                                    get(
                                            ojtDate,
                                            i
                                    )
                            )
                    );


                    // =================================================
                    // CERTIFICATION
                    // =================================================

                    record.setCertification(
                            initialCertification
                    );


                    // =================================================
                    // CERTIFICATE DATE
                    //
                    // Date is saved only when certification = YES
                    // =================================================

                    if ("yes".equalsIgnoreCase(
                            initialCertification)) {


                        String certificateDateValue =
                                get(
                                        initialCertificateDates,
                                        i
                                );


                        record.setCertificateDate(
                                parseDate(
                                        certificateDateValue
                                )
                        );


                    } else {

                        record.setCertificateDate(null);
                    }


                    // =================================================
                    // CERTIFICATE FILE
                    // =================================================

                    MultipartFile certificate =
                            get(
                                    initialCertificates,
                                    i
                            );


                    // Certificate is allowed only for YES

                    if (!"yes".equalsIgnoreCase(
                            initialCertification)) {

                        certificate = null;
                    }


                    // =================================================
                    // SAVE
                    // =================================================

                    service.saveRecord(
                            record,
                            certificate
                    );
                }
            }
        }


        // =====================================================
        // RECURRENT / SPECIALIZED / PREVIOUS
        // =====================================================

        else if (
                "recurrent".equalsIgnoreCase(trainingType)
                        ||
                        "specialized".equalsIgnoreCase(trainingType)
                        ||
                        "previous".equalsIgnoreCase(trainingType)
        ) {


            if (trainingDescription != null &&
                    !trainingDescription.isBlank()) {


                // =================================================
                // CREATE RECORD
                // =================================================

                PelTrainingRecord record =
                        createBaseRecord(
                                employeeId,
                                employeeName,
                                designation,
                                joiningDate,
                                trainingType
                        );


                // =================================================
                // DESCRIPTION
                // =================================================

                record.setTrainingDescription(
                        trainingDescription.trim()
                );


                // =================================================
                // PROVIDER
                // =================================================

                if (trainingProvider != null) {

                    record.setTrainingProvider(
                            trainingProvider.trim()
                    );
                }


                // =================================================
                // TRAINING DATE
                // =================================================

                record.setTrainingDate(
                        parseDate(
                                trainingDate
                        )
                );


                // =================================================
                // CERTIFICATION
                // =================================================

                record.setCertification(
                        otherCertification
                );


                // =================================================
                // CERTIFICATE DATE
                // =================================================

                if ("yes".equalsIgnoreCase(
                        otherCertification)) {


                    record.setCertificateDate(
                            parseDate(
                                    otherCertificateDate
                            )
                    );


                } else {

                    record.setCertificateDate(null);
                }


                // =================================================
                // CERTIFICATE FILE
                // =================================================

                MultipartFile certificate =
                        get(
                                otherCertificates,
                                0
                        );


                if (!"yes".equalsIgnoreCase(
                        otherCertification)) {

                    certificate = null;
                }


                // =================================================
                // SAVE
                // =================================================

                service.saveRecord(
                        record,
                        certificate
                );
            }
        }


        // =====================================================
        // SUCCESS
        // =====================================================

        return "redirect:/training/training-pel?saved=true";
    }


    // =====================================================
    // VIEW CERTIFICATE
    // =====================================================

    @GetMapping(
            "/certificate/{id}"
    )
    @ResponseBody
    public ResponseEntity<byte[]> viewCertificate(
            @PathVariable Long id) {


        PelTrainingRecord record =
                service.getById(id);


        if (record == null ||
                record.getCertificateData() == null ||
                record.getCertificateData().length == 0) {

            return ResponseEntity.notFound().build();
        }


        MediaType mediaType =
                MediaType.APPLICATION_OCTET_STREAM;


        String contentType =
                record.getCertificateContentType();


        if (contentType != null &&
                !contentType.isBlank()) {

            try {

                mediaType =
                        MediaType.parseMediaType(
                                contentType
                        );

            } catch (Exception ignored) {

                mediaType =
                        MediaType.APPLICATION_OCTET_STREAM;
            }
        }


        String fileName =
                record.getCertificateFileName();


        if (fileName == null ||
                fileName.isBlank()) {

            fileName = "certificate";
        }


        return ResponseEntity.ok()
                .contentType(mediaType)
                .header(
                        HttpHeaders.CONTENT_DISPOSITION,
                        "inline; filename=\"" +
                                fileName +
                                "\""
                )
                .contentLength(
                        record.getCertificateData().length
                )
                .body(
                        record.getCertificateData()
                );
    }


    // =====================================================
    // DOWNLOAD CERTIFICATE
    // =====================================================

    @GetMapping(
            "/certificate/{id}/download"
    )
    @ResponseBody
    public ResponseEntity<byte[]> downloadCertificate(
            @PathVariable Long id) {


        PelTrainingRecord record =
                service.getById(id);


        if (record == null ||
                record.getCertificateData() == null ||
                record.getCertificateData().length == 0) {

            return ResponseEntity.notFound().build();
        }


        String fileName =
                record.getCertificateFileName();


        if (fileName == null ||
                fileName.isBlank()) {

            fileName = "certificate";
        }


        MediaType mediaType =
                MediaType.APPLICATION_OCTET_STREAM;


        String contentType =
                record.getCertificateContentType();


        if (contentType != null &&
                !contentType.isBlank()) {

            try {

                mediaType =
                        MediaType.parseMediaType(
                                contentType
                        );

            } catch (Exception ignored) {

                mediaType =
                        MediaType.APPLICATION_OCTET_STREAM;
            }
        }


        return ResponseEntity.ok()
                .contentType(mediaType)
                .header(
                        HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" +
                                fileName +
                                "\""
                )
                .contentLength(
                        record.getCertificateData().length
                )
                .body(
                        record.getCertificateData()
                );
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


        PelTrainingRecord record =
                new PelTrainingRecord();


        record.setEmployeeId(
                employeeId.trim()
        );


        record.setEmployeeName(
                employeeName.trim()
        );


        record.setDesignation(
                designation.trim()
        );


        record.setJoiningDate(
                joiningDate
        );


        record.setTrainingType(
                trainingType.trim()
        );


        return record;
    }


    // =====================================================
    // PARSE DATE
    // =====================================================

    private LocalDate parseDate(
            String value) {


        if (value == null ||
                value.isBlank()) {

            return null;
        }


        try {

            return LocalDate.parse(
                    value.trim()
            );

        } catch (Exception e) {

            return null;
        }
    }


    // =====================================================
    // SAFE LIST GET
    // =====================================================

    private <T> T get(
            List<T> list,
            int index) {


        if (list == null ||
                index < 0 ||
                index >= list.size()) {

            return null;
        }


        return list.get(index);
    }
}