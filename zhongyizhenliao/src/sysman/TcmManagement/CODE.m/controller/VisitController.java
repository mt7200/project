package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.VisitCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.VisitResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.VisitService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/visits")
public class VisitController {

    private final VisitService visitService;

    public VisitController(VisitService visitService) {
        this.visitService = visitService;
    }

    @GetMapping("/")
    public R<List<VisitResponse>> listVisits(
            @RequestParam(required = false) Long patientId,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "0") int skip,
            @RequestParam(defaultValue = "50") int limit) {
        return R.success(visitService.listVisits(patientId, status, skip, limit));
    }

    @GetMapping("/{id}")
    public R<VisitResponse> getVisit(@PathVariable Long id) {
        try {
            return R.success(visitService.getVisit(id));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @PostMapping("/")
    public R<VisitResponse> createVisit(@RequestBody VisitCreateRequest request) {
        return R.success(visitService.createVisit(request));
    }

    @PutMapping("/{id}")
    public R<VisitResponse> updateVisit(@PathVariable Long id, @RequestBody VisitCreateRequest request) {
        try {
            return R.success(visitService.updateVisit(id, request));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @DeleteMapping("/{id}")
    public R<Map<String, String>> deleteVisit(@PathVariable Long id) {
        try {
            visitService.deleteVisit(id);
            return R.success(Map.of("message", "已删除"));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }
}
