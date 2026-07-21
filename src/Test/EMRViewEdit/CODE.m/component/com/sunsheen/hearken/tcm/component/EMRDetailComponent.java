package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("EMRDetailComponent")
@BixComponentPackage(dirname = "tcm/emr", type = "BIZ")
public class EMRDetailComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "EMRDetailComponent", memo = "电子病历详情查询", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", TcmParams.longValue(param, "id"));
        Map<String, Object> result = executeSelect("emr/detail", params);
        return TcmParams.ok(result);
    }
}
