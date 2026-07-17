"""药材查询接口"""
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import or_
from sqlalchemy.orm import Session

from core.database import get_db
from models.herb import Herb
from schemas.herb import HerbOut

router = APIRouter()


@router.get("/", response_model=List[HerbOut])
def list_herbs(
    keyword: Optional[str] = None,
    category: Optional[str] = None,
    nature: Optional[str] = None,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
):
    """查询/搜索药材列表，支持关键词、分类、药性筛选"""
    query = db.query(Herb)
    if keyword:
        kw = f"%{keyword}%"
        query = query.filter(
            or_(
                Herb.name.ilike(kw),
                Herb.functions.ilike(kw),
                Herb.indications.ilike(kw),
            )
        )
    if category:
        query = query.filter(Herb.category == category)
    if nature:
        query = query.filter(Herb.nature == nature)
    herbs = query.offset(skip).limit(limit).all()
    return herbs


@router.get("/{herb_id}", response_model=HerbOut)
def get_herb(herb_id: int, db: Session = Depends(get_db)):
    herb = db.query(Herb).filter(Herb.id == herb_id).first()
    if not herb:
        raise HTTPException(status_code=404, detail="药材不存在")
    return herb
