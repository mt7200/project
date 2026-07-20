package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("SystemPermissionTreeComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SystemPermissionTreeComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public SystemPermissionTreeComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SystemPermissionTreeComponent", memo = "权限资源树", type = "data")
    public Object run(Map param) {
        return SystemManagementTreeBuilder.resources(
                strategyFactory.getResourceManager().listAllResource());
    }
}
