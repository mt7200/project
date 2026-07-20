package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.SymptomDict;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SymptomDictRepository extends JpaRepository<SymptomDict, Long> {
    List<SymptomDict> findByCategoryOrderBySortOrder(String category);
    List<SymptomDict> findByIsCommonOrderBySortOrder(Integer isCommon);
    List<SymptomDict> findAllByOrderBySortOrder();

    @Query("SELECT DISTINCT s.category FROM SymptomDict s WHERE s.category IS NOT NULL")
    List<String> findDistinctCategories();

    @Query("SELECT DISTINCT s.subCategory FROM SymptomDict s WHERE s.subCategory IS NOT NULL")
    List<String> findDistinctSubCategories();
}
