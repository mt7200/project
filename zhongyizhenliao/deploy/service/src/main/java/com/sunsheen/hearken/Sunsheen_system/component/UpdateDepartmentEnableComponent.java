package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("UpdateDepartmentEnableComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class UpdateDepartmentEnableComponent extends ABaseComponent {
    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "UpdateDepartmentEnableComponent", memo = "更新组织状态", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "id", comment = "组织ID")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        Map values = param.get("data") instanceof Map data ? data : param;
        strategyFactory.getDepartmentManager().updateEnable(
                SystemManagementParams.string(values, "id"),
                SystemManagementParams.booleanValue(values, "enable"));
        return "操作成功";
    }
}
