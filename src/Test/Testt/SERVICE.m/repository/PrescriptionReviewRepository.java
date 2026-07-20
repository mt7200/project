package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.PrescriptionReview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PrescriptionReviewRepository extends JpaRepository<PrescriptionReview, Long> {
    List<PrescriptionReview> findByPrescriptionIdOrderByCreatedAtDesc(Long prescriptionId);
}
