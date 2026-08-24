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
    // EMPLOYEE
    // =====================================================

    @Column(nullable = false)
    private String employeeId;

    @Column(nullable = false)
    private String employeeName;

    @Column(nullable = false)
    private String designation;

    @Column(nullable = false)
    private LocalDate joiningDate;


    // =====================================================
    // TRAINING
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
    // CERTIFICATION
    // =====================================================

    private String certification;

    private LocalDate certificateDate;

    private String certificateFileName;

    private String certificateContentType;


    @Lob
    @Column(columnDefinition = "varbinary(max)")
    private byte[] certificateData;


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
    // DESIGNATION
    // =====================================================

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }


    // =====================================================
    // JOINING DATE
    // =====================================================

    public LocalDate getJoiningDate() {
        return joiningDate;
    }

    public void setJoiningDate(LocalDate joiningDate) {
        this.joiningDate = joiningDate;
    }


    // =====================================================
    // TRAINING TYPE
    // =====================================================

    public String getTrainingType() {
        return trainingType;
    }

    public void setTrainingType(String trainingType) {
        this.trainingType = trainingType;
    }


    // =====================================================
    // COURSE TITLE
    // =====================================================

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }


    // =====================================================
    // INITIAL TRAINING DATE
    // =====================================================

    public LocalDate getInitialTrainingDate() {
        return initialTrainingDate;
    }

    public void setInitialTrainingDate(
            LocalDate initialTrainingDate) {

        this.initialTrainingDate =
                initialTrainingDate;
    }


    // =====================================================
    // OJT DATE
    // =====================================================

    public LocalDate getOjtDate() {
        return ojtDate;
    }

    public void setOjtDate(LocalDate ojtDate) {
        this.ojtDate = ojtDate;
    }


    // =====================================================
    // TRAINING DESCRIPTION
    // =====================================================

    public String getTrainingDescription() {
        return trainingDescription;
    }

    public void setTrainingDescription(
            String trainingDescription) {

        this.trainingDescription =
                trainingDescription;
    }


    // =====================================================
    // TRAINING PROVIDER
    // =====================================================

    public String getTrainingProvider() {
        return trainingProvider;
    }

    public void setTrainingProvider(
            String trainingProvider) {

        this.trainingProvider =
                trainingProvider;
    }


    // =====================================================
    // TRAINING DATE
    // =====================================================

    public LocalDate getTrainingDate() {
        return trainingDate;
    }

    public void setTrainingDate(LocalDate trainingDate) {
        this.trainingDate = trainingDate;
    }


    // =====================================================
    // CERTIFICATION
    // =====================================================

    public String getCertification() {
        return certification;
    }

    public void setCertification(String certification) {
        this.certification = certification;
    }


    // =====================================================
    // CERTIFICATE DATE
    // =====================================================

    public LocalDate getCertificateDate() {
        return certificateDate;
    }

    public void setCertificateDate(
            LocalDate certificateDate) {

        this.certificateDate =
                certificateDate;
    }


    // =====================================================
    // CERTIFICATE FILE NAME
    // =====================================================

    public String getCertificateFileName() {
        return certificateFileName;
    }

    public void setCertificateFileName(
            String certificateFileName) {

        this.certificateFileName =
                certificateFileName;
    }


    // =====================================================
    // CERTIFICATE CONTENT TYPE
    // =====================================================

    public String getCertificateContentType() {
        return certificateContentType;
    }

    public void setCertificateContentType(
            String certificateContentType) {

        this.certificateContentType =
                certificateContentType;
    }


    // =====================================================
    // CERTIFICATE DATA
    // =====================================================

    public byte[] getCertificateData() {
        return certificateData;
    }

    public void setCertificateData(
            byte[] certificateData) {

        this.certificateData =
                certificateData;
    }

}