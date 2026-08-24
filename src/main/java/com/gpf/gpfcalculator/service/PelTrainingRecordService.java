package com.gpf.gpfcalculator.service;

import com.gpf.gpfcalculator.model.PelTrainingRecord;
import com.gpf.gpfcalculator.repository.PelTrainingRecordRepository;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
public class PelTrainingRecordService {

    private final PelTrainingRecordRepository repository;


    // =====================================================
    // CONSTRUCTOR
    // =====================================================

    public PelTrainingRecordService(
            PelTrainingRecordRepository repository) {

        this.repository = repository;
    }


    // =====================================================
    // SAVE RECORD
    // =====================================================

    public PelTrainingRecord saveRecord(
            PelTrainingRecord record,
            MultipartFile certificate) throws IOException {


        // =================================================
        // CERTIFICATE YES
        // =================================================

        if (
                "yes".equalsIgnoreCase(
                        record.getCertification()
                )
        ) {

            if (
                    certificate == null ||
                            certificate.isEmpty()
            ) {

                throw new IllegalArgumentException(
                        "Certificate file is required when certification is YES."
                );
            }


            validateCertificate(certificate);


            record.setCertificateData(
                    certificate.getBytes()
            );

            record.setCertificateFileName(
                    certificate.getOriginalFilename()
            );

            record.setCertificateContentType(
                    certificate.getContentType()
            );

        }


        // =================================================
        // CERTIFICATE NO
        // =================================================

        else {

            record.setCertificateData(null);

            record.setCertificateFileName(null);

            record.setCertificateContentType(null);

            record.setCertificateDate(null);

        }


        return repository.save(record);
    }


    // =====================================================
    // VALIDATE CERTIFICATE
    // =====================================================

    private void validateCertificate(
            MultipartFile certificate) {


        if (certificate.getSize() >
                10L * 1024L * 1024L) {

            throw new IllegalArgumentException(
                    "Certificate file must not exceed 10 MB."
            );
        }


        String fileName =
                certificate.getOriginalFilename();


        if (fileName == null ||
                fileName.isBlank()) {

            throw new IllegalArgumentException(
                    "Certificate file name is missing."
            );
        }


        String lowerName =
                fileName.toLowerCase();


        boolean validExtension =
                lowerName.endsWith(".pdf") ||
                        lowerName.endsWith(".jpg") ||
                        lowerName.endsWith(".jpeg") ||
                        lowerName.endsWith(".png");


        if (!validExtension) {

            throw new IllegalArgumentException(
                    "Only PDF, JPG, JPEG and PNG files are allowed."
            );
        }

    }


    // =====================================================
    // GET ALL
    // =====================================================

    public List<PelTrainingRecord> getAllRecords() {

        return repository.findAll();
    }


    // =====================================================
    // GET BY EMPLOYEE ID
    // =====================================================

    public List<PelTrainingRecord> getByEmployeeId(
            String employeeId) {

        return repository.findByEmployeeId(
                employeeId
        );
    }


    // =====================================================
    // GET BY ID
    // =====================================================

    public PelTrainingRecord getById(Long id) {

        return repository
                .findById(id)
                .orElse(null);
    }

}