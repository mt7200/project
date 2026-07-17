"""认证接口"""
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from core.security import oauth2_scheme, require_current_user
from schemas.auth import LoginRequest, LoginResponse, UserInfo
from models.user import User
from services.auth_service import authenticate_user, get_user_by_token

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
def get_current_user_info(current_user: User = Depends(require_current_user)):
    return UserInfo(
        id=current_user.id,
        username=current_user.username,
        real_name=current_user.real_name,
        role=current_user.role,
    )
