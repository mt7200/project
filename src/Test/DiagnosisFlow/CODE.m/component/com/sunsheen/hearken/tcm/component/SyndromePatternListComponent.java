package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("SyndromePatternListComponent")
@BixComponentPackage(dirname = "tcm/diagnosis", type = "BIZ")
public class SyndromePatternListComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SyndromePatternListComponent", memo = "证型知识库列表查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("patternName", TcmParams.string(param, "patternName"));
        params.put("category", TcmParams.string(param, "category"));
        params.put("offset", TcmParams.integer(param, "start") != null ? TcmParams.integer(param, "start") : 0);
        params.put("pageSize", TcmParams.integer(param, "limit") != null ? TcmParams.integer(param, "limit") : 10);
        List<Map<String, Object>> list = executeSelect("diagnosis/syndromeList", params);
        long count = executeSelect("diagnosis/syndromeCount", params);
        return TcmParams.page(count, list);
    }
}
