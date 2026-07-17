"""处方相关 Schema"""
from datetime import datetime
from typing import List, Optional, Dict, Any
from pydantic import BaseModel, Field


class PrescriptionItemCreate(BaseModel):
    herb_id: int = Field(..., description="药材 ID")
    dosage: float = Field(..., ge=0, description="实际用量")
    unit: str = Field(default="g")


class EditableHerb(BaseModel):
    id: int
    name: str
    current_dosage: float
    min_dosage: float
    max_dosage: float
    unit: str = "g"
    toxic: bool = False


class PrescriptionCreate(BaseModel):
    patient_id: int = Field(..., description="患者 ID")
    doctor_id: int = Field(..., description="医生 ID")
    visit_id: Optional[int] = Field(None, description="就诊记录 ID")
    formula_id: Optional[int] = Field(None, description="基于方剂 ID")
    diagnosis: str = Field(..., max_length=200, description="诊断")
    syndrome: str = Field(..., max_length=200, description="证型")
    notes: Optional[str] = Field(None, description="医嘱备注")
    items: List[PrescriptionItemCreate] = Field(..., description="处方药材明细")


class PrescriptionResponse(BaseModel):
    id: int
    prescription_no: str
    patient_id: int
    doctor_id: int
    visit_id: Optional[int] = None
    formula_id: Optional[int] = None
    diagnosis: str
    syndrome: str
    status: str
    risk_level: str = "low"
    risk_score: int = 0
    compatibility_risk: bool = False
    dosage_risk: bool = False
    contraindication_risk: bool = False
    risks: List[str] = []
    suggestions: List[str] = []
    notes: Optional[str] = None
    reviewer: Optional[str] = None
    created_at: datetime
    reviewed_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class PrescriptionListOut(PrescriptionResponse):
    items: List[PrescriptionItemCreate] = []
