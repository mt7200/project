"""辨证诊断结果表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey, JSON

from core.database import Base


class DiagnosisResult(Base):
    __tablename__ = "diagnosis_results"

    id = Column(Integer, primary_key=True, index=True)
    visit_id = Column(Integer, ForeignKey("visits.id"), nullable=False, index=True)
    pattern_name = Column(String(100), index=True)
    pattern_code = Column(String(20))
    confidence = Column(Integer)
    symptoms_summary = Column(JSON)
    analysis = Column(Text)
    treatment_principle = Column(String(200))
    recommended_formulas = Column(JSON)
    created_at = Column(DateTime, default=datetime.utcnow)