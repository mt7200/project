package com.sunsheen.hearken.tcm.component;

import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.*;

@Service("EMRSaveComponent")
@BixComponentPackage(dirname = "tcm/emr", type = "BIZ")
public class EMRSaveComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "EMRSaveComponent", memo = "保存/更新电子病历", type = "data")
    public Object run(Map param) {
        Long id = TcmParams.longValue(param, "id");
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("patientId", TcmParams.longValue(param, "patientId"));
        params.put("visitId", TcmParams.longValue(param, "visitId"));
        params.put("prescriptionId", TcmParams.longValue(param, "prescriptionId"));
        params.put("visitDate", TcmParams.string(param, "visitDate"));
        params.put("chiefComplaint", TcmParams.string(param, "chiefComplaint"));
        params.put("presentIllness", TcmParams.string(param, "presentIllness"));
        params.put("pastHistory", TcmParams.string(param, "pastHistory"));
        params.put("tongueImage", TcmParams.string(param, "tongueImage"));
        params.put("pulseImage", TcmParams.string(param, "pulseImage"));
        params.put("complexion", TcmParams.string(param, "complexion"));
        params.put("voice", TcmParams.string(param, "voice"));
        params.put("syndrome", TcmParams.string(param, "syndrome"));
        params.put("diagnosis", TcmParams.string(param, "diagnosis"));
        params.put("treatmentPrinciple", TcmParams.string(param, "treatmentPrinciple"));
        params.put("prescriptionText", TcmParams.string(param, "prescriptionText"));
        params.put("notes", TcmParams.string(param, "notes"));
        params.put("treatmentResult", TcmParams.string(param, "treatmentResult"));
        params.put("followUp", TcmParams.string(param, "followUp"));
        params.put("doctorId", TcmParams.longValue(param, "doctorId"));
        params.put("status", TcmParams.string(param, "status"));
        if (id != null) {
            // int rows = executeUpdate("emr/emr", params);
        } else {
            // int newId = executeInsert("emr/emr", params);
        }
        return TcmParams.ok();
    }
}
