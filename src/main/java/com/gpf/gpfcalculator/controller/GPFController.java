package com.gpf.gpfcalculator.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/gpf")
public class GPFController {

    @GetMapping("/calculator")
    public String calculator() {

        return "gpf-calculator";

    }

}