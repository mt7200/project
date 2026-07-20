package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.RoleDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("SaveRoleComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SaveRoleComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "SaveRoleComponent", memo = "新增或更新角色", type = "data")
    @Params({@ParamItem(type = "java.util.Map", name = "data", comment = "角色数据")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        RoleDTO role = SystemManagementParams.role((Map) param.get("data"));
        if (role.getRoleId() == null || role.getRoleId().isBlank()) {
            strategyFactory.getRoleManager().createRole(role);
        } else {
            strategyFactory.getRoleManager().updateRole(role);
        }
        return "保存成功";
    }
}
