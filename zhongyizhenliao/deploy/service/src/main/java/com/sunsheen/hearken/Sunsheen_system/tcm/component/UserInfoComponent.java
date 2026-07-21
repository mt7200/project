package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.UserInfo;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.AuthService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("UserInfoComponent")
@BixComponentPackage(dirname = "auth/user", type = "BIZ")
public class UserInfoComponent extends ABaseComponent {

    private final AuthService authService;

    public UserInfoComponent(AuthService authService) {
        this.authService = authService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "UserInfoComponent", memo = "获取当前用户信息", type = "data")
    public Object run(Map param) {
        try {
            UserInfo info = authService.getCurrentUserInfo();
            return TcmParams.ok(info);
        } catch (RuntimeException e) {
            Map<String, Object> err = new HashMap<>();
            err.put("code", 401);
            err.put("msg", e.getMessage());
            return err;
        }
    }
}
