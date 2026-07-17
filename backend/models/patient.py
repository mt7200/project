"""患者表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Date, Text

from core.database import Base


class Patient(Base):
    __tablename__ = "patients"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(64), nullable=False, index=True)
    gender = Column(String(8))  # 男 / 女
    birth_date = Column(Date)
    phone = Column(String(32))
    id_card = Column(String(32))
    address = Column(String(255))
    allergy = Column(Text)  # 过敏史
    medical_history = Column(Text)  # 既往史
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
