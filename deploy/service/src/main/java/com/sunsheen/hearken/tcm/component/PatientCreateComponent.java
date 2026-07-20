package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("PatientCreateComponent")
@BixComponentPackage(dirname = "tcm/patient", type = "BIZ")
public class PatientCreateComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "PatientCreateComponent", memo = "新增患者", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("name", TcmParams.string(param, "name"));
        params.put("gender", TcmParams.string(param, "gender"));
        params.put("age", TcmParams.integer(param, "age"));
        params.put("phone", TcmParams.string(param, "phone"));
        params.put("id_card", TcmParams.string(param, "idCard"));
        params.put("address", TcmParams.string(param, "address"));
        params.put("blood_type", TcmParams.string(param, "bloodType"));
        params.put("height", TcmParams.doubleValue(param, "height"));
        params.put("weight", TcmParams.doubleValue(param, "weight"));
        params.put("allergy_info", TcmParams.string(param, "allergyInfo"));
        params.put("status", "active");
        params.put("createdBy", TcmParams.longValue(param, "createdBy"));
        int rows = executeInsert("patient/patient", params);
        return TcmParams.ok(rows);
    }
}
