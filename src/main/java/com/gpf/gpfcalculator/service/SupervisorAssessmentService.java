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

        this.assessmentRepository = assessmentRepository;
        this.trainingRecordRepository = trainingRecordRepository;
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
        return assessmentRepository.findByAssessmentStatusOrderByIdDesc("PENDING");
    }

    // =====================================================
    // GET ASSESSMENT BY ID
    // =====================================================
    public SupervisorAssessment getById(Long id) {
        return assessmentRepository.findById(id).orElse(null);
    }

    // =====================================================
    // GET ASSESSMENT BY TRAINING RECORD ID
    // =====================================================
    public SupervisorAssessment getByTrainingRecordId(Long trainingRecordId) {
        return assessmentRepository.findByTrainingRecordId(trainingRecordId).orElse(null);
    }

    // =====================================================
    // CREATE INITIAL PENDING ASSESSMENT
    // =====================================================
    @Transactional
    public SupervisorAssessment createAssessment(Long trainingRecordId) {

        SupervisorAssessment existing = assessmentRepository
                .findByTrainingRecordId(trainingRecordId)
                .orElse(null);

        if (existing != null) {
            return existing;
        }

        PelTrainingRecord record = trainingRecordRepository
                .findById(trainingRecordId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Training record not found: " + trainingRecordId
                ));

        SupervisorAssessment assessment = new SupervisorAssessment();
        assessment.setTrainingRecordId(record.getId());
        assessment.setEmployeeId(record.getEmployeeId());
        assessment.setEmployeeName(record.getEmployeeName());
        assessment.setAssessmentStatus("PENDING");
        assessment.setSupervisorName(null);
        assessment.setRemarks(null);
        assessment.setAssessedAt(null);

        return assessmentRepository.save(assessment);
    }

    // =====================================================
    // SAVE ASSESSMENT (WITH DYNAMIC DROPDOWN STATUS & REMARKS)
    // =====================================================
    @Transactional
    public SupervisorAssessment saveAssessment(
            Long trainingRecordId,
            String supervisorName,
            String remarks,
            String status) {

        SupervisorAssessment assessment = assessmentRepository
                .findByTrainingRecordId(trainingRecordId)
                .orElseGet(() -> createAssessment(trainingRecordId));

        /*
         * Dropdown status set (Satisfactory, Needs Review, Approved, Rejected etc.)
         */
        if (status != null && !status.trim().isEmpty()) {
            assessment.setAssessmentStatus(status.trim());
        } else {
            assessment.setAssessmentStatus("APPROVED");
        }

        assessment.setSupervisorName(supervisorName);
        assessment.setRemarks(remarks);
        assessment.setAssessedAt(LocalDateTime.now());

        return assessmentRepository.save(assessment);
    }

    // =====================================================
    // APPROVE TRAINING RECORD (OVERLOADED FOR COMPATIBILITY)
    // =====================================================
    @Transactional
    public SupervisorAssessment approve(
            Long trainingRecordId,
            String supervisorName,
            String remarks) {

        return saveAssessment(trainingRecordId, supervisorName, remarks, "APPROVED");
    }

    @Transactional
    public SupervisorAssessment approve(
            Long trainingRecordId,
            String supervisorName,
            String remarks,
            String status) {

        return saveAssessment(trainingRecordId, supervisorName, remarks, status);
    }

    // =====================================================
    // REJECT TRAINING RECORD (OVERLOADED FOR COMPATIBILITY)
    // =====================================================
    @Transactional
    public SupervisorAssessment reject(
            Long trainingRecordId,
            String supervisorName,
            String remarks) {

        return saveAssessment(trainingRecordId, supervisorName, remarks, "REJECTED");
    }

    @Transactional
    public SupervisorAssessment reject(
            Long trainingRecordId,
            String supervisorName,
            String remarks,
            String status) {

        return saveAssessment(trainingRecordId, supervisorName, remarks, status);
    }

    // =====================================================
    // RESET ASSESSMENT TO PENDING
    // =====================================================
    @Transactional
    public SupervisorAssessment resetToPending(Long assessmentId) {

        SupervisorAssessment assessment = assessmentRepository
                .findById(assessmentId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Assessment not found: " + assessmentId
                ));

        assessment.setAssessmentStatus("PENDING");
        assessment.setSupervisorName(null);
        assessment.setRemarks(null);
        assessment.setAssessedAt(null);

        return assessmentRepository.save(assessment);
    }
}