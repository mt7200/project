package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.FormulaResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Formula;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.FormulaHerb;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.FormulaHerbRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.FormulaRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.FormulaService;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FormulaServiceImpl implements FormulaService {

    private final FormulaRepository formulaRepository;
    private final FormulaHerbRepository formulaHerbRepository;

    public FormulaServiceImpl(FormulaRepository formulaRepository, FormulaHerbRepository formulaHerbRepository) {
        this.formulaRepository = formulaRepository;
        this.formulaHerbRepository = formulaHerbRepository;
    }

    @Override
    public List<FormulaResponse> listFormulas(String category, int skip, int limit) {
        List<Formula> formulas;
        if (category != null && !category.isEmpty()) {
            formulas = formulaRepository.findByCategoryL1OrCategoryL2(category, category);
        } else {
            formulas = formulaRepository.findAll(PageRequest.of(skip / limit, limit)).toList();
        }
        return formulas.stream().map(this::toResponse).toList();
    }

    @Override
    public FormulaResponse getFormula(Long id) {
        Formula formula = formulaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("方剂不存在"));
        return toResponse(formula);
    }

    @Override
    public List<FormulaResponse> searchFormulas(String keyword) {
        return formulaRepository.findByNameContaining(keyword).stream()
                .map(this::toResponse).toList();
    }

    private FormulaResponse toResponse(Formula formula) {
        FormulaResponse r = new FormulaResponse();
        r.setId(formula.getId());
        r.setName(formula.getName());
        r.setCategoryL1(formula.getCategoryL1());
        r.setCategoryL2(formula.getCategoryL2());
        r.setFunctions(formula.getFunctions());
        r.setIndications(formula.getIndications());
        r.setModifications(formula.getModifications());
        r.setSource(formula.getSource());
        List<String> herbNames = formulaHerbRepository.findByFormulaIdOrderById(formula.getId())
                .stream().map(FormulaHerb::getHerbId).map(String::valueOf).toList();
        r.setHerbs(herbNames);
        return r;
    }
}
