package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.LoginRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.LoginResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.UserInfo;

public interface AuthService {
    LoginResponse login(LoginRequest request);
    void logout();
    UserInfo getCurrentUserInfo();
}
