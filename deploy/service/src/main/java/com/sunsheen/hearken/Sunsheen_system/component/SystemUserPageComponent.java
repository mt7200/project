package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.UserPageDTO;
import com.sunsheen.jfids.hearken.component.login.dto.UserQueryDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("SystemUserPageComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SystemUserPageComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public SystemUserPageComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SystemUserPageComponent", memo = "系统用户分页查询", type = "data")
    public Object run(Map param) {
        UserQueryDTO query = new UserQueryDTO();
        query.setUserName(SystemManagementParams.string(param, "user_name"));
        query.setAccount(SystemManagementParams.string(param, "account"));
        query.setDepartmentIds(SystemManagementParams.string(param, "departmentIds"));
        query.setDepartmentName(SystemManagementParams.string(param, "department_name"));
        query.setPage(SystemManagementParams.integer(param, "start"));
        query.setPageSize(SystemManagementParams.integer(param, "limit"));
        String scope = SystemManagementParams.string(param, "scope");
        UserPageDTO page = "permission".equals(scope)
                ? strategyFactory.getUserManager().pageEnabledUsers(query)
                : strategyFactory.getUserManager().pageUsers(query);
        return SystemManagementResponses.users(page);
    }
}
