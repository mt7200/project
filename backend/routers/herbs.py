"""药材查询接口"""
from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.herb import HerbOut

router = APIRouter()


@router.get("/", response_model=List[HerbOut])
def list_herbs(category: str = None, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    # TODO: 查询药材列表
    return []


@router.get("/{herb_id}", response_model=HerbOut)
def get_herb(herb_id: int, db: Session = Depends(get_db)):
    # TODO: 查询药材详情
    return {"id": herb_id, "name": "TODO"}


@router.get("/search/", response_model=List[HerbOut])
def search_herbs(q: str, db: Session = Depends(get_db)):
    # TODO: 搜索药材
    return []
