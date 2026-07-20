from sqlalchemy import Column, Integer, String, Float, Text
from core.database import Base


class Herb(Base):
    __tablename__ = "herb"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(64), unique=True, nullable=False, index=True)
    category = Column(String(50), nullable=False)
    nature = Column(String(20))
    taste = Column(String(20))
    meridian = Column(String(100))
    min_dosage = Column(Float)
    max_dosage = Column(Float)
    unit = Column(String(5), default="g")
    is_toxic = Column(Integer, default=0)
    functions = Column(Text)
    indications = Column(Text)
