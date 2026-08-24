package com.gpf.gpfcalculator.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "Employee")
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer employeeId;

    @Column(nullable = false, unique = true, length = 50)
    private String employeeCode;

    @Column(nullable = false, length = 150)
    private String employeeName;

    @Column(length = 150)
    private String fatherName;

    @Column(length = 150)
    private String motherName;

    @Column(length = 30)
    private String nid;

    @Column(length = 100)
    private String designation;

    @Column(length = 100)
    private String department;

    private LocalDate joiningDate;

    @Column(precision = 18, scale = 2)
    private BigDecimal basicSalary;

    @Column(precision = 18, scale = 2)
    private BigDecimal openingBalance;

    @Column(length = 20)
    private String mobile;

    @Column(length = 100)
    private String email;

    @Column(length = 20)
    private String status;

    private LocalDateTime createdDate;

    //==============================
    // Constructors
    //==============================

    public Employee() {
    }

    //==============================
    // Getters and Setters
    //==============================

    public Integer getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }

    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getFatherName() {
        return fatherName;
    }

    public void setFatherName(String fatherName) {
        this.fatherName = fatherName;
    }

    public String getMotherName() {
        return motherName;
    }

    public void setMotherName(String motherName) {
        this.motherName = motherName;
    }

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public LocalDate getJoiningDate() {
        return joiningDate;
    }

    public void setJoiningDate(LocalDate joiningDate) {
        this.joiningDate = joiningDate;
    }

    public BigDecimal getBasicSalary() {
        return basicSalary;
    }

    public void setBasicSalary(BigDecimal basicSalary) {
        this.basicSalary = basicSalary;
    }

    public BigDecimal getOpeningBalance() {
        return openingBalance;
    }

    public void setOpeningBalance(BigDecimal openingBalance) {
        this.openingBalance = openingBalance;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    //==============================
    // Automatically Set Default Values
    //==============================

    @PrePersist
    public void prePersist() {

        if (status == null) {
            status = "Active";
        }

        if (openingBalance == null) {
            openingBalance = BigDecimal.ZERO;
        }

        if (createdDate == null) {
            createdDate = LocalDateTime.now();
        }
    }

}