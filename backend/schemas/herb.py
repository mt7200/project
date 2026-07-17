"""药材相关 Schema"""
from typing import List, Optional
from pydantic import BaseModel


class HerbBase(BaseModel):
    name: str
    category: Optional[str] = None
    nature: Optional[str] = None
    taste: Optional[str] = None
    meridian: Optional[str] = None
    min_dosage: Optional[float] = None
    max_dosage: Optional[float] = None
    unit: str = "g"
    toxic: bool = False
    incompatibilities: List[str] = []
    synergies: List[str] = []
    functions: List[str] = []
    description: Optional[str] = None


class HerbOut(HerbBase):
    id: int

    class Config:
        from_attributes = True
