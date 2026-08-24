package com.gpf.gpfcalculator.service;

import com.gpf.gpfcalculator.model.PelTrainingRecord;
import com.gpf.gpfcalculator.model.SupervisorAssessment;
import com.gpf.gpfcalculator.repository.PelTrainingRecordRepository;
import com.gpf.gpfcalculator.repository.SupervisorAssessmentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class SupervisorAssessmentService {

    private final SupervisorAssessmentRepository assessmentRepository;
    private final PelTrainingRecordRepository trainingRecordRepository;


    // =====================================================
    // CONSTRUCTOR
    // =====================================================

    public SupervisorAssessmentService(
            SupervisorAssessmentRepository assessmentRepository,
            PelTrainingRecordRepository trainingRecordRepository) {

        this.assessmentRepository =
                assessmentRepository;

        this.trainingRecordRepository =
                trainingRecordRepository;
    }


    // =====================================================
    // GET ALL ASSESSMENTS
    // =====================================================

    public List<SupervisorAssessment> getAllAssessments() {

        return assessmentRepository.findAll();
    }


    // =====================================================
    // GET PENDING ASSESSMENTS
    // =====================================================

    public List<SupervisorAssessment> getPendingAssessments() {

        return assessmentRepository
                .findByAssessmentStatusOrderByIdDesc(
                        "PENDING"
                );
    }


    // =====================================================
    // GET ASSESSMENT BY ID
    // =====================================================

    public SupervisorAssessment getById(Long id) {

        return assessmentRepository
                .findById(id)
                .orElse(null);
    }


    // =====================================================
    // GET ASSESSMENT BY TRAINING RECORD ID
    // =====================================================

    public SupervisorAssessment getByTrainingRecordId(
            Long trainingRecordId) {

        return assessmentRepository
                .findByTrainingRecordId(
                        trainingRecordId
                )
                .orElse(null);
    }


    // =====================================================
    // CREATE ASSESSMENT
    // =====================================================

    @Transactional
    public SupervisorAssessment createAssessment(
            Long trainingRecordId) {

        /*
         * Check whether assessment already exists
         * for this training record.
         */

        SupervisorAssessment existing =
                assessmentRepository
                        .findByTrainingRecordId(
                                trainingRecordId
                        )
                        .orElse(null);


        if (existing != null) {

            return existing;
        }


        /*
         * Find the original training record.
         */

        PelTrainingRecord record =
                trainingRecordRepository
                        .findById(trainingRecordId)
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "Training record not found: "
                                                + trainingRecordId
                                )
                        );


        /*
         * Create new assessment.
         */

        SupervisorAssessment assessment =
                new SupervisorAssessment();


        /*
         * Store Training Record ID.
         */

        assessment.setTrainingRecordId(
                record.getId()
        );


        /*
         * Copy employee information.
         */

        assessment.setEmployeeId(
                record.getEmployeeId()
        );

        assessment.setEmployeeName(
                record.getEmployeeName()
        );


        /*
         * Initial status.
         */

        assessment.setAssessmentStatus(
                "PENDING"
        );


        /*
         * Initial supervisor information.
         */

        assessment.setSupervisorName(
                null
        );

        assessment.setRemarks(
                null
        );

        assessment.setAssessedAt(
                null
        );


        /*
         * Save assessment.
         */

        return assessmentRepository.save(
                assessment
        );
    }


    // =====================================================
    // APPROVE TRAINING RECORD
    // =====================================================

    @Transactional
    public SupervisorAssessment approve(
            Long trainingRecordId,
            String supervisorName,
            String remarks) {

        /*
         * IMPORTANT:
         *
         * The ID coming from the Supervisor Assessment
         * page is PelTrainingRecord ID.
         *
         * Therefore we must NOT use:
         *
         * assessmentRepository.findById(trainingRecordId)
         *
         * because that searches by SupervisorAssessment ID.
         *
         * Instead we search by trainingRecordId.
         */

        SupervisorAssessment assessment =
                assessmentRepository
                        .findByTrainingRecordId(
                                trainingRecordId
                        )
                        .orElseGet(() ->
                                createAssessment(
                                        trainingRecordId
                                )
                        );


        /*
         * Update assessment status.
         */

        assessment.setAssessmentStatus(
                "APPROVED"
        );


        /*
         * Store supervisor name.
         */

        assessment.setSupervisorName(
                supervisorName
        );


        /*
         * Store supervisor remarks.
         */

        assessment.setRemarks(
                remarks
        );


        /*
         * Store assessment time.
         */

        assessment.setAssessedAt(
                LocalDateTime.now()
        );


        /*
         * Save updated assessment.
         */

        return assessmentRepository.save(
                assessment
        );
    }


    // =====================================================
    // REJECT TRAINING RECORD
    // =====================================================

    @Transactional
    public SupervisorAssessment reject(
            Long trainingRecordId,
            String supervisorName,
            String remarks) {

        /*
         * Find assessment using Training Record ID.
         *
         * If assessment does not exist,
         * create a new one first.
         */

        SupervisorAssessment assessment =
                assessmentRepository
                        .findByTrainingRecordId(
                                trainingRecordId
                        )
                        .orElseGet(() ->
                                createAssessment(
                                        trainingRecordId
                                )
                        );


        /*
         * Update status.
         */

        assessment.setAssessmentStatus(
                "REJECTED"
        );


        /*
         * Store supervisor name.
         */

        assessment.setSupervisorName(
                supervisorName
        );


        /*
         * Store supervisor remarks.
         */

        assessment.setRemarks(
                remarks
        );


        /*
         * Store assessment time.
         */

        assessment.setAssessedAt(
                LocalDateTime.now()
        );


        /*
         * Save updated assessment.
         */

        return assessmentRepository.save(
                assessment
        );
    }


    // =====================================================
    // RESET ASSESSMENT TO PENDING
    // =====================================================

    @Transactional
    public SupervisorAssessment resetToPending(
            Long assessmentId) {

        /*
         * resetToPending() receives the actual
         * SupervisorAssessment ID.
         *
         * Therefore findById() is correct here.
         */

        SupervisorAssessment assessment =
                assessmentRepository
                        .findById(assessmentId)
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "Assessment not found: "
                                                + assessmentId
                                )
                        );


        /*
         * Reset status.
         */

        assessment.setAssessmentStatus(
                "PENDING"
        );


        /*
         * Clear supervisor information.
         */

        assessment.setSupervisorName(
                null
        );

        assessment.setRemarks(
                null
        );

        assessment.setAssessedAt(
                null
        );


        /*
         * Save assessment.
         */

        return assessmentRepository.save(
                assessment
        );
    }
}