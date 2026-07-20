package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Visit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VisitRepository extends JpaRepository<Visit, Long> {
    List<Visit> findByPatientIdOrderByVisitDateDesc(Long patientId);
    List<Visit> findByStatusOrderByVisitDateDesc(String status);

    @Query(value = "SELECT DATE_FORMAT(visit_date, '%Y-%m') AS month, COUNT(*) AS cnt FROM visit_record GROUP BY month ORDER BY month DESC LIMIT 6", nativeQuery = true)
    List<Object[]> countByMonth();
}
