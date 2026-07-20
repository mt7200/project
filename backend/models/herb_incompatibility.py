from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint
from core.database import Base


class HerbIncompatibility(Base):
    __tablename__ = "herb_incompatibility"

    id = Column(Integer, primary_key=True, index=True)
    herb_a_id = Column(Integer, ForeignKey("herb.id"), nullable=False)
    herb_b_id = Column(Integer, ForeignKey("herb.id"), nullable=False)
    type = Column(String(20), nullable=False, default="incompatibility")

    __table_args__ = (
        UniqueConstraint("herb_a_id", "herb_b_id", "type", name="uq_herb_incompatibility"),
    )
    herb_a_id = Column(Integer, ForeignKey("herb.id"), nullable=False, index=True)
    herb_b_id = Column(Integer, ForeignKey("herb.id"), nullable=False, index=True)
    type = Column(String(20))
    severity = Column(String(20), default="medium")
    detail = Column(String(500))
