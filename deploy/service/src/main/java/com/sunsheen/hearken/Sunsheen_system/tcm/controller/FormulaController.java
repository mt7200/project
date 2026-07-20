package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.FormulaResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.FormulaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/formulas")
public class FormulaController {

    private final FormulaService formulaService;

    public FormulaController(FormulaService formulaService) {
        this.formulaService = formulaService;
    }

    @GetMapping("/")
    public R<List<FormulaResponse>> listFormulas(
            @RequestParam(required = false) String category,
            @RequestParam(defaultValue = "0") int skip,
            @RequestParam(defaultValue = "100") int limit) {
        return R.success(formulaService.listFormulas(category, skip, limit));
    }

    @GetMapping("/{id}")
    public R<FormulaResponse> getFormula(@PathVariable Long id) {
        try {
            return R.success(formulaService.getFormula(id));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @GetMapping("/search/")
    public R<List<FormulaResponse>> searchFormulas(@RequestParam String q) {
        return R.success(formulaService.searchFormulas(q));
    }
}
