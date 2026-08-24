
package com.gpf.gpfcalculator.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(
        name = "pel_folders",
        uniqueConstraints = {
                @UniqueConstraint(
                        columnNames = {"name", "parent_id"}
                )
        }
)
public class PelFolder {

    // ==========================================
    // PRIMARY KEY
    // ==========================================

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    // ==========================================
    // FOLDER NAME
    // ==========================================

    @Column(
            nullable = false,
            length = 120
    )
    private String name;


    // ==========================================
    // PARENT FOLDER
    // ==========================================

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private PelFolder parent;


    // ==========================================
    // CREATED DATE
    // ==========================================

    @Column(
            nullable = false,
            updatable = false
    )
    private LocalDateTime createdAt = LocalDateTime.now();


    // ==========================================
    // GETTERS & SETTERS
    // ==========================================

    public Long getId() {

        return id;
    }


    public void setId(Long id) {

        this.id = id;
    }


    public String getName() {

        return name;
    }


    public void setName(String name) {

        this.name = name;
    }


    public PelFolder getParent() {

        return parent;
    }


    public void setParent(PelFolder parent) {

        this.parent = parent;
    }


    public LocalDateTime getCreatedAt() {

        return createdAt;
    }


    public void setCreatedAt(
            LocalDateTime createdAt) {

        this.createdAt = createdAt;
    }
}

