package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("UpdateRoleUsersComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class UpdateRoleUsersComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public UpdateRoleUsersComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @SuppressWarnings("unchecked")
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "UpdateRoleUsersComponent", memo = "更新角色人员", type = "data")
    public Object run(Map param) {
        List<Map<String, Object>> relations = (List<Map<String, Object>>) param.get("data");
        if (relations == null || relations.isEmpty()) {
            return true;
        }
        String roleId = SystemManagementParams.string(relations.get(0), "role_id");
        List<String> userIds = relations.stream()
                .map(relation -> SystemManagementParams.string(relation, "user_id"))
                .toList();
        Object action = getCallParam(param, "action");
        if ("remove".equals(action == null ? null : action.toString())) {
            strategyFactory.getRoleManager().removeUsers(roleId, userIds);
        } else {
            strategyFactory.getRoleManager().addUsers(roleId, userIds);
        }
        return true;
    }
}
