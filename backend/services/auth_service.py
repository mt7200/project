"""认证业务服务"""
from typing import Optional
from sqlalchemy.orm import Session

from models.user import User
from core.security import verify_password, create_access_token, decode_access_token
from schemas.auth import LoginResponse, UserInfo


def get_user_by_username(db: Session, username: str) -> Optional[User]:
    return db.query(User).filter(User.username == username, User.is_active == True).first()


def get_user_by_id(db: Session, user_id: int) -> Optional[User]:
    return db.query(User).filter(User.id == user_id, User.is_active == True).first()


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


def get_current_user(db: Session, token: str) -> Optional[User]:
    user_id = decode_access_token(token)
    if not user_id:
        return None
    return get_user_by_id(db, int(user_id))