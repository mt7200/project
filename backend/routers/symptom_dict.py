"""症状字典接口"""
from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.dict import SymptomDictOut

router = APIRouter()


@router.get("/", response_model=List[SymptomDictOut])
def list_symptoms(category: str = None, section: str = None, db: Session = Depends(get_db)):
    # TODO: 查询症状字典
    return []


@router.get("/sections")
def list_sections(db: Session = Depends(get_db)):
    # TODO: 返回症状分类树
    return []
