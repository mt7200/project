"""就诊记录 CRUD 接口"""
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from models.visit import Visit
from models.user import User
from schemas.visit import VisitCreate, VisitUpdate, VisitOut
from services.auth_service import require_auth

router = APIRouter()


@router.get("/", response_model=List[VisitOut])
def list_visits(
    patient_id: Optional[int] = None,
    status: Optional[str] = None,
    skip: int = 0,
    limit: int = 50,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """获取就诊记录列表，支持按患者和状态筛选"""
    query = db.query(Visit)
    if patient_id is not None:
        query = query.filter(Visit.patient_id == patient_id)
    if status is not None:
        query = query.filter(Visit.status == status)
    visits = query.order_by(Visit.visit_date.desc()).offset(skip).limit(limit).all()
    return visits


@router.get("/{visit_id}", response_model=VisitOut)
def get_visit(
    visit_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """获取就诊记录详情"""
    visit = db.query(Visit).filter(Visit.id == visit_id).first()
    if not visit:
        raise HTTPException(status_code=404, detail="就诊记录不存在")
    return visit


@router.post("/", response_model=VisitOut)
def create_visit(
    payload: VisitCreate,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """创建就诊记录"""
    visit = Visit(**payload.model_dump())
    db.add(visit)
    db.commit()
    db.refresh(visit)
    return visit


@router.put("/{visit_id}", response_model=VisitOut)
def update_visit(
    visit_id: int,
    payload: VisitUpdate,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """更新就诊记录"""
    visit = db.query(Visit).filter(Visit.id == visit_id).first()
    if not visit:
        raise HTTPException(status_code=404, detail="就诊记录不存在")
    for key, value in payload.model_dump(exclude_unset=True).items():
        setattr(visit, key, value)
    db.commit()
    db.refresh(visit)
    return visit


@router.delete("/{visit_id}")
def delete_visit(
    visit_id: int,
    db: Session = Depends(get_db),
    _: User = Depends(require_auth),
):
    """删除就诊记录"""
    visit = db.query(Visit).filter(Visit.id == visit_id).first()
    if not visit:
        raise HTTPException(status_code=404, detail="就诊记录不存在")
    db.delete(visit)
    db.commit()
    return {"message": "已删除"}
