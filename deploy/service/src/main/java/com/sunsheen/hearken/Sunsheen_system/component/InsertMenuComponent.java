package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.hearken.dev.dao.jform.config.MultiTransactional;
import com.sunsheen.jfids.hearken.component.login.dto.ResourceDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.hearken.component.login.utils.IdUtil;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Objects;

@Service("InsertMenuComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class InsertMenuComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;

    @Override
    @MultiTransactional
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "InsertMenuComponent", memo = "新增菜单", type = "data")
    @Params({@ParamItem(type = "java.util.Map", name = "data", comment = "菜单数据")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        Map data = (Map) param.get("data");
        ResourceDTO resource = SystemManagementParams.resource(data);
        resource.setId(IdUtil.getSnowflakeNextIdStr());
        ensureResourceCodeAvailable(resource.getResourceCode(), null);
        strategyFactory.getResourceManager().createResource(resource);
        return "新增成功";
    }

    private void ensureResourceCodeAvailable(String resourceCode, String currentId) {
        if (resourceCode == null || resourceCode.isBlank()) {
            return;
        }
        boolean exists = strategyFactory.getResourceManager().listAllResource().stream()
                .anyMatch(resource -> resourceCode.equals(resource.getResourceCode())
                        && !Objects.equals(resource.getResourceId(), currentId));
        if (exists) {
            throw new IllegalArgumentException("路由重复");
        }
    }
}
