package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.HerbResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.HerbService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/herbs")
public class HerbController {

    private final HerbService herbService;

    public HerbController(HerbService herbService) {
        this.herbService = herbService;
    }

    @GetMapping("/")
    public R<List<HerbResponse>> listHerbs(
            @RequestParam(required = false) String category,
            @RequestParam(defaultValue = "0") int skip,
            @RequestParam(defaultValue = "100") int limit) {
        return R.success(herbService.listHerbs(category, skip, limit));
    }

    @GetMapping("/{id}")
    public R<HerbResponse> getHerb(@PathVariable Long id) {
        try {
            return R.success(herbService.getHerb(id));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @GetMapping("/search/")
    public R<List<HerbResponse>> searchHerbs(@RequestParam String q) {
        return R.success(herbService.searchHerbs(q));
    }
}
