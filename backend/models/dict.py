"""字典表 ORM: 证型字典、症状字典"""
from sqlalchemy import Column, Integer, String, Text, JSON, Boolean

from core.database import Base


class SyndromePattern(Base):
    """证型字典"""
    __tablename__ = "dict_syndrome_patterns"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(128), unique=True, nullable=False, index=True)
    category = Column(String(64))  # 八纲/脏腑/气血津液...
    description = Column(Text)
    symptoms = Column(JSON)  # 典型症状
    treatment_principle = Column(Text)  # 治法
    recommended_formulas = Column(JSON)  # 推荐方剂


class SymptomDict(Base):
    """症状字典"""
    __tablename__ = "dict_symptoms"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(128), nullable=False, index=True)
    category = Column(String(64))  # 望/闻/问/切
    section = Column(String(64))  # 子分类
    description = Column(Text)
    related_syndromes = Column(JSON)
    is_common = Column(Boolean, default=False)
