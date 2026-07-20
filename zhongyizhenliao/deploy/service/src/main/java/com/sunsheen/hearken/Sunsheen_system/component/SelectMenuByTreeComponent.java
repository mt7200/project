package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.ResourceDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("SelectMenuByTreeComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SelectMenuByTreeComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "SelectMenuByTreeComponent", memo = "菜单树结构", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "text", comment = "菜单名称")})
    @Returns({@ReturnItem(type = "java.util.List", name = "answers", comment = "菜单树")})
    public Object run(Map param) {
        String text = SystemManagementParams.string(param, "text");
        List<ResourceDTO> resources = strategyFactory.getResourceManager().listAllResource();
        if (text != null && !text.isBlank()) {
            resources = resources.stream()
                    .filter(resource -> resource.getTitle() != null && resource.getTitle().contains(text))
                    .toList();
        }
        return SystemManagementTreeBuilder.resources(resources);
    }
}
