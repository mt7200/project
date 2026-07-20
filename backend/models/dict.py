"""字典表 ORM: 证型字典、症状字典"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, Text, DateTime, Boolean
from core.database import Base


class SyndromePattern(Base):
    """证型知识表"""
    __tablename__ = "syndrome_pattern"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    pattern_name = Column(String(100), unique=True, nullable=False, index=True, comment="证型名称")
    pattern_code = Column(String(20), comment="证候编码，如 B01.02")
    category = Column(String(50), comment="证型分类，如肝系病证/心系病证")
    etiology = Column(String(200), comment="病因")
    pathogenesis = Column(String(200), comment="病机")
    key_symptoms = Column(Text, comment="关键症状")
    pulse_pattern = Column(String(100), comment="典型脉象")
    tongue_pattern = Column(String(100), comment="典型舌象")
    differentiation = Column(Text, comment="辨证要点")
    treatment_method = Column(String(200), comment="治法/治则")
    recommended_formula = Column(String(100), comment="推荐方剂")
    related_diagnosis = Column(String(200), comment="对应西医诊断")
    sort_order = Column(Integer, default=0, comment="排序")
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class SymptomDict(Base):
    """症状/标签字典表"""
    __tablename__ = "symptom_dict"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    category = Column(String(50), nullable=False, index=True, comment="标签分类")
    sub_category = Column(String(50), comment="子分类")
    label = Column(String(100), nullable=False, comment="标签名称")
    sort_order = Column(Integer, default=0, comment="排序")
    is_common = Column(Integer, default=0, comment="是否常用：0-否，1-是")
    weight = Column(Integer, default=0, comment="权重")
    created_at = Column(DateTime, default=datetime.utcnow)
