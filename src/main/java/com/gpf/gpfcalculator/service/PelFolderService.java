
package com.gpf.gpfcalculator.service;

import com.gpf.gpfcalculator.model.PelFolder;
import com.gpf.gpfcalculator.repository.PelFolderRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PelFolderService {

    private final PelFolderRepository folderRepository;


    public PelFolderService(
            PelFolderRepository folderRepository) {

        this.folderRepository = folderRepository;
    }


    // ==========================================
    // GET ALL FOLDERS
    // ==========================================

    public List<PelFolder> getAllFolders() {

        return folderRepository.findAll();
    }


    // ==========================================
    // GET FOLDER BY ID
    // ==========================================

    public Optional<PelFolder> getFolderById(Long id) {

        return folderRepository.findById(id);
    }


    // ==========================================
    // CHECK DUPLICATE NAME
    // ==========================================

    public boolean existsByName(String name) {

        return folderRepository
                .existsByNameIgnoreCase(name);
    }


    // ==========================================
    // CREATE FOLDER
    // ==========================================

    public PelFolder createFolder(String name) {

        PelFolder folder = new PelFolder();

        folder.setName(name);

        return folderRepository.save(folder);
    }


    // ==========================================
    // RENAME FOLDER
    // ==========================================

    public PelFolder renameFolder(
            Long id,
            String name) {

        PelFolder folder =
                folderRepository.findById(id)
                        .orElseThrow(
                                () -> new RuntimeException(
                                        "Folder not found"
                                )
                        );

        folder.setName(name);

        return folderRepository.save(folder);
    }


    // ==========================================
    // DELETE FOLDER
    // ==========================================

    public void deleteFolder(Long id) {

        if (!folderRepository.existsById(id)) {

            throw new RuntimeException(
                    "Folder not found"
            );
        }

        folderRepository.deleteById(id);
    }


    // ==========================================
    // CHECK FOLDER EXISTS
    // ==========================================

    public boolean existsById(Long id) {

        return folderRepository.existsById(id);
    }
}

