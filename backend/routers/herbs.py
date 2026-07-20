"""药材查询接口"""
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.herb import HerbOut
from models.herb import Herb

router = APIRouter()


@router.get("/", response_model=List[HerbOut])
def list_herbs(category: str = None, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    q = db.query(Herb)
    if category:
        q = q.filter(Herb.category == category)
    return q.offset(skip).limit(limit).all()


@router.get("/{herb_id}", response_model=HerbOut)
def get_herb(herb_id: int, db: Session = Depends(get_db)):
    herb = db.query(Herb).filter(Herb.id == herb_id).first()
    if not herb:
        raise HTTPException(status_code=404, detail="药材不存在")
    return herb


@router.get("/search/", response_model=List[HerbOut])
def search_herbs(q: str, db: Session = Depends(get_db)):
    return db.query(Herb).filter(Herb.name.like(f"%{q}%")).all()
