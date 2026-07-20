package com.sunsheen.hearken.Sunsheen_system.tcm.common.util;

import java.util.Map;

public class PatternCodeUtil {

    private static final Map<String, String> CATEGORY_MAP = Map.ofEntries(
        Map.entry("肝系病证", "01"),
        Map.entry("心系病证", "02"),
        Map.entry("脾系病证", "03"),
        Map.entry("肺系病证", "04"),
        Map.entry("肾系病证", "05"),
        Map.entry("气血津液病证", "06"),
        Map.entry("肢体经络病证", "07"),
        Map.entry("外感病证", "08")
    );

    public static String makePatternCode(String category, int subIndex) {
        String code = CATEGORY_MAP.getOrDefault(category, "00");
        return String.format("B%s.%02d", code, subIndex);
    }

    private PatternCodeUtil() {}
}
