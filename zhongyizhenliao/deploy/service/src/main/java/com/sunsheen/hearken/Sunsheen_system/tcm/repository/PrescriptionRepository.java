package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Prescription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {
    List<Prescription> findByStatusOrderByCreatedAtDesc(String status);
    List<Prescription> findByStatusInOrderByCreatedAtDesc(Collection<String> statuses);
    List<Prescription> findByPatientIdOrderByCreatedAtDesc(Long patientId);
    List<Prescription> findAllByOrderByCreatedAtDesc();

    @Query("SELECT COUNT(p) FROM Prescription p WHERE p.prescriptionNo LIKE ?1")
    long countByPrescriptionNoLike(String prefix);
}
