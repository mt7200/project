package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.RolePageDTO;
import com.sunsheen.jfids.hearken.component.login.dto.RoleQueryDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("SystemRolePageComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SystemRolePageComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public SystemRolePageComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SystemRolePageComponent", memo = "系统角色分页查询", type = "data")
    public Object run(Map param) {
        RoleQueryDTO query = new RoleQueryDTO();
        query.setRoleId(SystemManagementParams.string(param, "role_id"));
        query.setRoleName(SystemManagementParams.string(param, "role_name"));
        query.setSort(SystemManagementParams.string(param, "sort"));
        query.setRemark(SystemManagementParams.string(param, "remark"));
        query.setPage(SystemManagementParams.integer(param, "start"));
        query.setPageSize(SystemManagementParams.integer(param, "limit"));
        String scope = SystemManagementParams.string(param, "scope");
        RolePageDTO page = switch (scope == null ? "maintenance" : scope) {
            case "assignment" -> strategyFactory.getRoleManager().pageAssignableRoles(query);
            case "permission" -> strategyFactory.getRoleManager().pagePermissionRoles(query);
            default -> strategyFactory.getRoleManager().pageMaintenanceRoles(query);
        };
        return SystemManagementResponses.roles(page);
    }
}
