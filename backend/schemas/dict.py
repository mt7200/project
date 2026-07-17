"""字典相关 Schema"""
from typing import List, Optional
from pydantic import BaseModel


class SyndromePatternOut(BaseModel):
    id: int
    name: str
    category: Optional[str]
    description: Optional[str]
    symptoms: List[str] = []
    treatment_principle: Optional[str]
    recommended_formulas: List[str] = []

    class Config:
        from_attributes = True


class SymptomDictOut(BaseModel):
    id: int
    name: str
    category: Optional[str]
    section: Optional[str]
    description: Optional[str]
    related_syndromes: List[str] = []
    is_common: bool = False

    class Config:
        from_attributes = True
