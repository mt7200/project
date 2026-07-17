"""字典相关 Schema"""
from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class SyndromePatternOut(BaseModel):
    """证型字典输出"""
    id: int
    pattern_name: str
    pattern_code: Optional[str] = None
    category: Optional[str] = None
    etiology: Optional[str] = None
    pathogenesis: Optional[str] = None
    key_symptoms: Optional[str] = None
    pulse_pattern: Optional[str] = None
    tongue_pattern: Optional[str] = None
    differentiation: Optional[str] = None
    treatment_method: Optional[str] = None
    recommended_formula: Optional[str] = None
    related_diagnosis: Optional[str] = None
    sort_order: Optional[int] = 0
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    model_config = {"from_attributes": True}


class SymptomDictOut(BaseModel):
    """症状字典输出"""
    id: int
    category: str
    sub_category: Optional[str] = None
    label: str
    sort_order: Optional[int] = 0
    is_common: Optional[int] = 0
    weight: Optional[int] = 0
    created_at: Optional[datetime] = None

    model_config = {"from_attributes": True}
