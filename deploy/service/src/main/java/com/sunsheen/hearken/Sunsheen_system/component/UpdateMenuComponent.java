package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.hearken.dev.dao.jform.config.MultiTransactional;
import com.sunsheen.jfids.hearken.component.login.dto.ResourceDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Objects;

@Service("UpdateMenuComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class UpdateMenuComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @MultiTransactional
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "UpdateMenuComponent", memo = "更新菜单", type = "data")
    @Params({@ParamItem(type = "java.util.Map", name = "data", comment = "菜单数据")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        Map data = (Map) param.get("data");
        ResourceDTO resource = SystemManagementParams.resource(data);
        boolean duplicate = strategyFactory.getResourceManager().listAllResource().stream()
                .anyMatch(item -> resource.getResourceCode() != null
                        && resource.getResourceCode().equals(item.getResourceCode())
                        && !Objects.equals(resource.getResourceId(), item.getResourceId()));
        if (duplicate) {
            throw new IllegalArgumentException("路由重复");
        }
        strategyFactory.getResourceManager().updateResource(resource.getResourceId(), resource);
        return "更新成功";
    }
}
