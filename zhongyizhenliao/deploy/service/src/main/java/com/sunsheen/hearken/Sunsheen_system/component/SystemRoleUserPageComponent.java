package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.RoleUserQueryDTO;
import com.sunsheen.jfids.hearken.component.login.dto.UserPageDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("SystemRoleUserPageComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SystemRoleUserPageComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public SystemRoleUserPageComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SystemRoleUserPageComponent", memo = "角色人员分页查询", type = "data")
    public Object run(Map param) {
        RoleUserQueryDTO query = new RoleUserQueryDTO();
        query.setRoleId(SystemManagementParams.string(param, "role_id"));
        query.setUserName(SystemManagementParams.string(param, "user_name"));
        query.setAccount(SystemManagementParams.string(param, "account"));
        query.setPage(SystemManagementParams.integer(param, "start"));
        query.setPageSize(SystemManagementParams.integer(param, "limit"));
        UserPageDTO page = "unassigned".equals(SystemManagementParams.string(param, "mode"))
                ? strategyFactory.getRoleManager().pageUsersWithoutRole(query)
                : strategyFactory.getRoleManager().pageRoleUsers(query);
        return SystemManagementResponses.users(page);
    }
}
