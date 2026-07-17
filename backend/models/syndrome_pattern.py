"""证型模式表 ORM"""
from sqlalchemy import Column, Integer, String, Text

from core.database import Base


class SyndromePatternRef(Base):
    __tablename__ = "syndrome_patterns"

    id = Column(Integer, primary_key=True, index=True)
    pattern_name = Column(String(100), unique=True, nullable=False, index=True)
    etiology = Column(String(200))
    treatment_method = Column(String(200))