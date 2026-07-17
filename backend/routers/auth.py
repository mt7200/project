"""认证接口"""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.auth import LoginRequest, LoginResponse
from services.auth_service import authenticate_user

router = APIRouter()


@router.post("/login", response_model=LoginResponse)
def login(payload: LoginRequest, db: Session = Depends(get_db)):
    # TODO: 接入 auth_service.authenticate_user
    user = authenticate_user(db, payload.username, payload.password)
    if not user:
        raise HTTPException(status_code=401, detail="用户名或密码错误")
    return user


@router.post("/logout")
def logout():
    return {"message": "已退出登录"}


@router.get("/me")
def get_current_user_info():
    # TODO: 解析 token 返回当前用户
    return {"message": "TODO"}
