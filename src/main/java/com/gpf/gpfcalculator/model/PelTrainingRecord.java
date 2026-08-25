package com.gpf.gpfcalculator.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "pel_training_records")
public class PelTrainingRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // =====================================================
    // EMPLOYEE DETAILS
    // =====================================================

    @Column(nullable = false)
    private String employeeId;

    @Column(nullable = false)
    private String employeeName;

    @Column(nullable = false)
    private String designation;

    @Column(nullable = false)
    private LocalDate joiningDate;

    // Division / Department Field Added
    private String depName;

    // =====================================================
    // TRAINING DETAILS
    // =====================================================

    @Column(nullable = false)
    private String trainingType;

    private String courseTitle;

    private LocalDate initialTrainingDate;

    private LocalDate ojtDate;

    private String trainingDescription;

    private String trainingProvider;

    private LocalDate trainingDate;

    // =====================================================
    // CERTIFICATION DETAILS
    // =====================================================

    private String certification;

    private LocalDate certificateDate;

    private String certificateFileName;

    private String certificateContentType;

    @Lob
    @Column(columnDefinition = "varbinary(max)")
    private byte[] certificateData;

    // =====================================================
    // TRANSIENT FIELDS (FOR REPORT & ASSESSMENT VIEWS)
    // =====================================================

    @Transient
    private String assessmentStatus;

    @Transient
    private String comment;

    // =====================================================
    // CONSTRUCTORS
    // =====================================================

    public PelTrainingRecord() {
    }

    // =====================================================
    // GETTERS AND SETTERS
    // =====================================================

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public LocalDate getJoiningDate() {
        return joiningDate;
    }

    public void setJoiningDate(LocalDate joiningDate) {
        this.joiningDate = joiningDate;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName;
    }

    public String getTrainingType() {
        return trainingType;
    }

    public void setTrainingType(String trainingType) {
        this.trainingType = trainingType;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public LocalDate getInitialTrainingDate() {
        return initialTrainingDate;
    }

    public void setInitialTrainingDate(LocalDate initialTrainingDate) {
        this.initialTrainingDate = initialTrainingDate;
    }

    public LocalDate getOjtDate() {
        return ojtDate;
    }

    public void setOjtDate(LocalDate ojtDate) {
        this.ojtDate = ojtDate;
    }

    public String getTrainingDescription() {
        return trainingDescription;
    }

    public void setTrainingDescription(String trainingDescription) {
        this.trainingDescription = trainingDescription;
    }

    public String getTrainingProvider() {
        return trainingProvider;
    }

    public void setTrainingProvider(String trainingProvider) {
        this.trainingProvider = trainingProvider;
    }

    public LocalDate getTrainingDate() {
        return trainingDate;
    }

    public void setTrainingDate(LocalDate trainingDate) {
        this.trainingDate = trainingDate;
    }

    public String getCertification() {
        return certification;
    }

    public void setCertification(String certification) {
        this.certification = certification;
    }

    public LocalDate getCertificateDate() {
        return certificateDate;
    }

    public void setCertificateDate(LocalDate certificateDate) {
        this.certificateDate = certificateDate;
    }

    public String getCertificateFileName() {
        return certificateFileName;
    }

    public void setCertificateFileName(String certificateFileName) {
        this.certificateFileName = certificateFileName;
    }

    public String getCertificateContentType() {
        return certificateContentType;
    }

    public void setCertificateContentType(String certificateContentType) {
        this.certificateContentType = certificateContentType;
    }

    public byte[] getCertificateData() {
        return certificateData;
    }

    public void setCertificateData(byte[] certificateData) {
        this.certificateData = certificateData;
    }

    public String getAssessmentStatus() {
        return assessmentStatus;
    }

    public void setAssessmentStatus(String assessmentStatus) {
        this.assessmentStatus = assessmentStatus;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}