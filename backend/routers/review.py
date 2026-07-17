"""处方审核接口"""
from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.database import get_db
from schemas.review import ReviewItem, ReviewAction
from services.review_service import get_review_list, apply_review

router = APIRouter()


@router.get("/", response_model=List[ReviewItem])
def list_reviews(status: str = "pending", db: Session = Depends(get_db)):
    return get_review_list(db, status)


@router.post("/action")
def review_action(payload: ReviewAction, db: Session = Depends(get_db)):
    return apply_review(db, payload)
