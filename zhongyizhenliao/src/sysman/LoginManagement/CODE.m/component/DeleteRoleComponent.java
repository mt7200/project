package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.SysUserImpl;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("DeleteRoleComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class DeleteRoleComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "DeleteRoleComponent", memo = "删除角色", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "role_id", comment = "角色ID")})
    @Returns({@ReturnItem(type = "java.lang.Object", name = "answers", comment = "校验或删除结果")})
    public Object run(Map param) {
        String roleId = SystemManagementParams.string(param, "role_id");
        int type = Integer.parseInt(SystemManagementParams.string(param, "type"));
        if (type == 0) {
            List<SysUserImpl> users = strategyFactory.getRoleManager().listUsers(roleId);
            if (!users.isEmpty()) {
                return users;
            }
        }
        strategyFactory.getRoleManager().deleteRole(roleId);
        return "删除成功";
    }
}
