"""处方审核接口"""
from typing import List
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.review import ReviewItem, ReviewAction, ReviewOut
from services.review_service import get_review_list, submit_review, apply_review

router = APIRouter()


@router.get("/", response_model=List[ReviewItem])
def list_reviews(status: str = Query("pending"), db: Session = Depends(get_db)):
    return get_review_list(db, status)


@router.post("/", response_model=ReviewOut)
def submit_for_review(prescription_id: int = Query(...), db: Session = Depends(get_db)):
    """提交处方进入审核"""
    return submit_review(db, prescription_id)


@router.put("/{review_id}", response_model=ReviewOut)
def process_review(review_id: int, payload: ReviewAction, db: Session = Depends(get_db)):
    """审核通过/驳回"""
    return apply_review(db, review_id, payload)
