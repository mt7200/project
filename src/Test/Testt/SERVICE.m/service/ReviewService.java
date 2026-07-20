package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.ReviewActionRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewItemResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.ReviewOutResponse;

import java.util.List;

public interface ReviewService {
    List<ReviewItemResponse> listReviews(String status);
    ReviewOutResponse submitForReview(Long prescriptionId);
    ReviewOutResponse processReview(Long reviewId, ReviewActionRequest request);
}
