package com.sunsheen.hearken.Sunsheen_system.tcm.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.LoginRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.LoginResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.UserInfo;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.AuthService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

import static com.sunsheen.hearken.Sunsheen_system.tcm.common.constant.TcmConst.API_PREFIX;

@RestController("tcmAuthController")
@RequestMapping(API_PREFIX + "/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public R<LoginResponse> login(@RequestBody LoginRequest request) {
        try {
            LoginResponse resp = authService.login(request);
            return R.success(resp);
        } catch (RuntimeException e) {
            return R.failed(null, e.getMessage(), null, null);
        }
    }

    @PostMapping("/logout")
    public R<Map<String, String>> logout() {
        authService.logout();
        return R.success(Map.of("message", "已退出登录"));
    }

    @GetMapping("/me")
    public R<UserInfo> getCurrentUserInfo() {
        UserInfo userInfo = authService.getCurrentUserInfo();
        return R.success(userInfo);
    }
}
