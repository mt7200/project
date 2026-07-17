"""处方创建/详情接口"""
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.prescription import PrescriptionCreate, PrescriptionOut
from services.prescription_service import create_prescription_with_review

router = APIRouter()


@router.get("/", response_model=List[PrescriptionOut])
def list_prescriptions(status: str = None, patient_id: int = None, db: Session = Depends(get_db)):
    # TODO: 查询处方列表
    return []


@router.get("/{prescription_id}", response_model=PrescriptionOut)
def get_prescription(prescription_id: int, db: Session = Depends(get_db)):
    raise HTTPException(status_code=404, detail="处方不存在")


@router.post("/", response_model=PrescriptionOut)
def create_prescription(payload: PrescriptionCreate, db: Session = Depends(get_db)):
    # TODO: 调用 prescription_service 创建处方并触发自动审核
    return create_prescription_with_review(db, payload)
