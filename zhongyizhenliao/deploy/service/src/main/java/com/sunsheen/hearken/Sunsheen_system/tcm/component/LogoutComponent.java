package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import com.sunsheen.hearken.Sunsheen_system.tcm.service.AuthService;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("LogoutComponent")
@BixComponentPackage(dirname = "auth/login", type = "BIZ")
public class LogoutComponent extends ABaseComponent {

    private final AuthService authService;

    public LogoutComponent(AuthService authService) {
        this.authService = authService;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "LogoutComponent", memo = "退出登录", type = "data")
    public Object run(Map param) {
        authService.logout();
        return TcmParams.ok();
    }
}
