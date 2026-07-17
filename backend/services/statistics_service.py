"""统计聚合业务服务"""
from sqlalchemy.orm import Session
from sqlalchemy import func

from models.visit import Visit
from models.prescription import Prescription


def get_summary(db: Session) -> dict:
    # TODO: 总诊疗人次 / 累计处方数 / 审方通过率 / 治疗有效率
    return {
        "total_visits": 0,
        "total_prescriptions": 0,
        "review_pass_rate": 0.0,
        "effective_rate": 0.0,
    }


def get_monthly_trend(db: Session) -> list:
    # TODO: 月度诊疗/处方/审核趋势
    return []


def get_syndrome_distribution(db: Session) -> list:
    # TODO: 证型分布
    return []


def get_herb_usage_ranking(db: Session) -> list:
    # TODO: 药材使用频次排行
    return []
