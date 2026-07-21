package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewItemResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.ReviewService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("PrescriptionReviewListComponent")
@BixComponentPackage(dirname = "tcm/prescription-review", type = "BIZ")
public class PrescriptionReviewListComponent extends ABaseComponent {

    private final ReviewService reviewService;

    public PrescriptionReviewListComponent(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "PrescriptionReviewListComponent", memo = "处方审核列表", type = "data")
    public Object run(Map param) {
        String status = TcmParams.string(param, "status");
        if (status == null) status = "pending";
        List<ReviewItemResponse> list = reviewService.listReviews(status);
        return TcmParams.ok(list);
    }
}
