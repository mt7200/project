"""辨证诊断接口"""
from typing import List, Optional
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.diagnosis import DiagnosisCreate, DiagnosisOut

router = APIRouter()


@router.get("/", response_model=List[DiagnosisOut])
def list_diagnoses(visit_id: Optional[int] = Query(None), db: Session = Depends(get_db)):
    return []


@router.post("/", response_model=DiagnosisOut)
def create_diagnosis(payload: DiagnosisCreate, db: Session = Depends(get_db)):
    return {"id": 1, "message": "TODO"}