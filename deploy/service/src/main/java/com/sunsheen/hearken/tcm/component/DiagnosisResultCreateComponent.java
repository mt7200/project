package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("DiagnosisResultCreateComponent")
@BixComponentPackage(dirname = "tcm/diagnosis", type = "BIZ")
public class DiagnosisResultCreateComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "DiagnosisResultCreateComponent", memo = "新增辨证诊断结果", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("visitId", TcmParams.longValue(param, "visitId"));
        params.put("patternName", TcmParams.string(param, "patternName"));
        params.put("patternCode", TcmParams.string(param, "patternCode"));
        params.put("confidence", TcmParams.integer(param, "confidence"));
        params.put("description", TcmParams.string(param, "description"));
        params.put("symptoms", TcmParams.string(param, "symptoms"));
        params.put("etiology", TcmParams.string(param, "etiology"));
        params.put("pathogenesis", TcmParams.string(param, "pathogenesis"));
        params.put("isSelected", TcmParams.integer(param, "isSelected"));
        params.put("source", TcmParams.string(param, "source"));
        int rows = executeInsert("diagnosis/diagnosis", params);
        return TcmParams.ok(rows);
    }
}
