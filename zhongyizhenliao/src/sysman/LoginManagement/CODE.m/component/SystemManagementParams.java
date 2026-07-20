package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.DepartmentDTO;
import com.sunsheen.jfids.hearken.component.login.dto.ResourceDTO;
import com.sunsheen.jfids.hearken.component.login.dto.RoleDTO;
import com.sunsheen.jfids.hearken.component.login.dto.UserManagementDTO;

import java.util.HashMap;
import java.util.Map;

final class SystemManagementParams {

    private SystemManagementParams() {
    }

    static UserManagementDTO user(Map<?, ?> source) {
        UserManagementDTO user = new UserManagementDTO();
        user.setUserId(string(source, "user_id"));
        user.setAccount(string(source, "account"));
        user.setUserName(string(source, "user_name"));
        user.setPassword(string(source, "password"));
        user.setDepartmentId(string(source, "department_id"));
        user.setPhone(string(source, "phone"));
        user.setEmail(string(source, "email"));
        user.setRemark(string(source, "remark"));
        user.setEnabled(bool(source, "user_status"));
        user.setNetworkEnabled(bool(source, "is_network"));
        user.setCreateBy(string(source, "create_by"));
        user.setUpdateBy(string(source, "update_by"));
        return user;
    }

    static RoleDTO role(Map<?, ?> source) {
        RoleDTO role = new RoleDTO();
        role.setRoleId(string(source, "role_id"));
        role.setRoleCode(string(source, "role_code"));
        role.setRoleName(string(source, "role_name"));
        role.setDescription(string(source, "description"));
        role.setSort(integer(source, "sort"));
        role.setRemark(string(source, "remark"));
        return role;
    }

    static ResourceDTO resource(Map<?, ?> source) {
        ResourceDTO resource = new ResourceDTO();
        resource.setResourceId(string(source, "id"));
        resource.setParentId(string(source, "belongto"));
        resource.setResourceName(string(source, "resource_name"));
        resource.setResourceCode(string(source, "resource_code"));
        resource.setComponentPath(string(source, "component_path"));
        resource.setResourceType(integer(source, "resource_type"));
        resource.setSortOrder(integer(source, "sequence"));
        resource.setGrade(integer(source, "grade"));
        resource.setTitle(string(source, "text"));
        resource.setIcon(string(source, "iconcls"));
        resource.setIsHide(bool(source, "is_hide"));
        resource.setLink(string(source, "is_link"));
        return resource;
    }

    static DepartmentDTO department(Map<?, ?> source) {
        DepartmentDTO department = new DepartmentDTO();
        department.setId(string(source, "id"));
        department.setParentId(string(source, "belongto"));
        department.setName(string(source, "text"));
        department.setTelephone(string(source, "tel"));
        department.setEmail(string(source, "email"));
        department.setSequence(integer(source, "sequence"));
        department.setMemo(string(source, "memo"));
        department.setEnabled(bool(source, "enable"));
        department.setGrade(integer(source, "grade"));
        department.setIcon(string(source, "iconcls"));
        department.setAddress(string(source, "address"));
        return department;
    }

    static Map<String, Object> resourceMap(ResourceDTO resource) {
        Map<String, Object> data = new HashMap<>();
        data.put("id", resource.getResourceId());
        data.put("belongto", resource.getParentId());
        data.put("resource_name", resource.getResourceName());
        data.put("resource_code", resource.getResourceCode());
        data.put("component_path", resource.getComponentPath());
        data.put("resource_type", resource.getResourceType());
        data.put("sequence", resource.getSortOrder());
        data.put("grade", resource.getGrade());
        data.put("text", resource.getTitle());
        data.put("iconcls", resource.getIcon());
        data.put("is_hide", Boolean.TRUE.equals(resource.getIsHide()) ? 1 : 0);
        data.put("is_link", resource.getLink());
        return data;
    }

    static Map<String, Object> departmentMap(DepartmentDTO department) {
        Map<String, Object> data = new HashMap<>();
        data.put("id", department.getId());
        data.put("belongto", department.getParentId());
        data.put("text", department.getName());
        data.put("tel", department.getTelephone());
        data.put("email", department.getEmail());
        data.put("sequence", department.getSequence());
        data.put("memo", department.getMemo());
        data.put("enable", Boolean.TRUE.equals(department.getEnabled()) ? 1 : 0);
        data.put("grade", department.getGrade());
        data.put("iconcls", department.getIcon());
        data.put("address", department.getAddress());
        return data;
    }

    static String string(Map<?, ?> source, String key) {
        Object value = source.get(key);
        return value == null ? null : value.toString();
    }

    static boolean booleanValue(Map<?, ?> source, String key) {
        return Boolean.TRUE.equals(bool(source, key));
    }

    private static Boolean bool(Map<?, ?> source, String key) {
        Object value = source.get(key);
        if (value instanceof Boolean bool) {
            return bool;
        }
        return value != null && ("1".equals(value.toString()) || Boolean.parseBoolean(value.toString()));
    }

    static Integer integer(Map<?, ?> source, String key) {
        Object value = source.get(key);
        if (value == null || value.toString().isBlank()) {
            return null;
        }
        return value instanceof Number number ? number.intValue() : Integer.valueOf(value.toString());
    }
}
