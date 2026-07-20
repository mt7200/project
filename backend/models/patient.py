from datetime import datetime
from sqlalchemy import Column, Integer, String, Float, DateTime, Text, ForeignKey
from core.database import Base


class Patient(Base):
    __tablename__ = "patient"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50), nullable=False, index=True)
    gender = Column(String(10))
    age = Column(Integer)
    phone = Column(String(20), unique=True)
    id_card = Column(String(20), unique=True)
    address = Column(String(200))
    blood_type = Column(String(10))
    height = Column(Float)
    weight = Column(Float)
    allergy_info = Column(Text)
    status = Column(String(20), default="active")
    created_by = Column(Integer, ForeignKey("sys_user.id"))
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
