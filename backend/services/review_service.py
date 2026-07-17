"""处方审核业务服务：自动审核 + 人工复核"""
from datetime import datetime
from typing import List
from sqlalchemy.orm import Session

from models.prescription import Prescription
from schemas.review import ReviewItem, ReviewAction


def run_auto_review(db: Session, rx: Prescription) -> None:
    """自动审核：配伍禁忌 / 剂量越界 / 禁忌"""
    # TODO: 实现配伍检测、剂量校验、禁忌识别
    risks: List[str] = []
    suggestions: List[str] = []
    compatibility_risk = False
    dosage_risk = False
    contraindication_risk = False

    # TODO: 检测逻辑
    rx.risks = risks
    rx.suggestions = suggestions
    rx.compatibility_risk = compatibility_risk
    rx.dosage_risk = dosage_risk
    rx.contraindication_risk = contraindication_risk
    rx.reviewer = "系统自动"
    # 风险评分与等级 (示例)
    rx.risk_score = 0
    rx.risk_level = "low"
    db.commit()


def get_review_list(db: Session, status: str) -> List[ReviewItem]:
    # TODO: 查询审核列表
    return []


def apply_review(db: Session, payload: ReviewAction) -> dict:
    # TODO: 更新处方状态为 approved / rejected
    rx = db.query(Prescription).filter(Prescription.id == payload.prescription_id).first()
    if not rx:
        return {"ok": False, "message": "处方不存在"}
    rx.status = payload.action
    rx.reviewed_at = datetime.utcnow()
    db.commit()
    return {"ok": True, "status": rx.status}
