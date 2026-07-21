package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("PatientDeleteComponent")
@BixComponentPackage(dirname = "tcm/patient", type = "BIZ")
public class PatientDeleteComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "PatientDeleteComponent", memo = "删除患者", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", TcmParams.longValue(param, "id"));
        int rows = executeDelete("patient/delete", params);
        return TcmParams.ok(rows);
    }
}
