from typing import Optional
from pydantic import BaseModel


class HerbBase(BaseModel):
    name: str
    category: str
    nature: Optional[str] = None
    taste: Optional[str] = None
    meridian: Optional[str] = None
    min_dosage: Optional[float] = None
    max_dosage: Optional[float] = None
    unit: str = "g"
    is_toxic: bool = False
    functions: Optional[str] = None
    indications: Optional[str] = None


class HerbOut(HerbBase):
    id: int

    class Config:
        from_attributes = True
