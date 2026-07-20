from typing import Optional, List
from pydantic import BaseModel


class FormulaBase(BaseModel):
    name: str
    category_l1: Optional[str] = None
    category_l2: Optional[str] = None
    functions: Optional[str] = None
    indications: Optional[str] = None
    modifications: Optional[str] = None
    source: Optional[str] = None


class FormulaOut(FormulaBase):
    id: int
    herbs: List[str] = []

    class Config:
        from_attributes = True


class FormulaDetail(FormulaOut):
    herbs: List[str] = []
