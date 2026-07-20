package com.sunsheen.hearken.Sunsheen_system.tcm.repository;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
}
