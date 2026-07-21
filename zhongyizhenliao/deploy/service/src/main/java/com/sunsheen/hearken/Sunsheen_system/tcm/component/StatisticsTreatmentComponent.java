package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.service.StatisticsService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("StatisticsTreatmentComponent")
@BixComponentPackage(dirname = "tcm/statistics", type = "BIZ")
public class StatisticsTreatmentComponent extends ABaseComponent {

    private final StatisticsService statisticsService;

    public StatisticsTreatmentComponent(StatisticsService statisticsService) {
        this.statisticsService = statisticsService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "StatisticsTreatmentComponent", memo = "治疗效果统计", type = "data")
    public Object run(Map param) {
        List<Map<String, Object>> data = statisticsService.getTreatmentResults();
        return TcmParams.ok(data);
    }
}
