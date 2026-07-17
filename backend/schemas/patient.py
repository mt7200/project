"""患者 Pydantic Schema"""
from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class PatientCreate(BaseModel):
    name: str
    gender: Optional[str] = None
    age: Optional[int] = None
    phone: Optional[str] = None
    id_card: Optional[str] = None
    address: Optional[str] = None
    blood_type: Optional[str] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    allergy_info: Optional[str] = None


class PatientUpdate(BaseModel):
    name: Optional[str] = None
    gender: Optional[str] = None
    age: Optional[int] = None
    phone: Optional[str] = None
    id_card: Optional[str] = None
    address: Optional[str] = None
    blood_type: Optional[str] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    allergy_info: Optional[str] = None


class PatientOut(BaseModel):
    id: int
    name: str
    gender: Optional[str] = None
    age: Optional[int] = None
    phone: Optional[str] = None
    id_card: Optional[str] = None
    address: Optional[str] = None
    blood_type: Optional[str] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    allergy_info: Optional[str] = None
    status: Optional[str] = "active"
    created_by: Optional[int] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    model_config = {"from_attributes": True}
