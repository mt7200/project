package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.hearken.dev.dao.jform.config.MultiTransactional;
import com.sunsheen.jfids.hearken.component.login.dto.SysUserImpl;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("DeleteDerpartmentComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class DeleteDerpartmentComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @MultiTransactional
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "DeleteDerpartmentComponent", memo = "删除组织", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "department_id", comment = "组织ID")})
    @Returns({@ReturnItem(type = "java.lang.Object", name = "answers", comment = "校验或删除结果")})
    public Object run(Map param) {
        String departmentId = SystemManagementParams.string(param, "department_id");
        int type = Integer.parseInt(SystemManagementParams.string(param, "type"));
        if (type == 0) {
            List<SysUserImpl> users = strategyFactory.getDepartmentManager().listUsers(departmentId);
            if (!users.isEmpty()) {
                return users;
            }
        }
        strategyFactory.getDepartmentManager().deleteDepartment(departmentId);
        return "删除成功";
    }
}
