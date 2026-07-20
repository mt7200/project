package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.AuditLogDTO;
import com.sunsheen.jfids.hearken.component.login.dto.AuditLogPageDTO;
import com.sunsheen.jfids.hearken.component.login.dto.RoleDTO;
import com.sunsheen.jfids.hearken.component.login.dto.RolePageDTO;
import com.sunsheen.jfids.hearken.component.login.dto.UserPageDTO;
import com.sunsheen.jfids.hearken.component.login.dto.UserSummaryDTO;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

final class SystemManagementResponses {

    private SystemManagementResponses() {
    }

    static Map<String, Object> users(UserPageDTO page) {
        return page(page.getCount(), page.getData().stream().map(SystemManagementResponses::user).toList());
    }

    static Map<String, Object> roles(RolePageDTO page) {
        return page(page.getCount(), page.getData().stream().map(SystemManagementResponses::role).toList());
    }

    static Map<String, Object> logs(AuditLogPageDTO page) {
        return page(page.getCount(), page.getData().stream().map(SystemManagementResponses::log).toList());
    }

    static Map<String, Object> user(UserSummaryDTO user) {
        Map<String, Object> row = new LinkedHashMap<>();
        row.put("user_id", user.getUserId());
        row.put("user_name", user.getUserName());
        row.put("account", user.getAccount());
        row.put("phone", user.getPhone());
        row.put("department_id", user.getDepartmentId());
        row.put("department_name", user.getDepartmentName());
        row.put("user_status", user.getUserStatus());
        row.put("is_network", user.getNetworkEnabled());
        row.put("remark", user.getRemark());
        row.put("create_time", user.getCreateTime());
        return row;
    }

    static Map<String, Object> role(RoleDTO role) {
        Map<String, Object> row = new LinkedHashMap<>();
        row.put("role_id", role.getRoleId());
        row.put("role_code", role.getRoleCode());
        row.put("role_name", role.getRoleName());
        row.put("description", role.getDescription());
        row.put("enable", role.getEnabled() == null ? null : role.getEnabled().getValue());
        row.put("sort", role.getSort());
        row.put("remark", role.getRemark());
        return row;
    }

    private static Map<String, Object> log(AuditLogDTO log) {
        Map<String, Object> row = new LinkedHashMap<>();
        row.put("id", log.getId());
        row.put("account", log.getAccount());
        row.put("user_name", log.getUserName());
        row.put("content", log.getContent());
        row.put("create_time", log.getCreateTime());
        row.put("ip", log.getIp());
        row.put("unit", log.getUnit());
        row.put("log_type", log.getLogType());
        return row;
    }

    private static Map<String, Object> page(long count, List<Map<String, Object>> data) {
        Map<String, Object> response = new LinkedHashMap<>();
        response.put("count", count);
        response.put("data", data);
        return response;
    }
}
