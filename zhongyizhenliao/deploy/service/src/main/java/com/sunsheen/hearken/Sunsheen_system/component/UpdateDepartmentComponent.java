package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("UpdateDepartmentComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class UpdateDepartmentComponent extends ABaseComponent {
    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "UpdateDepartmentComponent", memo = "更新组织", type = "data")
    @Params({@ParamItem(type = "java.util.Map", name = "data", comment = "组织数据")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        strategyFactory.getDepartmentManager().updateDepartment(
                SystemManagementParams.department((Map) param.get("data")));
        return "更新成功";
    }
}
