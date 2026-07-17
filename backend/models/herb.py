"""药材表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, Text, DateTime

from core.database import Base


class Herb(Base):
    __tablename__ = "herbs"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(64), unique=True, nullable=False, index=True)
    category = Column(String(50), nullable=False)  # 解表药/清热药/补虚药...
    nature = Column(String(20))  # 寒/凉/平/温/热
    taste = Column(String(20))  # 辛/甘/酸/苦/咸
    meridian = Column(String(100))  # 归经
    min_dosage = Column(Integer)  # 药典最小剂量 (g)
    max_dosage = Column(Integer)  # 药典最大剂量 (g)
    unit = Column(String(8), default="g")
    is_toxic = Column(Integer, default=0)  # 是否有毒：0-否，1-是
    functions = Column(Text)  # 功效
    indications = Column(Text)  # 主治
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
