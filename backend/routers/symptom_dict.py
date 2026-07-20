"""症状字典接口"""
from typing import List, Optional
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.database import get_db
from models.dict import SymptomDict
from schemas.dict import SymptomDictOut

router = APIRouter()


@router.get("/", response_model=List[SymptomDictOut])
def list_symptoms(
    category: Optional[str] = None,
    is_common: Optional[bool] = None,
    skip: int = 0,
    limit: int = 200,
    db: Session = Depends(get_db),
):
    """查询症状字典，支持按分类和常用筛选"""
    query = db.query(SymptomDict)
    if category:
        query = query.filter(SymptomDict.category == category)
    if is_common is not None:
        query = query.filter(SymptomDict.is_common == (1 if is_common else 0))
    symptoms = query.order_by(SymptomDict.sort_order).offset(skip).limit(limit).all()
    return symptoms


@router.get("/categories")
def list_categories(db: Session = Depends(get_db)):
    """返回所有症状分类列表"""
    from sqlalchemy import distinct
    rows = db.query(distinct(SymptomDict.category)).filter(SymptomDict.category.isnot(None)).all()
    return [row[0] for row in rows]


@router.get("/sections")
def list_sections(db: Session = Depends(get_db)):
    from sqlalchemy import distinct
    rows = db.query(distinct(SymptomDict.sub_category)).filter(SymptomDict.sub_category.isnot(None)).all()
    return [r[0] for r in rows]
