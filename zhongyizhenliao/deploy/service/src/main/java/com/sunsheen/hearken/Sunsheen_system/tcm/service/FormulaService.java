package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.FormulaResponse;

import java.util.List;

public interface FormulaService {
    List<FormulaResponse> listFormulas(String category, int skip, int limit);
    FormulaResponse getFormula(Long id);
    List<FormulaResponse> searchFormulas(String keyword);
}
