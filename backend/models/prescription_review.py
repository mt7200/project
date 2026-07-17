"""处方审核记录表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey, JSON

from core.database import Base


class PrescriptionReview(Base):
    __tablename__ = "prescription_reviews"

    id = Column(Integer, primary_key=True, index=True)
    prescription_id = Column(Integer, ForeignKey("prescriptions.id"), nullable=False, index=True)
    reviewer_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    risk_level = Column(String(10))
    review_status = Column(String(20), default="pending")
    risk_details = Column(JSON)
    comment = Column(Text)
    created_at = Column(DateTime, default=datetime.utcnow)
    reviewed_at = Column(DateTime)