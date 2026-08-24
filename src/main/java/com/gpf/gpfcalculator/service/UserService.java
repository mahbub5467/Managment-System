package com.gpf.gpfcalculator.service;

import com.gpf.gpfcalculator.dto.SignupRequest;
import com.gpf.gpfcalculator.model.User;
import com.gpf.gpfcalculator.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OtpService otpService;

    // ==========================
    // Register User
    // ==========================
    public String registerUser(SignupRequest request, HttpSession session) {

        // Password Match
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            return "Password and Confirm Password do not match.";
        }

        // Username Check
        if (userRepository.existsByUsername(request.getUsername())) {
            return "Username already exists.";
        }

        // Email Check
        if (userRepository.existsByEmail(request.getEmail())) {
            return "Email already exists.";
        }

        // Save User Info in Session
        session.setAttribute("signupUser", request);

        // Send OTP
        otpService.generateAndSendOtp(request.getEmail());

        return "OTP_SENT";
    }

    // ==========================
    // Login Authentication
    // ==========================
    public User authenticate(String username, String password) {

        Optional<User> optionalUser;

        // Login by Email or Username
        if (username.contains("@")) {
            optionalUser = userRepository.findByEmail(username);
        } else {
            optionalUser = userRepository.findByUsername(username);
        }

        if (optionalUser.isEmpty()) {
            return null;
        }

        User user = optionalUser.get();

        // Password Check
        if (!user.getPassword().equals(password)) {
            return null;
        }

        // Email Verification Check
        if (user.getEmailVerified() == null || !user.getEmailVerified()) {
            return null;
        }

        return user;
    }

    // ==========================
    // Save User After OTP Verification
    // ==========================
    public void saveUser(SignupRequest request) {

        User user = new User();

        user.setFullName(request.getFullName());
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPassword(request.getPassword());

        user.setRole("USER");
        user.setStatus("ACTIVE");
        user.setEmailVerified(true);
        user.setCreatedAt(LocalDateTime.now());

        userRepository.save(user);
    }

}