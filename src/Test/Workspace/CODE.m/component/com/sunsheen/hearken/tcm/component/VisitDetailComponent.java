package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("VisitDetailComponent")
@BixComponentPackage(dirname = "tcm/workspace", type = "BIZ")
public class VisitDetailComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "VisitDetailComponent", memo = "就诊记录详情查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", TcmParams.longValue(param, "id"));
        Map<String, Object> result = executeSelect("patient/visitDetail", params);
        return TcmParams.ok(result);
    }
}
