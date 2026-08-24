package com.gpf.gpfcalculator.repository;

import com.gpf.gpfcalculator.model.PelFolder;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PelFolderRepository
        extends JpaRepository<PelFolder, Long> {

    // ==========================================
    // GET ROOT FOLDERS
    // ==========================================

    List<PelFolder> findByParentIsNull();


    // ==========================================
    // GET SUB-FOLDERS
    // ==========================================

    List<PelFolder> findByParentId(Long parentId);


    // ==========================================
    // CHECK DUPLICATE ROOT FOLDER
    // ==========================================

    boolean existsByNameIgnoreCaseAndParentIsNull(
            String name
    );


    // ==========================================
    // CHECK DUPLICATE SUB-FOLDER
    // ==========================================

    boolean existsByNameIgnoreCaseAndParent(
            String name,
            PelFolder parent
    );


    // ==========================================
    // CHECK DUPLICATE FOLDER NAME
    // ==========================================

    boolean existsByNameIgnoreCase(
            String name
    );

}