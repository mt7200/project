"""方剂 Pydantic Schema"""
from datetime import datetime
from typing import List, Optional
from pydantic import BaseModel


class FormulaOut(BaseModel):
    id: int
    name: str
    category_l1: Optional[str] = None
    category_l2: Optional[str] = None
    functions: Optional[str] = None
    indications: Optional[str] = None
    modifications: Optional[str] = None
    source: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    model_config = {"from_attributes": True}


class HerbDetailItem(BaseModel):
    herb_id: int
    herb_name: str
    dosage: Optional[str] = None
    unit: Optional[str] = None
    sort_order: Optional[int] = None


class FormulaDetail(FormulaOut):
    herb_details: List[HerbDetailItem] = []
