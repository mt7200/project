"""配伍禁忌检测服务：十八反 / 十九畏"""
from typing import List, Dict, Any, Tuple, Set

# 十八反
INCOMPATIBLE_PAIRS_18: Set[Tuple[str, str]] = {
    ("甘草", "甘遂"), ("甘草", "大戟"), ("甘草", "海藻"), ("甘草", "芫花"),
    ("乌头", "半夏"), ("乌头", "贝母"), ("乌头", "瓜蒌"), ("乌头", "白及"), ("乌头", "白蔹"),
    ("藜芦", "人参"), ("藜芦", "沙参"), ("藜芦", "玄参"), ("藜芦", "苦参"),
    ("藜芦", "细辛"), ("藜芦", "芍药"),
}

# 十九畏
INCOMPATIBLE_PAIRS_19: Set[Tuple[str, str]] = {
    ("硫黄", "芒硝"), ("水银", "砒霜"), ("狼毒", "密陀僧"),
    ("巴豆", "牵牛子"), ("丁香", "郁金"), ("牙硝", "三棱"),
    ("川乌", "犀角"), ("人参", "五灵脂"), ("官桂", "赤石脂"),
}

# 合并所有禁忌对
ALL_PAIRS: List[Tuple[Tuple[str, str], str]] = [
    (pair, "十八反") for pair in INCOMPATIBLE_PAIRS_18
] + [(pair, "十九畏") for pair in INCOMPATIBLE_PAIRS_19]


def check_incompatibility(herbs: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    """
    检测处方药材中是否存在十八反 / 十九畏禁忌。

    参数:
        herbs: 处方药材列表，每项至少包含 {"name": "药材名"}
               示例: [{"name": "甘草", "dosage": 3}, {"name": "甘遂", "dosage": 1}]

    返回:
        冲突列表，每项格式:
        {
            "herb_a": str,       # 药材 A 名称
            "herb_b": str,       # 药材 B 名称
            "type": str,         # "十八反" | "十九畏"
            "herb_a_index": int, # 在原列表中的索引
            "herb_b_index": int, # 在原列表中的索引
        }
        无冲突时返回空列表 []
    """
    conflicts: List[Dict[str, Any]] = []

    # 提取名称列表（保留索引用于定位）
    names: List[str] = [h.get("name", "") for h in herbs]

    for i in range(len(names)):
        for j in range(i + 1, len(names)):
            pair = tuple(sorted([names[i], names[j]]))
            for p, conflict_type in ALL_PAIRS:
                if pair == p:
                    conflicts.append({
                        "herb_a": names[i],
                        "herb_b": names[j],
                        "type": conflict_type,
                        "herb_a_index": i,
                        "herb_b_index": j,
                    })

    return conflicts
