package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.HerbResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.Herb;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.HerbRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.HerbService;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HerbServiceImpl implements HerbService {

    private final HerbRepository herbRepository;

    public HerbServiceImpl(HerbRepository herbRepository) {
        this.herbRepository = herbRepository;
    }

    @Override
    public List<HerbResponse> listHerbs(String category, int skip, int limit) {
        List<Herb> herbs;
        if (category != null && !category.isEmpty()) {
            herbs = herbRepository.findByCategory(category);
        } else {
            herbs = herbRepository.findAll(PageRequest.of(skip / limit, limit)).toList();
        }
        return herbs.stream().map(this::toResponse).toList();
    }

    @Override
    public HerbResponse getHerb(Long id) {
        Herb herb = herbRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("药材不存在"));
        return toResponse(herb);
    }

    @Override
    public List<HerbResponse> searchHerbs(String keyword) {
        return herbRepository.findByNameContaining(keyword).stream()
                .map(this::toResponse).toList();
    }

    private HerbResponse toResponse(Herb herb) {
        HerbResponse r = new HerbResponse();
        r.setId(herb.getId());
        r.setName(herb.getName());
        r.setCategory(herb.getCategory());
        r.setNature(herb.getNature());
        r.setTaste(herb.getTaste());
        r.setMeridian(herb.getMeridian());
        r.setMinDosage(herb.getMinDosage());
        r.setMaxDosage(herb.getMaxDosage());
        r.setUnit(herb.getUnit() != null ? herb.getUnit() : "g");
        r.setIsToxic(herb.getIsToxic() != null && herb.getIsToxic() == 1);
        r.setFunctions(herb.getFunctions());
        r.setIndications(herb.getIndications());
        return r;
    }
}
