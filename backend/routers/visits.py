"""就诊记录 CRUD 接口"""
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.visit import VisitCreate, VisitUpdate, VisitOut

router = APIRouter()


@router.get("/", response_model=List[VisitOut])
def list_visits(patient_id: int = None, skip: int = 0, limit: int = 50, db: Session = Depends(get_db)):
    # TODO: 查询就诊列表
    return []


@router.get("/{visit_id}", response_model=VisitOut)
def get_visit(visit_id: int, db: Session = Depends(get_db)):
    raise HTTPException(status_code=404, detail="就诊记录不存在")


@router.post("/", response_model=VisitOut)
def create_visit(payload: VisitCreate, db: Session = Depends(get_db)):
    # TODO: 创建就诊记录
    return payload


@router.put("/{visit_id}", response_model=VisitOut)
def update_visit(visit_id: int, payload: VisitUpdate, db: Session = Depends(get_db)):
    # TODO: 更新就诊记录
    return payload
