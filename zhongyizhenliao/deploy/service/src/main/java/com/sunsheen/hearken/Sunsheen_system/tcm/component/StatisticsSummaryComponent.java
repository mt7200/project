package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.service.StatisticsService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("StatisticsSummaryComponent")
@BixComponentPackage(dirname = "tcm/statistics", type = "BIZ")
public class StatisticsSummaryComponent extends ABaseComponent {

    private final StatisticsService statisticsService;

    public StatisticsSummaryComponent(StatisticsService statisticsService) {
        this.statisticsService = statisticsService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "StatisticsSummaryComponent", memo = "统计汇总", type = "data")
    public Object run(Map param) {
        Map<String, Object> summary = statisticsService.getSummary();
        return TcmParams.ok(summary);
    }
}
