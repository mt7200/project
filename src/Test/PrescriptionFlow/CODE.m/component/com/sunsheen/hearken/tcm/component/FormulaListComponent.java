package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("FormulaListComponent")
@BixComponentPackage(dirname = "tcm/prescription", type = "BIZ")
public class FormulaListComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "FormulaListComponent", memo = "方剂列表查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("name", TcmParams.string(param, "name"));
        params.put("categoryL1", TcmParams.string(param, "categoryL1"));
        params.put("offset", TcmParams.integer(param, "start") != null ? TcmParams.integer(param, "start") : 0);
        params.put("pageSize", TcmParams.integer(param, "limit") != null ? TcmParams.integer(param, "limit") : 10);
        List<Map<String, Object>> list = executeSelect("herb/formulaList", params);
        long count = executeSelect("herb/formulaCount", params);
        return TcmParams.page(count, list);
    }
}
