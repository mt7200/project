"""处方表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Text, Float, ForeignKey, JSON, Boolean

from core.database import Base


class Prescription(Base):
    __tablename__ = "prescriptions"

    id = Column(Integer, primary_key=True, index=True)
    visit_id = Column(Integer, ForeignKey("visits.id"), nullable=False, index=True)
    patient_id = Column(Integer, ForeignKey("patients.id"))
    doctor_id = Column(Integer, ForeignKey("users.id"))
    diagnosis = Column(String(255))
    syndrome = Column(String(128))
    herbs = Column(JSON)  # 处方明细
    risk_level = Column(String(16), default="low")  # low / medium / high
    risk_score = Column(Integer, default=0)
    status = Column(String(16), default="pending")  # pending / approved / rejected
    compatibility_risk = Column(Boolean, default=False)
    dosage_risk = Column(Boolean, default=False)
    contraindication_risk = Column(Boolean, default=False)
    risks = Column(JSON)
    suggestions = Column(JSON)
    notes = Column(Text)
    reviewer = Column(String(64))
    created_at = Column(DateTime, default=datetime.utcnow)
    reviewed_at = Column(DateTime)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
