package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.DepartmentQueryDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("SystemDepartmentOptionsComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SystemDepartmentOptionsComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public SystemDepartmentOptionsComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SystemDepartmentOptionsComponent", memo = "用户管理部门选项", type = "data")
    public Object run(Map param) {
        return strategyFactory.getDepartmentManager().listDepartments(new DepartmentQueryDTO()).stream()
                .map(SystemManagementParams::departmentMap)
                .toList();
    }
}
