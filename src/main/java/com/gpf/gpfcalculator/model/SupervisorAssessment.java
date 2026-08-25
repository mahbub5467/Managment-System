package com.gpf.gpfcalculator.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "supervisor_assessments")
public class SupervisorAssessment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long trainingRecordId;

    private String employeeId;

    private String employeeName;

    private String supervisorName;

    @Column(nullable = false)
    private String assessmentStatus;

    @Column(length = 2000)
    private String remarks;

    private LocalDateTime assessedAt;

    // Custom Constructor
    public SupervisorAssessment(Long trainingRecordId, String employeeId, String supervisorName, String assessmentStatus, String remarks) {
        this.trainingRecordId = trainingRecordId;
        this.employeeId = employeeId;
        this.supervisorName = supervisorName;
        this.assessmentStatus = assessmentStatus;
        this.remarks = remarks;
        this.assessedAt = LocalDateTime.now();
    }

    @PrePersist
    @PreUpdate
    protected void onUpdate() {
        this.assessedAt = LocalDateTime.now();
    }
}