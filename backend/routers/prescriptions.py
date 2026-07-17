"""处方创建/详情接口"""
from typing import List
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.prescription import PrescriptionCreate, PrescriptionResponse
from services.prescription_service import (
    create_prescription_with_review,
    get_prescription_list,
    get_prescription_by_id,
)

router = APIRouter()


@router.get("/", response_model=List[PrescriptionResponse])
def list_prescriptions(
    status: str = Query(None),
    patient_id: int = Query(None),
    db: Session = Depends(get_db)
):
    return get_prescription_list(db, status, patient_id)


@router.get("/{prescription_id}", response_model=PrescriptionResponse)
def get_prescription(prescription_id: int, db: Session = Depends(get_db)):
    rx = get_prescription_by_id(db, prescription_id)
    if not rx:
        raise HTTPException(status_code=404, detail="处方不存在")
    return rx


@router.post("/", response_model=PrescriptionResponse)
def create_prescription(payload: PrescriptionCreate, db: Session = Depends(get_db)):
    return create_prescription_with_review(db, payload)
