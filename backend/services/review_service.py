"""处方审核业务服务：自动审核 + 状态机 + 人工复核"""
from datetime import datetime
from typing import List, Optional, Dict, Any
from sqlalchemy.orm import Session

from models.prescription import Prescription
from models.patient import Patient
from schemas.review import ReviewItem, ReviewAction
from services.incompatibility_service import check_incompatibility

# 状态机合法流转
_VALID_TRANSITIONS: Dict[str, List[str]] = {
    "draft":   ["pending"],
    "pending": ["approved", "rejected"],
    "rejected": ["pending"],
    "approved": [],   # 终态，不可再变
}


def run_auto_review(db: Session, rx: Prescription) -> None:
    """自动审核：配伍禁忌 + 整理风险"""
    herbs = rx.herbs or []
    suggestions: List[str] = []
    current_risks: List[str] = list(rx.risks or [])

    # 1) 配伍禁忌检测
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

    # 2) 汇总风险评分
    extra_score = len(conflicts) * 10
    total_score = (rx.risk_score or 0) + extra_score

    # 配伍禁忌为 critical 时强制提升等级
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
    """查询待审核处方列表"""
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


def apply_review(db: Session, payload: ReviewAction) -> dict:
    """人工审核：通过 / 驳回（含状态机校验）"""
    rx = db.query(Prescription).filter(Prescription.id == payload.prescription_id).first()
    if not rx:
        return {"ok": False, "message": "处方不存在"}

    current_status = rx.status or "pending"
    target_action = payload.action

    # 状态机合法性校验
    allowed = _VALID_TRANSITIONS.get(current_status, [])
    if target_action not in allowed:
        return {
            "ok": False,
            "message": f"当前状态 [{current_status}] 不允许执行 [{target_action}] 操作，允许的操作: {allowed}"
        }

    rx.status = target_action

    if target_action == "rejected":
        # 驳回时写入原因
        if payload.comment:
            current_risks = list(rx.risks or [])
            current_risks.append(f"[reviewer] {payload.comment}")
            rx.risks = current_risks

    rx.reviewed_at = datetime.utcnow()
    db.commit()
    return {"ok": True, "status": rx.status, "message": "审核完成"}
