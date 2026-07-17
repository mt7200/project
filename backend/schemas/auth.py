"""认证相关 Schema"""
from typing import Optional
from pydantic import BaseModel


class LoginRequest(BaseModel):
    username: str
    password: str


class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"


class UserInfo(BaseModel):
    id: int
    username: str
    real_name: Optional[str] = None
    role: str = "doctor"

    class Config:
        from_attributes = True


class LoginResponse(BaseModel):
    token: str
    user: UserInfo
