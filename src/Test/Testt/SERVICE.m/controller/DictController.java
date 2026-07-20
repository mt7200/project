package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.SymptomDictResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.SyndromePatternResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.DictService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX)
public class DictController {

    private final DictService dictService;

    public DictController(DictService dictService) {
        this.dictService = dictService;
    }

    // ===== 证型字典 =====
    @GetMapping("/syndrome-patterns/")
    public R<List<SyndromePatternResponse>> listSyndromePatterns(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "0") int skip,
            @RequestParam(defaultValue = "100") int limit) {
        return R.success(dictService.listSyndromePatterns(category, keyword, skip, limit));
    }

    @GetMapping("/syndrome-patterns/{id}")
    public R<SyndromePatternResponse> getSyndromePattern(@PathVariable Long id) {
        try {
            return R.success(dictService.getSyndromePattern(id));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    // ===== 症状字典 =====
    @GetMapping("/symptom-dict/")
    public R<List<SymptomDictResponse>> listSymptoms(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) Boolean isCommon,
            @RequestParam(defaultValue = "0") int skip,
            @RequestParam(defaultValue = "200") int limit) {
        return R.success(dictService.listSymptoms(category, isCommon, skip, limit));
    }

    @GetMapping("/symptom-dict/categories")
    public R<List<String>> listCategories() {
        return R.success(dictService.listSymptomCategories());
    }

    @GetMapping("/symptom-dict/sections")
    public R<List<String>> listSections() {
        return R.success(dictService.listSymptomSections());
    }
}
