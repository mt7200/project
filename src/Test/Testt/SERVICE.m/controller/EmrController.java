package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.EmrCreateRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.EmrResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.EmrService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/emrs")
public class EmrController {

    private final EmrService emrService;

    public EmrController(EmrService emrService) {
        this.emrService = emrService;
    }

    @GetMapping("/")
    public R<List<EmrResponse>> listEmrs(
            @RequestParam(required = false) Long patientId,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "0") int skip,
            @RequestParam(defaultValue = "50") int limit) {
        return R.success(emrService.listEmrs(patientId, status, skip, limit));
    }

    @GetMapping("/{id}")
    public R<EmrResponse> getEmr(@PathVariable Long id) {
        try {
            return R.success(emrService.getEmr(id));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @PostMapping("/")
    public R<EmrResponse> createEmr(@RequestBody EmrCreateRequest request) {
        return R.success(emrService.createEmr(request));
    }

    @PutMapping("/{id}")
    public R<EmrResponse> updateEmr(@PathVariable Long id, @RequestBody EmrCreateRequest request) {
        try {
            return R.success(emrService.updateEmr(id, request));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @DeleteMapping("/{id}")
    public R<Map<String, String>> deleteEmr(@PathVariable Long id) {
        try {
            emrService.deleteEmr(id);
            return R.success(Map.of("message", "已删除"));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @GetMapping("/{id}/history")
    public R<List<EmrResponse>> getHistoryRecords(@PathVariable Long id) {
        try {
            return R.success(emrService.getHistoryRecords(id));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }
}
