"""通用工具函数"""
from datetime import datetime
from typing import Optional


def format_dt(dt: Optional[datetime], fmt: str = "%Y-%m-%d %H:%M") -> str:
    if not dt:
        return ""
    return dt.strftime(fmt)


def parse_int(value, default: int = 0) -> int:
    try:
        return int(value)
    except (TypeError, ValueError):
        return default


def safe_str(value, default: str = "") -> str:
    return "" if value is None else str(value)
