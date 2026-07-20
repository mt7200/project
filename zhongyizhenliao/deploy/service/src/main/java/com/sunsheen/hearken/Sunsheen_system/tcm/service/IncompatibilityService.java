package com.sunsheen.hearken.Sunsheen_system.tcm.service;

import java.util.*;

public class IncompatibilityService {

    // 十八反
    private static final Set<Set<String>> INCOMPATIBLE_18 = Set.of(
        Set.of("甘草", "甘遂"), Set.of("甘草", "大戟"), Set.of("甘草", "海藻"), Set.of("甘草", "芫花"),
        Set.of("乌头", "半夏"), Set.of("乌头", "贝母"), Set.of("乌头", "瓜蒌"), Set.of("乌头", "白及"), Set.of("乌头", "白蔹"),
        Set.of("藜芦", "人参"), Set.of("藜芦", "沙参"), Set.of("藜芦", "玄参"), Set.of("藜芦", "苦参"),
        Set.of("藜芦", "细辛"), Set.of("藜芦", "芍药")
    );

    // 十九畏
    private static final Set<Set<String>> INCOMPATIBLE_19 = Set.of(
        Set.of("硫黄", "芒硝"), Set.of("水银", "砒霜"), Set.of("狼毒", "密陀僧"),
        Set.of("巴豆", "牵牛子"), Set.of("丁香", "郁金"), Set.of("牙硝", "三棱"),
        Set.of("川乌", "犀角"), Set.of("人参", "五灵脂"), Set.of("官桂", "赤石脂")
    );

    public static List<Map<String, Object>> checkIncompatibility(List<Map<String, Object>> herbs) {
        List<Map<String, Object>> conflicts = new ArrayList<>();
        List<String> names = herbs.stream()
                .map(h -> (String) h.getOrDefault("name", ""))
                .toList();

        for (int i = 0; i < names.size(); i++) {
            for (int j = i + 1; j < names.size(); j++) {
                Set<String> pair = new HashSet<>(Arrays.asList(names.get(i), names.get(j)));
                String type = null;
                if (INCOMPATIBLE_18.contains(pair)) type = "十八反";
                else if (INCOMPATIBLE_19.contains(pair)) type = "十九畏";

                if (type != null) {
                    Map<String, Object> conflict = new HashMap<>();
                    conflict.put("herb_a", names.get(i));
                    conflict.put("herb_b", names.get(j));
                    conflict.put("type", type);
                    conflict.put("herb_a_index", i);
                    conflict.put("herb_b_index", j);
                    conflicts.add(conflict);
                }
            }
        }
        return conflicts;
    }
}
