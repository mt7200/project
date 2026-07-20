package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Herb;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HerbRepository extends JpaRepository<Herb, Long> {
    List<Herb> findByCategory(String category);
    List<Herb> findByNameContaining(String name);
}
