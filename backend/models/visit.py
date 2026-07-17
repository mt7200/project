"""就诊记录表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey, JSON

from core.database import Base


class Visit(Base):
    __tablename__ = "visits"

    id = Column(Integer, primary_key=True, index=True)
    patient_id = Column(Integer, ForeignKey("patients.id"), nullable=False, index=True)
    doctor_id = Column(Integer, ForeignKey("users.id"))
    visit_date = Column(DateTime, default=datetime.utcnow)
    status = Column(String(16), default="pending")  # pending / diagnosing / completed
    # 四诊采集 (JSON: 22 字段症状)
    symptoms = Column(JSON)
    diagnosis = Column(Text)  # 辨证结论
    syndrome = Column(String(128))  # 证型
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
