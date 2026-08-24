package com.gpf.gpfcalculator.repository;

import com.gpf.gpfcalculator.model.EmailOtp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EmailOtpRepository extends JpaRepository<EmailOtp, Integer> {

    Optional<EmailOtp> findTopByEmailOrderByIdDesc(String email);

}