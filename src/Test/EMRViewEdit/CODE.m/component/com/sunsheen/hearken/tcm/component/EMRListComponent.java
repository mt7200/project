package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("EMRListComponent")
@BixComponentPackage(dirname = "tcm/emr", type = "BIZ")
public class EMRListComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "EMRListComponent", memo = "电子病历列表查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("patientId", TcmParams.longValue(param, "patientId"));
        params.put("doctorId", TcmParams.longValue(param, "doctorId"));
        params.put("status", TcmParams.string(param, "status"));
        params.put("visitDateStart", TcmParams.string(param, "visitDateStart"));
        params.put("visitDateEnd", TcmParams.string(param, "visitDateEnd"));
        params.put("offset", TcmParams.integer(param, "start") != null ? TcmParams.integer(param, "start") : 0);
        params.put("pageSize", TcmParams.integer(param, "limit") != null ? TcmParams.integer(param, "limit") : 10);
        List<Map<String, Object>> list = executeSelect("emr/list", params);
        long count = executeSelect("emr/count", params);
        return TcmParams.page(count, list);
    }
}
