package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("PatientUpdateComponent")
@BixComponentPackage(dirname = "tcm/patient", type = "BIZ")
public class PatientUpdateComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "PatientUpdateComponent", memo = "更新患者信息", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", TcmParams.longValue(param, "id"));
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
        params.put("status", TcmParams.string(param, "status"));
        int rows = executeUpdate("patient/patient", params);
        return TcmParams.ok(rows);
    }
}
