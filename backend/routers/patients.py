"""患者 CRUD 接口"""
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.patient import PatientCreate, PatientUpdate, PatientOut
import services.auth_service as auth_service  # 占位，避免循环

router = APIRouter()


@router.get("/", response_model=List[PatientOut])
def list_patients(skip: int = 0, limit: int = 50, db: Session = Depends(get_db)):
    # TODO: 查询患者列表
    return []


@router.get("/{patient_id}", response_model=PatientOut)
def get_patient(patient_id: int, db: Session = Depends(get_db)):
    # TODO: 查询患者详情
    raise HTTPException(status_code=404, detail="患者不存在")


@router.post("/", response_model=PatientOut)
def create_patient(payload: PatientCreate, db: Session = Depends(get_db)):
    # TODO: 创建患者
    return payload


@router.put("/{patient_id}", response_model=PatientOut)
def update_patient(patient_id: int, payload: PatientUpdate, db: Session = Depends(get_db)):
    # TODO: 更新患者
    return payload


@router.delete("/{patient_id}")
def delete_patient(patient_id: int, db: Session = Depends(get_db)):
    # TODO: 删除患者
    return {"message": "已删除"}
