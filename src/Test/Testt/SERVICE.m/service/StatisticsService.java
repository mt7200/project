package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import java.util.List;
import java.util.Map;

public interface StatisticsService {
    Map<String, Object> getSummary();
    List<Map<String, Object>> getVisitCountByMonth();
    List<Map<String, Object>> getSyndromeDistribution();
    List<Map<String, Object>> getHerbRanking();
    List<Map<String, Object>> getTreatmentResults();
}
