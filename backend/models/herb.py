"""药材表 ORM"""
from sqlalchemy import Column, Integer, String, Float, Boolean, Text, JSON

from core.database import Base


class Herb(Base):
    __tablename__ = "herbs"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(64), unique=True, nullable=False, index=True)
    category = Column(String(32))  # 解表药/清热药/补虚药...
    nature = Column(String(16))  # 寒/凉/平/温/热
    taste = Column(String(32))  # 辛/甘/酸/苦/咸
    meridian = Column(String(128))  # 归经
    min_dosage = Column(Float)
    max_dosage = Column(Float)
    unit = Column(String(8), default="g")
    toxic = Column(Boolean, default=False)
    incompatibilities = Column(JSON)  # 配伍禁忌
    synergies = Column(JSON)  # 相须相使
    functions = Column(JSON)  # 功效
    description = Column(Text)
