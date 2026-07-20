from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint
from core.database import Base


class FormulaHerb(Base):
    __tablename__ = "formula_herb"

    id = Column(Integer, primary_key=True, index=True)
    formula_id = Column(Integer, ForeignKey("formula.id"), nullable=False)
    herb_id = Column(Integer, ForeignKey("herb.id"), nullable=False)
    dosage = Column(String(20))
    sort_order = Column(Integer, default=0)

    __table_args__ = (
        UniqueConstraint("formula_id", "herb_id", name="uq_formula_herb"),
    )
    dosage = Column(String(50))
    unit = Column(String(10), default="g")
    usage_note = Column(String(200))
