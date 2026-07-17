"""证型编码工具：生成 pattern_code 格式 B + 两位大类 + 两位小类

示例: pattern_code="B01.02" = 肝系病证 - 第 2 号子项
"""

# 大类编码映射
_CATEGORY_MAP = {
    "肝系病证": "01",
    "心系病证": "02",
    "脾系病证": "03",
    "肺系病证": "04",
    "肾系病证": "05",
    "气血津液病证": "06",
    "肢体经络病证": "07",
    "外感病证": "08",
}


def make_pattern_code(category: str, sub_index: int) -> str:
    """根据大类名和子项序号生成 pattern_code"""
    code = _CATEGORY_MAP.get(category, "00")
    return f"B{code}.{sub_index:02d}"


__all__ = ["make_pattern_code"]
