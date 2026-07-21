package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("DiagnosisResultListComponent")
@BixComponentPackage(dirname = "tcm/diagnosis", type = "BIZ")
public class DiagnosisResultListComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "DiagnosisResultListComponent", memo = "辨证诊断结果列表（按就诊记录）", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("visitId", TcmParams.longValue(param, "visitId"));
        List<Map<String, Object>> list = executeSelect("diagnosis/list", params);
        return TcmParams.ok(list);
    }
}
