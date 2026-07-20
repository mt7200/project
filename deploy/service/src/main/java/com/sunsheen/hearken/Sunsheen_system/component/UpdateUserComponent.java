package com.sunsheen.hearken.Sunsheen_system.component;

import cn.hutool.crypto.digest.BCrypt;
import com.sunsheen.hearken.dev.api.bean.SysUser;
import com.sunsheen.jfids.hearken.component.login.handler.SystemAdapterHandler;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("UpdateUserComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class UpdateUserComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;
    @Autowired
    private SystemAdapterHandler systemAdapterHandler;

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "UpdateUserComponent", memo = "修改用户信息", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "data", comment = "数据")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        SysUser currentUser = systemAdapterHandler.getCurrentUser();
        param.put("update_by", currentUser.getId());
        String password = SystemManagementParams.string(param, "password");
        if (password != null && !password.isBlank()) {
            param.put("password", BCrypt.hashpw(password));
        }
        strategyFactory.getUserManager().updateUser(SystemManagementParams.user(param));
        return "修改成功";
    }
}
