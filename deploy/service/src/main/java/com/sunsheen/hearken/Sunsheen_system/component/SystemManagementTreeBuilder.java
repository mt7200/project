package com.sunsheen.hearken.Sunsheen_system.component;

import com.sunsheen.jfids.hearken.component.login.dto.DepartmentDTO;
import com.sunsheen.jfids.hearken.component.login.dto.ResourceDTO;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

final class SystemManagementTreeBuilder {

    private SystemManagementTreeBuilder() {
    }

    static List<Map<String, Object>> resources(List<ResourceDTO> resources) {
        List<Map<String, Object>> nodes = resources.stream()
                .map(SystemManagementParams::resourceMap)
                .map(SystemManagementTreeBuilder::node)
                .toList();
        return build(nodes);
    }

    static List<Map<String, Object>> departments(List<DepartmentDTO> departments) {
        List<Map<String, Object>> nodes = departments.stream()
                .map(SystemManagementParams::departmentMap)
                .map(SystemManagementTreeBuilder::node)
                .toList();
        return build(nodes);
    }

    private static Map<String, Object> node(Map<String, Object> data) {
        Map<String, Object> node = new LinkedHashMap<>();
        node.put("checkbox", false);
        node.put("checked", false);
        node.put("data", data);
        node.put("expanded", false);
        node.put("iconCls", data.getOrDefault("iconcls", ""));
        node.put("id", String.valueOf(data.get("id")));
        node.put("belongto", data.get("belongto") == null ? "" : String.valueOf(data.get("belongto")));
        node.put("leaf", true);
        node.put("text", data.getOrDefault("text", ""));
        node.put("cls", "");
        node.put("children", new ArrayList<>());
        return node;
    }

    @SuppressWarnings("unchecked")
    private static List<Map<String, Object>> build(List<Map<String, Object>> nodes) {
        Map<String, Map<String, Object>> byId = new LinkedHashMap<>();
        nodes.forEach(node -> byId.put((String) node.get("id"), node));
        List<Map<String, Object>> roots = new ArrayList<>();
        for (Map<String, Object> node : nodes) {
            String parentId = (String) node.get("belongto");
            Map<String, Object> parent = byId.get(parentId);
            if (parent == null || parentId.isBlank() || "0".equals(parentId) || "-1".equals(parentId)) {
                roots.add(node);
                continue;
            }
            ((List<Map<String, Object>>) parent.get("children")).add(node);
            parent.put("leaf", false);
        }
        return roots;
    }
}
