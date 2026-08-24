package com.gpf.gpfcalculator.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "email_otp")
public class EmailOtp {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String email;

    private String otp;

    @Column(name = "expiry_time")
    private LocalDateTime expiryTime;

    private Boolean verified;

}