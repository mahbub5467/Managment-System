package com.gpf.gpfcalculator.service;

import com.gpf.gpfcalculator.model.Employee;
import com.gpf.gpfcalculator.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeeService {

    @Autowired
    private EmployeeRepository employeeRepository;

    // Save Employee
    public Employee saveEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }

    // Get All Employees
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    // Get Employee By ID
    public Employee getEmployeeById(Integer id) {
        Optional<Employee> employee = employeeRepository.findById(id);
        return employee.orElse(null);
    }

    // Update Employee
    public Employee updateEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }

    // Delete Employee
    public void deleteEmployee(Integer id) {
        employeeRepository.deleteById(id);
    }

    // Check Employee Code Exists
    public boolean existsByEmployeeCode(String employeeCode) {
        return employeeRepository.existsByEmployeeCode(employeeCode);
    }

    // Find by Employee Code
    public Employee findByEmployeeCode(String employeeCode) {
        return employeeRepository.findByEmployeeCode(employeeCode).orElse(null);
    }

}