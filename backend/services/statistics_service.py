"""统计聚合业务服务"""
from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from sqlalchemy import func

from models.visit import Visit
from models.prescription import Prescription


def get_summary(db: Session) -> dict:
    total_visits = db.query(func.count(Visit.id)).scalar() or 0
    total_prescriptions = db.query(func.count(Prescription.id)).scalar() or 0
    approved = db.query(func.count(Prescription.id)).filter(Prescription.status == "approved").scalar() or 0
    review_pass_rate = round(approved / total_prescriptions * 100, 1) if total_prescriptions else 0.0
    effective = db.query(func.count(Prescription.id)).filter(
        Prescription.risk_level == "low"
    ).scalar() or 0
    effective_rate = round(effective / total_prescriptions * 100, 1) if total_prescriptions else 0.0

    return {
        "total_visits": total_visits,
        "total_prescriptions": total_prescriptions,
        "review_pass_rate": review_pass_rate,
        "effective_rate": effective_rate,
    }


def get_visit_count_by_month(db: Session) -> list:
    """月度就诊量统计"""
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
    """证型分布"""
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
    """药材使用频次排行（从 prescriptions.herbs JSON 解析）"""
    prescriptions = db.query(Prescription.herbs).filter(Prescription.herbs.isnot(None)).all()
    herb_count: dict = {}
    for (herbs_json,) in prescriptions:
        if not herbs_json:
            continue
        for item in herbs_json:
            name = item.get("name", "") if isinstance(item, dict) else ""
            if name:
                herb_count[name] = herb_count.get(name, 0) + 1

    ranking = sorted(herb_count.items(), key=lambda x: x[1], reverse=True)[:20]
    return [{"name": k, "count": v} for k, v in ranking]


def get_treatment_results(db: Session) -> list:
    """疗效统计（按风险等级分组）"""
    rows = (
        db.query(
            Prescription.risk_level,
            func.count(Prescription.id).label("count"),
        )
        .group_by(Prescription.risk_level)
        .all()
    )
    return [{"level": r.risk_level or "unknown", "count": r.count} for r in rows]
