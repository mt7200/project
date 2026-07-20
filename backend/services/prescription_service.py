"""处方业务服务：创建处方 + 剂量校验 + 触发自动审核"""
from datetime import datetime
from typing import List, Dict, Any
from sqlalchemy.orm import Session
from sqlalchemy import func

from models.herb import Herb
from models.prescription import Prescription
from models.prescription_item import PrescriptionItem
from schemas.prescription import PrescriptionCreate, PrescriptionResponse
from services.review_service import run_auto_review


def _generate_prescription_no(db: Session) -> str:
    today = datetime.utcnow().strftime("%Y%m%d")
    prefix = f"RX{today}"
    count = db.query(func.count(Prescription.id)).filter(
        Prescription.prescription_no.like(f"{prefix}%")
    ).scalar() or 0
    return f"{prefix}{count + 1:03d}"


def create_prescription_with_review(db: Session, payload: PrescriptionCreate) -> PrescriptionResponse:
    rx = Prescription(
        prescription_no=_generate_prescription_no(db),
        visit_id=payload.visit_id,
        patient_id=payload.patient_id,
        doctor_id=payload.doctor_id,
        formula_id=payload.formula_id,
        diagnosis=payload.diagnosis,
        syndrome=payload.syndrome,
        notes=payload.notes,
        status="draft",
    )
    db.add(rx)
    db.commit()
    db.refresh(rx)

    herbs_for_check: List[Dict[str, Any]] = []
    for idx, item in enumerate(payload.items):
        h = db.query(Herb).filter(Herb.id == item.herb_id).first()
        pi = PrescriptionItem(
            prescription_id=rx.id,
            herb_id=item.herb_id,
            herb_name=h.name if h else "未知",
            dosage=item.dosage,
            unit=item.unit,
            sort_order=idx,
        )
        db.add(pi)
        if h:
            herbs_for_check.append({
                "id": h.id,
                "name": h.name,
                "current_dosage": item.dosage,
            })
    db.commit()
    db.refresh(rx)

    run_auto_review(db, rx, herbs_for_check)
    db.refresh(rx)
    return rx


def get_prescription_list(db: Session, status: str = None, patient_id: int = None) -> List[Prescription]:
    q = db.query(Prescription)
    if status:
        q = q.filter(Prescription.status == status)
    if patient_id:
        q = q.filter(Prescription.patient_id == patient_id)
    return q.order_by(Prescription.created_at.desc()).all()


def get_prescription_by_id(db: Session, prescription_id: int) -> Prescription:
    return db.query(Prescription).filter(Prescription.id == prescription_id).first()
