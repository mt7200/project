package com.sunsheen.hearken.tcm.component;

import java.util.HashMap;
import java.util.Map;

final class TcmParams {
    private TcmParams() {}
    static String string(Map<?, ?> source, String key) {
        Object value = source.get(key);
        return value == null ? null : value.toString();
    }
    static Integer integer(Map<?, ?> source, String key) {
        Object value = source.get(key);
        if (value == null || value.toString().isBlank()) return null;
        return value instanceof Number number ? number.intValue() : Integer.valueOf(value.toString());
    }
    static Long longValue(Map<?, ?> source, String key) {
        Object value = source.get(key);
        if (value == null || value.toString().isBlank()) return null;
        return value instanceof Number number ? number.longValue() : Long.valueOf(value.toString());
    }
    static Double doubleValue(Map<?, ?> source, String key) {
        Object value = source.get(key);
        if (value == null || value.toString().isBlank()) return null;
        return value instanceof Number number ? number.doubleValue() : Double.valueOf(value.toString());
    }
    static Map<String, Object> page(long count, java.util.List<?> data) {
        Map<String, Object> response = new HashMap<>();
        response.put("count", count);
        response.put("data", data);
        return response;
    }
    static Map<String, Object> ok() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        return result;
    }
    static Map<String, Object> ok(Object data) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        result.put("data", data);
        return result;
    }
}
