package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.StatisticsService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/statistics")
public class StatisticsController {

    private final StatisticsService statisticsService;

    public StatisticsController(StatisticsService statisticsService) {
        this.statisticsService = statisticsService;
    }

    @GetMapping("/summary")
    public R<Map<String, Object>> summary() {
        return R.success(statisticsService.getSummary());
    }

    @GetMapping("/visit-count")
    public R<List<Map<String, Object>>> visitCount() {
        return R.success(statisticsService.getVisitCountByMonth());
    }

    @GetMapping("/syndrome-distribution")
    public R<List<Map<String, Object>>> syndromeDistribution() {
        return R.success(statisticsService.getSyndromeDistribution());
    }

    @GetMapping("/herb-ranking")
    public R<List<Map<String, Object>>> herbRanking() {
        return R.success(statisticsService.getHerbRanking());
    }

    @GetMapping("/treatment-results")
    public R<List<Map<String, Object>>> treatmentResults() {
        return R.success(statisticsService.getTreatmentResults());
    }
}
