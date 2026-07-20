package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("SymptomDictListComponent")
@BixComponentPackage(dirname = "tcm/workspace", type = "BIZ")
public class SymptomDictListComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SymptomDictListComponent", memo = "症状字典/标签查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("category", TcmParams.string(param, "category"));
        params.put("subCategory", TcmParams.string(param, "subCategory"));
        params.put("label", TcmParams.string(param, "label"));
        params.put("isCommon", TcmParams.integer(param, "isCommon"));
        // List<Map<String, Object>> list = executeSelect("diagnosis/diagnosis", params);
        return TcmParams.ok(Collections.emptyList());
    }
}
