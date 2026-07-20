package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.UserPermissionAssignmentDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("InsertByUserIdComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class InsertByUserIdComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public InsertByUserIdComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "InsertByUserIdComponent", memo = "保存用户权限", type = "data")
    @Params({@ParamItem(type = "java.util.List", name = "data", comment = "权限数据")})
    @Returns({@ReturnItem(type = "java.lang.Object", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        List<Map<String, Object>> data = (List<Map<String, Object>>) getCallParam(param, "data");
        if (data.isEmpty()) {
            throw new IllegalArgumentException("菜单权限数据为空");
        }
        UserPermissionAssignmentDTO assignment = new UserPermissionAssignmentDTO();
        assignment.setUserId(SystemManagementParams.string(data.get(0), "user_id"));
        assignment.setResourceIds(data.stream()
                .map(item -> SystemManagementParams.string(item, "resource_id"))
                .filter(java.util.Objects::nonNull)
                .toList());
        strategyFactory.getResourceManager().replaceUserPermissions(assignment);
        return true;
    }
}
