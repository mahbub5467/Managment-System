package com.gpf.gpfcalculator.service;

import com.gpf.gpfcalculator.model.EmailOtp;
import com.gpf.gpfcalculator.repository.EmailOtpRepository;
import com.gpf.gpfcalculator.util.OtpUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class OtpService {

    @Autowired
    private EmailOtpRepository otpRepository;

    @Autowired
    private EmailService emailService;

    // ==========================
    // Generate OTP
    // ==========================
    public void generateAndSendOtp(String email) {

        String otp = OtpUtil.generateOtp();

        EmailOtp emailOtp = new EmailOtp();

        emailOtp.setEmail(email);
        emailOtp.setOtp(otp);
        emailOtp.setVerified(false);
        emailOtp.setExpiryTime(LocalDateTime.now().plusMinutes(5));

        otpRepository.save(emailOtp);

        emailService.sendVerificationEmail(email, otp);
    }

    // ==========================
    // Verify OTP
    // ==========================
    public boolean verifyOtp(String email, String otp) {

        Optional<EmailOtp> optionalOtp =
                otpRepository.findTopByEmailOrderByIdDesc(email);

        if (optionalOtp.isEmpty()) {
            return false;
        }

        EmailOtp emailOtp = optionalOtp.get();

        // OTP Match
        if (!emailOtp.getOtp().equals(otp)) {
            return false;
        }

        // Expiry Check
        if (emailOtp.getExpiryTime().isBefore(LocalDateTime.now())) {
            return false;
        }

        // Already Verified
        if (Boolean.TRUE.equals(emailOtp.getVerified())) {
            return false;
        }

        emailOtp.setVerified(true);

        otpRepository.save(emailOtp);

        return true;
    }

}