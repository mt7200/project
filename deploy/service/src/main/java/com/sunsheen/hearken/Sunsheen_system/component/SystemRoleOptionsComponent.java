package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("SystemRoleOptionsComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SystemRoleOptionsComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public SystemRoleOptionsComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SystemRoleOptionsComponent", memo = "用户管理角色选项", type = "data")
    public Object run(Map param) {
        return strategyFactory.getRoleManager().list().stream()
                .map(SystemManagementResponses::role)
                .toList();
    }
}
