package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.ReviewActionRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewOutResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.ReviewService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("PrescriptionReviewProcessComponent")
@BixComponentPackage(dirname = "tcm/prescription-review", type = "BIZ")
public class PrescriptionReviewProcessComponent extends ABaseComponent {

    private final ReviewService reviewService;

    public PrescriptionReviewProcessComponent(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "PrescriptionReviewProcessComponent", memo = "处理处方审核", type = "data")
    public Object run(Map param) {
        try {
            Long reviewId = TcmParams.longValue(param, "reviewId");
            ReviewActionRequest req = new ReviewActionRequest();
            req.setAction(TcmParams.string(param, "action"));
            req.setComment(TcmParams.string(param, "comment"));
            ReviewOutResponse resp = reviewService.processReview(reviewId, req);
            return TcmParams.ok(resp);
        } catch (RuntimeException e) {
            Map<String, Object> err = new HashMap<>();
            err.put("code", 500);
            err.put("msg", e.getMessage());
            return err;
        }
    }
}
