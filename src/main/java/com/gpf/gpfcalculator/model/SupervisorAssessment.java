package com.gpf.gpfcalculator.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "supervisor_assessments")
public class SupervisorAssessment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long trainingRecordId;

    @Column(nullable = false)
    private String employeeId;

    @Column(nullable = false)
    private String employeeName;

    private String supervisorName;

    @Column(nullable = false)
    private String assessmentStatus;

    @Column(length = 2000)
    private String remarks;

    private LocalDateTime assessedAt;


    // =====================================================
    // ID
    // =====================================================

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    // =====================================================
    // TRAINING RECORD ID
    // =====================================================

    public Long getTrainingRecordId() {
        return trainingRecordId;
    }

    public void setTrainingRecordId(Long trainingRecordId) {
        this.trainingRecordId = trainingRecordId;
    }


    // =====================================================
    // EMPLOYEE ID
    // =====================================================

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }


    // =====================================================
    // EMPLOYEE NAME
    // =====================================================

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }


    // =====================================================
    // SUPERVISOR NAME
    // =====================================================

    public String getSupervisorName() {
        return supervisorName;
    }

    public void setSupervisorName(String supervisorName) {
        this.supervisorName = supervisorName;
    }


    // =====================================================
    // ASSESSMENT STATUS
    // =====================================================

    public String getAssessmentStatus() {
        return assessmentStatus;
    }

    public void setAssessmentStatus(String assessmentStatus) {
        this.assessmentStatus = assessmentStatus;
    }


    // =====================================================
    // REMARKS
    // =====================================================

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }


    // =====================================================
    // ASSESSED AT
    // =====================================================

    public LocalDateTime getAssessedAt() {
        return assessedAt;
    }

    public void setAssessedAt(LocalDateTime assessedAt) {
        this.assessedAt = assessedAt;
    }
}