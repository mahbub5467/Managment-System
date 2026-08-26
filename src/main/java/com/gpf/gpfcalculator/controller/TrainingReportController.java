package com.gpf.gpfcalculator.controller;

import com.gpf.gpfcalculator.model.PelTrainingRecord;
import com.gpf.gpfcalculator.model.SupervisorAssessment;
import com.gpf.gpfcalculator.repository.PelTrainingRecordRepository;
import com.gpf.gpfcalculator.repository.SupervisorAssessmentRepository;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class TrainingReportController {

    private final PelTrainingRecordRepository trainingRecordRepository;
    private final SupervisorAssessmentRepository assessmentRepository;

    public TrainingReportController(
            PelTrainingRecordRepository trainingRecordRepository,
            SupervisorAssessmentRepository assessmentRepository) {
        this.trainingRecordRepository = trainingRecordRepository;
        this.assessmentRepository = assessmentRepository;
    }

    // =========================================================
    // ১. REPORT MAIN PAGE VIEW (Search Action Triggered Only)
    // =========================================================
    @GetMapping("/training/training-records-report")
    public String showReport(
            @RequestParam(required = false) String employeeId,
            @RequestParam(required = false) String department,
            HttpServletRequest request,
            Model model) {

        List<PelTrainingRecord> records = new ArrayList<>();

        // 🎯 সার্চ বাটন প্রেস করা হয়েছে কিনা চেক (Query Params চেক করে)
        boolean isSearchSubmitted = request.getParameterMap().containsKey("employeeId") ||
                request.getParameterMap().containsKey("department");

        // ইউজার সার্চ বাটনে ক্লিক করলেই কেবল ডাটা লোড হবে
        if (isSearchSubmitted) {
            records = trainingRecordRepository.findAll();

            // ১. Employee ID (EIIN) দিয়ে ফিল্টার (ইনপুট থাকলে)
            if (employeeId != null && !employeeId.trim().isEmpty()) {
                String empQuery = employeeId.trim().toLowerCase();
                records = records.stream()
                        .filter(r -> r.getEmployeeId() != null && r.getEmployeeId().trim().toLowerCase().contains(empQuery))
                        .collect(Collectors.toList());
            }

            // ২. Division / Department ফিল্টার (ড্রপডাউন সিলেক্ট থাকলে)
            if (department != null && !department.trim().isEmpty()) {
                String deptQuery = department.trim().toLowerCase();
                String fullDeptName = getDepartmentFullName(deptQuery);

                records = records.stream()
                        .filter(r -> {
                            String depName = (r.getDepName() != null && !r.getDepName().trim().isEmpty())
                                    ? r.getDepName().trim().toLowerCase()
                                    : "pel";

                            return depName.equals(deptQuery) ||
                                    (!fullDeptName.isEmpty() && depName.equals(fullDeptName)) ||
                                    depName.contains(deptQuery);
                        })
                        .collect(Collectors.toList());
            }
        }

        long approvedCount = 0;
        long pendingCount = 0;

        if (records != null && !records.isEmpty()) {
            for (PelTrainingRecord record : records) {
                SupervisorAssessment assessment = assessmentRepository
                        .findByTrainingRecordId(record.getId())
                        .orElse(null);

                if (assessment != null) {
                    record.setAssessmentStatus(assessment.getAssessmentStatus());
                    record.setComment(assessment.getRemarks());

                    if ("APPROVED".equalsIgnoreCase(assessment.getAssessmentStatus()) ||
                            "SATISFACTORY".equalsIgnoreCase(assessment.getAssessmentStatus())) {
                        approvedCount++;
                    } else {
                        pendingCount++;
                    }
                } else {
                    record.setAssessmentStatus("PENDING");
                    pendingCount++;
                }
            }
        }

        // ইউনিক ইন্সপেক্টরদের সামারি মেপিং
        Map<String, Map<String, Object>> inspectorMap = new LinkedHashMap<>();

        if (records != null) {
            for (PelTrainingRecord record : records) {
                String empId = record.getEmployeeId();
                if (empId == null || empId.trim().isEmpty()) continue;

                if (!inspectorMap.containsKey(empId)) {
                    Map<String, Object> data = new HashMap<>();
                    data.put("employeeId", empId);
                    data.put("employeeName", record.getEmployeeName() != null ? record.getEmployeeName() : "N/A");
                    data.put("designation", record.getDesignation() != null ? record.getDesignation() : "N/A");
                    data.put("totalRecords", 1);
                    inspectorMap.put(empId, data);
                } else {
                    Map<String, Object> data = inspectorMap.get(empId);
                    data.put("totalRecords", (Integer) data.get("totalRecords") + 1);
                }
            }
        }

        model.addAttribute("records", records);
        model.addAttribute("inspectorList", inspectorMap.values());
        model.addAttribute("searchEmployeeId", employeeId);
        model.addAttribute("searchDepartment", department);
        model.addAttribute("isSearchSubmitted", isSearchSubmitted);
        model.addAttribute("totalRecords", records != null ? records.size() : 0);
        model.addAttribute("approvedCount", approvedCount);
        model.addAttribute("pendingCount", pendingCount);

        return "training-records-report";
    }

    // =========================================================
    // ২. INDIVIDUAL INSPECTOR REPORT PDF VIEW
    // URL Path: /training/training-records-report/pdf/{employeeId}
    // =========================================================
    @GetMapping("/training/training-records-report/pdf/{employeeId}")
    public String viewInspectorReportPdf(@PathVariable String employeeId, Model model) {

        List<PelTrainingRecord> records = trainingRecordRepository.findByEmployeeId(employeeId);

        if (records != null) {
            for (PelTrainingRecord record : records) {
                SupervisorAssessment assessment = assessmentRepository
                        .findByTrainingRecordId(record.getId())
                        .orElse(null);

                if (assessment != null) {
                    record.setAssessmentStatus(assessment.getAssessmentStatus());
                    record.setComment(assessment.getRemarks());
                } else {
                    record.setAssessmentStatus("PENDING");
                }
            }
        }

        model.addAttribute("records", records);
        model.addAttribute("employeeId", employeeId);
        model.addAttribute("isAllRecords", false);

        return "training-report-pdf";
    }

    // =========================================================
    // ৩. ALL INSPECTORS PDF REPORT VIEW (ALL DATA TOGETHER)
    // URL Path: /training/training-records-report/pdf/all
    // =========================================================
    @GetMapping("/training/training-records-report/pdf/all")
    public String viewAllInspectorsReportPdf(
            @RequestParam(required = false) String department,
            Model model) {

        List<PelTrainingRecord> records = trainingRecordRepository.findAll();

        // যদি নির্দিষ্ট Division ফিল্টার সিলেক্ট থাকে
        if (department != null && !department.trim().isEmpty()) {
            String deptQuery = department.trim().toLowerCase();
            String fullDeptName = getDepartmentFullName(deptQuery);

            records = records.stream()
                    .filter(r -> {
                        String depName = (r.getDepName() != null && !r.getDepName().trim().isEmpty())
                                ? r.getDepName().trim().toLowerCase() : "pel";
                        return depName.equals(deptQuery) ||
                                (!fullDeptName.isEmpty() && depName.equals(fullDeptName)) ||
                                depName.contains(deptQuery);
                    })
                    .collect(Collectors.toList());
        }

        if (records != null) {
            for (PelTrainingRecord record : records) {
                SupervisorAssessment assessment = assessmentRepository
                        .findByTrainingRecordId(record.getId())
                        .orElse(null);

                if (assessment != null) {
                    record.setAssessmentStatus(assessment.getAssessmentStatus());
                    record.setComment(assessment.getRemarks());
                } else {
                    record.setAssessmentStatus("PENDING");
                }
            }
        }

        model.addAttribute("records", records);
        model.addAttribute("isAllRecords", true);

        return "training-report-pdf";
    }

    // হেলপার মেথড: শর্টকোড বনাম পূর্ণাঙ্গ ডিপার্টমেন্ট নাম
    private String getDepartmentFullName(String code) {
        if (code == null) return "";
        switch (code.toUpperCase()) {
            case "PEL": return "personnel licensing";
            case "OPS": return "flight operations";
            case "AIR": return "airworthiness";
            case "ANS": return "air navigation services";
            case "AGA": return "aerodromes & ground aids";
            case "LEG": return "legal documents";
            case "ORG": return "organization";
            case "SSP": return "state safety programme";
            case "AIG": return "accident investigation";
            default: return "";
        }
    }
}