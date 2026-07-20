package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.PrescriptionItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PrescriptionItemRepository extends JpaRepository<PrescriptionItem, Long> {
    List<PrescriptionItem> findByPrescriptionIdOrderById(Long prescriptionId);

    @Query(value = "SELECT herb_name AS name, COUNT(*) AS cnt FROM prescription_item GROUP BY herb_name ORDER BY cnt DESC LIMIT 20", nativeQuery = true)
    List<Object[]> countByHerbName();
}
