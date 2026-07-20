from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey, JSON
from core.database import Base


class DiagnosisResult(Base):
    __tablename__ = "diagnosis_result"

    id = Column(Integer, primary_key=True, index=True)
    visit_id = Column(Integer, ForeignKey("visit_record.id"), nullable=False, index=True)
    pattern_name = Column(String(100), index=True)
    pattern_code = Column(String(20))
    confidence = Column(Integer)
    symptoms_summary = Column(JSON)
    analysis = Column(Text)
    treatment_principle = Column(String(200))
    recommended_formulas = Column(JSON)
    created_at = Column(DateTime, default=datetime.utcnow)
    patient_id = Column(Integer, ForeignKey("patient.id"), nullable=False)
    doctor_id = Column(Integer, ForeignKey("sys_user.id"), nullable=False)
    syndrome_pattern_id = Column(Integer, ForeignKey("syndrome_pattern.id"))
    syndrome = Column(String(200))
    diagnosis = Column(String(200))
    differentiation = Column(Text)
    treatment_principle = Column(Text)
    diagnosis_type = Column(String(50))
    notes = Column(Text)
    status = Column(String(20), default="confirmed")
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
