"""证型知识库接口"""
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import or_
from sqlalchemy.orm import Session

from core.database import get_db
from models.dict import SyndromePattern
from schemas.dict import SyndromePatternOut

router = APIRouter()


@router.get("/", response_model=List[SyndromePatternOut])
def list_syndrome_patterns(
    category: Optional[str] = None,
    keyword: Optional[str] = None,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
):
    """查询证型列表，支持分类筛选和关键词搜索"""
    query = db.query(SyndromePattern)
    if category:
        query = query.filter(SyndromePattern.category == category)
    if keyword:
        kw = f"%{keyword}%"
        query = query.filter(
            or_(
                SyndromePattern.pattern_name.ilike(kw),
                SyndromePattern.etiology.ilike(kw),
                SyndromePattern.key_symptoms.ilike(kw),
                SyndromePattern.treatment_method.ilike(kw),
            )
        )
    patterns = query.order_by(SyndromePattern.sort_order).offset(skip).limit(limit).all()
    return patterns


@router.get("/{pattern_id}", response_model=SyndromePatternOut)
def get_syndrome_pattern(
    pattern_id: int,
    db: Session = Depends(get_db),
):
    """获取证型详情"""
    pattern = db.query(SyndromePattern).filter(SyndromePattern.id == pattern_id).first()
    if not pattern:
        raise HTTPException(status_code=404, detail="证型不存在")
    return pattern



