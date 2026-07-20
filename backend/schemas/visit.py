"""就诊相关 Schema"""
from datetime import date, datetime
from typing import Optional
from pydantic import BaseModel


class VisitCreate(BaseModel):
    """创建就诊记录"""
    patient_id: int
    doctor_id: int
    visit_date: date
    chief_complaint: Optional[str] = None
    present_illness: Optional[str] = None
    past_history: Optional[str] = None
    allergy_history: Optional[str] = None
    personal_history: Optional[str] = None
    tongue_image: Optional[str] = None
    pulse_image: Optional[str] = None
    other_exams: Optional[str] = None


class VisitUpdate(BaseModel):
    """更新就诊记录"""
    chief_complaint: Optional[str] = None
    present_illness: Optional[str] = None
    past_history: Optional[str] = None
    allergy_history: Optional[str] = None
    personal_history: Optional[str] = None
    tongue_image: Optional[str] = None
    pulse_image: Optional[str] = None
    other_exams: Optional[str] = None


class VisitOut(BaseModel):
    """就诊记录输出"""
    id: int
    patient_id: int
    doctor_id: int
    visit_date: date
    chief_complaint: Optional[str] = None
    present_illness: Optional[str] = None
    past_history: Optional[str] = None
    allergy_history: Optional[str] = None
    personal_history: Optional[str] = None
    tongue_image: Optional[str] = None
    pulse_image: Optional[str] = None
    other_exams: Optional[str] = None
    status: Optional[str] = "ongoing"
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    model_config = {"from_attributes": True}
