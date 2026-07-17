"""病历相关 Schema（匹配数据库设计文档 emr 表）"""
from datetime import date, datetime
from typing import Optional
from pydantic import BaseModel


class EMRBase(BaseModel):
    patient_id: int
    visit_date: date
    doctor_id: int
    visit_id: Optional[int] = None
    prescription_id: Optional[int] = None
    chief_complaint: Optional[str] = None
    present_illness: Optional[str] = None
    past_history: Optional[str] = None
    tongue_image: Optional[str] = None
    pulse_image: Optional[str] = None
    complexion: Optional[str] = None
    voice: Optional[str] = None
    syndrome: Optional[str] = None
    diagnosis: Optional[str] = None
    treatment_principle: Optional[str] = None
    prescription_text: Optional[str] = None
    notes: Optional[str] = None
    treatment_result: Optional[str] = None
    follow_up: Optional[str] = None
    status: str = "active"


class EMRCreate(EMRBase):
    pass


class EMRUpdate(BaseModel):
    chief_complaint: Optional[str] = None
    present_illness: Optional[str] = None
    past_history: Optional[str] = None
    tongue_image: Optional[str] = None
    pulse_image: Optional[str] = None
    complexion: Optional[str] = None
    voice: Optional[str] = None
    syndrome: Optional[str] = None
    diagnosis: Optional[str] = None
    treatment_principle: Optional[str] = None
    prescription_text: Optional[str] = None
    notes: Optional[str] = None
    treatment_result: Optional[str] = None
    follow_up: Optional[str] = None
    status: Optional[str] = None


class EMROut(EMRBase):
    id: int
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    model_config = {"from_attributes": True}


class HistoryRecordOut(BaseModel):
    """历史诊疗记录（同表按患者分组查询）"""
    id: int
    visit_date: Optional[date] = None
    diagnosis: Optional[str] = None
    syndrome: Optional[str] = None
    treatment_principle: Optional[str] = None
    prescription_text: Optional[str] = None
    doctor_id: Optional[int] = None
    treatment_result: Optional[str] = None
    created_at: Optional[datetime] = None

    model_config = {"from_attributes": True}
