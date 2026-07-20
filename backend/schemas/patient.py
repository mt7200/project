from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class PatientBase(BaseModel):
    name: str
    gender: Optional[str] = None
    age: Optional[int] = None
    phone: Optional[str] = None
    id_card: Optional[str] = None
    address: Optional[str] = None
    blood_type: Optional[str] = None
    height: Optional[float] = None
    weight: Optional[float] = None
    allergy_info: Optional[str] = None
    status: str = "active"


class PatientCreate(PatientBase):
    pass


class PatientUpdate(BaseModel):
    name: Optional[str] = None
    gender: Optional[str] = None
    age: Optional[int] = None
    phone: Optional[str] = None
    address: Optional[str] = None
    allergy_info: Optional[str] = None
    status: Optional[str] = None


class PatientOut(PatientBase):
    id: int
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True
