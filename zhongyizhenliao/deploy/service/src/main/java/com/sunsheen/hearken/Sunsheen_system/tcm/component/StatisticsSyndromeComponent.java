package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.service.StatisticsService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("StatisticsSyndromeComponent")
@BixComponentPackage(dirname = "tcm/statistics", type = "BIZ")
public class StatisticsSyndromeComponent extends ABaseComponent {

    private final StatisticsService statisticsService;

    public StatisticsSyndromeComponent(StatisticsService statisticsService) {
        this.statisticsService = statisticsService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "StatisticsSyndromeComponent", memo = "证型分布统计", type = "data")
    public Object run(Map param) {
        List<Map<String, Object>> data = statisticsService.getSyndromeDistribution();
        return TcmParams.ok(data);
    }
}
