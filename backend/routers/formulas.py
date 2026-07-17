"""方剂查询接口"""
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import or_
from sqlalchemy.orm import Session

from core.database import get_db
from models.formula import Formula
from models.formula_herb import FormulaHerb
from models.herb import Herb
from schemas.formula import FormulaOut, FormulaDetail

router = APIRouter()


@router.get("/", response_model=List[FormulaOut])
def list_formulas(
    keyword: Optional[str] = None,
    category_l1: Optional[str] = None,
    category_l2: Optional[str] = None,
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
):
    """查询/搜索方剂列表，支持关键词和分类筛选"""
    query = db.query(Formula)
    if keyword:
        kw = f"%{keyword}%"
        query = query.filter(
            or_(
                Formula.name.ilike(kw),
                Formula.indications.ilike(kw),
                Formula.functions.ilike(kw),
            )
        )
    if category_l1:
        query = query.filter(Formula.category_l1 == category_l1)
    if category_l2:
        query = query.filter(Formula.category_l2 == category_l2)
    formulas = query.offset(skip).limit(limit).all()
    return formulas


@router.get("/search/", response_model=List[FormulaOut])
def search_formulas(q: str, db: Session = Depends(get_db)):
    """按关键词搜索方剂（名称、主治、功用）"""
    keyword = f"%{q}%"
    formulas = (
        db.query(Formula)
        .filter(
            or_(
                Formula.name.ilike(keyword),
                Formula.indications.ilike(keyword),
                Formula.functions.ilike(keyword),
            )
        )
        .limit(50)
        .all()
    )
    return formulas


@router.get("/{formula_id}", response_model=FormulaDetail)
def get_formula(formula_id: int, db: Session = Depends(get_db)):
    """查询方剂详情（含药材明细）"""
    formula = db.query(Formula).filter(Formula.id == formula_id).first()
    if not formula:
        raise HTTPException(status_code=404, detail="方剂不存在")

    fh_rows = (
        db.query(FormulaHerb, Herb.name, Herb.unit)
        .join(Herb, FormulaHerb.herb_id == Herb.id)
        .filter(FormulaHerb.formula_id == formula_id)
        .order_by(FormulaHerb.sort_order)
        .all()
    )

    herb_details = [
        {
            "herb_id": fh.FormulaHerb.herb_id,
            "herb_name": fh.name,
            "dosage": fh.FormulaHerb.dosage,
            "unit": fh.unit,
            "sort_order": fh.FormulaHerb.sort_order,
        }
        for fh in fh_rows
    ]

    return FormulaDetail(
        id=formula.id,
        name=formula.name,
        category_l1=formula.category_l1,
        category_l2=formula.category_l2,
        functions=formula.functions,
        indications=formula.indications,
        modifications=formula.modifications,
        source=formula.source,
        created_at=formula.created_at,
        updated_at=formula.updated_at,
        herb_details=herb_details,
    )
