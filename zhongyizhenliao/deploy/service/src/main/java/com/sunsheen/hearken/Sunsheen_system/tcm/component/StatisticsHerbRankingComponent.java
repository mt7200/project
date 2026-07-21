package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.service.StatisticsService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("StatisticsHerbRankingComponent")
@BixComponentPackage(dirname = "tcm/statistics", type = "BIZ")
public class StatisticsHerbRankingComponent extends ABaseComponent {

    private final StatisticsService statisticsService;

    public StatisticsHerbRankingComponent(StatisticsService statisticsService) {
        this.statisticsService = statisticsService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "StatisticsHerbRankingComponent", memo = "药材使用排名", type = "data")
    public Object run(Map param) {
        List<Map<String, Object>> data = statisticsService.getHerbRanking();
        return TcmParams.ok(data);
    }
}
