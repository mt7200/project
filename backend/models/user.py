from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Boolean
from core.database import Base


class User(Base):
    __tablename__ = "sys_user"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(64), unique=True, nullable=False, index=True)
    password_hash = Column(String(128), nullable=False)
    role = Column(String(20), default="doctor")
    real_name = Column(String(50))
    phone = Column(String(20))
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
