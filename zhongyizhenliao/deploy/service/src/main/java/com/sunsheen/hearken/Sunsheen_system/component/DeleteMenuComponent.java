package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.hearken.dev.dao.jform.config.MultiTransactional;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("DeleteMenuComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class DeleteMenuComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @MultiTransactional
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "DeleteMenuComponent", memo = "删除菜单及关联关系", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "id", comment = "菜单ID")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        strategyFactory.getResourceManager().deleteResource(SystemManagementParams.string(param, "id"));
        return "删除成功";
    }
}
