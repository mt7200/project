package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.ReviewActionRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewItemResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewOutResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.ReviewService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController
@RequestMapping(API_PREFIX + "/prescription-review")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping("/")
    public R<List<ReviewItemResponse>> listReviews(
            @RequestParam(defaultValue = "pending") String status) {
        return R.success(reviewService.listReviews(status));
    }

    @PostMapping("/")
    public R<ReviewOutResponse> submitForReview(@RequestParam Long prescriptionId) {
        try {
            return R.success(reviewService.submitForReview(prescriptionId));
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @PutMapping("/{id}")
    public R<ReviewOutResponse> processReview(@PathVariable Long id, @RequestBody ReviewActionRequest request) {
        return R.success(reviewService.processReview(id, request));
    }
}
