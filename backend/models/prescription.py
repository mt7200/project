from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey
from core.database import Base


class Prescription(Base):
    __tablename__ = "prescription"

    id = Column(Integer, primary_key=True, index=True)
    prescription_no = Column(String(50), unique=True)
    patient_id = Column(Integer, ForeignKey("patient.id"), nullable=False)
    visit_id = Column(Integer, ForeignKey("visit_record.id"))
    doctor_id = Column(Integer, ForeignKey("sys_user.id"), nullable=False)
    formula_id = Column(Integer, ForeignKey("formula.id"))
    diagnosis = Column(String(200))
    syndrome = Column(String(200))
    notes = Column(Text)
    status = Column(String(20), default="draft")
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
