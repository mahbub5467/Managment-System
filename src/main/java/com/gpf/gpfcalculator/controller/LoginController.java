package com.gpf.gpfcalculator.controller;

import com.gpf.gpfcalculator.model.User;
import com.gpf.gpfcalculator.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    // ==========================
    // Home Page
    // ==========================
    @GetMapping("/")
    public String home() {
        return "login";
    }

    // ==========================
    // Login Page
    // ==========================
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    // ==========================
    // Login Process
    // ==========================
    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {

        User user = userService.authenticate(username, password);

        if (user == null) {
            model.addAttribute("error", "Invalid Username or Password");
            return "login";
        }

        if (!Boolean.TRUE.equals(user.getEmailVerified())) {
            model.addAttribute("error", "Please verify your email first.");
            return "login";
        }

        session.setAttribute("loggedUser", user);

        return "redirect:/index";
    }

    // ==========================
    // Dashboard
    // ==========================
    @GetMapping("/index")
    public String dashboard(HttpSession session) {

        if (session.getAttribute("loggedUser") == null) {
            return "redirect:/login";
        }

        return "index";
    }

    // ==========================
    // Logout
    // ==========================
    @GetMapping("/logout")
    public String logout(HttpSession session) {

        session.invalidate();

        return "redirect:/login";
    }
}