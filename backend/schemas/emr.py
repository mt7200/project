"""病历相关 Schema"""
from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class EMRBase(BaseModel):
    patient_id: int
    visit_id: Optional[int] = None
    title: Optional[str] = None
    chief_complaint: Optional[str] = None
    present_illness: Optional[str] = None
    diagnosis: Optional[str] = None
    treatment: Optional[str] = None
    status: str = "draft"


class EMRCreate(EMRBase):
    pass


class EMRUpdate(BaseModel):
    title: Optional[str] = None
    chief_complaint: Optional[str] = None
    present_illness: Optional[str] = None
    diagnosis: Optional[str] = None
    treatment: Optional[str] = None
    status: Optional[str] = None


class EMROut(EMRBase):
    id: int
    doctor_id: Optional[int]
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class HistoryRecordOut(BaseModel):
    id: int
    patient_id: int
    visit_date: Optional[datetime]
    diagnosis: Optional[str]
    syndrome: Optional[str]
    prescription: Optional[str]
    doctor: Optional[str]
    created_at: datetime

    class Config:
        from_attributes = True
