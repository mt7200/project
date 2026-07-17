"""审核相关 Schema"""
from datetime import datetime
from typing import List, Optional
from pydantic import BaseModel, Field


class ReviewAction(BaseModel):
    action: str = Field(..., description="approved / rejected")
    comment: Optional[str] = None


class ReviewItem(BaseModel):
    id: int
    patient_name: Optional[str]
    diagnosis: Optional[str]
    syndrome: Optional[str]
    herbs: List[str] = []
    risk_level: str
    risk_score: int
    status: str
    compatibility_risk: bool
    dosage_risk: bool
    contraindication_risk: bool
    risks: List[str] = []
    suggestions: List[str] = []
    reviewer: Optional[str]
    created_at: datetime
    reviewed_at: Optional[datetime]


class ReviewOut(BaseModel):
    id: int
    prescription_id: int
    risk_level: str
    review_status: str
    comment: Optional[str] = None
    reviewed_at: Optional[datetime] = None

    class Config:
        from_attributes = True
