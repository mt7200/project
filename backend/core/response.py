"""统一响应格式"""
from datetime import datetime, timezone
from typing import Any, Optional


def success(data: Any = None, message: str = "success", code: int = 200) -> dict:
    return {
        "code": code,
        "message": message,
        "data": data,
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }


def error(message: str = "error", code: int = 400, data: Any = None) -> dict:
    return {
        "code": code,
        "message": message,
        "data": data,
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }
