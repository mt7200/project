"""方剂表 ORM"""
from sqlalchemy import Column, Integer, String, Text, JSON

from core.database import Base


class Formula(Base):
    __tablename__ = "formula"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(128), unique=True, nullable=False, index=True)
    category = Column(String(32))  # 和解剂/补益剂/解表剂...
    herbs = Column(JSON)  # 组成药材名列表
    indications = Column(Text)  # 主治
    usage = Column(Text)  # 用法
    description = Column(Text)
