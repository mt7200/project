package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.LoginRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.LoginResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.AuthService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("LoginComponent")
@BixComponentPackage(dirname = "auth/login", type = "BIZ")
public class LoginComponent extends ABaseComponent {

    private final AuthService authService;

    public LoginComponent(AuthService authService) {
        this.authService = authService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "LoginComponent", memo = "用户登录", type = "data")
    public Object run(Map param) {
        try {
            LoginRequest req = new LoginRequest();
            req.setUsername(TcmParams.string(param, "username"));
            req.setPassword(TcmParams.string(param, "password"));
            LoginResponse resp = authService.login(req);
            return TcmParams.ok(resp);
        } catch (RuntimeException e) {
            Map<String, Object> err = new HashMap<>();
            err.put("code", 401);
            err.put("msg", e.getMessage());
            return err;
        }
    }
}
