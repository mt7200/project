from datetime import datetime
from sqlalchemy import Column, Integer, String, Text, DateTime
from core.database import Base


class Formula(Base):
    __tablename__ = "formula"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), unique=True, nullable=False, index=True)
    category_l1 = Column(String(50))
    category_l2 = Column(String(50))
    functions = Column(Text)
    indications = Column(Text)
    modifications = Column(Text)
    source = Column(String(200))
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
