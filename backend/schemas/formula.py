"""方剂相关 Schema"""
from typing import List, Optional
from pydantic import BaseModel


class FormulaBase(BaseModel):
    name: str
    category: Optional[str] = None
    herbs: List[str] = []
    indications: Optional[str] = None
    usage: Optional[str] = None
    description: Optional[str] = None


class FormulaOut(FormulaBase):
    id: int

    class Config:
        from_attributes = True


class FormulaDetail(FormulaOut):
    herb_details: List[dict] = []
