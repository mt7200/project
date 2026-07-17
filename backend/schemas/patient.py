"""患者相关 Schema"""
from datetime import date, datetime
from typing import Optional
from pydantic import BaseModel


class PatientBase(BaseModel):
    name: str
    gender: Optional[str] = None
    birth_date: Optional[date] = None
    phone: Optional[str] = None
    id_card: Optional[str] = None
    address: Optional[str] = None
    allergy: Optional[str] = None
    medical_history: Optional[str] = None


class PatientCreate(PatientBase):
    pass


class PatientUpdate(PatientBase):
    pass


class PatientOut(PatientBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class PatientSummary(BaseModel):
    id: int
    name: str
    gender: Optional[str]
    age: Optional[int]
    last_visit_date: Optional[datetime]
