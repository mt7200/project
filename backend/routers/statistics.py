"""统计聚合接口"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.database import get_db
from services.statistics_service import (
    get_summary, get_visit_count_by_month, get_syndrome_distribution,
    get_herb_ranking, get_treatment_results,
)

router = APIRouter()


@router.get("/visit-count")
def visit_count(db: Session = Depends(get_db)):
    return get_visit_count_by_month(db)


@router.get("/syndrome-distribution")
def syndrome_distribution(db: Session = Depends(get_db)):
    return get_syndrome_distribution(db)


@router.get("/herb-ranking")
def herb_ranking(db: Session = Depends(get_db)):
    return get_herb_ranking(db)


@router.get("/treatment-results")
def treatment_results(db: Session = Depends(get_db)):
    return get_treatment_results(db)


@router.get("/summary")
def summary(db: Session = Depends(get_db)):
    return get_summary(db)
