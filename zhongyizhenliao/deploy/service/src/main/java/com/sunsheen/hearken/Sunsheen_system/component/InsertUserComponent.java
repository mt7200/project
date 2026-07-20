package com.sunsheen.hearken.Sunsheen_system.component;

import cn.hutool.core.util.IdUtil;
import com.sunsheen.hearken.dev.api.bean.SysUser;
import com.sunsheen.hearken.dev.dao.jform.config.MultiTransactional;
import com.sunsheen.jfids.hearken.component.login.dto.UserManagementDTO;
import com.sunsheen.jfids.hearken.component.login.handler.SystemAdapterHandler;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.BixComponentPackage;
import com.sunsheen.jfids.system.bizass.annotation.Component;
import com.sunsheen.jfids.system.bizass.annotation.ParamItem;
import com.sunsheen.jfids.system.bizass.annotation.Params;
import com.sunsheen.jfids.system.bizass.annotation.ReturnItem;
import com.sunsheen.jfids.system.bizass.annotation.Returns;
import com.sunsheen.jfids.system.bizass.annotation.WebRemote;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("InsertUserComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class InsertUserComponent extends ABaseComponent {

    @Autowired
    private SystemManagerStrategyFactory strategyFactory;
    @Autowired
    private SystemAdapterHandler systemAdapterHandler;

    @Override
    @MultiTransactional
    @WebRemote(paramsType = {"data", "json"})
    @Component(name = "InsertUserComponent", memo = "添加用户", type = "data")
    @Params({@ParamItem(type = "java.lang.String", name = "data", comment = "数据")})
    @Returns({@ReturnItem(type = "java.lang.String", name = "answers", comment = "执行结果")})
    public Object run(Map param) {
        String account = SystemManagementParams.string(param, "account");
        if (strategyFactory.getUserManager().getUserByAccount(account) != null) {
            throw new IllegalArgumentException("用户名已存在");
        }
        SysUser currentUser = systemAdapterHandler.getCurrentUser();
        param.put("create_by", currentUser.getId());
        param.put("user_id", IdUtil.getSnowflakeNextIdStr());
        param.put("password", "$2a$10$zY8G6SqrrRXu7k4BtlWn6OOX1ymGUJ7KwWvCyh01nkc3vI2JQ/UeK");
        UserManagementDTO user = SystemManagementParams.user(param);
        strategyFactory.getUserManager().createUser(user);
        return "添加成功";
    }
}
