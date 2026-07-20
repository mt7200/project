"""统计聚合业务服务"""
from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from sqlalchemy import func

from models.visit import Visit
from models.prescription import Prescription
from models.prescription_item import PrescriptionItem
from models.herb import Herb
from models.emr import EMR


def get_summary(db: Session) -> dict:
    total_visits = db.query(func.count(Visit.id)).scalar() or 0
    total_prescriptions = db.query(func.count(Prescription.id)).scalar() or 0

    reviewed_count = db.query(func.count(Prescription.id)).filter(
        Prescription.status.in_(["approved", "rejected"])
    ).scalar() or 0
    approved_count = db.query(func.count(Prescription.id)).filter(
        Prescription.status == "approved"
    ).scalar() or 0
    review_pass_rate = round(approved_count / reviewed_count, 4) if reviewed_count else 0.0

    total_emrs = db.query(func.count(EMR.id)).scalar() or 0
    effective_count = db.query(func.count(EMR.id)).filter(
        EMR.treatment_result.in_(["effective", "cured", "improved", "显效", "痊愈", "好转"])
    ).scalar() or 0
    effective_rate = round(effective_count / total_emrs, 4) if total_emrs else 0.0

    return {
        "total_visits": total_visits,
        "total_prescriptions": total_prescriptions,
        "review_pass_rate": review_pass_rate,
        "effective_rate": effective_rate,
    }


def get_visit_count_by_month(db: Session) -> list:
    six_months_ago = datetime.utcnow() - timedelta(days=180)
    rows = (
        db.query(
            func.date_format(Visit.created_at, "%Y-%m").label("month"),
            func.count(Visit.id).label("count"),
        )
        .filter(Visit.created_at >= six_months_ago)
        .group_by("month")
        .order_by("month")
        .all()
    )
    return [{"month": r.month, "count": r.count} for r in rows]


def get_syndrome_distribution(db: Session) -> list:
    rows = (
        db.query(
            Prescription.syndrome,
            func.count(Prescription.id).label("count"),
        )
        .filter(Prescription.syndrome.isnot(None))
        .group_by(Prescription.syndrome)
        .order_by(func.count(Prescription.id).desc())
        .limit(10)
        .all()
    )
    return [{"name": r.syndrome, "count": r.count} for r in rows]


def get_herb_ranking(db: Session) -> list:
    rows = (
        db.query(
            Herb.name.label("herb_name"),
            func.count(PrescriptionItem.id).label("count"),
            func.sum(PrescriptionItem.dosage).label("total_dosage"),
        )
        .join(PrescriptionItem, PrescriptionItem.herb_id == Herb.id)
        .group_by(Herb.id, Herb.name)
        .order_by(func.count(PrescriptionItem.id).desc())
        .limit(20)
        .all()
    )
    return [
        {
            "name": r.herb_name,
            "count": r.count,
            "total_dosage": float(r.total_dosage) if r.total_dosage else 0,
        }
        for r in rows
    ]


def get_treatment_results(db: Session) -> list:
    rows = (
        db.query(
            EMR.treatment_result.label("result"),
            func.count(EMR.id).label("count"),
        )
        .filter(EMR.treatment_result.isnot(None), EMR.treatment_result != "")
        .group_by(EMR.treatment_result)
        .order_by(func.count(EMR.id).desc())
        .all()
    )
    return [{"name": r.result, "count": r.count} for r in rows]
