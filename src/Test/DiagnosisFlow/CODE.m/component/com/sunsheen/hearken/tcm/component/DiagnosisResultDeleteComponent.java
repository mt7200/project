package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("DiagnosisResultDeleteComponent")
@BixComponentPackage(dirname = "tcm/diagnosis", type = "BIZ")
public class DiagnosisResultDeleteComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "DiagnosisResultDeleteComponent", memo = "删除辨证诊断结果", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", TcmParams.longValue(param, "id"));
        int rows = executeDelete("diagnosis/delete", params);
        return TcmParams.ok(rows);
    }
}
