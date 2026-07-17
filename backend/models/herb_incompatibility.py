"""药材配伍禁忌表 ORM"""
from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint

from core.database import Base


class HerbIncompatibility(Base):
    __tablename__ = "herb_incompatibilities"

    id = Column(Integer, primary_key=True, index=True)
    herb_a_id = Column(Integer, ForeignKey("herbs.id"), nullable=False)
    herb_b_id = Column(Integer, ForeignKey("herbs.id"), nullable=False)
    type = Column(String(20), nullable=False, default="incompatibility")

    __table_args__ = (
        UniqueConstraint("herb_a_id", "herb_b_id", "type", name="uq_herb_incompatibility"),
    )