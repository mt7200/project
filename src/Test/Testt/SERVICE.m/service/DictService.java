package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.SymptomDictResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.SyndromePatternResponse;

import java.util.List;

public interface DictService {
    List<SyndromePatternResponse> listSyndromePatterns(String category, String keyword, int skip, int limit);
    SyndromePatternResponse getSyndromePattern(Long id);
    List<SymptomDictResponse> listSymptoms(String category, Boolean isCommon, int skip, int limit);
    List<String> listSymptomCategories();
    List<String> listSymptomSections();
}
