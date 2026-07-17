"""认证业务服务"""
from typing import Optional
from sqlalchemy.orm import Session

from models.user import User
from core.security import verify_password, create_access_token
from schemas.auth import LoginResponse, UserInfo


def get_user_by_username(db: Session, username: str) -> Optional[User]:
    # TODO: 实现
    return None


def authenticate_user(db: Session, username: str, password: str) -> Optional[LoginResponse]:
    """校验账号密码并签发 token"""
    user = get_user_by_username(db, username)
    if not user or not verify_password(password, user.password_hash):
        return None
    token = create_access_token(subject=str(user.id))
    return LoginResponse(
        token=token,
        user=UserInfo(id=user.id, username=user.username, real_name=user.real_name, role=user.role),
    )
