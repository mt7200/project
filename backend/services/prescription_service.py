"""处方业务服务：创建处方 + 触发自动审核"""
from sqlalchemy.orm import Session

from models.prescription import Prescription
from schemas.prescription import PrescriptionCreate, PrescriptionOut
from services.review_service import run_auto_review


def create_prescription_with_review(db: Session, payload: PrescriptionCreate) -> PrescriptionOut:
    # TODO: 1) 持久化处方 2) 调用 run_auto_review 评估风险 3) 返回带审核结果的对象
    rx = Prescription(
        visit_id=payload.visit_id,
        patient_id=payload.patient_id,
        diagnosis=payload.diagnosis,
        syndrome=payload.syndrome,
        herbs=payload.herbs,
        notes=payload.notes,
    )
    db.add(rx)
    db.commit()
    db.refresh(rx)
    run_auto_review(db, rx)
    return rx
