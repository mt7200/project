"""证型字典接口"""
from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.dict import SyndromePatternOut

router = APIRouter()


@router.get("/", response_model=List[SyndromePatternOut])
def list_syndrome_patterns(category: str = None, db: Session = Depends(get_db)):
    # TODO: 查询证型字典
    return []


@router.get("/{pattern_id}", response_model=SyndromePatternOut)
def get_syndrome_pattern(pattern_id: int, db: Session = Depends(get_db)):
    return {"id": pattern_id, "name": "TODO"}
