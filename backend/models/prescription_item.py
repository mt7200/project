"""处方药材明细表 ORM"""
from sqlalchemy import Column, Integer, Float, String, ForeignKey

from core.database import Base


class PrescriptionItem(Base):
    __tablename__ = "prescription_items"

    id = Column(Integer, primary_key=True, index=True)
    prescription_id = Column(Integer, ForeignKey("prescriptions.id"), nullable=False, index=True)
    herb_id = Column(Integer, ForeignKey("herbs.id"), nullable=False)
    formula_id = Column(Integer, ForeignKey("formulas.id"))
    dosage = Column(Float)
    unit = Column(String(8), default="g")
    sort_order = Column(Integer, default=0)