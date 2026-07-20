package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("RoleComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class RoleComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "RoleComponent", memo = "权限资源树", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "data", comment = "查询参数")})
    @Returns({@ReturnItem(type = "java.util.List", name = "answers", comment = "资源树")})
    public Object run(Map param) {
        return SystemManagementTreeBuilder.resources(
                strategyFactory.getResourceManager().listAllResource());
    }
}
