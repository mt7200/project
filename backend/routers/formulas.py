"""方剂查询接口"""
from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.formula import FormulaOut, FormulaDetail

router = APIRouter()


@router.get("/", response_model=List[FormulaOut])
def list_formulas(category: str = None, skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    # TODO: 查询方剂列表
    return []


@router.get("/{formula_id}", response_model=FormulaDetail)
def get_formula(formula_id: int, db: Session = Depends(get_db)):
    # TODO: 查询方剂详情 (含药材详情)
    return {"id": formula_id, "name": "TODO"}


@router.get("/search/", response_model=List[FormulaOut])
def search_formulas(q: str, db: Session = Depends(get_db)):
    # TODO: 搜索方剂
    return []
