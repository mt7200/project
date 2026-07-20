package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.hearken.dev.dao.jform.config.MultiTransactional;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("HierarchyAdjustmentComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class HierarchyAdjustmentComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @MultiTransactional
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "HierarchyAdjustmentComponent", memo = "层级调整", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "id", comment = "组织ID")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        Map values = param.get("data") instanceof Map data ? data : param;
        strategyFactory.getDepartmentManager().adjustHierarchy(
                SystemManagementParams.string(values, "id"),
                SystemManagementParams.string(values, "belongto"));
        return "调整成功";
    }
}
