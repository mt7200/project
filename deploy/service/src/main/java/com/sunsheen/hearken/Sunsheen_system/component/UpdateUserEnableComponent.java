package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.hearken.dev.api.bean.SysUser;
import com.sunsheen.jfids.hearken.component.login.handler.SystemAdapterHandler;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("UpdateUserEnableComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class UpdateUserEnableComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;
    @Autowired
    private SystemAdapterHandler systemAdapterHandler;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "UpdateUserEnableComponent", memo = "启用或禁用用户", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "user_id", comment = "用户ID")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        SysUser currentUser = systemAdapterHandler.getCurrentUser();
        strategyFactory.getUserManager().updateEnable(
                SystemManagementParams.string(param, "user_id"),
                SystemManagementParams.booleanValue(param, "user_status"), currentUser.getId());
        return "操作成功";
    }
}
