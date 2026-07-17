"""统计聚合接口"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.database import get_db
from services.statistics_service import (
    get_summary, get_monthly_trend, get_syndrome_distribution, get_herb_usage_ranking,
)

router = APIRouter()


@router.get("/summary")
def summary(db: Session = Depends(get_db)):
    return get_summary(db)


@router.get("/monthly-trend")
def monthly_trend(db: Session = Depends(get_db)):
    return get_monthly_trend(db)


@router.get("/syndrome-distribution")
def syndrome_distribution(db: Session = Depends(get_db)):
    return get_syndrome_distribution(db)


@router.get("/herb-usage-ranking")
def herb_usage_ranking(db: Session = Depends(get_db)):
    return get_herb_usage_ranking(db)
