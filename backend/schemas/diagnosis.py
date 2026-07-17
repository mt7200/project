"""辨证诊断相关 Schema"""
from datetime import datetime
from typing import Optional, List, Dict, Any
from pydantic import BaseModel, Field


class DiagnosisCreate(BaseModel):
    visit_id: int = Field(..., description="就诊记录 ID")
    pattern_name: str = Field(..., max_length=100, description="证型名称")
    pattern_code: Optional[str] = Field(None, max_length=20)
    confidence: Optional[int] = Field(None, ge=0, le=100)
    symptoms_summary: Optional[Dict[str, Any]] = None
    analysis: Optional[str] = None
    treatment_principle: Optional[str] = Field(None, max_length=200)
    recommended_formulas: Optional[List[Dict[str, Any]]] = None


class DiagnosisOut(BaseModel):
    id: int
    visit_id: int
    pattern_name: str
    pattern_code: Optional[str]
    confidence: Optional[int]
    symptoms_summary: Optional[Dict[str, Any]]
    analysis: Optional[str]
    treatment_principle: Optional[str]
    recommended_formulas: Optional[List[Dict[str, Any]]]
    created_at: datetime

    class Config:
        from_attributes = True