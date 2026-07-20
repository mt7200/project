package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.DepartmentQueryDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("TreeDerpartmentComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class TreeDerpartmentComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "TreeDerpartmentComponent", memo = "组织树结构", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "text", comment = "组织名称")})
    @Returns({@ReturnItem(type = "java.util.List", name = "answers", comment = "组织树")})
    public Object run(Map param) {
        DepartmentQueryDTO query = new DepartmentQueryDTO();
        query.setName(SystemManagementParams.string(param, "text"));
        query.setParentId(SystemManagementParams.string(param, "belongto"));
        query.setTelephone(SystemManagementParams.string(param, "tel"));
        query.setEmail(SystemManagementParams.string(param, "email"));
        query.setMemo(SystemManagementParams.string(param, "memo"));
        query.setAddress(SystemManagementParams.string(param, "address"));
        return SystemManagementTreeBuilder.departments(
                strategyFactory.getDepartmentManager().listDepartments(query));
    }
}
