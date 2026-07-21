package com.sunsheen.hearken.Sunsheen_system.tcm.component;

import java.util.HashMap;
import java.util.Map;

public final class TcmParams {
    private TcmParams() {}
    public static String string(Map<?, ?> source, String key) {
        Object value = source.get(key);
        return value == null ? null : value.toString();
    }
    public static Integer integer(Map<?, ?> source, String key) {
        Object value = source.get(key);
        if (value == null || value.toString().isBlank()) return null;
        return value instanceof Number number ? number.intValue() : Integer.valueOf(value.toString());
    }
    public static Long longValue(Map<?, ?> source, String key) {
        Object value = source.get(key);
        if (value == null || value.toString().isBlank()) return null;
        return value instanceof Number number ? number.longValue() : Long.valueOf(value.toString());
    }
    public static Double doubleValue(Map<?, ?> source, String key) {
        Object value = source.get(key);
        if (value == null || value.toString().isBlank()) return null;
        return value instanceof Number number ? number.doubleValue() : Double.valueOf(value.toString());
    }
    public static Map<String, Object> ok() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        return result;
    }
    public static Map<String, Object> ok(Object data) {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("msg", "success");
        result.put("data", data);
        return result;
    }
}
