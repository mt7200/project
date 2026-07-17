"""处方审核记录表 ORM"""
from datetime import datetime
from sqlalchemy import Column, BigInteger, String, Integer, Text, DateTime

from core.database import Base


class PrescriptionReview(Base):
    """处方审核记录"""
    __tablename__ = "prescription_review"

    id = Column(BigInteger, primary_key=True, index=True)
    prescription_id = Column(BigInteger, nullable=False, index=True)
    reviewer_id = Column(BigInteger)
    review_status = Column(String(20), default="pending")
    review_comment = Column(Text)
    risk_score = Column(Integer)
    incompatibility_found = Column(Text)
    dosage_warnings = Column(Text)
    reviewed_at = Column(DateTime)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
