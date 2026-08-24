package com.gpf.gpfcalculator.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendVerificationEmail(String email, String otp) {

        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo(email);

        message.setSubject("GPF Management System - Email Verification");

        message.setText(
                "Dear User,\n\n"
                        + "Welcome to GPF Management System.\n\n"
                        + "Your Email Verification OTP is: " + otp
                        + "\n\nThis OTP is valid for 5 minutes."
                        + "\n\nPlease do not share this OTP with anyone."
                        + "\n\nThank You."
        );

        mailSender.send(message);
    }
}