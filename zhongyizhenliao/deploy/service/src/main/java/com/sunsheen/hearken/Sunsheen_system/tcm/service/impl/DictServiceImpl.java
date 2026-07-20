package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.SymptomDictResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.SyndromePatternResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.SymptomDict;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.SyndromePattern;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.SymptomDictRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.SyndromePatternRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.DictService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DictServiceImpl implements DictService {

    private final SyndromePatternRepository syndromePatternRepository;
    private final SymptomDictRepository symptomDictRepository;

    public DictServiceImpl(SyndromePatternRepository syndromePatternRepository,
                           SymptomDictRepository symptomDictRepository) {
        this.syndromePatternRepository = syndromePatternRepository;
        this.symptomDictRepository = symptomDictRepository;
    }

    @Override
    public List<SyndromePatternResponse> listSyndromePatterns(String category, String keyword, int skip, int limit) {
        List<SyndromePattern> patterns;
        if (category != null && !category.isEmpty()) {
            patterns = syndromePatternRepository.findByCategoryOrderBySortOrder(category);
        } else {
            patterns = syndromePatternRepository.findAllByOrderBySortOrder();
        }
        if (keyword != null && !keyword.isEmpty()) {
            String kw = keyword.toLowerCase();
            patterns = patterns.stream()
                    .filter(p -> (p.getPatternName() != null && p.getPatternName().toLowerCase().contains(kw))
                            || (p.getEtiology() != null && p.getEtiology().toLowerCase().contains(kw))
                            || (p.getKeySymptoms() != null && p.getKeySymptoms().toLowerCase().contains(kw))
                            || (p.getTreatmentMethod() != null && p.getTreatmentMethod().toLowerCase().contains(kw)))
                    .toList();
        }
        return patterns.stream().skip(skip).limit(limit).map(this::toSyndromeResponse).toList();
    }

    @Override
    public SyndromePatternResponse getSyndromePattern(Long id) {
        SyndromePattern pattern = syndromePatternRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("证型不存在"));
        return toSyndromeResponse(pattern);
    }

    @Override
    public List<SymptomDictResponse> listSymptoms(String category, Boolean isCommon, int skip, int limit) {
        List<SymptomDict> symptoms;
        if (category != null && !category.isEmpty()) {
            symptoms = symptomDictRepository.findByCategoryOrderBySortOrder(category);
        } else if (isCommon != null) {
            symptoms = symptomDictRepository.findByIsCommonOrderBySortOrder(isCommon ? 1 : 0);
        } else {
            symptoms = symptomDictRepository.findAllByOrderBySortOrder();
        }
        return symptoms.stream().skip(skip).limit(limit).map(this::toSymptomResponse).toList();
    }

    @Override
    public List<String> listSymptomCategories() {
        return symptomDictRepository.findDistinctCategories();
    }

    @Override
    public List<String> listSymptomSections() {
        return symptomDictRepository.findDistinctSubCategories();
    }

    private SyndromePatternResponse toSyndromeResponse(SyndromePattern p) {
        SyndromePatternResponse r = new SyndromePatternResponse();
        r.setId(p.getId());
        r.setPatternName(p.getPatternName());
        r.setPatternCode(p.getPatternCode());
        r.setCategory(p.getCategory());
        r.setEtiology(p.getEtiology());
        r.setPathogenesis(p.getPathogenesis());
        r.setKeySymptoms(p.getKeySymptoms());
        r.setPulsePattern(p.getPulsePattern());
        r.setTonguePattern(p.getTonguePattern());
        r.setDifferentiation(p.getDifferentiation());
        r.setTreatmentMethod(p.getTreatmentMethod());
        r.setRecommendedFormula(p.getRecommendedFormula());
        r.setRelatedDiagnosis(p.getRelatedDiagnosis());
        r.setSortOrder(p.getSortOrder());
        r.setCreatedAt(p.getCreatedAt());
        r.setUpdatedAt(p.getUpdatedAt());
        return r;
    }

    private SymptomDictResponse toSymptomResponse(SymptomDict s) {
        SymptomDictResponse r = new SymptomDictResponse();
        r.setId(s.getId());
        r.setCategory(s.getCategory());
        r.setSubCategory(s.getSubCategory());
        r.setLabel(s.getLabel());
        r.setSortOrder(s.getSortOrder());
        r.setIsCommon(s.getIsCommon());
        r.setWeight(s.getWeight());
        r.setCreatedAt(s.getCreatedAt());
        return r;
    }
}
