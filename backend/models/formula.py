"""方剂表 ORM"""
from datetime import datetime
from sqlalchemy import Column, Integer, String, Text, DateTime

from core.database import Base


class Formula(Base):
    __tablename__ = "formulas"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False, index=True)
    category_l1 = Column(String(50))  # 一级分类
    category_l2 = Column(String(50))  # 二级分类
    functions = Column(Text)  # 功用
    indications = Column(Text)  # 主治
    modifications = Column(Text)  # 加减化裁
    source = Column(String(200))  # 来源典籍
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
