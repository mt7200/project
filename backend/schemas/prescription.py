"""处方相关 Schema"""
from datetime import datetime
from typing import List, Optional, Dict, Any
from pydantic import BaseModel


class EditableHerb(BaseModel):
    id: int
    name: str
    current_dosage: float
    min_dosage: float
    max_dosage: float
    unit: str = "g"
    toxic: bool = False


class PrescriptionBase(BaseModel):
    visit_id: int
    patient_id: Optional[int] = None
    diagnosis: Optional[str] = None
    syndrome: Optional[str] = None
    herbs: List[Dict[str, Any]] = []
    notes: Optional[str] = None


class PrescriptionCreate(PrescriptionBase):
    pass


class PrescriptionOut(PrescriptionBase):
    id: int
    doctor_id: Optional[int]
    risk_level: str
    risk_score: int
    status: str
    compatibility_risk: bool
    dosage_risk: bool
    contraindication_risk: bool
    risks: List[str] = []
    suggestions: List[str] = []
    reviewer: Optional[str] = None
    created_at: datetime
    reviewed_at: Optional[datetime] = None

    class Config:
        from_attributes = True
