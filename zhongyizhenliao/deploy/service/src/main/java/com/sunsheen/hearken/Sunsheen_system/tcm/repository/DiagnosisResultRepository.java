package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.DiagnosisResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiagnosisResultRepository extends JpaRepository<DiagnosisResult, Long> {
    List<DiagnosisResult> findByVisitId(Long visitId);

    @Query(value = "SELECT pattern_name AS name, COUNT(*) AS cnt FROM diagnosis_result WHERE pattern_name IS NOT NULL AND pattern_name != '' GROUP BY pattern_name ORDER BY cnt DESC LIMIT 10", nativeQuery = true)
    List<Object[]> countByPatternName();
}
