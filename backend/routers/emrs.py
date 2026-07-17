"""病历 CRUD 接口"""
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.emr import EMRCreate, EMRUpdate, EMROut, HistoryRecordOut

router = APIRouter()


@router.get("/", response_model=List[EMROut])
def list_emrs(patient_id: int = None, status: str = None, db: Session = Depends(get_db)):
    # TODO: 查询病历列表
    return []


@router.get("/{emr_id}", response_model=EMROut)
def get_emr(emr_id: int, db: Session = Depends(get_db)):
    raise HTTPException(status_code=404, detail="病历不存在")


@router.post("/", response_model=EMROut)
def create_emr(payload: EMRCreate, db: Session = Depends(get_db)):
    # TODO: 创建病历
    return payload


@router.put("/{emr_id}", response_model=EMROut)
def update_emr(emr_id: int, payload: EMRUpdate, db: Session = Depends(get_db)):
    # TODO: 更新病历
    return payload


@router.get("/{emr_id}/history", response_model=List[HistoryRecordOut])
def get_history_records(emr_id: int, db: Session = Depends(get_db)):
    # TODO: 查询历史诊疗记录
    return []
