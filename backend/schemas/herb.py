"""药材 Pydantic Schema"""
from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class HerbOut(BaseModel):
    id: int
    name: str
    category: str
    nature: Optional[str] = None
    taste: Optional[str] = None
    meridian: Optional[str] = None
    min_dosage: Optional[int] = None
    max_dosage: Optional[int] = None
    unit: Optional[str] = "g"
    is_toxic: Optional[int] = 0
    functions: Optional[str] = None
    indications: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    model_config = {"from_attributes": True}
