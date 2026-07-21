package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewOutResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.ReviewService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("PrescriptionReviewSubmitComponent")
@BixComponentPackage(dirname = "tcm/prescription-review", type = "BIZ")
public class PrescriptionReviewSubmitComponent extends ABaseComponent {

    private final ReviewService reviewService;

    public PrescriptionReviewSubmitComponent(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "PrescriptionReviewSubmitComponent", memo = "提交处方审核", type = "data")
    public Object run(Map param) {
        try {
            Long prescriptionId = TcmParams.longValue(param, "prescriptionId");
            ReviewOutResponse resp = reviewService.submitForReview(prescriptionId);
            return TcmParams.ok(resp);
        } catch (RuntimeException e) {
            Map<String, Object> err = new HashMap<>();
            err.put("code", 500);
            err.put("msg", e.getMessage());
            return err;
        }
    }
}
