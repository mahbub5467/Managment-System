package com.gpf.gpfcalculator.repository;

import com.gpf.gpfcalculator.model.PelFile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PelFileRepository
        extends JpaRepository<PelFile, Long> {

    List<PelFile> findByFolderId(Long folderId);

}