"""自定义异常类"""
from typing import Any, Optional


class AppException(Exception):
    def __init__(self, message: str, code: int = 400, detail: Optional[Any] = None):
        self.message = message
        self.code = code
        self.detail = detail
        super().__init__(message)


class NotFoundException(AppException):
    def __init__(self, message: str = "资源不存在", detail: Optional[Any] = None):
        super().__init__(message, code=404, detail=detail)


class UnauthorizedException(AppException):
    def __init__(self, message: str = "未授权访问", detail: Optional[Any] = None):
        super().__init__(message, code=401, detail=detail)


class ForbiddenException(AppException):
    def __init__(self, message: str = "禁止访问", detail: Optional[Any] = None):
        super().__init__(message, code=403, detail=detail)


class ValidationException(AppException):
    def __init__(self, message: str = "数据校验失败", detail: Optional[Any] = None):
        super().__init__(message, code=422, detail=detail)


class BusinessException(AppException):
    def __init__(self, message: str, detail: Optional[Any] = None):
        super().__init__(message, code=400, detail=detail)