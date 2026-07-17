"""就诊相关 Schema"""
from datetime import datetime
from typing import Optional, Dict, Any
from pydantic import BaseModel


class SymptomForm(BaseModel):
    """四诊采集表单 (22 字段)"""
    complexion: Optional[str] = None
    spirit: Optional[str] = None
    body_shape: Optional[str] = None
    tongue_color: Optional[str] = None
    tongue_coating: Optional[str] = None
    tongue_shape: Optional[str] = None
    voice: Optional[str] = None
    breath: Optional[str] = None
    cough: Optional[str] = None
    odor: Optional[str] = None
    chief_complaint: Optional[str] = None
    chill_fever: Optional[str] = None
    sweat: Optional[str] = None
    appetite: Optional[str] = None
    thirst: Optional[str] = None
    stool: Optional[str] = None
    urine: Optional[str] = None
    sleep: Optional[str] = None
    menstruation: Optional[str] = None
    pain: Optional[str] = None
    pulse: Optional[str] = None
    abdomen: Optional[str] = None


class VisitBase(BaseModel):
    patient_id: int
    symptoms: Optional[Dict[str, Any]] = None
    diagnosis: Optional[str] = None
    syndrome: Optional[str] = None


class VisitCreate(VisitBase):
    pass


class VisitUpdate(BaseModel):
    symptoms: Optional[Dict[str, Any]] = None
    diagnosis: Optional[str] = None
    syndrome: Optional[str] = None
    status: Optional[str] = None


class VisitOut(VisitBase):
    id: int
    doctor_id: Optional[int]
    visit_date: datetime
    status: str
    created_at: datetime

    class Config:
        from_attributes = True
