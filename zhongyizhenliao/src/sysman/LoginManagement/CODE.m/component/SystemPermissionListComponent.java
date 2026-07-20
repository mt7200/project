package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.ResourceDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("SystemPermissionListComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SystemPermissionListComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public SystemPermissionListComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SystemPermissionListComponent", memo = "已分配权限查询", type = "data")
    public Object run(Map param) {
        String principalId = SystemManagementParams.string(param, "principalId");
        List<ResourceDTO> resources = "user".equals(SystemManagementParams.string(param, "principalType"))
                ? strategyFactory.getResourceManager().listEffectivePermissionsByUserId(principalId)
                : strategyFactory.getResourceManager().listPermissionsByRoleCode(principalId);
        return resources.stream().map(SystemManagementParams::resourceMap).toList();
    }
}
