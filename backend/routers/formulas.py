"""方剂查询接口"""
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.formula import FormulaOut, FormulaDetail
from models.formula import Formula
from models.formula_herb import FormulaHerb
from models.herb import Herb

router = APIRouter()


def _build_formula_dict(formula: Formula, db: Session) -> dict:
    herbs = (
        db.query(Herb.name)
        .join(FormulaHerb, Herb.id == FormulaHerb.herb_id)
        .filter(FormulaHerb.formula_id == formula.id)
        .order_by(FormulaHerb.id)
        .all()
    )
    return {
        "id": formula.id,
        "name": formula.name,
        "category_l1": formula.category_l1,
        "category_l2": formula.category_l2,
        "functions": formula.functions,
        "indications": formula.indications,
        "modifications": formula.modifications,
        "source": formula.source,
        "herbs": [h[0] for h in herbs],
    }


@router.get("/", response_model=List[FormulaOut])
def list_formulas(category: str = None, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    q = db.query(Formula)
    if category:
        q = q.filter((Formula.category_l1 == category) | (Formula.category_l2 == category))
    formulas = q.offset(skip).limit(limit).all()
    return [_build_formula_dict(f, db) for f in formulas]


@router.get("/{formula_id}", response_model=FormulaDetail)
def get_formula(formula_id: int, db: Session = Depends(get_db)):
    formula = db.query(Formula).filter(Formula.id == formula_id).first()
    if not formula:
        raise HTTPException(status_code=404, detail="方剂不存在")
    return _build_formula_dict(formula, db)


@router.get("/search/", response_model=List[FormulaOut])
def search_formulas(q: str, db: Session = Depends(get_db)):
    formulas = db.query(Formula).filter(Formula.name.like(f"%{q}%")).all()
    return [_build_formula_dict(f, db) for f in formulas]
