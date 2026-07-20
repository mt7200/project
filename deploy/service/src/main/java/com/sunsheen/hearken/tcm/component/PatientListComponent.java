package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("PatientListComponent")
@BixComponentPackage(dirname = "tcm/patient", type = "BIZ")
public class PatientListComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "PatientListComponent", memo = "患者列表分页查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("name", TcmParams.string(param, "name"));
        params.put("phone", TcmParams.string(param, "phone"));
        params.put("status", TcmParams.string(param, "status"));
        params.put("offset", TcmParams.integer(param, "start") != null ? TcmParams.integer(param, "start") : 0);
        params.put("pageSize", TcmParams.integer(param, "limit") != null ? TcmParams.integer(param, "limit") : 10);
        List<Map<String, Object>> list = executeSelect("patient/patient", params);
        long count = executeSelect("patient/patient", params);
        return TcmParams.page(count, list);
    }
}
