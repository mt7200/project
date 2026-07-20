package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("VisitCreateComponent")
@BixComponentPackage(dirname = "tcm/workspace", type = "BIZ")
public class VisitCreateComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "VisitCreateComponent", memo = "创建就诊记录（含四诊信息）", type = "data")
    public Object run(Map param) {
        Map<String, Object> params = new HashMap<>();
        params.put("patientId", TcmParams.longValue(param, "patientId"));
        params.put("doctorId", TcmParams.longValue(param, "doctorId"));
        params.put("visitDate", TcmParams.string(param, "visitDate"));
        params.put("chiefComplaint", TcmParams.string(param, "chiefComplaint"));
        params.put("presentIllness", TcmParams.string(param, "presentIllness"));
        params.put("pastHistory", TcmParams.string(param, "pastHistory"));
        params.put("allergyHistory", TcmParams.string(param, "allergyHistory"));
        params.put("personalHistory", TcmParams.string(param, "personalHistory"));
        params.put("tongueImage", TcmParams.string(param, "tongueImage"));
        params.put("pulseImage", TcmParams.string(param, "pulseImage"));
        params.put("otherExams", TcmParams.string(param, "otherExams"));
        params.put("status", "ongoing");
        // int id = executeInsert("patient/patient", params);
        return TcmParams.ok();
    }
}
