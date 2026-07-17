"""病历 CRUD 接口"""
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from models.emr import EMR
from models.user import User
from schemas.emr import EMRCreate, EMRUpdate, EMROut, HistoryRecordOut
from services.auth_service import require_auth

router = APIRouter()


@router.get("/", response_model=List[EMROut])
def list_emrs(
    patient_id: Optional[int] = None,
    status: Optional[str] = None,
    skip: int = 0,
    limit: int = 50,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """获取病历列表，支持按患者和状态筛选"""
    query = db.query(EMR)
    if patient_id is not None:
        query = query.filter(EMR.patient_id == patient_id)
    if status is not None:
        query = query.filter(EMR.status == status)
    records = query.order_by(EMR.visit_date.desc()).offset(skip).limit(limit).all()
    return records


@router.get("/{emr_id}", response_model=EMROut)
def get_emr(
    emr_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """获取病历详情"""
    record = db.query(EMR).filter(EMR.id == emr_id).first()
    if not record:
        raise HTTPException(status_code=404, detail="病历不存在")
    return record


@router.post("/", response_model=EMROut)
def create_emr(
    payload: EMRCreate,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """创建病历"""
    record = EMR(**payload.model_dump())
    db.add(record)
    db.commit()
    db.refresh(record)
    return record


@router.put("/{emr_id}", response_model=EMROut)
def update_emr(
    emr_id: int,
    payload: EMRUpdate,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """更新病历"""
    record = db.query(EMR).filter(EMR.id == emr_id).first()
    if not record:
        raise HTTPException(status_code=404, detail="病历不存在")
    for key, value in payload.model_dump(exclude_unset=True).items():
        setattr(record, key, value)
    db.commit()
    db.refresh(record)
    return record


@router.delete("/{emr_id}")
def delete_emr(
    emr_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """删除病历"""
    record = db.query(EMR).filter(EMR.id == emr_id).first()
    if not record:
        raise HTTPException(status_code=404, detail="病历不存在")
    db.delete(record)
    db.commit()
    return {"message": "已删除"}


@router.get("/{emr_id}/history", response_model=List[HistoryRecordOut])
def get_history_records(
    emr_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """查询同患者的历史诊疗记录（排除自身）"""
    record = db.query(EMR).filter(EMR.id == emr_id).first()
    if not record:
        raise HTTPException(status_code=404, detail="病历不存在")
    histories = (
        db.query(EMR)
        .filter(EMR.patient_id == record.patient_id, EMR.id != emr_id)
        .order_by(EMR.visit_date.desc())
        .all()
    )
    return histories
