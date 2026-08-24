package com.gpf.gpfcalculator.repository;

import com.gpf.gpfcalculator.model.SupervisorAssessment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SupervisorAssessmentRepository
        extends JpaRepository<SupervisorAssessment, Long> {

    // =====================================================
    // FIND BY EMPLOYEE ID
    // =====================================================

    List<SupervisorAssessment> findByEmployeeId(String employeeId);


    // =====================================================
    // FIND BY ASSESSMENT STATUS
    // =====================================================

    List<SupervisorAssessment> findByAssessmentStatus(
            String assessmentStatus
    );


    // =====================================================
    // FIND BY STATUS - LATEST FIRST
    // =====================================================

    List<SupervisorAssessment>
    findByAssessmentStatusOrderByIdDesc(
            String assessmentStatus
    );


    // =====================================================
    // FIND BY TRAINING RECORD ID
    // =====================================================

    Optional<SupervisorAssessment>
    findByTrainingRecordId(
            Long trainingRecordId
    );


    // =====================================================
    // APPROVED RECORDS + EMPLOYEE SEARCH
    // =====================================================

    List<SupervisorAssessment>
    findByAssessmentStatusAndEmployeeIdOrderByIdDesc(
            String assessmentStatus,
            String employeeId
    );

}