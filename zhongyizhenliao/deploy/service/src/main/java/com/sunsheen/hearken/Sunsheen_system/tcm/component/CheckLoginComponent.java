package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import cn.dev33.satoken.stp.StpUtil;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("CheckLoginComponent")
@BixComponentPackage(dirname = "auth/login", type = "BIZ")
public class CheckLoginComponent extends ABaseComponent {

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "CheckLoginComponent", memo = "检查登录状态", type = "data")
    public Object run(Map param) {
        Map<String, Object> result = new HashMap<>();
        boolean login = StpUtil.isLogin();
        result.put("code", 200);
        result.put("msg", "success");
        result.put("login", login);
        if (login) {
            result.put("userId", StpUtil.getLoginIdDefaultNull());
        }
        return result;
    }
}
