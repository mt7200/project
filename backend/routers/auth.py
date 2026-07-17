"""认证接口"""
from fastapi import APIRouter, Depends, HTTPException, Header
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.auth import LoginRequest, LoginResponse, UserInfo
from services.auth_service import authenticate_user, get_current_user

router = APIRouter()


@router.post("/login", response_model=LoginResponse)
def login(payload: LoginRequest, db: Session = Depends(get_db)):
    user = authenticate_user(db, payload.username, payload.password)
    if not user:
        raise HTTPException(status_code=401, detail="用户名或密码错误")
    return user


@router.post("/logout")
def logout():
    return {"message": "已退出登录"}


@router.get("/me", response_model=UserInfo)
def get_current_user_info(authorization: str = Header(None), db: Session = Depends(get_db)):
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="未提供认证令牌")
    token = authorization.split(" ", 1)[1]
    user = get_current_user(db, token)
    if not user:
        raise HTTPException(status_code=401, detail="无效的认证令牌")
    return UserInfo(id=user.id, username=user.username, real_name=user.real_name, role=user.role)