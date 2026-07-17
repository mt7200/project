"""处方审核业务服务：自动审核 + 状态机 + 人工复核"""
from datetime import datetime
from typing import List, Dict, Any
from sqlalchemy.orm import Session

from models.prescription import Prescription
from models.prescription_review import PrescriptionReview
from models.patient import Patient
from schemas.review import ReviewItem, ReviewAction, ReviewOut
from services.incompatibility_service import check_incompatibility

_VALID_TRANSITIONS: Dict[str, List[str]] = {
    "draft":   ["pending"],
    "pending": ["approved", "rejected"],
    "rejected": ["pending"],
    "approved": [],
}


def run_auto_review(db: Session, rx: Prescription) -> None:
    herbs = rx.herbs or []
    suggestions: List[str] = []
    current_risks: List[str] = list(rx.risks or [])

    conflicts = check_incompatibility(herbs)
    if conflicts:
        rx.compatibility_risk = True
        for c in conflicts:
            current_risks.append(
                f"[critical] 配伍禁忌({c['type']}): {c['herb_a']} 与 {c['herb_b']} 不可同用"
            )
            suggestions.append(
                f"{c['herb_a']} 与 {c['herb_b']} 存在{c['type']}禁忌，建议替换其中一味"
            )

    extra_score = len(conflicts) * 10
    total_score = (rx.risk_score or 0) + extra_score

    if conflicts:
        rx.risk_level = "high"
    elif total_score == 0:
        rx.risk_level = "low"
    elif total_score <= 5:
        rx.risk_level = "medium"
    else:
        rx.risk_level = "high"

    rx.risk_score = total_score
    rx.risks = current_risks if current_risks else None
    rx.suggestions = suggestions if suggestions else None
    rx.reviewer = "系统自动"
    db.commit()


def get_review_list(db: Session, status: str) -> List[ReviewItem]:
    q = db.query(Prescription)
    if status:
        q = q.filter(Prescription.status == status)
    prescriptions = q.order_by(Prescription.created_at.desc()).all()

    result: List[ReviewItem] = []
    for rx in prescriptions:
        patient = db.query(Patient).filter(Patient.id == rx.patient_id).first()
        result.append(ReviewItem(
            id=rx.id,
            patient_name=patient.name if patient else None,
            diagnosis=rx.diagnosis,
            syndrome=rx.syndrome,
            herbs=[h.get("name", "") for h in (rx.herbs or [])],
            risk_level=rx.risk_level or "low",
            risk_score=rx.risk_score or 0,
            status=rx.status or "pending",
            compatibility_risk=rx.compatibility_risk or False,
            dosage_risk=rx.dosage_risk or False,
            contraindication_risk=rx.contraindication_risk or False,
            risks=list(rx.risks or []),
            suggestions=list(rx.suggestions or []),
            reviewer=rx.reviewer,
            created_at=rx.created_at,
            reviewed_at=rx.reviewed_at,
        ))
    return result


def submit_review(db: Session, prescription_id: int) -> ReviewOut:
    """提交处方进入待审核"""
    rx = db.query(Prescription).filter(Prescription.id == prescription_id).first()
    if not rx:
        return ReviewOut(id=0, prescription_id=prescription_id, risk_level="low", review_status="error")

    # 状态机: draft → pending
    current = rx.status or "draft"
    if "pending" not in _VALID_TRANSITIONS.get(current, []):
        rx.status = "pending"
        db.commit()

    # 创建审核记录
    review = PrescriptionReview(
        prescription_id=rx.id,
        reviewer_id=rx.doctor_id or 1,
        risk_level=rx.risk_level or "low",
        review_status="pending",
    )
    db.add(review)
    db.commit()
    db.refresh(review)
    return ReviewOut(
        id=review.id,
        prescription_id=rx.id,
        risk_level=review.risk_level,
        review_status=review.review_status,
    )


def apply_review(db: Session, review_id: int, payload: ReviewAction) -> ReviewOut:
    """人工审核：通过 / 驳回（含状态机校验）"""
    review = db.query(PrescriptionReview).filter(PrescriptionReview.id == review_id).first()
    if not review:
        return ReviewOut(id=0, prescription_id=0, risk_level="low", review_status="not_found")

    rx = db.query(Prescription).filter(Prescription.id == review.prescription_id).first()
    if not rx:
        return ReviewOut(id=review_id, prescription_id=review.prescription_id, risk_level="low", review_status="error")

    current_status = rx.status or "pending"
    target_action = payload.action
    allowed = _VALID_TRANSITIONS.get(current_status, [])
    if target_action not in allowed:
        return ReviewOut(
            id=review_id,
            prescription_id=rx.id,
            risk_level=rx.risk_level or "low",
            review_status=review.review_status,
            comment=f"不允许从 [{current_status}] 执行 [{target_action}]",
        )

    rx.status = target_action
    review.review_status = target_action
    review.comment = payload.comment

    if target_action == "rejected" and payload.comment:
        current_risks = list(rx.risks or [])
        current_risks.append(f"[reviewer] {payload.comment}")
        rx.risks = current_risks

    rx.reviewed_at = datetime.utcnow()
    review.reviewed_at = datetime.utcnow()
    db.commit()
    return ReviewOut(
        id=review_id,
        prescription_id=rx.id,
        risk_level=rx.risk_level or "low",
        review_status=review.review_status,
        comment=review.comment,
        reviewed_at=review.reviewed_at,
    )
