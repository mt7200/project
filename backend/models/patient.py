"""患者表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, Text, DateTime, BigInteger

from core.database import Base


class Patient(Base):
    __tablename__ = "patient"

    id = Column(BigInteger, primary_key=True, index=True)
    name = Column(String(50), nullable=False)
    gender = Column(String(10))  # 男/女
    age = Column(Integer)  # 年龄
    phone = Column(String(20), unique=True, index=True)
    id_card = Column(String(20), unique=True)
    address = Column(String(200))
    blood_type = Column(String(10))
    height = Column(Integer)  # cm
    weight = Column(Integer)  # kg
    allergy_info = Column(Text)  # 过敏信息
    status = Column(String(20), default="active")  # active/inactive
    created_by = Column(BigInteger, index=True)  # 创建人用户ID
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
