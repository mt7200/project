"""处方审核业务服务：状态机 + 自动风险评分 + 人工复核"""
from datetime import datetime
from typing import List, Dict, Any, Optional
from sqlalchemy.orm import Session

from models.herb import Herb
from models.patient import Patient
from models.prescription import Prescription
from models.prescription_item import PrescriptionItem
from models.prescription_review import PrescriptionReview
from schemas.review import ReviewItem, ReviewAction, ReviewOut
from services.incompatibility_service import check_incompatibility

_VALID_TRANSITIONS: Dict[str, List[str]] = {
    "draft":   ["pending"],
    "pending": ["approved", "rejected"],
    "rejected": ["pending"],
    "approved": [],
}

_RISK_ORDER = {"low": 0, "medium": 1, "high": 2, "critical": 3}
_RISK_LABEL = {"low": "低风险", "medium": "中风险", "high": "高风险", "critical": "极高风险"}


def _validate_dosage(db: Session, herbs: List[Dict[str, Any]]) -> Dict[str, Any]:
    warnings: List[Dict[str, Any]] = []
    high_risks: List[Dict[str, Any]] = []
    critical_risks: List[Dict[str, Any]] = []
    score = 0

    herb_ids = [h.get("id") for h in herbs if h.get("id")]
    herb_map: Dict[int, Herb] = {}
    if herb_ids:
        for h in db.query(Herb).filter(Herb.id.in_(herb_ids)).all():
            herb_map[h.id] = h

    for herb in herbs:
        herb_id = herb.get("id")
        name = herb.get("name", "未知")
        dosage = herb.get("current_dosage") or herb.get("dosage", 0)

        h = herb_map.get(herb_id)
        if not h:
            continue

        min_d = h.min_dosage or 0
        max_d = h.max_dosage or 999

        if dosage < min_d:
            warnings.append({
                "herb_name": name,
                "message": f"{name} 用量 ({dosage}g) 低于最小剂量 ({min_d}g)",
            })
            score += 1
        elif dosage > max_d * 1.5:
            critical_risks.append({
                "herb_name": name,
                "message": f"{name} 用量 ({dosage}g) 超过最大剂量 1.5 倍 ({max_d * 1.5}g)",
            })
            score += 11
        elif dosage > max_d:
            high_risks.append({
                "herb_name": name,
                "message": f"{name} 用量 ({dosage}g) 超过最大剂量 ({max_d}g)",
            })
            score += 5

    return {
        "warnings": warnings,
        "high_risks": high_risks,
        "critical_risks": critical_risks,
        "has_critical": len(critical_risks) > 0,
        "score": score,
    }


def _determine_risk_level(score: int, has_critical: bool = False, has_incompatibility: bool = False) -> str:
    if has_critical or has_incompatibility or score >= 11:
        return "high"
    if score >= 6:
        return "medium"
    return "low"


def run_auto_review(db: Session, rx: Prescription, herbs_for_check: Optional[List[Dict[str, Any]]] = None) -> Dict[str, Any]:
    """对处方执行自动风险评分，写入 PrescriptionReview 记录。返回评分摘要。"""
    if herbs_for_check is None:
        items = db.query(PrescriptionItem).filter(PrescriptionItem.prescription_id == rx.id).all()
        herbs_for_check = []
        for it in items:
            herbs_for_check.append({"id": it.herb_id, "name": it.herb_name, "current_dosage": it.dosage})

    dosage_result = _validate_dosage(db, herbs_for_check)
    conflicts = check_incompatibility(herbs_for_check)

    score = dosage_result["score"] + len(conflicts) * 11
    risk_level = _determine_risk_level(
        score,
        dosage_result["has_critical"],
        len(conflicts) > 0,
    )

    dosage_msgs = [w["message"] for w in dosage_result["warnings"]]
    dosage_msgs += [h["message"] for h in dosage_result["high_risks"]]
    dosage_msgs += [c["message"] for c in dosage_result["critical_risks"]]
    dosage_check_str = "；".join(dosage_msgs) if dosage_msgs else "通过"

    incompatibility_msgs = [f"{c['herb_a']}-{c['herb_b']}（{c['type']}）" for c in conflicts]
    incompatibility_check_str = "；".join(incompatibility_msgs) if incompatibility_msgs else "通过"

    risks: List[str] = []
    suggestions: List[str] = []
    risks += [f"[剂量超限] {m}" for m in dosage_msgs]
    risks += [f"[配伍禁忌] {m}" for m in incompatibility_msgs]
    if dosage_result["warnings"]:
        suggestions.append("请核对低于最小剂量的药材，确认是否需要调整")
    if dosage_result["high_risks"] or dosage_result["critical_risks"]:
        suggestions.append("存在超量用药，建议调整剂量或更换药材")
    if conflicts:
        suggestions.append("检测到十八反/十九畏配伍，建议立即调整处方")
    if not risks:
        risks.append("无风险项")

    review = PrescriptionReview(
        prescription_id=rx.id,
        reviewer_id=rx.doctor_id or 1,
        review_status="auto_reviewed",
        review_comment=_RISK_LABEL.get(risk_level, risk_level),
        risk_score=score,
        dosage_warnings=dosage_check_str[:200],
        incompatibility_found=incompatibility_check_str[:500],
    )
    db.add(review)
    db.commit()
    db.refresh(review)

    return {
        "review_id": review.id,
        "risk_level": risk_level,
        "risk_score": score,
        "dosage_check": dosage_check_str,
        "incompatibility_check": incompatibility_check_str,
        "risks": risks,
        "suggestions": suggestions,
        "compatibility_risk": len(conflicts) > 0,
        "dosage_risk": len(dosage_msgs) > 0,
        "contraindication_risk": len(conflicts) > 0,
    }


def _latest_review(db: Session, prescription_id: int) -> Optional[PrescriptionReview]:
    rows = (
        db.query(PrescriptionReview)
        .filter(PrescriptionReview.prescription_id == prescription_id)
        .order_by(PrescriptionReview.created_at.desc())
        .all()
    )
    return rows[0] if rows else None


def _build_review_item(db: Session, rx: Prescription) -> ReviewItem:
    patient = db.query(Patient).filter(Patient.id == rx.patient_id).first()
    items = db.query(PrescriptionItem).filter(PrescriptionItem.prescription_id == rx.id).all()
    herbs = [it.herb_name for it in items]
    review = _latest_review(db, rx.id)

    risks: List[str] = []
    suggestions: List[str] = []
    risk_level = "low"
    risk_score = 0
    compatibility_risk = False
    dosage_risk = False
    contraindication_risk = False
    reviewer = None
    reviewed_at = None

    if review:
        risk_score = review.risk_score or 0
        risk_level = _determine_risk_level(risk_score, False, False)
        reviewer = str(review.reviewer_id) if review.reviewer_id else None
        reviewed_at = review.reviewed_at
        if review.dosage_warnings and review.dosage_warnings != "通过":
            dosage_risk = True
            risks.append(f"[剂量] {review.dosage_warnings}")
        if review.incompatibility_found and review.incompatibility_found != "通过":
            compatibility_risk = True
            contraindication_risk = True
            risks.append(f"[配伍] {review.incompatibility_found}")
        if review.review_comment:
            suggestions.append(review.review_comment)
    else:
        if herbs:
            herbs_for_check = []
            for it in items:
                herbs_for_check.append({"id": it.herb_id, "name": it.herb_name, "current_dosage": it.dosage})
            auto = run_auto_review(db, rx, herbs_for_check)
            risk_level = auto["risk_level"]
            risk_score = auto["risk_score"]
            risks = auto["risks"]
            suggestions = auto["suggestions"]
            compatibility_risk = auto["compatibility_risk"]
            dosage_risk = auto["dosage_risk"]
            contraindication_risk = auto["contraindication_risk"]
            reviewed_at = datetime.utcnow()

    return ReviewItem(
        id=rx.id,
        patient_name=patient.name if patient else None,
        diagnosis=rx.diagnosis,
        syndrome=rx.syndrome,
        herbs=herbs,
        risk_level=risk_level,
        risk_score=risk_score,
        status=rx.status or "pending",
        compatibility_risk=compatibility_risk,
        dosage_risk=dosage_risk,
        contraindication_risk=contraindication_risk,
        risks=risks,
        suggestions=suggestions,
        reviewer=reviewer,
        created_at=rx.created_at,
        reviewed_at=reviewed_at,
    )


def get_review_list(db: Session, status: str) -> List[ReviewItem]:
    q = db.query(Prescription)
    if status:
        q = q.filter(Prescription.status == status)
    prescriptions = q.order_by(Prescription.created_at.desc()).all()
    return [_build_review_item(db, rx) for rx in prescriptions]


def submit_review(db: Session, prescription_id: int) -> ReviewOut:
    rx = db.query(Prescription).filter(Prescription.id == prescription_id).first()
    if not rx:
        return ReviewOut(id=0, prescription_id=prescription_id, risk_level="low", review_status="error")

    current = rx.status or "draft"
    if "pending" in _VALID_TRANSITIONS.get(current, []):
        rx.status = "pending"
        db.commit()

    review = PrescriptionReview(
        prescription_id=rx.id,
        reviewer_id=rx.doctor_id or 1,
        review_status="pending",
    )
    db.add(review)
    db.commit()
    db.refresh(review)
    return ReviewOut(
        id=review.id,
        prescription_id=rx.id,
        risk_level="low",
        review_status=review.review_status,
    )


def apply_review(db: Session, review_id: int, payload: ReviewAction) -> ReviewOut:
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
            risk_level="low",
            review_status=review.review_status,
            comment=f"不允许从 [{current_status}] 执行 [{target_action}]",
        )

    rx.status = target_action
    review.review_status = target_action
    review.review_comment = payload.comment
    review.reviewed_at = datetime.utcnow()
    db.commit()
    risk_level = _determine_risk_level(review.risk_score or 0)
    return ReviewOut(
        id=review_id,
        prescription_id=rx.id,
        risk_level=risk_level,
        review_status=review.review_status,
        comment=review.review_comment,
        reviewed_at=review.reviewed_at,
    )
