package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("FormulaDetailComponent")
@BixComponentPackage(dirname = "tcm/prescription", type = "BIZ")
public class FormulaDetailComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "FormulaDetailComponent", memo = "方剂详情查询（含组成药材）", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", TcmParams.longValue(param, "id"));
        Map<String, Object> formula = executeSelect("herb/formulaDetail", params);
        List<Map<String, Object>> herbs = executeSelect("herb/formulaHerbList", params);
        Map<String, Object> result = new HashMap<>();
        result.put("formula", formula);
        result.put("herbs", herbs);
        return TcmParams.ok(result);
    }
}
