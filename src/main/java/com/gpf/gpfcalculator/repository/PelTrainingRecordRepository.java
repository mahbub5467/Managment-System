package com.gpf.gpfcalculator.repository;

import com.gpf.gpfcalculator.model.PelTrainingRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PelTrainingRecordRepository
        extends JpaRepository<PelTrainingRecord, Long> {

    List<PelTrainingRecord> findByEmployeeId(String employeeId);
}