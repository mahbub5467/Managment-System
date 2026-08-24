package com.gpf.gpfcalculator.dto;

import lombok.Data;

@Data
public class SignupRequest {

    private String fullName;

    private String username;

    private String email;

    private String password;

    private String confirmPassword;

}