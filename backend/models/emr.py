"""病历表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey

from core.database import Base


class EMR(Base):
    """电子病历"""
    __tablename__ = "emrs"

    id = Column(Integer, primary_key=True, index=True)
    patient_id = Column(Integer, ForeignKey("patients.id"), nullable=False, index=True)
    visit_id = Column(Integer, ForeignKey("visits.id"))
    title = Column(String(128))
    chief_complaint = Column(Text)  # 主诉
    present_illness = Column(Text)  # 现病史
    diagnosis = Column(Text)  # 诊断
    treatment = Column(Text)  # 治法/处理
    doctor_id = Column(Integer, ForeignKey("users.id"))
    status = Column(String(16), default="draft")  # draft / finalized
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class HistoryRecord(Base):
    """历史诊疗记录"""
    __tablename__ = "history_records"

    id = Column(Integer, primary_key=True, index=True)
    patient_id = Column(Integer, ForeignKey("patients.id"), nullable=False, index=True)
    visit_date = Column(DateTime)
    diagnosis = Column(String(255))
    syndrome = Column(String(128))
    prescription = Column(Text)
    doctor = Column(String(64))
    created_at = Column(DateTime, default=datetime.utcnow)
