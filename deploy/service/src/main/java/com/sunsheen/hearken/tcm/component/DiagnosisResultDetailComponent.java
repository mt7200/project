package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("DiagnosisResultDetailComponent")
@BixComponentPackage(dirname = "tcm/diagnosis", type = "BIZ")
public class DiagnosisResultDetailComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "DiagnosisResultDetailComponent", memo = "辨证诊断结果详情查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", TcmParams.longValue(param, "id"));
        Map<String, Object> result = executeSelect("diagnosis/diagnosis", params);
        return TcmParams.ok(result);
    }
}
