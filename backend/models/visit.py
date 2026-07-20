"""就诊记录表 ORM"""
from datetime import datetime, date
from sqlalchemy import Column, BigInteger, Integer, String, Date, Text, DateTime, ForeignKey
from core.database import Base


class Visit(Base):
    """就诊记录表"""
    __tablename__ = "visit_record"

    id = Column(BigInteger, primary_key=True, index=True, autoincrement=True)
    patient_id = Column(BigInteger, nullable=False, index=True)
    doctor_id = Column(BigInteger, nullable=False)
    visit_date = Column(Date, nullable=False)
    chief_complaint = Column(Text)
    present_illness = Column(Text)
    past_history = Column(Text)
    allergy_history = Column(Text)
    personal_history = Column(Text)
    tongue_image = Column(Text)
    pulse_image = Column(Text)
    other_exams = Column(Text)
    status = Column(String(20), default="ongoing")
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
