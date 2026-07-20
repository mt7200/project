package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.HerbResponse;

import java.util.List;

public interface HerbService {
    List<HerbResponse> listHerbs(String category, int skip, int limit);
    HerbResponse getHerb(Long id);
    List<HerbResponse> searchHerbs(String keyword);
}
