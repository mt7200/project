"""处方业务服务：创建处方 + 剂量校验 + 触发自动审核"""
from typing import List, Dict, Any
from sqlalchemy.orm import Session

from models.herb import Herb
from models.prescription import Prescription
from schemas.prescription import PrescriptionCreate, PrescriptionResponse
from services.review_service import run_auto_review


def validate_dosage(db: Session, herbs: List[Dict[str, Any]]) -> Dict[str, Any]:
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
                "type": "warning",
                "actual": dosage,
                "min": min_d,
                "max": max_d,
            })
            score += 1
        elif dosage > max_d * 1.5:
            critical_risks.append({
                "herb_name": name,
                "message": f"{name} 用量 ({dosage}g) 超过最大剂量 1.5 倍 ({max_d * 1.5}g)",
                "type": "critical",
                "actual": dosage,
                "min": min_d,
                "max": max_d,
            })
            score += 10
        elif dosage > max_d:
            high_risks.append({
                "herb_name": name,
                "message": f"{name} 用量 ({dosage}g) 超过最大剂量 ({max_d}g)",
                "type": "high",
                "actual": dosage,
                "min": min_d,
                "max": max_d,
            })
            score += 5

    return {
        "warnings": warnings,
        "high_risks": high_risks,
        "critical_risks": critical_risks,
        "has_critical": len(critical_risks) > 0,
        "score": score,
    }


def determine_risk_level(score: int, has_critical: bool) -> str:
    if has_critical or score > 10:
        return "high"
    if score > 5:
        return "medium"
    return "low"


def create_prescription_with_review(db: Session, payload: PrescriptionCreate) -> PrescriptionResponse:
    # 将 items 转为 herbs dict 列表（兼容现有 herbs JSON 字段）
    herb_list: List[Dict[str, Any]] = []
    for item in payload.items:
        h = db.query(Herb).filter(Herb.id == item.herb_id).first()
        herb_list.append({
            "id": item.herb_id,
            "name": h.name if h else "未知",
            "current_dosage": item.dosage,
            "dosage": item.dosage,
            "unit": item.unit,
        })

    rx = Prescription(
        visit_id=payload.visit_id,
        patient_id=payload.patient_id,
        doctor_id=payload.doctor_id,
        diagnosis=payload.diagnosis,
        syndrome=payload.syndrome,
        herbs=herb_list,
        notes=payload.notes,
        status="draft",
    )
    db.add(rx)
    db.commit()
    db.refresh(rx)

    dosage_result = validate_dosage(db, herb_list)
    rx.dosage_risk = len(dosage_result["high_risks"]) > 0 or dosage_result["has_critical"]
    rx.risk_score = dosage_result["score"]
    rx.risk_level = determine_risk_level(dosage_result["score"], dosage_result["has_critical"])

    all_risks: List[str] = []
    for w in dosage_result["warnings"]:
        all_risks.append(f"[warning] {w['message']}")
    for h in dosage_result["high_risks"]:
        all_risks.append(f"[high] {h['message']}")
    for c in dosage_result["critical_risks"]:
        all_risks.append(f"[critical] {c['message']}")
    rx.risks = all_risks

    db.commit()
    db.refresh(rx)

    run_auto_review(db, rx)

    return rx


def get_prescription_list(db: Session, status: str = None, patient_id: int = None) -> List[PrescriptionResponse]:
    q = db.query(Prescription)
    if status:
        q = q.filter(Prescription.status == status)
    if patient_id:
        q = q.filter(Prescription.patient_id == patient_id)
    return q.order_by(Prescription.created_at.desc()).all()


def get_prescription_by_id(db: Session, prescription_id: int) -> Prescription:
    return db.query(Prescription).filter(Prescription.id == prescription_id).first()
