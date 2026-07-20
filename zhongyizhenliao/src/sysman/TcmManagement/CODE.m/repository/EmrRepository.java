package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Emr;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmrRepository extends JpaRepository<Emr, Long> {
    List<Emr> findByPatientIdOrderByVisitDateDesc(Long patientId);
    List<Emr> findByStatusOrderByVisitDateDesc(String status);

    @Query("SELECT COUNT(e) FROM Emr e")
    long countTotal();

    @Query("SELECT COUNT(e) FROM Emr e WHERE e.treatmentResult IN ('effective', 'cured', 'improved', '显效', '痊愈', '好转')")
    long countEffective();

    @Query("SELECT e.treatmentResult, COUNT(e) FROM Emr e WHERE e.treatmentResult IS NOT NULL AND e.treatmentResult <> '' GROUP BY e.treatmentResult ORDER BY COUNT(e) DESC")
    List<Object[]> countByTreatmentResult();
}
