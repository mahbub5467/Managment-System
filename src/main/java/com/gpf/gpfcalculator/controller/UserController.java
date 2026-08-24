package com.gpf.gpfcalculator.controller;

import com.gpf.gpfcalculator.dto.SignupRequest;
import com.gpf.gpfcalculator.model.User;
import com.gpf.gpfcalculator.service.OtpService;
import com.gpf.gpfcalculator.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private OtpService otpService;

    // ==========================
    // Login Page
    // ==========================

    // ==========================
    // Signup Page
    // ==========================
    @GetMapping("/signup")
    public String signup(Model model) {

        model.addAttribute("signupRequest", new SignupRequest());

        return "signup";
    }

    // ==========================
    // Signup Process
    // ==========================
    @PostMapping("/signup")
    public String signup(@ModelAttribute SignupRequest signupRequest,
                         HttpSession session,
                         Model model) {

        String result = userService.registerUser(signupRequest, session);

        if ("OTP_SENT".equals(result)) {

            model.addAttribute("email", signupRequest.getEmail());

            return "verify-otp";
        }

        model.addAttribute("error", result);

        return "signup";
    }

    // ==========================
    // Verify OTP Page
    // ==========================
    @GetMapping("/verify-otp")
    public String verifyOtpPage() {

        return "verify-otp";
    }

    // ==========================
    // Verify OTP Process
    // ==========================
    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam String email,
                            @RequestParam String otp,
                            HttpSession session,
                            Model model) {

        boolean verified = otpService.verifyOtp(email, otp);

        if (!verified) {

            model.addAttribute("email", email);
            model.addAttribute("error", "Invalid or Expired OTP");

            return "verify-otp";
        }

        SignupRequest signupRequest =
                (SignupRequest) session.getAttribute("signupUser");

        if (signupRequest == null) {

            model.addAttribute("error", "Session Expired. Please Signup Again.");

            return "signup";
        }

        // Save User
        userService.saveUser(signupRequest);

        // Remove Session
        session.removeAttribute("signupUser");

        model.addAttribute("success",
                "Registration Successful. Please Login.");

        return "login";
    }
}