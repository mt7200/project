package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.AuditLogQueryDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.system.bizass.annotation.*;
import com.sunsheen.jfids.system.bizass.core.ABaseComponent;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("SystemAuditLogPageComponent")
@BixComponentPackage(dirname = "system/ai", type = "SYSTEM")
public class SystemAuditLogPageComponent extends ABaseComponent {

    private final SystemManagerStrategyFactory strategyFactory;

    public SystemAuditLogPageComponent(SystemManagerStrategyFactory strategyFactory) {
        this.strategyFactory = strategyFactory;
    }

    @Override
    @WebRemote(paramsType = {"data", "json"})
    @Params(@ParamItem(name = "data", type = "json"))
    @Component(name = "SystemAuditLogPageComponent", memo = "系统日志分页查询", type = "data")
    public Object run(Map param) {
        AuditLogQueryDTO query = new AuditLogQueryDTO();
        query.setUnit(SystemManagementParams.string(param, "unit"));
        query.setUserName(SystemManagementParams.string(param, "user_name"));
        query.setAccount(SystemManagementParams.string(param, "account"));
        query.setLogType(SystemManagementParams.string(param, "log_type"));
        query.setStartTime(SystemManagementParams.string(param, "start_time"));
        query.setEndTime(SystemManagementParams.string(param, "end_time"));
        query.setPage(SystemManagementParams.integer(param, "start"));
        query.setPageSize(SystemManagementParams.integer(param, "limit"));
        return SystemManagementResponses.logs(strategyFactory.getLogManager().pageAuditLogs(query));
    }
}
