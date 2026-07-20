from sqlalchemy import Column, Integer, String, Float, ForeignKey
from core.database import Base


class PrescriptionItem(Base):
    __tablename__ = "prescription_item"

    id = Column(Integer, primary_key=True, index=True)
    prescription_id = Column(Integer, ForeignKey("prescription.id"), nullable=False)
    herb_id = Column(Integer, ForeignKey("herb.id"), nullable=False)
    herb_name = Column(String(50), nullable=False)
    dosage = Column(Float)
    unit = Column(String(5), default="g")
    sort_order = Column(Integer, default=0)
