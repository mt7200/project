package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.FormulaHerb;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FormulaHerbRepository extends JpaRepository<FormulaHerb, Long> {
    List<FormulaHerb> findByFormulaIdOrderById(Long formulaId);
}
