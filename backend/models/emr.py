"""电子病历表 ORM"""
from datetime import datetime
from sqlalchemy import Column, BigInteger, String, Date, Text, DateTime

from core.database import Base


class EMR(Base):
    """电子病历"""
    __tablename__ = "emr"

    id = Column(BigInteger, primary_key=True, index=True)
    patient_id = Column(BigInteger, nullable=False, index=True)
    visit_id = Column(BigInteger)
    prescription_id = Column(BigInteger)
    visit_date = Column(Date, nullable=False)
    chief_complaint = Column(Text)
    present_illness = Column(Text)
    past_history = Column(Text)
    tongue_image = Column(Text)
    pulse_image = Column(Text)
    complexion = Column(String(50))
    voice = Column(String(50))
    syndrome = Column(String(200))
    diagnosis = Column(String(200))
    treatment_principle = Column(String(200))
    prescription_text = Column(Text)
    notes = Column(Text)
    treatment_result = Column(String(20))
    follow_up = Column(String(100))
    doctor_id = Column(BigInteger, nullable=False)
    status = Column(String(20), default="active")
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
