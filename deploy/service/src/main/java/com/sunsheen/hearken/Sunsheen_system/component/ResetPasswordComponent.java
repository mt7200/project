package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.hearken.dev.api.bean.SysUser;
import com.sunsheen.jfids.hearken.component.login.handler.SystemAdapterHandler;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("ResetPasswordComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class ResetPasswordComponent extends ABaseComponent {

    private static final String DEFAULT_PASSWORD =
            "$2a$10$zY8G6SqrrRXu7k4BtlWn6OOX1ymGUJ7KwWvCyh01nkc3vI2JQ/UeK";

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;
    @Autowired
    private SystemAdapterHandler systemAdapterHandler;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "ResetPasswordComponent", memo = "重置密码", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "user_id", comment = "用户ID")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        SysUser currentUser = systemAdapterHandler.getCurrentUser();
        strategyFactory.getUserManager().resetPassword(
                SystemManagementParams.string(param, "user_id"), DEFAULT_PASSWORD, currentUser.getId());
        return "重置密码成功";
    }
}
