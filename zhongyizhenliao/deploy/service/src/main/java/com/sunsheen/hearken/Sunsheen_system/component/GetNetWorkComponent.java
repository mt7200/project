package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.hearken.dev.api.bean.SysUser;
import com.sunsheen.jfids.hearken.component.login.handler.SystemAdapterHandler;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("GetNetWorkComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class GetNetWorkComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;
    @Autowired
    private SystemAdapterHandler systemAdapterHandler;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "GetNetWorkComponent", memo = "启用或禁用入网权限", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "user_id", comment = "用户ID")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        SysUser currentUser = systemAdapterHandler.getCurrentUser();
        strategyFactory.getUserManager().updateNetworkEnable(
                SystemManagementParams.string(param, "user_id"),
                SystemManagementParams.booleanValue(param, "is_network"), currentUser.getId());
        return "操作成功";
    }
}
