package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("VisitListComponent")
@BixComponentPackage(dirname = "tcm/workspace", type = "BIZ")
public class VisitListComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "VisitListComponent", memo = "就诊记录列表分页查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("patientId", TcmParams.longValue(param, "patientId"));
        params.put("doctorId", TcmParams.longValue(param, "doctorId"));
        params.put("status", TcmParams.string(param, "status"));
        params.put("visitDateStart", TcmParams.string(param, "visitDateStart"));
        params.put("visitDateEnd", TcmParams.string(param, "visitDateEnd"));
        params.put("offset", TcmParams.integer(param, "start") != null ? TcmParams.integer(param, "start") : 0);
        params.put("pageSize", TcmParams.integer(param, "limit") != null ? TcmParams.integer(param, "limit") : 10);
        // List<Map<String, Object>> list = executeSelect("patient/patient", params);
        // long count = executeSelect("patient/patient", params);
        return TcmParams.page(0, Collections.emptyList());
    }
}
